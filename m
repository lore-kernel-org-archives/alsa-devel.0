From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: Add bindings documentation for
	DA7218 audio codec" to the asoc tree
Date: Mon, 30 Nov 2015 12:25:30 +0000
Message-ID: <E1a3NWM-0003QG-U5@debutante>
References: <6803c3c07d01b4803892bca8e88958037ea38cbc.1448461029.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 652962614A7
 for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2015 13:25:42 +0100 (CET)
In-Reply-To: <6803c3c07d01b4803892bca8e88958037ea38cbc.1448461029.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: Add bindings documentation for DA7218 audio codec

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

>From ee4105a589a3ea979850d9806ff3f69337da46a5 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Wed, 25 Nov 2015 14:24:33 +0000
Subject: [PATCH] ASoC: da7218: Add bindings documentation for DA7218 audio
 codec

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/da7218.txt | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7218.txt

diff --git a/Documentation/devicetree/bindings/sound/da7218.txt b/Documentation/devicetree/bindings/sound/da7218.txt
new file mode 100644
index 000000000000..5ca5a709b6aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/da7218.txt
@@ -0,0 +1,104 @@
+Dialog Semiconductor DA7218 Audio Codec bindings
+
+DA7218 is an audio codec with HP detect feature.
+
+======
+
+Required properties:
+- compatible : Should be "dlg,da7217" or "dlg,da7218"
+- reg: Specifies the I2C slave address
+
+- VDD-supply: VDD power supply for the device
+- VDDMIC-supply: VDDMIC power supply for the device
+- VDDIO-supply: VDDIO power supply for the device
+  (See Documentation/devicetree/bindings/regulator/regulator.txt for further
+   information relating to regulators)
+
+Optional properties:
+- interrupt-parent: Specifies the phandle of the interrupt controller to which
+  the IRQs from DA7218 are delivered to.
+- interrupts: IRQ line info for DA7218 chip.
+  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt for
+   further information relating to interrupt properties)
+- interrupt-names : Name associated with interrupt line. Should be "wakeup" if
+  interrupt is to be used to wake system, otherwise "irq" should be used.
+- wakeup-source: Flag to indicate this device can wake system (suspend/resume).
+
+- clocks : phandle and clock specifier for codec MCLK.
+- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
+- dlg,micbias1-lvl-millivolt : Voltage (mV) for Mic Bias 1
+	[<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>, <3000>]
+- dlg,micbias2-lvl-millivolt : Voltage (mV) for Mic Bias 2
+	[<1200>, <1600>, <1800>, <2000>, <2200>, <2400>, <2600>, <2800>, <3000>]
+- dlg,mic1-amp-in-sel : Mic1 input source type
+	["diff", "se_p", "se_n"]
+- dlg,mic2-amp-in-sel : Mic2 input source type
+	["diff", "se_p", "se_n"]
+- dlg,dmic1-data-sel : DMIC1 channel select based on clock edge.
+	["lrise_rfall", "lfall_rrise"]
+- dlg,dmic1-samplephase : When to sample audio from DMIC1.
+	["on_clkedge", "between_clkedge"]
+- dlg,dmic1-clkrate-hz : DMic1 clock frequency (Hz).
+	[<1500000>, <3000000>]
+- dlg,dmic2-data-sel : DMic2 channel select based on clock edge.
+	["lrise_rfall", "lfall_rrise"]
+- dlg,dmic2-samplephase : When to sample audio from DMic2.
+	["on_clkedge", "between_clkedge"]
+- dlg,dmic2-clkrate-hz : DMic2 clock frequency (Hz).
+	[<1500000>, <3000000>]
+- dlg,hp-diff-single-supply : Boolean flag, use single supply for HP
+			      (DA7217 only)
+
+======
+
+Optional Child node - 'da7218_hpldet' (DA7218 only):
+
+Optional properties:
+- dlg,jack-rate-us : Time between jack detect measurements (us)
+	[<5>, <10>, <20>, <40>, <80>, <160>, <320>, <640>]
+- dlg,jack-debounce : Number of debounce measurements taken for jack detect
+	[<0>, <2>, <3>, <4>]
+- dlg,jack-threshold-pct : Threshold level for jack detection (% of VDD)
+	[<84>, <88>, <92>, <96>]
+- dlg,comp-inv : Boolean flag, invert comparator output
+- dlg,hyst : Boolean flag, enable hysteresis
+- dlg,discharge : Boolean flag, auto discharge of Mic Bias on jack removal
+
+======
+
+Example:
+
+	codec: da7218@1a {
+		compatible = "dlg,da7218";
+		reg = <0x1a>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		wakeup-source;
+
+		VDD-supply = <&reg_audio>;
+		VDDMIC-supply = <&reg_audio>;
+		VDDIO-supply = <&reg_audio>;
+
+		clocks = <&clks 201>;
+		clock-names = "mclk";
+
+		dlg,micbias1-lvl-millivolt = <2600>;
+		dlg,micbias2-lvl-millivolt = <2600>;
+		dlg,mic1-amp-in-sel = "diff";
+		dlg,mic2-amp-in-sel = "diff";
+
+		dlg,dmic1-data-sel = "lrise_rfall";
+		dlg,dmic1-samplephase = "on_clkedge";
+		dlg,dmic1-clkrate-hz = <3000000>;
+		dlg,dmic2-data-sel = "lrise_rfall";
+		dlg,dmic2-samplephase = "on_clkedge";
+		dlg,dmic2-clkrate-hz = <3000000>;
+
+		da7218_hpldet {
+			dlg,jack-rate-us = <40>;
+			dlg,jack-debounce = <2>;
+			dlg,jack-threshold-pct = <84>;
+			dlg,hyst;
+		};
+	};
-- 
2.6.2
