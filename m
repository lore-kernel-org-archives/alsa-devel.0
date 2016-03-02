From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v5 9/9] ASoC: mediatek: Add HDMI dai-links to the
 mt8173-rt5650 machine driver
Date: Wed,  2 Mar 2016 15:49:13 +0100
Message-ID: <1456930153-11853-10-git-send-email-p.zabel@pengutronix.de>
References: <1456930153-11853-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1456930153-11853-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

This patch adds HDMI audio output support to the MT8173 RT5650 machine
driver.

Signed-off-by: PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |  5 ++-
 sound/soc/mediatek/Kconfig                         |  1 +
 sound/soc/mediatek/mt8173-rt5650.c                 | 47 ++++++++++++++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
index fe5a5ef..6b182c4 100644
--- a/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
+++ b/Documentation/devicetree/bindings/sound/mt8173-rt5650.txt
@@ -1,15 +1,16 @@
-MT8173 with RT5650 CODECS
+MT8173 with RT5650 CODECS and HDMI via I2S
 
 Required properties:
 - compatible : "mediatek,mt8173-rt5650"
 - mediatek,audio-codec: the phandles of rt5650 codecs
+                        and of the hdmi encoder node
 - mediatek,platform: the phandle of MT8173 ASoC platform
 
 Example:
 
 	sound {
 		compatible = "mediatek,mt8173-rt5650";
-		mediatek,audio-codec = <&rt5650>;
+		mediatek,audio-codec = <&rt5650 &hdmi0>;
 		mediatek,platform = <&afe>;
 	};
 
diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 6c88087..1a8c844 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -21,6 +21,7 @@ config SND_SOC_MT8173_RT5650
         tristate "ASoC Audio driver for MT8173 with RT5650 codec"
         depends on SND_SOC_MEDIATEK && I2C
         select SND_SOC_RT5645
+        select SND_SOC_HDMI_CODEC
         help
           This adds ASoC driver for Mediatek MT8173 boards
           with the RT5650 audio codec.
diff --git a/sound/soc/mediatek/mt8173-rt5650.c b/sound/soc/mediatek/mt8173-rt5650.c
index bb09bb1..55eeca5 100644
--- a/sound/soc/mediatek/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173-rt5650.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <sound/soc.h>
+#include <sound/hdmi-codec.h>
 #include <sound/jack.h>
 #include "../codecs/rt5645.h"
 
@@ -114,10 +115,31 @@ static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
 	},
 };
 
+static struct snd_soc_jack mt8173_hdmi_card_jack;
+
+static int mt8173_hdmi_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_codec *codec = runtime->codec;
+	int ret;
+
+	/* enable jack detection */
+	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &mt8173_hdmi_card_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
+		return ret;
+	}
+
+	return hdmi_codec_set_jack_detect(codec, &mt8173_hdmi_card_jack);
+}
+
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
+	DAI_LINK_HDMI,
 	DAI_LINK_CODEC_I2S,
+	DAI_LINK_HDMI_I2S,
 };
 
 /* Digital audio interface glue - connects codec <---> CPU */
@@ -143,6 +165,16 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.dynamic = 1,
 		.dpcm_capture = 1,
 	},
+	[DAI_LINK_HDMI] = {
+		.name = "HDMI",
+		.stream_name = "HDMI PCM",
+		.cpu_dai_name = "HDMI",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+	},
 	/* Back End DAI links */
 	[DAI_LINK_CODEC_I2S] = {
 		.name = "Codec",
@@ -158,6 +190,14 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 	},
+	[DAI_LINK_HDMI_I2S] = {
+		.name = "HDMI BE",
+		.cpu_dai_name = "HDMIO",
+		.no_pcm = 1,
+		.codec_dai_name = "i2s-hifi",
+		.dpcm_playback = 1,
+		.init = mt8173_hdmi_init,
+	},
 };
 
 static struct snd_soc_card mt8173_rt5650_card = {
@@ -199,6 +239,13 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 			"Property 'audio-codec' missing or invalid\n");
 		return -EINVAL;
 	}
+	mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "mediatek,audio-codec", 1);
+	if (!mt8173_rt5650_dais[DAI_LINK_HDMI_I2S].codec_of_node) {
+		dev_err(&pdev->dev,
+			"Property 'audio-codec' missing or invalid\n");
+		return -EINVAL;
+	}
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
-- 
2.7.0
