From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Add bindings documentation for
	DA7219 audio codec" to the asoc tree
Date: Fri, 02 Oct 2015 18:13:44 +0100
Message-ID: <E1Zi3tw-00081J-49@finisterre>
References: <4565872dd2854a249ff2e93f126f2b8b9faf848a.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A70426070C
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 19:13:52 +0200 (CEST)
In-Reply-To: <4565872dd2854a249ff2e93f126f2b8b9faf848a.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Add bindings documentation for DA7219 audio codec

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

>From b29759ee29d5592b686bb42bb007179c215297c0 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 29 Sep 2015 16:44:07 +0100
Subject: [PATCH] ASoC: da7219: Add bindings documentation for DA7219 audio
 codec

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7219.txt

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
new file mode 100644
index 0000000..1b70309
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
+- interrupt-parent : Specifies the phandle of the interrupt controller to which
+  the IRQs from DA7219 are delivered to.
+- interrupts : IRQ line info for DA7219.
+  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+   further information relating to interrupt properties)
+
+- VDD-supply: VDD power supply for the device
+- VDDMIC-supply: VDDMIC power supply for the device
+- VDDIO-supply: VDDIO power supply for the device
+  (See Documentation/devicetree/bindings/regulator/regulator.txt for further
+   information relating to regulators)
+
+Optional properties:
+- interrupt-names : Name associated with interrupt line. Should be "wakeup" if
+  interrupt is to be used to wake system, otherwise "irq" should be used.
+- wakeup-source: Flag to indicate this device can wake system (suspend/resume).
+
+- clocks : phandle and clock specifier for codec MCLK.
+- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
+- dlg,ldo-lvl : Required internal LDO voltage (mV) level for digital engine
+	[<1050>, <1100>, <1200>, <1400>]
+- dlg,micbias-lvl : Voltage (mV) for Mic Bias
+	[<1800>, <2000>, <2200>, <2400>, <2600>]
+- dlg,mic-amp-in-sel : Mic input source type
+	["diff", "se_p", "se_n"]
+
+======
+
+Child node - 'da7219_aad':
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
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+
+		VDD-supply = <&reg_audio>;
+		VDDMIC-supply = <&reg_audio>;
+		VDDIO-supply = <&reg_audio>;
+
+		clocks = <&clks 201>;
+		clock-names = "mclk";
+
+		dlg,ldo-lvl = <1200>;
+		dlg,micbias-lvl = <2600>;
+		dlg,mic-amp-in-sel = "diff";
+
+		da7219_aad {
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
2.5.0
