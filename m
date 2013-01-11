From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: twl4030: Remove suspend/resume soc
	driver operations
Date: Fri, 11 Jan 2013 17:01:41 +0100
Message-ID: <1357920101-15179-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 437AF26507D
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 17:01:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

With idle_bias_off these are no longer needed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 63b280b..5611b7b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2267,18 +2267,6 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 },
 };
 
-static int twl4030_soc_suspend(struct snd_soc_codec *codec)
-{
-	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int twl4030_soc_resume(struct snd_soc_codec *codec)
-{
-	twl4030_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
 static int twl4030_soc_probe(struct snd_soc_codec *codec)
 {
 	struct twl4030_priv *twl4030;
@@ -2316,8 +2304,6 @@ static int twl4030_soc_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_twl4030 = {
 	.probe = twl4030_soc_probe,
 	.remove = twl4030_soc_remove,
-	.suspend = twl4030_soc_suspend,
-	.resume = twl4030_soc_resume,
 	.read = twl4030_read_reg_cache,
 	.write = twl4030_write,
 	.set_bias_level = twl4030_set_bias_level,
-- 
1.8.1
