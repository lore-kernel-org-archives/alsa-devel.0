From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 08/11] ASoC: Use data based init for wm8728 DAPM
Date: Wed, 30 Mar 2011 21:53:14 +0800
Message-ID: <1301493197-8673-8-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 6380F243AD
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
 sound/soc/codecs/wm8728.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/wm8728.c b/sound/soc/codecs/wm8728.c
index 736b035..86d4718 100644
--- a/sound/soc/codecs/wm8728.c
+++ b/sound/soc/codecs/wm8728.c
@@ -65,22 +65,11 @@ SND_SOC_DAPM_OUTPUT("VOUTL"),
 SND_SOC_DAPM_OUTPUT("VOUTR"),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route wm8728_intercon[] = {
 	{"VOUTL", NULL, "DAC"},
 	{"VOUTR", NULL, "DAC"},
 };
 
-static int wm8728_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, wm8728_dapm_widgets,
-				  ARRAY_SIZE(wm8728_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 static int wm8728_mute(struct snd_soc_dai *dai, int mute)
 {
 	struct snd_soc_codec *codec = dai->codec;
@@ -255,7 +244,6 @@ static int wm8728_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, wm8728_snd_controls,
 				ARRAY_SIZE(wm8728_snd_controls));
-	wm8728_add_widgets(codec);
 
 	return ret;
 }
@@ -275,6 +263,10 @@ static struct snd_soc_codec_driver soc_codec_dev_wm8728 = {
 	.reg_cache_size = ARRAY_SIZE(wm8728_reg_defaults),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = wm8728_reg_defaults,
+	.dapm_widgets = wm8728_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(wm8728_dapm_widgets),
+	.dapm_routes = wm8728_intercon,
+	.num_dapm_routes = ARRAY_SIZE(wm8728_intercon),
 };
 
 #if defined(CONFIG_SPI_MASTER)
-- 
1.7.2.3
