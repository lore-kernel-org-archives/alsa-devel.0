From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Fix snd_pcm_format_t handling"
	to the asoc tree
Date: Thu, 26 Jul 2018 17:11:38 +0100 (BST)
Message-ID: <20180726161138.2111E440083@finisterre.ee.mobilebroadband>
References: <20180725211722.18944-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BEB92677A2
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 20:22:43 +0200 (CEST)
In-Reply-To: <20180725211722.18944-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Timur Tabi <timur@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Fix snd_pcm_format_t handling

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b5453e8ca311fdb6003c6583ad101d2b9131b994 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 25 Jul 2018 23:17:19 +0200
Subject: [PATCH] ASoC: intel: Fix snd_pcm_format_t handling

As sparse warns, the PCM format type can't be dealt as integer as
found in Intel SST driver codes.

Fix them in the following two ways:

- The open code with snd_mask_set() and params->masks reference is
  replaced with params_set_format()

- The rest codes with snd_mask_set(fmt, SNDRV_PCM_FORMAT_XXX) are
  replaced with the new helper, snd_mask_set_format().

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bdw-rt5677.c                 | 4 +---
 sound/soc/intel/boards/bxt_da7219_max98357a.c       | 2 +-
 sound/soc/intel/boards/bxt_rt298.c                  | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98357a.c       | 2 +-
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 4 ++--
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 4 ++--
 sound/soc/intel/boards/skl_nau88l25_max98357a.c     | 2 +-
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c       | 2 +-
 sound/soc/intel/boards/skl_rt286.c                  | 2 +-
 9 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 6ea360f33575..efcfd906c856 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -154,9 +154,7 @@ static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 	channels->min = channels->max = 2;
 
 	/* set SSP0 to 16 bit */
-	snd_mask_set(&params->masks[SNDRV_PCM_HW_PARAM_FORMAT -
-				    SNDRV_PCM_HW_PARAM_FIRST_MASK],
-				    SNDRV_PCM_FORMAT_S16_LE);
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 3aba5bcf806a..be6e4b40bf03 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -160,7 +160,7 @@ static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index b68c289558a8..27308337ab12 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -221,7 +221,7 @@ static int broxton_ssp5_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP5 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 7961f1fd18bd..38f6ab74709d 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -152,7 +152,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 3a61252fe450..21a6490746a6 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -434,14 +434,14 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
 		snd_mask_none(fmt);
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	}
 	/*
 	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
 	 * thus changing the mask here
 	 */
 	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 92f5fb2ae0a3..a892b37eab7c 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -307,7 +307,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
 		snd_mask_none(fmt);
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
 		if (params_channels(params) == 2 ||
 				DMIC_CH(dmic_constraints) == 2)
@@ -320,7 +320,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * thus changing the mask here
 	 */
 	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 3ff6646cfa21..d31482b8c9bb 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -157,7 +157,7 @@ static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP0 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index b0610bba3cfa..e877bb60beb1 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -346,7 +346,7 @@ static int skylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP0 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 38a1495c29cf..0e1818dd4cc6 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -229,7 +229,7 @@ static int skylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP0 to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
-- 
2.18.0
