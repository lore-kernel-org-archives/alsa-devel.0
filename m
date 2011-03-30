From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 04/11] ASoC: Use data based init for max98088
	DAPM
Date: Wed, 30 Mar 2011 21:53:10 +0800
Message-ID: <1301493197-8673-4-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AC19243AB
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 15:53:44 +0200 (CEST)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Lu Guanqun <guanqun.lu@intel.com>, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

CC: Liam Girdwood <lrg@slimlogic.co.uk>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
CC: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
CC: Jarkko Nikula <jhnikula@gmail.com>
CC: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/max98088.c |   25 +++++++------------------
 1 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index bd0517c..bb58bdb 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1112,7 +1112,7 @@ static const struct snd_soc_dapm_widget max98088_dapm_widgets[] = {
        SND_SOC_DAPM_INPUT("INB2"),
 };
 
-static const struct snd_soc_dapm_route audio_map[] = {
+static const struct snd_soc_dapm_route max98088_audio_map[] = {
        /* Left headphone output mixer */
        {"Left HP Mixer", "Left DAC1 Switch", "DACL1"},
        {"Left HP Mixer", "Left DAC2 Switch", "DACL2"},
@@ -1226,22 +1226,6 @@ static const struct snd_soc_dapm_route audio_map[] = {
        {"MIC2 Input", NULL, "MIC2"},
 };
 
-static int max98088_add_widgets(struct snd_soc_codec *codec)
-{
-       struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-       snd_soc_dapm_new_controls(dapm, max98088_dapm_widgets,
-                                 ARRAY_SIZE(max98088_dapm_widgets));
-
-       snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
-
-       snd_soc_add_controls(codec, max98088_snd_controls,
-                            ARRAY_SIZE(max98088_snd_controls));
-
-       snd_soc_dapm_new_widgets(dapm);
-       return 0;
-}
-
 /* codec mclk clock divider coefficients */
 static const struct {
        u32 rate;
@@ -2010,7 +1994,8 @@ static int max98088_probe(struct snd_soc_codec *codec)
 
        max98088_handle_pdata(codec);
 
-       max98088_add_widgets(codec);
+       snd_soc_add_controls(codec, max98088_snd_controls,
+                            ARRAY_SIZE(max98088_snd_controls));
 
 err_access:
        return ret;
@@ -2036,6 +2021,10 @@ static struct snd_soc_codec_driver soc_codec_dev_max98088 = {
        .reg_word_size = sizeof(u8),
        .reg_cache_default = max98088_reg,
        .volatile_register = max98088_volatile_register,
+	.dapm_widgets = max98088_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(max98088_dapm_widgets),
+	.dapm_routes = max98088_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(max98088_audio_map),
 };
 
 static int max98088_i2c_probe(struct i2c_client *i2c,
-- 
1.7.2.3
