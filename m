From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: Don't add DAPM routes
	for ASRC if it doesn't exist" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:08 +0000
Message-ID: <E1aRIpU-0001AI-54@debutante>
References: <1454224020-19746-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AB56261AA1
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:19 +0100 (CET)
In-Reply-To: <1454224020-19746-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicolinc@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: Don't add DAPM routes for ASRC if it doesn't exist

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

>From 089dfaf7f7f9b18e3dffb6d9ee8b37089025b952 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicolinc@nvidia.com>
Date: Sat, 30 Jan 2016 23:07:00 -0800
Subject: [PATCH] ASoC: fsl-asoc-card: Don't add DAPM routes for ASRC if it
 doesn't exist

There are a pair of warnings when ASRC is absent in the DTB:
  fsl-asoc-card sound: ASoC: no source widget found for ASRC-Playback
  fsl-asoc-card sound: ASoC: Failed to add route ASRC-Playback -> direct -> CPU-Playback
  fsl-asoc-card sound: ASoC: no sink widget found for ASRC-Capture
  fsl-asoc-card sound: ASoC: Failed to add route CPU-Capture -> direct -> ASRC-Capture

This is because the driver is still trying to add DAPM routes for ASRC
even if it doesn't exist on that platform.

The warnings are harmless but it might be annoying. So this patch drops
the DAPM routes of ASRC when it's absent in the DAI link.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 562b3bd22d9a..3d40797e3bcc 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -99,19 +99,26 @@ struct fsl_asoc_card_priv {
 /**
  * This dapm route map exsits for DPCM link only.
  * The other routes shall go through Device Tree.
+ *
+ * Note: keep all ASRC routes in the second half
+ *	 to drop them easily for non-ASRC cases.
  */
 static const struct snd_soc_dapm_route audio_map[] = {
-	{"CPU-Playback",  NULL, "ASRC-Playback"},
+	/* 1st half -- Normal DAPM routes */
 	{"Playback",  NULL, "CPU-Playback"},
-	{"ASRC-Capture",  NULL, "CPU-Capture"},
 	{"CPU-Capture",  NULL, "Capture"},
+	/* 2nd half -- ASRC DAPM routes */
+	{"CPU-Playback",  NULL, "ASRC-Playback"},
+	{"ASRC-Capture",  NULL, "CPU-Capture"},
 };
 
 static const struct snd_soc_dapm_route audio_map_ac97[] = {
-	{"AC97 Playback",  NULL, "ASRC-Playback"},
+	/* 1st half -- Normal DAPM routes */
 	{"Playback",  NULL, "AC97 Playback"},
-	{"ASRC-Capture",  NULL, "AC97 Capture"},
 	{"AC97 Capture",  NULL, "Capture"},
+	/* 2nd half -- ASRC DAPM routes */
+	{"AC97 Playback",  NULL, "ASRC-Playback"},
+	{"ASRC-Capture",  NULL, "AC97 Capture"},
 };
 
 /* Add all possible widgets into here without being redundant */
@@ -593,6 +600,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
 	priv->card.num_dapm_widgets = ARRAY_SIZE(fsl_asoc_card_dapm_widgets);
 
+	/* Drop the second half of DAPM routes -- ASRC */
+	if (!asrc_pdev)
+		priv->card.num_dapm_routes /= 2;
+
 	memcpy(priv->dai_link, fsl_asoc_card_dai,
 	       sizeof(struct snd_soc_dai_link) * ARRAY_SIZE(priv->dai_link));
 
-- 
2.7.0.rc3
