From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: hda-stream: fix a deadlock
	with bus->reg_lock" to the asoc tree
Date: Mon, 17 Jun 2019 16:24:22 +0100 (BST)
Message-ID: <20190617152422.636CE440046@finisterre.sirena.org.uk>
References: <20190612172347.22338-10-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D159BF896DA
 for <alsa-devel@alsa-project.org>; Mon, 17 Jun 2019 17:24:26 +0200 (CEST)
In-Reply-To: <20190612172347.22338-10-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Keyon Jie <yang.jie@linux.intel.com>
Cc: tiwai@suse.de, Xun Zhang <xun2.zhang@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: hda-stream: fix a deadlock with bus->reg_lock

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7fd572e7d317fa51049d623badb8b2874bfd0119 Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Wed, 12 Jun 2019 12:23:41 -0500
Subject: [PATCH] ASoC: SOF: Intel: hda-stream: fix a deadlock with
 bus->reg_lock

We should use irq disabled mode when read/write hda registers from
thread context, as we need to hold the same bus->reg_lock in interrupt
context hda_dsp_stream_interrupt(), otherwise, when we are holding the
lock in hda_dsp_stream_hw_free() and the interrupt arrives, we will get
deadlock in the interrupt handler.

Error logs like this:

[    5.603606]        CPU0
[    5.603606]        ----
[    5.603607]   lock(&(&bus->reg_lock)->rlock);
[    5.603608]   <Interrupt>
[    5.603609]     lock(&(&bus->reg_lock)->rlock);
[    5.603610]
                *** DEADLOCK ***

[    5.603611] 2 locks held by pulseaudio/2329:
[    5.603612]  #0: 000000005fcf26c6 (&card->mutex/1){+.+.}, at: dpcm_fe_dai_hw_free+0x2b/0x110 [snd_soc_core]
[    5.603619]  #1: 00000000ef369faf (&rtd->pcm_mutex){+.+.}, at: soc_pcm_hw_free+0x2e/0x1c0 [snd_soc_core]

The fix is simple, let's switch to use spin_lock/unlock_irq().

Reported-by: Xun Zhang <xun2.zhang@intel.com>
Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index d44318040948..23cff5aca007 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -448,12 +448,12 @@ int hda_dsp_stream_hw_free(struct snd_sof_dev *sdev,
 	struct hdac_bus *bus = sof_to_bus(sdev);
 	u32 mask = 0x1 << stream->index;
 
-	spin_lock(&bus->reg_lock);
+	spin_lock_irq(&bus->reg_lock);
 	/* couple host and link DMA if link DMA channel is idle */
 	if (!link_dev->link_locked)
 		snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR,
 					SOF_HDA_REG_PP_PPCTL, mask, 0);
-	spin_unlock(&bus->reg_lock);
+	spin_unlock_irq(&bus->reg_lock);
 
 	return 0;
 }
-- 
2.20.1
