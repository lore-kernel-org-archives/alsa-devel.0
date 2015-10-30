From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Intel: Skylake: Fix the SSP0 Fmt
	fixup to 24 bit
Date: Fri, 30 Oct 2015 11:08:18 +0900
Message-ID: <E1Zrz74-00017I-Nc@finisterre>
References: <1446089495-31250-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE765265917
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 03:08:24 +0100 (CET)
In-Reply-To: <1446089495-31250-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix the SSP0 Fmt fixup to 24 bit

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

>From 0b5a4831607f4d2c21f1779470d14253137050a3 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Thu, 29 Oct 2015 12:31:34 +0900
Subject: [PATCH] ASoC: Intel: Skylake: Fix the SSP0 Fmt fixup to 24 bit

SSP0 FMT uses 24 bits so fix to the value to 24 bits

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_rt286.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index a73a431..e6af484 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -112,12 +112,15 @@ static int skylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 
 	/* The output is 48KHz, stereo, 16bits */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
-	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 
+	/* set SSP0 to 24 bit */
+	snd_mask_none(fmt);
+	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
-- 
2.6.1
