From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [RFC][PATCH 3/3] ASoC: core: remove the default regmap I/O setting up from soc_probe_codec()
Date: Tue, 4 Mar 2014 16:25:29 +0800
Message-ID: <1393921529-28985-4-git-send-email-Li.Xiubo@freescale.com>
References: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393921529-28985-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Since all the CODEC drivers has using the snd_soc_register_codec()
to set up the CODEC I/O while the CODEC probing, so this could be
removed entirely.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/soc-core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0fb502f..bc3a930 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1137,16 +1137,6 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
-	if (!codec->write && dev_get_regmap(codec->dev, NULL)) {
-		/* Set the default I/O up try regmap */
-		ret = snd_soc_codec_set_cache_io(codec, NULL);
-		if (ret < 0) {
-			dev_err(codec->dev,
-				"Failed to set cache I/O: %d\n", ret);
-			goto err_probe;
-		}
-	}
-
 	if (driver->probe) {
 		ret = driver->probe(codec);
 		if (ret < 0) {
-- 
1.8.4
