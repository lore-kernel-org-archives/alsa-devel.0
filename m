From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [RFC][PATCH 1/3] ASoC: core: Move the default regmap I/O setting to snd_soc_register_codec()
Date: Tue, 4 Mar 2014 16:25:27 +0800
Message-ID: <1393921529-28985-2-git-send-email-Li.Xiubo@freescale.com>
References: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Add the default regmap I/O setting to snd_soc_register_codec() while
the CODEC is initialising, which will be called by CODEC driver device
probe(), and then we can make set_cache_io() go away entirely from each
CODEC ASoC probe.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 include/sound/soc.h  |  3 +++
 sound/soc/soc-core.c | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4c4d7e1..94bc1c4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -749,6 +749,9 @@ struct snd_soc_codec_driver {
 	int (*set_pll)(struct snd_soc_codec *codec, int pll_id, int source,
 		unsigned int freq_in, unsigned int freq_out);
 
+	/* codec regmap */
+	struct regmap *regmap;
+
 	/* codec IO */
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a14155b..0fb502f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4443,6 +4443,17 @@ int snd_soc_register_codec(struct device *dev,
 	codec->num_dai = num_dai;
 	mutex_init(&codec->mutex);
 
+	if (!codec->write && (codec_drv->regmap ||
+			      dev_get_regmap(codec->dev, NULL))) {
+		/* Set the default I/O up try regmap */
+		ret = snd_soc_codec_set_cache_io(codec, codec_drv->regmap);
+		if (ret < 0 && ret != -ENOTSUPP) {
+			dev_err(codec->dev,
+				"Failed to set cache I/O: %d\n", ret);
+			goto fail_codec_name;
+		}
+	}
+
 	for (i = 0; i < num_dai; i++) {
 		fixup_codec_formats(&dai_drv[i].playback);
 		fixup_codec_formats(&dai_drv[i].capture);
-- 
1.8.4
