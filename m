From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: kbl: Remove option of
	choosing CH count based on pdata
Date: Thu,  9 Nov 2017 19:34:35 +0530
Message-ID: <1510236276-3416-2-git-send-email-naveen.m@intel.com>
References: <1510236276-3416-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 0917C266F89
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 15:05:09 +0100 (CET)
In-Reply-To: <1510236276-3416-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

User-space expects 4ch DMIC data and uses channel-map in ucm to
figure-out the desired channel to use. Hence removing driver change
to allow choosing channels using pdata.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 7f76074..661f164 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -390,26 +390,6 @@ static int kabylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
-static unsigned int channels_dmic[] = {
-	2, 4,
-};
-
-static struct snd_pcm_hw_constraint_list constraints_dmic_channels = {
-	.count = ARRAY_SIZE(channels_dmic),
-	.list = channels_dmic,
-	.mask = 0,
-};
-
-static const unsigned int dmic_2ch[] = {
-	2,
-};
-
-static const struct snd_pcm_hw_constraint_list constraints_dmic_2ch = {
-	.count = ARRAY_SIZE(dmic_2ch),
-	.list = dmic_2ch,
-	.mask = 0,
-};
-
 static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -838,7 +818,6 @@ static int kabylake_card_late_probe(struct snd_soc_card *card)
 static int kabylake_audio_probe(struct platform_device *pdev)
 {
 	struct kbl_rt5663_private *ctx;
-	struct skl_machine_pdata *pdata;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
 	if (!ctx)
@@ -852,11 +831,6 @@ static int kabylake_audio_probe(struct platform_device *pdev)
 	kabylake_audio_card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
 
-	pdata = dev_get_drvdata(&pdev->dev);
-	if (pdata)
-		dmic_constraints = pdata->dmic_num == 2 ?
-			&constraints_dmic_2ch : &constraints_dmic_channels;
-
 	return devm_snd_soc_register_card(&pdev->dev, kabylake_audio_card);
 }
 
-- 
1.9.1
