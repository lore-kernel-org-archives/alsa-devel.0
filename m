From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dpcm: fix the BE state on hw_free" to the asoc tree
Date: Tue, 02 Feb 2016 19:41:58 +0000
Message-ID: <E1aQgpq-0007sX-Vq@debutante>
References: <1454345800-13261-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1454345800-13261-1-git-send-email-vinod.koul@intel.com>
Sender: stable-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dpcm: fix the BE state on hw_free

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

>From 5e82d2be6ee53275c72e964507518d7964c82753 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 1 Feb 2016 22:26:40 +0530
Subject: [PATCH] ASoC: dpcm: fix the BE state on hw_free

While performing hw_free, DPCM checks the BE state but leaves out
the suspend state. The suspend state needs to be checked as well,
as we might be suspended and then usermode closes rather than
resuming the audio stream.

This was found by a stress testing of system with playback in
loop and killed after few seconds running in background and second
script running suspend-resume test in loop

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index e898b427be7e..1af4f23697a7 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1810,7 +1810,8 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
 			continue;
 
 		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
-- 
2.7.0.rc3
