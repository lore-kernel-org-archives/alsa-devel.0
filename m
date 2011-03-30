From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 02/11] ASoC: Use data based init for ak4671 DAPM
Date: Wed, 30 Mar 2011 21:53:08 +0800
Message-ID: <1301493197-8673-2-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DCE64243AA
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Lu Guanqun <guanqun.lu@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

CC: Liam Girdwood <lrg@slimlogic.co.uk>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
CC: Jarkko Nikula <jhnikula@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>
CC: Timur Tabi <timur@freescale.com>
Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/ak4671.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/ak4671.c b/sound/soc/codecs/ak4671.c
index 2ec75ab..88b29f8 100644
--- a/sound/soc/codecs/ak4671.c
+++ b/sound/soc/codecs/ak4671.c
@@ -352,7 +352,7 @@ static const struct snd_soc_dapm_widget ak4671_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("PMPLL", AK4671_PLL_MODE_SELECT1, 0, 0, NULL, 0),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route ak4671_intercon[] = {
 	{"DAC Left", "NULL", "PMPLL"},
 	{"DAC Right", "NULL", "PMPLL"},
 	{"ADC Left", "NULL", "PMPLL"},
@@ -433,17 +433,6 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"ROUT3 Mixer", "RINS4", "RIN4 Mixing Circuit"},
 };
 
-static int ak4671_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, ak4671_dapm_widgets,
-				  ARRAY_SIZE(ak4671_dapm_widgets));
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 static int ak4671_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct snd_soc_dai *dai)
@@ -650,7 +639,6 @@ static int ak4671_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, ak4671_snd_controls,
 			     ARRAY_SIZE(ak4671_snd_controls));
-	ak4671_add_widgets(codec);
 
 	ak4671_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -670,6 +658,10 @@ static struct snd_soc_codec_driver soc_codec_dev_ak4671 = {
 	.reg_cache_size = AK4671_CACHEREGNUM,
 	.reg_word_size = sizeof(u8),
 	.reg_cache_default = ak4671_reg,
+	.dapm_widgets = ak4671_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ak4671_dapm_widgets),
+	.dapm_routes = ak4671_intercon,
+	.num_dapm_routes = ARRAY_SIZE(ak4671_intercon),
 };
 
 static int __devinit ak4671_i2c_probe(struct i2c_client *client,
-- 
1.7.2.3
