From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v9 3/3] ASoC: mediatek: Add jack detection support to the
 mt8173-rt5650 machine driver
Date: Tue, 15 Nov 2016 19:52:40 +0100
Message-ID: <1479235960-23696-4-git-send-email-p.zabel@pengutronix.de>
References: <1479235960-23696-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1479235960-23696-1-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Find the HDMI state notifier device (CEC) in the device tree and pass it
to hdmi-codec.

Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
Changes since v8:
 - Rebased onto the "video: add HDMI state notifier support" patch.
   Now we look for the CEC device in the device tree to pass it to
   hdmi_codec_set_jack_detect.
---
 sound/soc/mediatek/mt8173/mt8173-rt5650.c | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/soc/mediatek/mt8173/mt8173-rt5650.c b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
index ba65f41..daf00cf 100644
--- a/sound/soc/mediatek/mt8173/mt8173-rt5650.c
+++ b/sound/soc/mediatek/mt8173/mt8173-rt5650.c
@@ -17,7 +17,9 @@
 #include <linux/module.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/of_platform.h>
 #include <sound/soc.h>
+#include <sound/hdmi-codec.h>
 #include <sound/jack.h>
 #include "../../codecs/rt5645.h"
 
@@ -166,6 +168,27 @@ static struct snd_soc_dai_link_component mt8173_rt5650_codecs[] = {
 	},
 };
 
+static struct snd_soc_jack mt8173_hdmi_card_jack;
+
+static int mt8173_hdmi_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_codec *codec = runtime->codec;
+	struct device *cec_dev = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	/* Enable jack detection */
+	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &mt8173_hdmi_card_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "HDMI Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	return hdmi_codec_set_jack_detect(codec, &mt8173_hdmi_card_jack,
+					  cec_dev);
+}
+
 enum {
 	DAI_LINK_PLAYBACK,
 	DAI_LINK_CAPTURE,
@@ -228,6 +251,7 @@ static struct snd_soc_dai_link mt8173_rt5650_dais[] = {
 		.no_pcm = 1,
 		.codec_dai_name = "i2s-hifi",
 		.dpcm_playback = 1,
+		.init = mt8173_hdmi_init,
 	},
 };
 
@@ -249,6 +273,8 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &mt8173_rt5650_card;
 	struct device_node *platform_node;
 	struct device_node *np;
+	struct device_node *cec_np;
+	struct platform_device *cec_pdev;
 	const char *codec_capture_dai;
 	int i, ret;
 
@@ -313,6 +339,22 @@ static int mt8173_rt5650_dev_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 	platform_set_drvdata(pdev, card);
 
+	/* The CEC module handles HDMI hotplug detection */
+	cec_np = of_find_compatible_node(pdev->dev.of_node->parent, NULL,
+					 "mediatek,mt8173-cec");
+	if (!cec_np) {
+		dev_err(&pdev->dev, "Failed to find CEC node\n");
+		return -EINVAL;
+	}
+
+	cec_pdev = of_find_device_by_node(cec_np);
+	if (!cec_pdev) {
+		dev_err(&pdev->dev, "Waiting for CEC device %s\n",
+			cec_np->full_name);
+		return -EPROBE_DEFER;
+	}
+
+	snd_soc_card_set_drvdata(card, &cec_pdev->dev);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret)
 		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
-- 
2.10.2
