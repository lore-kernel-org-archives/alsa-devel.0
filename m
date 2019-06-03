From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 6/7] ASoC: rockchip_max98090: Add HDMI jack support
Date: Mon,  3 Jun 2019 12:32:50 +0800
Message-ID: <20190603043251.226549-7-cychiang@chromium.org>
References: <20190603043251.226549-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190603043251.226549-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kern
List-Id: alsa-devel@alsa-project.org

In machine driver, create a jack and let hdmi-codec report jack status.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/rockchip/rockchip_max98090.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index 2dd247670c7a..17c50d9fbac1 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gpio.h>
@@ -27,6 +28,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/hdmi-codec.h>
 
 #include "rockchip_i2s.h"
 #include "../codecs/ts3a227e.h"
@@ -131,6 +133,26 @@ enum {
 	DAILINK_HDMI,
 };
 
+static struct snd_soc_jack rk_hdmi_jack;
+
+static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct snd_soc_component *component = runtime->codec_dai->component;
+	struct device *hdmi_dev = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	/* enable jack detection */
+	ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &rk_hdmi_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
+		return ret;
+	}
+
+	return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack, hdmi_dev);
+}
+
 /* max98090 and HDMI codec dai_link */
 static struct snd_soc_dai_link rk_dailinks[] = {
 	[DAILINK_MAX98090] = {
@@ -148,6 +170,7 @@ static struct snd_soc_dai_link rk_dailinks[] = {
 		.ops = &rk_aif1_ops,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
+		.init = rk_hdmi_init,
 	}
 };
 
@@ -200,6 +223,8 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_cpu;
 	struct of_phandle_args args;
+	struct device_node *np_hdmi;
+	struct platform_device *hdmi_pdev;
 
 	/* register the soc card */
 	card->dev = &pdev->dev;
@@ -248,6 +273,22 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* The hdmi device handles HDMI hotplug detection */
+	np_hdmi = of_parse_phandle(np, "rockchip,hdmi", 0);
+	if (!np_hdmi) {
+		dev_err(&pdev->dev, "Failed to find HDMI node\n");
+		return -EINVAL;
+	}
+
+	hdmi_pdev = of_find_device_by_node(np_hdmi);
+	if (!hdmi_pdev) {
+		dev_err(&pdev->dev, "Waiting for HDMI device %s\n",
+			np_hdmi->full_name);
+		return -EPROBE_DEFER;
+	}
+
+	snd_soc_card_set_drvdata(card, &hdmi_pdev->dev);
+
 	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.22.0.rc1.257.g3120a18244-goog
