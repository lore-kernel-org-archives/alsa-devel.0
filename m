From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH  V1 1/6] ASoC: tlv320aic26: Add device tree binding
Date: Fri, 25 Sep 2015 14:30:04 -0400
Message-ID: <1443205809-27549-2-git-send-email-jcormier@criticallink.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
 <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443205809-27549-1-git-send-email-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Cormier, Jonathan" <jcormier@criticallink.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 .../devicetree/bindings/sound/tlv320aic26.txt      | 65 ++++++++++++++++++++++
 sound/soc/codecs/tlv320aic26.c                     |  6 ++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.txt

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic26.txt b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
new file mode 100644
index 000000000000..93aa0f76ec0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
@@ -0,0 +1,65 @@
+Texas Instruments - tlv320aic26 Codec module
+
+The tlv320aic26 serial control bus communicates through I2C protocols
+
+Required properties:
+
+- compatible - "string" - One of:
+    "ti,tlv320aic26" - TLV320AIC26
+- reg - <int> -  SPI chip select
+
+CODEC input pins:
+  * MICIN
+  * AUX
+
+CODEC output pins:
+  * HPL
+  * HPR
+
+The pins can be used in referring sound node's audio-routing property.
+
+Example:
+
+tlv320aic26: tlv320aic26@0 {
+	compatible = "ti,tlv320aic26";
+	reg = <0>;
+};
+
+&spi0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-1 = <&spi0_sleep_pins>;
+
+	status = "okay";
+	ti,pindir-d0-out-d1-in = <1>;
+
+	tlv320aic26: tlv320aic26@1 {
+		compatible = "ti,tlv320aic26";
+		reg = <0x1>;
+		status = "okay";
+
+		spi-max-frequency = <2000000>;
+		spi-cpha;
+	};
+};
+
+sound {
+	compatible = "simple-audio-card";
+	simple-audio-card,name = "AM335x_SND";
+	simple-audio-card,format = "dsp_b";
+	/* SND_SOC_DAIFMT_CBM_CFM */
+	simple-audio-card,bitclock-master = <&tlv320aic26_codec>;
+	simple-audio-card,frame-master = <&tlv320aic26_codec>;
+	/* SND_SOC_DAIFMT_IB_NF */
+	simple-audio-card,bitclock-inversion;
+
+	simple-audio-card,cpu {
+		sound-dai = <&mcasp1>;
+		system-clock-frequency = <24576000>;
+	};
+
+	tlv320aic26_codec: simple-audio-card,codec {
+		sound-dai = <&tlv320aic26>;
+		system-clock-frequency = <24576000>;
+	};
+};
diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 620ab9ea1ef0..65c2bfb02e76 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -370,10 +370,16 @@ static int aic26_spi_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct of_device_id tlv320aic26_of_match[] = {
+	{ .compatible = "ti,tlv320aic26", },
+	{},
+};
+
 static struct spi_driver aic26_spi = {
 	.driver = {
 		.name = "tlv320aic26-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(tlv320aic26_of_match),
 	},
 	.probe = aic26_spi_probe,
 	.remove = aic26_spi_remove,
-- 
1.9.1
