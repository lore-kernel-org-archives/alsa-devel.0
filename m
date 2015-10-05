From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: da7213: Add bindings documentation for codec driver
Date: Mon, 5 Oct 2015 16:40:20 +0100
Message-ID: <d86c170c3eaea34e128026b04126b699e0311d65.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1444042230.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7213.txt | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/da7213.txt

diff --git a/Documentation/devicetree/bindings/sound/da7213.txt b/Documentation/devicetree/bindings/sound/da7213.txt
new file mode 100644
index 0000000..7280e82
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/da7213.txt
@@ -0,0 +1,41 @@
+Dialog Semiconductor DA7213 Audio Codec bindings
+
+======
+
+Required properties:
+- compatible : Should be "dlg,da7213"
+- reg: Specifies the I2C slave address
+
+Optional properties:
+- clocks : phandle and clock specifier for codec MCLK.
+- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
+- dlg,micbias1-lvl : Voltage (mV) for Mic Bias 1
+	[<1600>, <2200>, <2500>, <3000>]
+- dlg,micbias2-lvl : Voltage (mV) for Mic Bias 2
+	[<1600>, <2200>, <2500>, <3000>]
+- dlg,dmic-data-sel : DMIC channel select based on clock edge.
+	["lrise_rfall", "lfall_rrise"]
+- dlg,dmic-samplephase : When to sample audio from DMIC.
+	["on_clkedge", "between_clkedge"]
+- dlg,dmic-clkrate : DMIC clock frequency (MHz).
+	[<1500000>, <3000000>]
+
+======
+
+Example:
+
+	codec_i2c: da7213@1a {
+		compatible = "dlg,da7213";
+ 		reg = <0x1a>;
+
+ 		clocks = <&clks 201>;
+		clock-names = "mclk";
+
+		dlg,micbias1-lvl = <2500>;
+		dlg,micbias2-lvl = <2500>;
+
+		dlg,dmic-data-sel = "lrise_rfall";
+		dlg,dmic-samplephase = "between_clkedge";
+		dlg,dmic-clkrate = <3000000>;
+	};
-- 
1.9.3
