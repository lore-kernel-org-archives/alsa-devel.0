From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Enabling ASRC for RT5663 codec
	on kabylake platform" to the asoc tree
Date: Fri, 28 Jul 2017 13:43:54 +0100
Message-ID: <E1db4cU-0005iV-UB@finisterre>
References: <1501102065-11083-2-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 628892676B2
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 14:44:04 +0200 (CEST)
In-Reply-To: <1501102065-11083-2-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Enabling ASRC for RT5663 codec on kabylake platform

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

>From 349d63c33a34e39b205cf116d2406e096a029f8b Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Thu, 27 Jul 2017 17:41:25 -0700
Subject: [PATCH] ASoC: Intel: Enabling ASRC for RT5663 codec on kabylake
 platform

This patch fixes the cracking noise in rt5663 headphones for kabylake platform
by calling rt5663_sel_asrc_clk_src() for RT5663_AD_STEREO_FILTER to set ASRC.

The ASRC function is for asynchronous MCLK and LRCK. For RT5663 ASRC should be
enabled to  support special i2s clock format like Intel's 100fs.
ASRC function will track i2s clock and generate a corresponding
system clock for codec. Calling this function helps select the clock source
for both RT5663_AD_STEREO_FILTER and RT5663_DA_STEREO_FILTER filters
which fixes the crackling sound.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 3fe4a0807095..cfde894d250f 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -319,7 +319,9 @@ static int kabylake_rt5663_hw_params(struct snd_pcm_substream *substream,
 	int ret;
 
 	/* use ASRC for internal clocks, as PLL rate isn't multiple of BCLK */
-	rt5663_sel_asrc_clk_src(codec_dai->codec, RT5663_DA_STEREO_FILTER, 1);
+	rt5663_sel_asrc_clk_src(codec_dai->codec,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
 
 	ret = snd_soc_dai_set_sysclk(codec_dai,
 			RT5663_SCLK_S_MCLK, 24576000, SND_SOC_CLOCK_IN);
-- 
2.13.2
