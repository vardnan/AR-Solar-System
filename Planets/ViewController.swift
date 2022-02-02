//
//  ViewController.swift
//  Planets
//
//  Created by Vardnan Sivarajah on 30/01/2022.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Sun
        let sun = SCNNode()
        sun.geometry = SCNSphere(radius: 0.35)
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "SunDiffuse.jpeg")
        sun.position = SCNVector3(0,0,-1)
        self.sceneView.scene.rootNode.addChildNode(sun)
        
        // Earth
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0,0,-1)
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "EarthDay.jpeg"), specular: UIImage (named: "EarthSpecular.png"), emission: UIImage(named: "EarthClouds.jpeg"), normal: UIImage(named: "EarthNormal.png"), position: SCNVector3(1.4,0,0))
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        
        // Venus
        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0,0,-1)
        let venus = planet(geometry: SCNSphere(radius: 0.3), diffuse: UIImage(named: "VenusDiffuse.jpeg"), specular: nil, emission: UIImage(named: "VenusEmission.jpeg")!, normal: nil, position: SCNVector3(1,0,0))
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        // Moons
        let earthMoonParent = SCNNode()
        earthMoonParent.position = SCNVector3(1.4,0,0)
        let earthMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "MoonDiffuse.jpeg"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0,0,-0.3))
        
        // Actions
        let sunAction = Rotation(time: 8)
        let earthParentRotation = Rotation(time: 14)
        let venusParentRotation = Rotation(time: 10)
        let earthMoonParentRotation = Rotation(time: 5)
        let earthRotation = Rotation(time: 8)
        let venusRotation = Rotation(time: 8)
        
        sun.runAction(sunAction)
        earthParent.runAction(earthParentRotation)
        venusParent.runAction(venusParentRotation)
        earth.runAction(earthRotation)
        venus.runAction(venusRotation)
        earthMoonParent.runAction(earthMoonParentRotation)
        
        // Adding child nodes
        earthParent.addChildNode(earth)
        earthParent.addChildNode(earthMoonParent)
        venusParent.addChildNode(venus)
        earthMoonParent.addChildNode(earthMoon)
    
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage?, specular: UIImage?, emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode {
        
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    
    func Rotation(time: TimeInterval) -> SCNAction {
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
}

extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

