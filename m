From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l35: Add bindings file for CS35L35"
	to the asoc tree
Date: Tue, 07 Mar 2017 13:57:36 +0100
Message-ID: <E1clEgK-0004iA-HS@finisterre>
References: <d1e85503-c400-45f6-aa89-a24dd16cb44a@EX3.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 503C7266E29
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:57:47 +0100 (CET)
In-Reply-To: <d1e85503-c400-45f6-aa89-a24dd16cb44a@EX3.ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, robh+dt@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l35: Add bindings file for CS35L35

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ed864461bfbdacefc242d4c0675989915a1431b0 Mon Sep 17 00:00:00 2001
From: Brian Austin <brian.austin@cirrus.com>
Date: Mon, 6 Mar 2017 08:08:00 -0600
Subject: [PATCH] ASoC: cs35l35: Add bindings file for CS35L35

Add bindings documentation for CS35L35 Amplifier

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs35l35.txt          | 171 +++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l35.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l35.txt b/Documentation/devicetree/bindings/sound/cs35l35.txt
new file mode 100644
index 000000000000..07d9c0f177fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l35.txt
@@ -0,0 +1,171 @@
+CS35L35 Boosted Speaker Amplifier
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
+  - reset-gpios : gpio used to reset the amplifier
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
+  - cirrus,boost-ctl-millivolt : Boost Voltage Value.  Configures the boost
+    converter's output voltage in mV. The range is from 2600mV to 9000mV with
+    increments of 100mV.
+    (Default) VP
+
+  - cirrus,boost-peak-milliamp : Boost-converter peak current limit in mA.
+  Configures the peak current by monitoring the current through the boost FET.
+  Range starts at 1680mA and goes to a maximum of 4480mA with increments of
+  110mA.
+  (Default) 2.46 Amps
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
+cs35l35: cs35l35@20 {
+	compatible = "cirrus,cs35l35";
+	reg = <0x20>;
+	VA-supply = <&dummy_vreg>;
+	VP-supply = <&dummy_vreg>;
+	reset-gpios = <&axi_gpio 54 0>;
+	interrupt-parent = <&gpio8>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+	cirrus,boost-ctl-millivolt = <9000>;
+
+	cirrus,stereo-config;
+	cirrus,audio-channel = <0x00>;
+	cirrus,advisory-channel = <0x01>;
+	cirrus,shared-boost;
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
2.11.0
