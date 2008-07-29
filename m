From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 01/14] ASoC: Update Poodle to current ASoC API
Date: Tue, 29 Jul 2008 11:42:22 +0100
Message-ID: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C70B2483A
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
This is a compile fix and it would therefore be good if it could be
considered for merge into 2.6.27.

 sound/soc/pxa/poodle.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 65a4e9a..d968cf7 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -85,17 +85,13 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 }
 
 /* we need to unmute the HP at shutdown as the mute burns power on poodle */
-static int poodle_shutdown(struct snd_pcm_substream *substream)
+static void poodle_shutdown(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_codec *codec = rtd->socdev->codec;
-
 	/* set = unmute headphone */
 	locomo_gpio_write(&poodle_locomo_device.dev,
 		POODLE_LOCOMO_GPIO_MUTE_L, 1);
 	locomo_gpio_write(&poodle_locomo_device.dev,
 		POODLE_LOCOMO_GPIO_MUTE_R, 1);
-	return 0;
 }
 
 static int poodle_hw_params(struct snd_pcm_substream *substream,
@@ -232,7 +228,7 @@ static const struct soc_enum poodle_enum[] = {
 	SOC_ENUM_SINGLE_EXT(2, spk_function),
 };
 
-static const snd_kcontrol_new_t wm8731_poodle_controls[] = {
+static const struct snd_kcontrol_new wm8731_poodle_controls[] = {
 	SOC_ENUM_EXT("Jack Function", poodle_enum[0], poodle_get_jack,
 		poodle_set_jack),
 	SOC_ENUM_EXT("Speaker Function", poodle_enum[1], poodle_get_spk,
-- 
1.5.6.3
