From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/5] ASoC: wm8804: Remove unnecessary
	suspend/resume bias level changes
Date: Tue,  2 Sep 2014 22:20:33 +0200
Message-ID: <1409689234-14774-5-git-send-email-lars@metafoo.de>
References: <1409689234-14774-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id AC0CF2654D8
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 22:20:44 +0200 (CEST)
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
 sound/soc/codecs/wm8804.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 0ea01df..3addc5f 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -518,23 +518,6 @@ static int wm8804_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int wm8804_suspend(struct snd_soc_codec *codec)
-{
-	wm8804_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int wm8804_resume(struct snd_soc_codec *codec)
-{
-	wm8804_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-#else
-#define wm8804_suspend NULL
-#define wm8804_resume NULL
-#endif
-
 static int wm8804_remove(struct snd_soc_codec *codec)
 {
 	struct wm8804_priv *wm8804;
@@ -671,8 +654,6 @@ static struct snd_soc_dai_driver wm8804_dai = {
 static struct snd_soc_codec_driver soc_codec_dev_wm8804 = {
 	.probe = wm8804_probe,
 	.remove = wm8804_remove,
-	.suspend = wm8804_suspend,
-	.resume = wm8804_resume,
 	.set_bias_level = wm8804_set_bias_level,
 	.idle_bias_off = true,
 
-- 
1.8.0
