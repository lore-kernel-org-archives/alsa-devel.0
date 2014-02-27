From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 3/3] ASoC: SGTL5000: Simplify ASoC probe code.
Date: Thu, 27 Feb 2014 17:49:53 +0800
Message-ID: <1393494593-26310-4-git-send-email-Li.Xiubo@freescale.com>
References: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393494593-26310-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index ab4754a..d3ed1be 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1352,14 +1352,6 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
 	int ret;
 	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
 
-	/* setup i2c data ops */
-	codec->control_data = sgtl5000->regmap;
-	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_REGMAP);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
-		return ret;
-	}
-
 	ret = sgtl5000_enable_regulators(codec);
 	if (ret)
 		return ret;
-- 
1.8.4
