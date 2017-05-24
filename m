From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: add .get_dai_id support" to the asoc tree
Date: Wed, 24 May 2017 18:45:45 +0100
Message-ID: <E1dDaLx-0003Rd-Fq@debutante>
References: <878tlvosk9.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <878tlvosk9.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Archit Taneja <architt@codeaurora.org>, Jose Abreu <joabreu@synopsys.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: add .get_dai_id support

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

>From 96203fb4237bf70f0fd0fa307ca2975077db3ceb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 May 2017 01:40:20 +0000
Subject: [PATCH] ASoC: hdmi-codec: add .get_dai_id support

ALSA SoC needs to know connected DAI ID for probing.
It is not a big problem if device/driver was only for sound,
but getting DAI ID will be difficult if device includes both
Video/Sound, like HDMI.
To solve this issue, this patch adds new .get_dai_id callback
on hdmi_codec_ops

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/hdmi-codec.h    |  9 +++++++++
 sound/soc/codecs/hdmi-codec.c | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 915c4357945c..9483c55f871b 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -18,9 +18,11 @@
 #ifndef __HDMI_CODEC_H__
 #define __HDMI_CODEC_H__
 
+#include <linux/of_graph.h>
 #include <linux/hdmi.h>
 #include <drm/drm_edid.h>
 #include <sound/asoundef.h>
+#include <sound/soc.h>
 #include <uapi/sound/asound.h>
 
 /*
@@ -87,6 +89,13 @@ struct hdmi_codec_ops {
 	 */
 	int (*get_eld)(struct device *dev, void *data,
 		       uint8_t *buf, size_t len);
+
+	/*
+	 * Getting DAI ID
+	 * Optional
+	 */
+	int (*get_dai_id)(struct snd_soc_component *comment,
+			  struct device_node *endpoint);
 };
 
 /* HDMI codec initalization data */
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 8659b76b066a..6d05161b625d 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -719,6 +719,18 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
 	.pcm_new = hdmi_codec_pcm_new,
 };
 
+static int hdmi_of_xlate_dai_id(struct snd_soc_component *component,
+				 struct device_node *endpoint)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+	int ret = -ENOTSUPP; /* see snd_soc_get_dai_id() */
+
+	if (hcp->hcd.ops->get_dai_id)
+		ret = hcp->hcd.ops->get_dai_id(component, endpoint);
+
+	return ret;
+}
+
 static struct snd_soc_codec_driver hdmi_codec = {
 	.component_driver = {
 		.controls		= hdmi_controls,
@@ -727,6 +739,7 @@ static struct snd_soc_codec_driver hdmi_codec = {
 		.num_dapm_widgets	= ARRAY_SIZE(hdmi_widgets),
 		.dapm_routes		= hdmi_routes,
 		.num_dapm_routes	= ARRAY_SIZE(hdmi_routes),
+		.of_xlate_dai_id	= hdmi_of_xlate_dai_id,
 	},
 };
 
-- 
2.11.0
