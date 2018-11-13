From: James Schulman <james.schulman@cirrus.com>
Subject: [PATCH 2/2] ASoC: cs35l36: Add device tree
	documentation for CS35L36
Date: Tue, 13 Nov 2018 12:49:17 -0600
Message-ID: <1542134957-2395-2-git-send-email-james.schulman@cirrus.com>
References: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 21C4B267A61
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 19:47:35 +0100 (CET)
In-Reply-To: <1542134957-2395-1-git-send-email-james.schulman@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, paul.handrigan@cirrus.com, robh+dt@kernel.org, broonie@kernel.org, charles.keepax@cirrus.com
List-Id: alsa-devel@alsa-project.org

Add device tree documentation for Cirrus Logic CS35L36
speaker amplifier

Signed-off-by: James Schulman <james.schulman@cirrus.com>
---
 .../devicetree/bindings/sound/cs35l36.txt          | 192 +++++++++++++++++++++
 1 file changed, 192 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l36.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l36.txt b/Documentation/devicetree/bindings/sound/cs35l36.txt
new file mode 100644
index 0000000..f3c2088
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l36.txt
@@ -0,0 +1,192 @@
+CS35L36 Speaker Amplifier
+
+Required properties:
+
+  - compatible : "cirrus,cs35l36"
+
+  - reg : the I2C address of the device for I2C
+
+  - VA-supply, VP-supply : power supplies for the device,
+    as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Optional properties:
+  - cirrus,sclk-force-output : Audio serial port SCLK force
+  output control. Forces the SCLK to continue to drive even
+  if no ASP_TXn channels are enabled.
+
+  - cirrus,lrclk-force-output : Audio serial port LRCLK force
+  output control. Forces the LRCLK to continue to drive even
+  if no ASP_TXn channels are enabled.
+
+  - cirrus,multi-amp-mode : Boolean to determine if there are more than
+  one amplifier in the system. If more than one it is best to Hi-Z the ASP
+  port to prevent bus contention on the output signal
+
+  - cirrus,boost-ctl-millivolt : Boost Voltage Value.  Configures the boost
+  converter's output voltage in mV. The range is from 2550mV to 12000mV with
+  increments of 50mV.
+  (Default) VP
+
+  - cirrus,boost-ctl-select : Boost conerter control source selection.
+  Selects the source of the BST_CTL target VBST voltage for the boost
+  converter to generate.
+  0x00 - Control Port Value
+  0x01 - Class H Tracking (Default)
+  0x10 - MultiDevice Sync Value
+
+  - cirrus,boost-peak-milliamp : Boost-converter peak current limit in mA.
+  Configures the peak current by monitoring the current through the boost FET.
+  Range starts at 1600mA and goes to a maximum of 4500mA with increments of
+  50mA.
+  (Default) 4.50 Amps
+
+  - cirrus,amp-gain-zc : Boolean to determine if to use Amplifier gain-change
+  zero-cross
+
+  - cirrus,amp-pcm-inv : Boolean to determine Amplifier will invert incoming
+  PCM data
+
+  - cirrus,ldm-mode-select : Amplifier level-dependent muting enable mode selection.
+  Configures whether the amplifier level-dependent muting is enabled for the various
+  blocks when the selected audio source has been below the AMP_LDM_THLD for a period
+  of time configured by AMP_LDM_DELAY. Any and all bits can be set.
+
+  00000 - All level-dependent muting functionality disabled (Default)
+  xxxx1 - Amplifier level-dependent muting detection enabled (OUT+/-; switching)
+  xxx1x - Boost converter DCM detection enabled
+  xx1xx - VMON low power mode detection enabled
+  x1xxx - IMON low power mode detection enabled
+  1xxxx - VP brownout prevention detection enabled
+
+  - cirrus,pdm-ldm-exit : Boolean : Amplifier PDM mode digital volume ramp enable.
+  When AMP_PDM_MODE = 1 controls whether the digital volume soft ramp is enabled
+  or disabled when exiting a level-dependent muted condition. The AMP_RAMP_PDM_DN
+  control is used to control desired ramp rate.
+
+  - cirrus,pdm-ldm-enter : Boolean: Amplifier PDM mode digital volume ramp enable.
+  When AMP_PDM_MODE = 1 controls whether the digital volume soft ramp is enabled
+  or disabled when entering a level-dependent muted condition. The AMP_RAMP_PDM_UP
+  control is used to control desired ramp rate.
+
+  - cirrus,imon-pol-inv : Boolean to determine Amplifier will invert the
+  polarity of outbound IMON feedback data
+
+  - cirrus,vmon-pol-inv : Boolean to determine Amplifier will invert the
+  polarity of outbound VMON feedback data
+
+  - cirrus,pdm-channel-select : PDM Channel select.
+  0x00 (Default) : Selects Channel A data when the PDM audio input is selected.
+  0x01 : Selects Channel B data when the PDM audio input is selected
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
+	cirrus,boost-ctl-select = <0x00>;
+	cirrus,boost-peak-milliamp = <4500>;
+	cirrus,amp-gain-zc;
+	cirrus,ldm-mode-select = <0x01>;
+	cirrus,pdm-ldm-exit;
+	cirrus,pdm-ldm-enter;
+	cirrus,weak-fet-delay = <0x04>;
+	cirrus,weak-fet-thld = <0x01>;
+	cirrus,temp-warn-threshold = <0x01>;
+	cirrus,multi-amp-mode;
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
+
+	cirrus,irq-config {
+		cirrus,irq-drive-select = <0x01>;
+		cirrus,irq-polarity = <0x00>;
+		cirrus,irq-gpio-select = <0x01>;
+		cirrus,irq-output-enable = <0x01>;
+		cirrus,irq-src-select = <0x01>;
+	};
+};
-- 
1.9.1
