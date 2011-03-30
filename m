From: Lu Guanqun <guanqun.lu@intel.com>
Subject: [PATCH 11/11] ASoC: Use data based init for sn95031
	DAPM
Date: Wed, 30 Mar 2011 21:53:17 +0800
Message-ID: <1301493197-8673-11-git-send-email-guanqun.lu@intel.com>
References: <1301493197-8673-1-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 8825E10381B
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 15:53:47 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>, Lu Guanqun <guanqun.lu@intel.com>, Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

CC: Liam Girdwood <lrg@slimlogic.co.uk>
CC: Mark Brown <broonie@opensource.wolfsonmicro.com>
CC: Jaroslav Kysela <perex@perex.cz>
CC: Takashi Iwai <tiwai@suse.de>
CC: Harsha Priya <priya.harsha@intel.com>
CC: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
---
 sound/soc/codecs/sn95031.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 2a30eae..569555f 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -825,8 +825,6 @@ EXPORT_SYMBOL_GPL(sn95031_jack_detection);
 /* codec registration */
 static int sn95031_codec_probe(struct snd_soc_codec *codec)
 {
-	int ret;
-
 	pr_debug("codec_probe called\n");
 
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
@@ -877,16 +875,7 @@ static int sn95031_codec_probe(struct snd_soc_codec *codec)
 	snd_soc_add_controls(codec, sn95031_snd_controls,
 			     ARRAY_SIZE(sn95031_snd_controls));
 
-	ret = snd_soc_dapm_new_controls(&codec->dapm, sn95031_dapm_widgets,
-				ARRAY_SIZE(sn95031_dapm_widgets));
-	if (ret)
-		pr_err("soc_dapm_new_control failed %d", ret);
-	ret = snd_soc_dapm_add_routes(&codec->dapm, sn95031_audio_map,
-				ARRAY_SIZE(sn95031_audio_map));
-	if (ret)
-		pr_err("soc_dapm_add_routes failed %d", ret);
-
-	return ret;
+	return 0;
 }
 
 static int sn95031_codec_remove(struct snd_soc_codec *codec)
@@ -903,6 +892,10 @@ struct snd_soc_codec_driver sn95031_codec = {
 	.read		= sn95031_read,
 	.write		= sn95031_write,
 	.set_bias_level	= sn95031_set_vaud_bias,
+	.dapm_widgets	= sn95031_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(sn95031_dapm_widgets),
+	.dapm_routes	= sn95031_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(sn95031_audio_map),
 };
 
 static int __devinit sn95031_device_probe(struct platform_device *pdev)
-- 
1.7.2.3
