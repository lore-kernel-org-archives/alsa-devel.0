From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/3] ASoC: da7219: Add bindings documentation
 for DA7219 audio codec
Date: Thu, 17 Sep 2015 17:01:16 +0100
Message-ID: <381b367e0a4c6c9e00db74f1b0e91d383156ba86.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BCBC264E9F
 for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2015 18:01:20 +0200 (CEST)
In-Reply-To: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jason Coughlan <jason.coughlan@diasemi.com>, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7219.txt

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
new file mode 100644
index 0000000..b29fe2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -0,0 +1,106 @@
+Dialog Semiconductor DA7219 Audio Codec bindings
+
+DA7219 is an audio codec with advanced accessory detect features.
+
+======
+
+Required properties:
+- compatible : Should be "dlg,da7219"
+- reg: Specifies the I2C slave address
+
+Optional properties:
+- wakeup-source: Flag to indicate this device can wake system (suspend/resume).
+
+- clocks : phandle and clock specifier for codec MCLK.
+- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
+- dlg,io-lvl : Expected voltage level range for digital IO
+	["2.5V_3.6V", "1.2V_2.8V"]
+- dlg,ldo-lvl : Required internal LDO voltage (mV) level
+	[<1050>, <1100>, <1200>, <1400>]
+- dlg,micbias-lvl : Voltage (mV) for Mic Bias
+	[<1800>, <2000>, <2200>, <2400>, <2600>, <2800>, <3000>]
+- dlg,mic-amp-in-sel : Mic input source type
+	["diff", "se_p", "se_n"]
+- dlg,cp-mchange : Charge pump voltage tracking mode
+	["largest_vol", "dac_vol", "sig_mag"]
+- dlg,cp-vol-thresh : Charge pump volume threshold value (6-bit value)
+	[ 0 - 0x3F ]
+
+======
+
+Child node - 'da7219_aad':
+
+Required properties:
+- interrupt-parent : Specifies the phandle of the interrupt controller to which
+  the IRQs from DA7219 AAD block are delivered to.
+- interrupts : IRQ line info for DA7219 AAD block.
+  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+   further information relating to interrupt properties)
+
+Optional properties:
+- dlg,micbias-pulse-lvl : Mic bias higher voltage pulse level (mV).
+	[<2800>, <2900>]
+- dlg,micbias-pulse-time : Mic bias higher voltage pulse duration (ms)
+- dlg,btn-cfg : Periodic button press measurements for 4-pole jack (ms)
+	[<2>, <5>, <10>, <50>, <100>, <200>, <500>]
+- dlg,mic-det-thr : Impedance threshold for mic detection measurement (Ohms)
+	[<200>, <500>, <750>, <1000>]
+- dlg,jack-ins-deb : Debounce time for jack insertion (ms)
+	[<5>, <10>, <20>, <50>, <100>, <200>, <500>, <1000>]
+- dlg,jack-det-rate: Jack type detection latency (3/4 pole)
+	["32ms_64ms", "64ms_128ms", "128ms_256ms", "256ms_512ms"]
+- dlg,jack-rem-deb : Debounce time for jack removal (ms)
+	[<1>, <5>, <10>, <20>]
+- dlg,a-d-btn-thr : Impedance threshold between buttons A and D
+	[0x0 - 0xFF]
+- dlg,d-b-btn-thr : Impedance threshold between buttons D and B
+	[0x0 - 0xFF]
+- dlg,b-c-btn-thr : Impedance threshold between buttons B and C
+	[0x0 - 0xFF]
+- dlg,c-mic-btn-thr : Impedance threshold between button C and Mic
+	[0x0 - 0xFF]
+- dlg,btn-avg : Number of 8-bit readings for averaged button measurement
+	[<1>, <2>, <4>, <8>]
+- dlg,adc-1bit-rpt : Repeat count for 1-bit button measurement
+	[<1>, <2>, <4>, <8>]
+
+======
+
+Example:
+
+	codec: da7219@1a {
+		compatible = "dlg,da7219";
+		reg = <0x1a>;
+
+		clocks = <&clks 201>;
+		clock-names = "mclk";
+
+		dlg,io-lvl = "1.2V_2.8V";
+		dlg,ldo-lvl = <1200>;
+
+		dlg,micbias-lvl = <2600>;
+		dlg,mic-amp-in-sel = "diff";
+
+		dlg,cp-mchange = "sig_mag";
+		dlg,cp-vol-thresh = <0x34>;
+
+		da7219_aad {
+			interrupt-parent = <&gpio6>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+
+			dlg,btn-cfg = <50>;
+			dlg,mic-det-thr = <500>;
+			dlg,jack-ins-deb = <20>;
+			dlg,jack-det-rate = "32ms_64ms";
+			dlg,jack-rem-deb = <1>;
+
+			dlg,a-d-btn-thr = <0xa>;
+			dlg,d-b-btn-thr = <0x16>;
+			dlg,b-c-btn-thr = <0x21>;
+			dlg,c-mic-btn-thr = <0x3E>;
+
+			dlg,btn-avg = <4>;
+			dlg,adc-1bit-rpt = <1>;
+		};
+	};
-- 
1.9.3
