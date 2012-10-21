From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [sound-unstable:topic/hda-spdif-fix 99/124] ERROR:
 "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
Date: Sun, 21 Oct 2012 11:59:54 +0800
Message-ID: <5083733a.T3zEi6cLE4psrO1W%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 64B00264E96
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 06:00:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Peter,

FYI, kernel build failed on

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git topic/hda-spdif-fix
head:   afc51e492b36bd61b46f4d70dd646678d96f5f97
commit: e7736cdea223f3a5b867c359fb35cf08250dd771 [99/124] dmaengine: Add flags parameter to dmaengine_prep_dma_cyclic()
config: arm-omap2plus_defconfig # make ARCH=arm omap2plus_defconfig

All error/warnings:

ERROR: "snd_hwparams_to_dma_slave_config" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] undefined!
ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undefined!

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
