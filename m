From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Update pcm capability"
	to the asoc tree
Date: Wed, 25 Nov 2015 17:57:41 +0000
Message-ID: <E1a1eK5-0006YN-Ex@debutante>
References: <1448297789-6524-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17CF426501D
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 18:57:48 +0100 (CET)
In-Reply-To: <1448297789-6524-5-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Update pcm capability

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

>From 06b23d9379d4cd034b7a5edad323ea9419ab2016 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Mon, 23 Nov 2015 22:26:26 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Update pcm capability

This patch adds pcm capability to support 16/8k rates and 32 bit formats

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 3c891d78ba58..c79bbff00cb7 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -39,9 +39,12 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
 				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
 				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
-	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
-	.rates =		SNDRV_PCM_RATE_48000,
-	.rate_min =		48000,
+	.formats =		SNDRV_PCM_FMTBIT_S16_LE |
+				SNDRV_PCM_FMTBIT_S32_LE |
+				SNDRV_PCM_FMTBIT_S24_LE,
+	.rates =		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 |
+				SNDRV_PCM_RATE_8000,
+	.rate_min =		8000,
 	.rate_max =		48000,
 	.channels_min =		2,
 	.channels_max =		2,
-- 
2.6.2
