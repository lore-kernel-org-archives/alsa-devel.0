From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 2/3] ASoC: core: Set the default I/O up try regmap.
Date: Thu, 27 Feb 2014 17:49:52 +0800
Message-ID: <1393494593-26310-3-git-send-email-Li.Xiubo@freescale.com>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

For most CODEC drivers which the REGMAP is used, the soc_probe_codec()
will do the stuff work of snd_soc_codec_set_cache_io(), which the CODEC
drivers' ASoC probe will do too, and almost at the same time.

This patch set the default I/O up try regmap, and then the CODEC drivers'
stuff work of snd_soc_codec_set_cache_io() will be redundant, while if one
CODEC driver needed to set it's own I/O, then it can rewrite the default ones.
Then could we just discard the snd_soc_codec_set_cache_io() from the CODEC
drivers' ASoC probe to simplify the code.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e5a535b..c159a34 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1137,6 +1137,10 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
+	/* Set the default I/O up try regmap */
+	if (dev_get_regmap(codec->dev, NULL))
+		snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
+
 	if (driver->probe) {
 		ret = driver->probe(codec);
 		if (ret < 0) {
@@ -1150,10 +1154,6 @@ static int soc_probe_codec(struct snd_soc_card *card,
 			codec->name);
 	}
 
-	/* If the driver didn't set I/O up try regmap */
-	if (!codec->write && dev_get_regmap(codec->dev, NULL))
-		snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
-
 	if (driver->controls)
 		snd_soc_add_codec_controls(codec, driver->controls,
 				     driver->num_controls);
-- 
1.8.4
