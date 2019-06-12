From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 09/15] ASoC: SOF: Intel: hda-stream: fix a
	deadlock with bus->reg_lock
Date: Wed, 12 Jun 2019 12:23:41 -0500
Message-ID: <20190612172347.22338-10-pierre-louis.bossart@linux.intel.com>
References: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5903F89731
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 19:24:00 +0200 (CEST)
In-Reply-To: <20190612172347.22338-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Xun Zhang <xun2.zhang@intel.com>, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

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
