From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: cht_bsw_max98090: Fix I2S config
	+ unused code" to the asoc tree
Date: Tue, 19 Sep 2017 14:45:47 +0100
Message-ID: <E1duIqR-000862-Ls@debutante>
References: <20170822203239.19891-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A999E26735F
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:45:49 +0200 (CEST)
In-Reply-To: <20170822203239.19891-4-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: cht_bsw_max98090: Fix I2S config + unused code

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

>From 948c5e192eaeef5bd8b479135ea83d1f97d78bb8 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 8 Sep 2017 00:13:04 -0500
Subject: [PATCH] ASoC: Intel: cht_bsw_max98090: Fix I2S config + unused code

This driver probably never worked, the slots are configured
for 2ch 16 bit and the SSP2 as 24 bits, the cpu_dai configured as
LEFT_J and the codec_dai as I2S.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 20755ecc7f9e..455a55af7ad2 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -160,7 +160,7 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 		return ret;
 	}
 
-	fmt = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF
+	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBS_CFS;
 
 	ret = snd_soc_dai_set_fmt(rtd->cpu_dai, fmt);
@@ -173,8 +173,8 @@ static int cht_codec_fixup(struct snd_soc_pcm_runtime *rtd,
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
 
-	/* set SSP2 to 24-bit */
-	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+	/* set SSP2 to 16-bit */
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 	return 0;
 }
 
-- 
2.14.1
