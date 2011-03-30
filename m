From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 01/11] ASoC: Use data based init for ak4535 DAPM
Date: Wed, 30 Mar 2011 21:53:07 +0800
Message-ID: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A4B8243A7
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 15:53:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <s.hauer@pengutronix.de>, Lu Guanqun <guanqun.lu@intel.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

CC: Liam Girdwood <lrg@slimlogic.co.uk>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
CC: Jarkko Nikula <jhnikula@gmail.com>
CC: Timur Tabi <timur@freescale.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/ak4535.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/ak4535.c b/sound/soc/codecs/ak4535.c
index 8b38739..e1a214e 100644
--- a/sound/soc/codecs/ak4535.c
+++ b/sound/soc/codecs/ak4535.c
@@ -230,7 +230,7 @@ static const struct snd_soc_dapm_widget ak4535_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("AIN"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route ak4535_audio_map[] = {
 	/*stereo mixer */
 	{"Stereo Mixer", "Playback Switch", "DAC"},
 	{"Stereo Mixer", "Mic Sidetone Switch", "Mic"},
@@ -287,17 +287,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"Input Mixer", "Aux Capture Switch", "Aux In"},
 };
 
-static int ak4535_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, ak4535_dapm_widgets,
-				  ARRAY_SIZE(ak4535_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 static int ak4535_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	int clk_id, unsigned int freq, int dir)
 {
@@ -457,8 +446,6 @@ static int ak4535_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, ak4535_snd_controls,
 				ARRAY_SIZE(ak4535_snd_controls));
-	ak4535_add_widgets(codec);
-
 	return 0;
 }
 
@@ -480,6 +467,10 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4535 = {
 	.reg_cache_size = ARRAY_SIZE(ak4535_reg),
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = ak4535_reg,
+	.dapm_widgets = ak4535_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ak4535_dapm_widgets),
+	.dapm_routes = ak4535_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(ak4535_audio_map),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.2.3
