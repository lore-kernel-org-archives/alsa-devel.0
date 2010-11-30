From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Simplify pm860x_probe error handling
Date: Tue, 30 Nov 2010 15:34:11 +0800
Message-ID: <1291102451.6929.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simplify pm860x_probe error handling and return actual error code we got.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/88pm860x-codec.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 7e4d880..08e15de 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1358,7 +1358,7 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 					   pm860x->name[i], pm860x);
 		if (ret < 0) {
 			dev_err(codec->dev, "Failed to request IRQ!\n");
-			goto out_irq;
+			goto out;
 		}
 	}
 
@@ -1369,7 +1369,7 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to fill register cache: %d\n",
 			ret);
-		goto out_codec;
+		goto out;
 	}
 
 	snd_soc_add_controls(codec, pm860x_snd_controls,
@@ -1379,12 +1379,10 @@ static int pm860x_probe(struct snd_soc_codec *codec)
 	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
 	return 0;
 
-out_codec:
-	i = 3;
-out_irq:
-	for (; i >= 0; i--)
+out:
+	while (--i >= 0)
 		free_irq(pm860x->irq[i], pm860x);
-	return -EINVAL;
+	return ret;
 }
 
 static int pm860x_remove(struct snd_soc_codec *codec)
-- 
1.7.2
