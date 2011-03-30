From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 09/11] ASoC: Use data based init for wm8711 DAPM
Date: Wed, 30 Mar 2011 21:53:15 +0800
Message-ID: <1301493197-8673-9-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E77B243AE
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
 sound/soc/codecs/wm8711.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8711.c b/sound/soc/codecs/wm8711.c
index 97c3038..a537e4a 100644
--- a/sound/soc/codecs/wm8711.c
+++ b/sound/soc/codecs/wm8711.c
@@ -77,7 +77,7 @@ SND_SOC_DAPM_OUTPUT("ROUT"),
 SND_SOC_DAPM_OUTPUT("RHPOUT"),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route wm8711_intercon[] = {
 	/* output mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
 	{"Output Mixer", "HiFi Playback Switch", "DAC"},
@@ -89,17 +89,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"LOUT", NULL, "Output Mixer"},
 };
 
-static int wm8711_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8711_dapm_widgets,
-				  ARRAY_SIZE(wm8711_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 struct _coeff_div {
 	u32 mclk;
 	u32 rate;
@@ -398,7 +387,6 @@ static int wm8711_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8711_snd_controls,
 			     ARRAY_SIZE(wm8711_snd_controls));
-	wm8711_add_widgets(codec);
 
 	return ret;
 
@@ -420,6 +408,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8711 = {
 	.reg_cache_size = ARRAY_SIZE(wm8711_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8711_reg,
+	.dapm_widgets = wm8711_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8711_dapm_widgets),
+	.dapm_routes = wm8711_intercon,
+	.num_dapm_routes = ARRAY_SIZE(wm8711_intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.2.3
