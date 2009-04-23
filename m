From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/3] ASoC: Beagle: Add support for 4 channel
	mode
Date: Thu, 23 Apr 2009 14:36:50 +0300
Message-ID: <1240486610-8125-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1240486610-8125-1-git-send-email-peter.ujfalusi@nokia.com>
	<1240486610-8125-2-git-send-email-peter.ujfalusi@nokia.com>
	<1240486610-8125-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 66981103854
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 13:37:09 +0200 (CEST)
In-Reply-To: <1240486610-8125-3-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

From: Ujfalusi Peter (Nokia-D/Tampere) <peter.ujfalusi@nokia.com>

This patch adds support for the four channel TDM mode
on Beagle board.

Depending on the channel count, the interface needs to be
configured differently (I2S for stereo DSP_A for four channels)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/omap/omap3beagle.c |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index 6aa428e..b0cff9f 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -41,23 +41,33 @@ static int omap3beagle_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int fmt;
 	int ret;
 
+	switch (params_channels(params)) {
+	case 2: /* Stereo I2S mode */
+		fmt =	SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	case 4: /* Four channel TDM mode */
+		fmt =	SND_SOC_DAIFMT_DSP_A |
+			SND_SOC_DAIFMT_IB_NF |
+			SND_SOC_DAIFMT_CBM_CFM;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* Set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
+	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
 	if (ret < 0) {
 		printk(KERN_ERR "can't set codec DAI configuration\n");
 		return ret;
 	}
 
 	/* Set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
 	if (ret < 0) {
 		printk(KERN_ERR "can't set cpu DAI configuration\n");
 		return ret;
-- 
1.6.2.3
