From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Fix setting of SSP parameters in
	Kabylake machine driver" to the asoc tree
Date: Tue, 31 Oct 2017 11:21:08 +0000
Message-ID: <E1e9UbU-0002kv-RP@debutante>
References: <1504291278-4482-3-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 015FC2670B6
 for <alsa-devel@alsa-project.org>; Tue, 31 Oct 2017 12:21:12 +0100 (CET)
In-Reply-To: <1504291278-4482-3-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Harsha Priya <harshapriya.n@intel.com>, vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.de, Naveen M <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Fix setting of SSP parameters in Kabylake machine driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e78407fb7ed38fded024def7a76e4c91bc814080 Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Thu, 26 Oct 2017 11:44:03 -0700
Subject: [PATCH] ASoC: Intel: Fix setting of SSP parameters in Kabylake
 machine driver

This patch sets the SSP params based on FE and BE dai links
for kabylake machine driver that uses rt5663 and max98927 codecs

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 5a4ee5b1c6a0..6f9a8bcf20f3 100644
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
2.15.0.rc2
