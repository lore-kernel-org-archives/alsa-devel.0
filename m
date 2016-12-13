From: Li Xu <li.xu@cirrus.com>
Subject: [PATCH v2 2/2] ASoC: cs35l35: Add device tree
	documentation for CS35L35
Date: Tue, 13 Dec 2016 10:26:44 -0600
Message-ID: <7900b605-6715-4c95-ac44-381b0f7bc95d@EX3.ad.cirrus.com>
References: <1481646404-19012-1-git-send-email-li.xu@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 028EB266E59
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 17:27:00 +0100 (CET)
In-Reply-To: <1481646404-19012-1-git-send-email-li.xu@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, Paul.Handrigan@cirrus.com, Li Xu <li.xu@cirrus.com>
List-Id: alsa-devel@alsa-project.org

Add device tree documentation for Cirrus Logic CS35L35
speaker amplifier

Signed-off-by: Li Xu <li.xu@cirrus.com>
---
 .../devicetree/bindings/sound/cs35l35.txt          | 172 +++++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l35.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
new file mode 100644
index 0000000..8b13f67
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l35.txt
@@ -0,0 +1,172 @@
+CS35L35 Speaker Amplifier
+
+Required properties:
+
+  - compatible : "cirrus,cs35l35"
+
+  - reg : the I2C address of the device for I2C
+
+  - VA-supply, VP-supply : power supplies for the device,
+    as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - interrupt-parent : Specifies the phandle of the interrupt controller to
+    which the IRQs from CS35L35 are delivered to.
+  - interrupts : IRQ line info CS35L35.
+    (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+    for further information relating to interrupt properties)
+
+Optional properties:
+  - cirrus,reset-gpios : Active low GPIO used to reset the amplifier
+
+  - cirrus,stereo-config : Boolean to determine if there are 2 AMPs for a
+  Stereo configuration
+
+  - cirrus,audio-channel : Set Location of Audio Signal on Serial Port
+  0 = Data Packet received on Left I2S Channel
+  1 = Data Packet received on Right I2S Channel
+
+  - cirrus,advisory-channel : Set Location of Advisory Signal on Serial Port
+  0 = Data Packet received on Left I2S Channel
+  1 = Data Packet received on Right I2S Channel
+
+  - cirrus,shared-boost : Boolean to enable ClassH tracking of Advisory Signal
+  if 2 Devices share Boost BST_CTL
+
+  - cirrus,sp-drv-strength : Value for setting the Serial Port drive strength
+  Table 3-10 of the datasheet lists drive-strength specifications
+  0 = 1x (Default)
+  1 = .5x
+
+  - cirrus,bst-pdn-fet-on : Boolean to determine if the Boost PDN control
+  powers down with a rectification FET On or Off. If VSPK is supplied
+  externally then FET is off.
+
+  - cirrus,boost-ctl-millivolt : Boost Converter control word. Step Size of 100mV
+  0x00 = (Default) VP
+  0x01 = 2600mV
+  0x41 = 9000mV
+
+  - cirrus,boost-ipk-milliamp : Boost-converter peak current limit.
+  Configures the peak current by monitoring the current through the boost FET.
+  Step size: 112mA
+  0x00 = 1680mA
+  0x19 = 4480mA
+
+  - cirrus,amp-gain-zc : Boolean to determine if to use Amplifier gain-change
+  zero-cross
+
+Optional H/G Algorithm sub-node:
+
+  The cs35l35 node can have a single "cirrus,classh-internal-algo" sub-node
+  that will disable automatic control of the internal H/G Algorithm.
+
+  It is strongly recommended that the Datasheet be referenced when adjusting
+  or using these Class H Algorithm controls over the internal Algorithm.
+  Serious damage can occur to the Device and surrounding components.
+
+  - cirrus,classh-internal-algo : Sub-node for the Internal Class H Algorithm
+  See Section 4.3 Internal Class H Algorithm in the Datasheet.
+  If not used, the device manages the ClassH Algorithm internally.
+
+Optional properties for the "cirrus,classh-internal-algo" Sub-node
+
+  Section 7.29 Class H Control
+  - cirrus,classh-bst-overide : Boolean
+  - cirrus,classh-bst-max-limit
+  - cirrus,classh-mem-depth
+
+  Section 7.30 Class H Headroom Control
+  - cirrus,classh-headroom
+
+  Section 7.31 Class H Release Rate
+  - cirrus,classh-release-rate
+
+  Section 7.32 Class H Weak FET Drive Control
+  - cirrus,classh-wk-fet-disable
+  - cirrus,classh-wk-fet-delay
+  - cirrus,classh-wk-fet-thld
+
+  Section 7.34 Class H VP Control
+  - cirrus,classh-vpch-auto
+  - cirrus,classh-vpch-rate
+  - cirrus,classh-vpch-man
+
+Optional Monitor Signal Format sub-node:
+
+  The cs35l35 node can have a single "cirrus,monitor-signal-format" sub-node
+  for adjusting the Depth, Location and Frame of the Monitoring Signals
+  for Algorithms.
+
+  See Sections 4.8.2 through 4.8.4 Serial-Port Control in the Datasheet
+
+  -cirrus,monitor-signal-format : Sub-node for the Monitor Signaling Formating
+  on the I2S Port. Each of the 3 8 bit values in the array contain the settings
+  for depth, location, and frame.
+
+  If not used, the defaults for the 6 monitor signals is used.
+
+  Sections 7.44 - 7.53 lists values for the depth, location, and frame
+  for each monitoring signal.
+
+  - cirrus,imon : 3 8 bit values to set the depth, location, and frame
+  of the IMON monitor signal.
+
+  - cirrus,vmon : 3 8 bit values to set the depth, location, and frame
+  of the VMON monitor signal.
+
+  - cirrus,vpmon : 3 8 bit values to set the depth, location, and frame
+  of the VPMON monitor signal.
+
+  - cirrus,vbstmon : 3 8 bit values to set the depth, location, and frame
+  of the VBSTMON monitor signal
+
+  - cirrus,vpbrstat : 3 8 bit values to set the depth, location, and frame
+  of the VPBRSTAT monitor signal
+
+  - cirrus,zerofill : 3 8 bit values to set the depth, location, and frame\
+  of the ZEROFILL packet in the monitor signal
+
+Example:
+
+cs35l35: audio-codec@20 {
+	compatible = "cirrus,cs35l35";
+	reg = <0x20>;
+	VA-supply = <&dummy_vreg>;
+	VP-supply = <&dummy_vreg>;
+	reset-gpios = <&axi_gpio 54 1>;
+	interrupt-parent = <&gpio8>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+	cirrus,boost-ctl = <0x41>;
+
+	cirrus,stereo-config {
+		cirrus,audio-channel = <0x00>;
+		cirrus,advisory-channel = <0x01>;
+		cirrus,shared-boost;
+	};
+
+	cirrus,classh-internal-algo {
+		cirrus,classh-bst-overide;
+		cirrus,classh-bst-max-limit = <0x01>;
+		cirrus,classh-mem-depth = <0x01>;
+		cirrus,classh-release-rate = <0x08>;
+		cirrus,classh-headroom-millivolt = <0x0B>;
+		cirrus,classh-wk-fet-disable = <0x01>;
+		cirrus,classh-wk-fet-delay = <0x04>;
+		cirrus,classh-wk-fet-thld = <0x01>;
+		cirrus,classh-vpch-auto = <0x01>;
+		cirrus,classh-vpch-rate = <0x02>;
+		cirrus,classh-vpch-man = <0x05>;
+	};
+
+	/* Depth, Location, Frame */
+	cirrus,monitor-signal-format {
+		cirrus,imon = /bits/ 8 <0x03 0x00 0x01>;
+		cirrus,vmon = /bits/ 8 <0x03 0x00 0x00>;
+		cirrus,vpmon = /bits/ 8 <0x03 0x04 0x00>;
+		cirrus,vbstmon = /bits/ 8 <0x03 0x04 0x01>;
+		cirrus,vpbrstat = /bits/ 8 <0x00 0x04 0x00>;
+		cirrus,zerofill = /bits/ 8 <0x00 0x00 0x00>;
+	};
+
+};
-- 
1.9.1
