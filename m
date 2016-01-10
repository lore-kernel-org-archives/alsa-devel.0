From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add Resume capability
	in PCM info." to the asoc tree
Date: Sun, 10 Jan 2016 12:22:28 +0000
Message-ID: <E1aIF0u-0008PT-1Z@debutante>
References: <1448297789-6524-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EF912605EA
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:22:34 +0100 (CET)
In-Reply-To: <1448297789-6524-2-git-send-email-vinod.koul@intel.com>
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

   ASoC: Intel: Skylake: Add Resume capability in PCM info.

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

>From 3637976b8975afb0a55a1fc88a2c320a2839a9da Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Fri, 18 Dec 2015 15:12:09 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add Resume capability in PCM info.

This patch adds pcm capability to support Resume.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 17a64362b283..f3553258091a 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -38,6 +38,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
 				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
 				 SNDRV_PCM_INFO_MMAP_VALID |
 				 SNDRV_PCM_INFO_PAUSE |
+				 SNDRV_PCM_INFO_RESUME |
 				 SNDRV_PCM_INFO_SYNC_START |
 				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
 				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
-- 
2.7.0.rc3
