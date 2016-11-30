From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: intel: Fix crash at suspend/resume without card registration" to the asoc tree
Date: Wed, 30 Nov 2016 18:07:28 +0000
Message-ID: <E1cC9I0-0008CW-B5@debutante>
References: <20161125155406.7617-1-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161125155406.7617-1-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgMark Brown <broonie@kernel.org>Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: intel: Fix crash at suspend/resume without card registration

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

>From 2fc995a87f2efcd803438f07bfecd35cc3d90d32 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Fri, 25 Nov 2016 16:54:06 +0100
Subject: [PATCH] ASoC: intel: Fix crash at suspend/resume without card
 registration

When ASoC Intel SST Medfield driver is probed but without codec / card
assigned, it causes an Oops and freezes the kernel at suspend/resume,

 PM: Suspending system (freeze)
 Suspending console(s) (use no_console_suspend to debug)
 BUG: unable to handle kernel NULL pointer dereference at 0000000000000018
 IP: [<ffffffffc09d9409>] sst_soc_prepare+0x19/0xa0 [snd_soc_sst_mfld_platform]
 Oops: 0000 [#1] PREEMPT SMP
 CPU: 0 PID: 1552 Comm: systemd-sleep Tainted: G W 4.9.0-rc6-1.g5f5c2ad-default #1
 Call Trace:
  [<ffffffffb45318f9>] dpm_prepare+0x209/0x460
  [<ffffffffb4531b61>] dpm_suspend_start+0x11/0x60
  [<ffffffffb40d3cc2>] suspend_devices_and_enter+0xb2/0x710
  [<ffffffffb40d462e>] pm_suspend+0x30e/0x390
  [<ffffffffb40d2eba>] state_store+0x8a/0x90
  [<ffffffffb43c670f>] kobj_attr_store+0xf/0x20
  [<ffffffffb42b0d97>] sysfs_kf_write+0x37/0x40
  [<ffffffffb42b02bc>] kernfs_fop_write+0x11c/0x1b0
  [<ffffffffb422be68>] __vfs_write+0x28/0x140
  [<ffffffffb43728a8>] ? apparmor_file_permission+0x18/0x20
  [<ffffffffb433b2ab>] ? security_file_permission+0x3b/0xc0
  [<ffffffffb422d095>] vfs_write+0xb5/0x1a0
  [<ffffffffb422e3d6>] SyS_write+0x46/0xa0
  [<ffffffffb4719fbb>] entry_SYSCALL_64_fastpath+0x1e/0xad

Add proper NULL checks in the PM code of mdfld driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 25c6d87c818e..f5a8050351b5 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -771,6 +771,9 @@ static int sst_soc_prepare(struct device *dev)
 	struct sst_data *drv = dev_get_drvdata(dev);
 	struct snd_soc_pcm_runtime *rtd;
 
+	if (!drv->soc_card)
+		return 0;
+
 	/* suspend all pcms first */
 	snd_soc_suspend(drv->soc_card->dev);
 	snd_soc_poweroff(drv->soc_card->dev);
@@ -793,6 +796,9 @@ static void sst_soc_complete(struct device *dev)
 	struct sst_data *drv = dev_get_drvdata(dev);
 	struct snd_soc_pcm_runtime *rtd;
 
+	if (!drv->soc_card)
+		return;
+
 	/* restart SSPs */
 	list_for_each_entry(rtd, &drv->soc_card->rtd_list, list) {
 		struct snd_soc_dai *dai = rtd->cpu_dai;
-- 
2.10.2
