From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: kbl: Enabling ASRC for RT5663
	codec on kabylake platform" to the asoc tree
Date: Thu, 17 Aug 2017 18:13:18 +0100
Message-ID: <E1diOMA-0008S0-6U@debutante>
References: <1502427646-18880-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C6A07266FEC
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 19:13:29 +0200 (CEST)
In-Reply-To: <1502427646-18880-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Shruthi Sudhakar <shruthi.sudhakar@intel.com>, Harsha Priya <harshapriya.n@intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, tiwai@suse.de, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: kbl: Enabling ASRC for RT5663 codec on kabylake platform

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

>From d46b1828406f74bc2d9ffe15e9a7b76ddbffbf7f Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Wed, 16 Aug 2017 16:19:55 +0530
Subject: [PATCH] ASoC: Intel: kbl: Enabling ASRC for RT5663 codec on kabylake
 platform

Patch fixes cracking noise in rt5663 headphones for kbl platform by
calling rt5663_sel_asrc_clk_src() for RT5663_AD_STEREO_FILTER to set
ASRC.

The ASRC function is for asynchronous MCLK and LRCLK. For RT5663 ASRC
should be enabled to support pcm format with 100fs.
ASRC function will track i2s clock and generate corresponding
system clock for codec. Calling this func helps select clock source
for both RT5663_AD_STEREO_FILTER and RT5663_DA_STEREO_FILTER filters
which fixes the crackling sound.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Shruthi Sudhakar <shruthi.sudhakar@intel.com>
Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 8bdd6131c6ad..c1442147d138 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -356,11 +356,13 @@ static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret;
 
-	ret = snd_soc_dai_set_sysclk(codec_dai,
-			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
 	/* use ASRC for internal clocks, as PLL rate isn't multiple of BCLK */
-	rt5663_sel_asrc_clk_src(codec_dai->codec, RT5663_DA_STEREO_FILTER, 1);
+	rt5663_sel_asrc_clk_src(codec_dai->codec,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
 
+	ret = snd_soc_dai_set_sysclk(codec_dai,
+			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
 
-- 
2.13.3
