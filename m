From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l36: Add device tree documentation
	for CS35L36" to the asoc tree
Date: Fri,  8 Feb 2019 13:11:13 +0000 (GMT)
Message-ID: <20190208131113.D5A311127F30@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E8A0267A16
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 14:11:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: James Schulman <james.schulman@cirrus.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l36: Add device tree documentation for CS35L36

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0d250bf24a68ec25b4aa2b07c200b7de4607b182 Mon Sep 17 00:00:00 2001
From: James Schulman <james.schulman@cirrus.com>
Date: Thu, 7 Feb 2019 12:12:19 -0600
Subject: [PATCH] ASoC: cs35l36: Add device tree documentation for CS35L36

Add device tree documentation for Cirrus Logic CS35L36
speaker amplifier

Signed-off-by: James Schulman <james.schulman@cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs35l36.txt     | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l36.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l36.txt b/Documentation/devicetree/bindings/sound/cs35l36.txt
new file mode 100644
index 000000000000..912bd162b477
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l36.txt
@@ -0,0 +1,168 @@
+CS35L36 Speaker Amplifier
+
+Required properties:
+
+  - compatible : "cirrus,cs35l36"
+
+  - reg : the I2C address of the device for I2C
+
+  - VA-supply, VP-supply : power supplies for the device,
+  as covered in
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - cirrus,boost-ctl-millivolt : Boost Voltage Value.  Configures the boost
+  converter's output voltage in mV. The range is from 2550mV to 12000mV with
+  increments of 50mV.
+  (Default) VP
+
+  - cirrus,boost-peak-milliamp : Boost-converter peak current limit in mA.
+  Configures the peak current by monitoring the current through the boost FET.
+  Range starts at 1600mA and goes to a maximum of 4500mA with increments of
+  50mA.
+  (Default) 4.50 Amps
+
+  - cirrus,boost-ind-nanohenry : Inductor estimation LBST reference value.
+  Seeds the digital boost converter's inductor estimation block with the initial
+  inductance value to reference.
+
+  1000 = 1uH (Default)
+  1200 = 1.2uH
+
+Optional properties:
+  - cirrus,multi-amp-mode : Boolean to determine if there are more than
+  one amplifier in the system. If more than one it is best to Hi-Z the ASP
+  port to prevent bus contention on the output signal
+
+  - cirrus,boost-ctl-select : Boost conerter control source selection.
+  Selects the source of the BST_CTL target VBST voltage for the boost
+  converter to generate.
+  0x00 - Control Port Value
+  0x01 - Class H Tracking (Default)
+  0x10 - MultiDevice Sync Value
+
+  - cirrus,amp-pcm-inv : Boolean to determine Amplifier will invert incoming
+  PCM data
+
+  - cirrus,imon-pol-inv : Boolean to determine Amplifier will invert the
+  polarity of outbound IMON feedback data
+
+  - cirrus,vmon-pol-inv : Boolean to determine Amplifier will invert the
+  polarity of outbound VMON feedback data
+
+  - cirrus,dcm-mode-enable : Boost converter automatic DCM Mode enable.
+  This enables the digital boost converter to operate in a low power
+  (Discontinuous Conduction) mode during low loading conditions.
+
+  - cirrus,weak-fet-disable : Boolean : The strength of the output drivers is
+  reduced when operating in a Weak-FET Drive Mode and must not be used to drive
+  a large load.
+
+  - cirrus,classh-wk-fet-delay :  Weak-FET entry delay. Controls the delay
+  (in ms) before the Class H algorithm switches to the weak-FET voltage
+  (after the audio falls and remains below the value specified in WKFET_AMP_THLD).
+
+  0 = 0ms
+  1 = 5ms
+  2 = 10ms
+  3 = 50ms
+  4 = 100ms (Default)
+  5 = 200ms
+  6 = 500ms
+  7 = 1000ms
+
+  - cirrus,classh-weak-fet-thld-millivolt : Weak-FET amplifier drive threshold.
+  Configures the signal threshold at which the PWM output stage enters
+  weak-FET operation. The range is 50mV to 700mV in 50mV increments.
+
+  - cirrus,temp-warn-threshold :  Amplifier overtemperature warning threshold.
+  Configures the threshold at which the overtemperature warning condition occurs.
+  When the threshold is met, the overtemperature warning attenuation is applied
+  and the TEMP_WARN_EINT interrupt status bit is set.
+  If TEMP_WARN_MASK = 0, INTb is asserted.
+
+  0 = 105C
+  1 = 115C
+  2 = 125C (Default)
+  3 = 135C
+
+  - cirrus,irq-drive-select : Selects the driver type of the selected interrupt
+  output.
+
+  0 = Open-drain
+  1 = Push-pull (Default)
+
+  - cirrus,irq-gpio-select : Selects the pin to serve as the programmable
+  interrupt output.
+
+  0 = PDM_DATA / SWIRE_SD / INT (Default)
+  1 = GPIO
+
+Optional properties for the "cirrus,vpbr-config" Sub-node
+
+  - cirrus,vpbr-en : VBST brownout prevention enable. Configures whether the
+  VBST brownout prevention algorithm is enabled or disabled.
+
+  0 = VBST brownout prevention disabled (default)
+  1 = VBST brownout prevention enabled
+
+  See Section 7.31.1 VPBR Config for configuration options & further details
+
+  - cirrus,vpbr-thld : Initial VPBR threshold. Configures the VP brownout
+  threshold voltage
+
+  - cirrus,cirrus,vpbr-atk-rate : Attenuation attack step rate. Configures the
+  amount delay between consecutive volume attenuation steps when a brownout
+  condition is present and the VP brownout condition is in an attacking state.
+
+  - cirrus,vpbr-atk-vol : VP brownout prevention step size. Configures the VP
+  brownout prevention attacking attenuation step size when operating in either
+  digital volume or analog gain modes.
+
+  - cirrus,vpbr-max-attn : Maximum attenuation that the VP brownout prevention
+  can apply to the audio signal.
+
+  - cirrus,vpbr-wait : Configures the delay time between a brownout condition
+  no longer being present and the VP brownout prevention entering an attenuation
+  release state.
+
+  - cirrus,vpbr-rel-rate : Attenuation release step rate. Configures the delay
+  between consecutive volume attenuation release steps when a brownout condition
+  is not longer present and the VP brownout is in an attenuation release state.
+
+  - cirrus,vpbr-mute-en : During the attack state, if the vpbr-max-attn value
+  is reached, the error condition still remains, and this bit is set, the audio
+  is muted.
+
+Example:
+
+cs35l36: cs35l36@40 {
+	compatible = "cirrus,cs35l36";
+	reg = <0x40>;
+	VA-supply = <&dummy_vreg>;
+	VP-supply = <&dummy_vreg>;
+	reset-gpios = <&gpio0 54 0>;
+	interrupt-parent = <&gpio8>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+	cirrus,boost-ind-nanohenry = <1000>;
+	cirrus,boost-ctl-millivolt = <10000>;
+	cirrus,boost-peak-milliamp = <4500>;
+	cirrus,boost-ctl-select = <0x00>;
+	cirrus,weak-fet-delay = <0x04>;
+	cirrus,weak-fet-thld = <0x01>;
+	cirrus,temp-warn-threshold = <0x01>;
+	cirrus,multi-amp-mode;
+	cirrus,irq-drive-select = <0x01>;
+	cirrus,irq-gpio-select = <0x01>;
+
+	cirrus,vpbr-config {
+		cirrus,vpbr-en = <0x00>;
+		cirrus,vpbr-thld = <0x05>;
+		cirrus,vpbr-atk-rate = <0x02>;
+		cirrus,vpbr-atk-vol = <0x01>;
+		cirrus,vpbr-max-attn = <0x09>;
+		cirrus,vpbr-wait = <0x01>;
+		cirrus,vpbr-rel-rate = <0x05>;
+		cirrus,vpbr-mute-en = <0x00>;
+	};
+};
-- 
2.20.1
