From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: use snd_mask_set_format
	in all machine drivers" to the asoc tree
Date: Fri,  4 Jan 2019 14:01:46 +0000 (GMT)
Message-ID: <20190104140146.192AC11270A3@debutante.sirena.org.uk>
References: <20181216224910.16198-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 018C9267C86
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2019 15:01:51 +0100 (CET)
In-Reply-To: <20181216224910.16198-10-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Filip Kaczmarski <filip.kaczmarski@intel.com>, tiwai@suse.de, Cezary Rojewski <cezary.rojewski@intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: use snd_mask_set_format in all machine drivers

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

>From 4e88068ed0888549acd1cbb2f6e271b007051203 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Sun, 16 Dec 2018 16:49:10 -0600
Subject: [PATCH] ASoC: Intel: boards: use snd_mask_set_format in all machine
 drivers

Fix Sparse warnings with two machine drivers which weren't updated

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/glk_rt5682_max98357a.c | 2 +-
 sound/soc/intel/boards/kbl_da7219_max98927.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index c74c4f17316f..0739e3a75083 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -164,7 +164,7 @@ static int geminilake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	/* set SSP to 24 bit */
 	snd_mask_none(fmt);
-	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 
 	return 0;
 }
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 723a4935ed76..6dd5c69671b3 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -221,7 +221,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 		rate->min = rate->max = 48000;
 		channels->min = channels->max = 2;
 		snd_mask_none(fmt);
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	}
 
 	/*
@@ -229,7 +229,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * thus changing the mask here
 	 */
 	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
-		snd_mask_set(fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
 }
-- 
2.20.1
