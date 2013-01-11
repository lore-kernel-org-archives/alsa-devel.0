From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: tlv320dac33: Remove suspend/resume soc
	driver operations
Date: Fri, 11 Jan 2013 17:01:50 +0100
Message-ID: <1357920110-15213-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E49B26515C
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 17:01:53 +0100 (CET)
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
 sound/soc/codecs/tlv320dac33.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 782b0cd..4f35839 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1452,20 +1452,6 @@ static int dac33_soc_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int dac33_soc_suspend(struct snd_soc_codec *codec)
-{
-	dac33_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int dac33_soc_resume(struct snd_soc_codec *codec)
-{
-	dac33_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
 	.read = dac33_read_reg_cache,
 	.write = dac33_write_locked,
@@ -1476,8 +1462,6 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320dac33 = {
 	.reg_cache_default = dac33_reg,
 	.probe = dac33_soc_probe,
 	.remove = dac33_soc_remove,
-	.suspend = dac33_soc_suspend,
-	.resume = dac33_soc_resume,
 
 	.controls = dac33_snd_controls,
 	.num_controls = ARRAY_SIZE(dac33_snd_controls),
-- 
1.8.1
