From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Fix PM and non-atomic crash in bytcr drivers" to the asoc tree
Date: Mon, 24 Apr 2017 19:20:42 +0100
Message-ID: <E1d2ibK-0000f3-Md@debutante>
References: <20170424120955.15519-1-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170424120955.15519-1-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgMark Brown <broonie@kernel.org>Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Fix PM and non-atomic crash in bytcr drivers

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

>From 22ae4057173ebf48020d5a713242bd9de9e64b46 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 24 Apr 2017 14:09:55 +0200
Subject: [PATCH] ASoC: intel: Fix PM and non-atomic crash in bytcr drivers

The FE setups of Intel SST bytcr_rt5640 and bytcr_rt5651 drivers carry
the ignore_suspend flag, and this prevents the suspend/resume working
properly while the stream is running, since SST core code has the
check of the running streams and returns -EBUSY.  Drop these
superfluous flags for fixing the behavior.

Also, the bytcr_rt5640 driver lacks of nonatomic flag in some FE
definitions, which leads to the kernel Oops at suspend/resume like:

  BUG: scheduling while atomic: systemd-sleep/3144/0x00000003
  Call Trace:
   dump_stack+0x5c/0x7a
   __schedule_bug+0x55/0x70
   __schedule+0x63c/0x8c0
   schedule+0x3d/0x90
   schedule_timeout+0x16b/0x320
   ? del_timer_sync+0x50/0x50
   ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
   ? sst_wait_timeout+0xa9/0x170 [snd_intel_sst_core]
   ? remove_wait_queue+0x60/0x60
   ? sst_prepare_and_post_msg+0x275/0x960 [snd_intel_sst_core]
   ? sst_pause_stream+0x9b/0x110 [snd_intel_sst_core]
   ....

This patch addresses these appropriately, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # v4.1+
---
 sound/soc/intel/boards/bytcr_rt5640.c | 4 ++--
 sound/soc/intel/boards/bytcr_rt5651.c | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 0ac32788f216..b1f0ccb64a6a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -625,7 +625,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.codec_name = "snd-soc-dummy",
 		.platform_name = "sst-mfld-platform",
-		.ignore_suspend = 1,
+		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
@@ -638,7 +638,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.codec_name = "snd-soc-dummy",
 		.platform_name = "sst-mfld-platform",
-		.ignore_suspend = 1,
 		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
@@ -665,6 +664,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 						| SND_SOC_DAIFMT_CBS_CFS,
 		.be_hw_params_fixup = byt_rt5640_codec_fixup,
 		.ignore_suspend = 1,
+		.nonatomic = true,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		.init = byt_rt5640_init,
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 3186f015939f..8164bec63bf1 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -235,7 +235,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.codec_name = "snd-soc-dummy",
 		.platform_name = "sst-mfld-platform",
-		.ignore_suspend = 1,
 		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
@@ -249,7 +248,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.codec_name = "snd-soc-dummy",
 		.platform_name = "sst-mfld-platform",
-		.ignore_suspend = 1,
 		.nonatomic = true,
 		.dynamic = 1,
 		.dpcm_playback = 1,
-- 
2.11.0
