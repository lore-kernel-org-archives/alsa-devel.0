From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 06/11] ASoC: Use data based init for wm9712 DAPM
Date: Wed, 30 Mar 2011 21:53:12 +0800
Message-ID: <1301493197-8673-6-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id CB01E243AF
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 15:53:46 +0200 (CEST)
In-Reply-To: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Lu Guanqun <guanqun.lu@intel.com>, Ian Lartey <ian@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Ian Lartey <ian@opensource.wolfsonmicro.com>
CC: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
CC: Liam Girdwood <lrg@slimlogic.co.uk>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/wm9712.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index bf5d4ef..90117f8 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -332,7 +332,7 @@ SND_SOC_DAPM_INPUT("MIC1"),
 SND_SOC_DAPM_INPUT("MIC2"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route wm9712_audio_map[] = {
 	/* virtual mixer - mixes left & right channels for spk and mono */
 	{"AC97 Mixer", NULL, "Left DAC"},
 	{"AC97 Mixer", NULL, "Right DAC"},
@@ -429,17 +429,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"ROUT2", NULL, "Speaker PGA"},
 };
 
-static int wm9712_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm9712_dapm_widgets,
-				  ARRAY_SIZE(wm9712_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-	return 0;
-}
-
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
@@ -651,7 +640,6 @@ static int wm9712_soc_probe(struct snd_soc_codec *codec)
 	wm9712_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	snd_soc_add_controls(codec, wm9712_snd_ac97_controls,
 				ARRAY_SIZE(wm9712_snd_ac97_controls));
-	wm9712_add_widgets(codec);
 
 	return 0;
 
@@ -678,6 +666,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.reg_word_size = sizeof(u16),
 	.reg_cache_step = 2,
 	.reg_cache_default = wm9712_reg,
+	.dapm_widgets = wm9712_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm9712_dapm_widgets),
+	.dapm_routes = wm9712_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(wm9712_audio_map),
 };
 
 static __devinit int wm9712_probe(struct platform_device *pdev)
-- 
1.7.2.3
