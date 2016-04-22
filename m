From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: fix boot warning" to the
	asoc tree
Date: Fri, 22 Apr 2016 11:49:26 +0100
Message-ID: <E1atYeM-0002bK-Qf@debutante>
References: <1461296033-6762-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB45D264FFF
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 12:49:31 +0200 (CEST)
In-Reply-To: <1461296033-6762-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sandeep Tayal <sandeepx.tayal@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: fix boot warning

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

>From fba0d7066524ab7b8ccf60e7e95981d10ed008b0 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 22 Apr 2016 09:03:53 +0530
Subject: [PATCH] ASoC: Intel: Atom: fix boot warning

Users have reported seeing this false warning on atom driver

[    5.647469] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 0 doesn't have DAPM widget!!!
[    5.661612] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 1 doesn't have DAPM widget!!!
[    5.661646] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 2 doesn't have DAPM widget!!!
[    5.661681] sst-mfld-platform sst-mfld-platform: Slot control: codec_out tx interleaver slot 3 doesn't have DAPM widget!!!
[    5.661708] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_0 doesn't have DAPM widget!!!
[    5.661738] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in0_1 doesn't have DAPM widget!!!
[    5.661771] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_0 doesn't have DAPM widget!!!
[    5.661807] sst-mfld-platform sst-mfld-platform: Slot control: codec_in rx deinterleaver codec_in1_1 doesn't have DAPM widget!!!

This is caused when check for control is not being associated
with a dapm widget, but the check is wrong as the else case
maybe triggered when widget is not powered up, so we should
check if widget is associated before printing this message.

Tested-by: Sandeep Tayal <sandeepx.tayal@intel.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index b97e6adcf1b2..98720a93de8a 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -195,7 +195,7 @@ static int sst_check_and_send_slot_map(struct sst_data *drv, struct snd_kcontrol
 
 	if (e->w && e->w->power)
 		ret = sst_send_slot_map(drv);
-	else
+	else if (!e->w)
 		dev_err(&drv->pdev->dev, "Slot control: %s doesn't have DAPM widget!!!\n",
 				kcontrol->id.name);
 	return ret;
-- 
2.8.0.rc3
