From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH RESEND 2/2] ASoC: Intel: Fix setting of SSP
	parameters in Kabylake machine driver
Date: Thu, 26 Oct 2017 11:44:03 -0700
Message-ID: <1509043443-28143-3-git-send-email-harshapriya.n@intel.com>
References: <1509043443-28143-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 82B9F2671A8
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 20:47:31 +0200 (CEST)
In-Reply-To: <1509043443-28143-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch sets the SSP params based on FE and BE dai links
for kabylake machine driver that uses rt5663 and max98927 codecs

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 5a4ee5b..6f9a8bc 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -350,13 +350,28 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct snd_interval *channels = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	struct snd_soc_dpcm *dpcm = container_of(
+			params, struct snd_soc_dpcm, hw_params);
+	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
+	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
 
-	/* The ADSP will convert the FE rate to 48k, stereo */
-	rate->min = rate->max = 48000;
-	channels->min = channels->max = 2;
-	/* set SSP1 to 24 bit */
-	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	/*
+	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
+	 */
+	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
+	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
+	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
+		rate->min = rate->max = 48000;
+		channels->min = channels->max = 2;
+		snd_mask_none(fmt);
+		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	}
+	/*
+	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
+	 * thus changing the mask here
+	 */
+	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
+		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
-- 
1.9.1
