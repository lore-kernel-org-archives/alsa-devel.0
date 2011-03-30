From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 10/11] ASoC: Use data based init for
	tlv320aic23 DAPM
Date: Wed, 30 Mar 2011 21:53:16 +0800
Message-ID: <1301493197-8673-10-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id F3DF7243AB
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
 sound/soc/codecs/tlv320aic23.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 54a30ef..33bb52f 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -212,7 +212,7 @@ static const struct snd_soc_dapm_widget tlv320aic23_dapm_widgets[] = {
 	SND_SOC_DAPM_INPUT("MICIN"),
 };
 
-static const struct snd_soc_dapm_route intercon[] = {
+static const struct snd_soc_dapm_route tlv320aic23_intercon[] = {
 	/* Output Mixer */
 	{"Output Mixer", "Line Bypass Switch", "Line Input"},
 	{"Output Mixer", "Playback Switch", "DAC"},
@@ -388,18 +388,6 @@ static int set_sample_rate_control(struct snd_soc_codec *codec, int mclk,
 	return 0;
 }
 
-static int tlv320aic23_add_widgets(struct snd_soc_codec *codec)
-{
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	snd_soc_dapm_new_controls(dapm, tlv320aic23_dapm_widgets,
-				  ARRAY_SIZE(tlv320aic23_dapm_widgets));
-	/* set up audio path interconnects */
-	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
-
-	return 0;
-}
-
 static int tlv320aic23_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
@@ -676,7 +664,6 @@ static int tlv320aic23_probe(struct snd_soc_codec *codec)
 
 	snd_soc_add_controls(codec, tlv320aic23_snd_controls,
 				ARRAY_SIZE(tlv320aic23_snd_controls));
-	tlv320aic23_add_widgets(codec);
 
 	return 0;
 }
@@ -698,6 +685,10 @@ static struct snd_soc_codec_driver soc_codec_dev_tlv320aic23 = {
 	.read = tlv320aic23_read_reg_cache,
 	.write = tlv320aic23_write,
 	.set_bias_level = tlv320aic23_set_bias_level,
+	.dapm_widgets = tlv320aic23_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tlv320aic23_dapm_widgets),
+	.dapm_routes = tlv320aic23_intercon,
+	.num_dapm_routes = ARRAY_SIZE(tlv320aic23_intercon),
 };
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-- 
1.7.2.3
