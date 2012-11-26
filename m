From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 03/14] ASoC: wm8400: Use devm_regulator_bulk_get
Date: Mon, 26 Nov 2012 17:19:36 +0530
Message-ID: <1353930587-12907-4-git-send-email-sachin.kamat@linaro.org>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f51.google.com (mail-da0-f51.google.com
 [209.85.210.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 31BA2265089
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 12:56:24 +0100 (CET)
Received: by mail-da0-f51.google.com with SMTP id i30so2953117dad.38
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 03:56:23 -0800 (PST)
In-Reply-To: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

devm_regulator_bulk_get() is device managed and makes error
handling and code cleanup simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/wm8400.c |   14 +++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 5d277a9..262c440 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1373,7 +1373,7 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 	codec->control_data = priv->wm8400 = wm8400;
 	priv->codec = codec;
 
-	ret = regulator_bulk_get(wm8400->dev,
+	ret = devm_regulator_bulk_get(wm8400->dev,
 				 ARRAY_SIZE(power), &power[0]);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to get regulators: %d\n", ret);
@@ -1398,15 +1398,9 @@ static int wm8400_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8400_LEFT_OUTPUT_VOLUME, 0x50 | (1<<8));
 	snd_soc_write(codec, WM8400_RIGHT_OUTPUT_VOLUME, 0x50 | (1<<8));
 
-	if (!schedule_work(&priv->work)) {
-		ret = -EINVAL;
-		goto err_regulator;
-	}
+	if (!schedule_work(&priv->work))
+		return -EINVAL;
 	return 0;
-
-err_regulator:
-	regulator_bulk_free(ARRAY_SIZE(power), power);
-	return ret;
 }
 
 static int  wm8400_codec_remove(struct snd_soc_codec *codec)
@@ -1417,8 +1411,6 @@ static int  wm8400_codec_remove(struct snd_soc_codec *codec)
 	snd_soc_write(codec, WM8400_POWER_MANAGEMENT_1,
 		     reg & (~WM8400_CODEC_ENA));
 
-	regulator_bulk_free(ARRAY_SIZE(power), power);
-
 	return 0;
 }
 
-- 
1.7.4.1
