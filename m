From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/5] ASoC: tlv320aic3x: Remove unnecessary
	suspend/resume bias level changes
Date: Tue,  2 Sep 2014 22:20:32 +0200
Message-ID: <1409689234-14774-4-git-send-email-lars@metafoo.de>
References: <1409689234-14774-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id BB6C82654D3
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 22:20:43 +0200 (CEST)
In-Reply-To: <1409689234-14774-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The ASoC core will only call the suspend/resume callbacks when the device's
DAPM context is idle. Since this driver sets idle_bias_off to true this
means that the device is already in SND_SOC_BIAS_OFF when the suspend
callback is called, so there is no need to manually set this state again.
There is also no need to go to SND_SOC_BIAS_STANDBY in the resume callback
since the core will go right back to SND_SOC_BIAS_OFF.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/tlv320aic3x.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 64f179e..f2c416d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1222,20 +1222,6 @@ static struct snd_soc_dai_driver aic3x_dai = {
 	.symmetric_rates = 1,
 };
 
-static int aic3x_suspend(struct snd_soc_codec *codec)
-{
-	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	return 0;
-}
-
-static int aic3x_resume(struct snd_soc_codec *codec)
-{
-	aic3x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
-	return 0;
-}
-
 static void aic3x_mono_init(struct snd_soc_codec *codec)
 {
 	/* DAC to Mono Line Out default volume and route to Output mixer */
@@ -1429,8 +1415,6 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
 	.idle_bias_off = true,
 	.probe = aic3x_probe,
 	.remove = aic3x_remove,
-	.suspend = aic3x_suspend,
-	.resume = aic3x_resume,
 	.controls = aic3x_snd_controls,
 	.num_controls = ARRAY_SIZE(aic3x_snd_controls),
 	.dapm_widgets = aic3x_dapm_widgets,
-- 
1.8.0
