From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [sound-unstable:topic/hda-spdif-fix 99/124] ERROR:
 "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
Date: Sun, 21 Oct 2012 13:33:54 +0800
Message-ID: <20121021053354.GA23699@localhost>
References: <5083733a.T3zEi6cLE4psrO1W%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D3B0264EAA
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 07:33:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5083733a.T3zEi6cLE4psrO1W%fengguang.wu@intel.com>
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

On Sun, Oct 21, 2012 at 11:59:54AM +0800, Fengguang Wu wrote:
> Hi Peter,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git topic/hda-spdif-fix
> head:   afc51e492b36bd61b46f4d70dd646678d96f5f97
> commit: e7736cdea223f3a5b867c359fb35cf08250dd771 [99/124] dmaengine: Add flags parameter to dmaengine_prep_dma_cyclic()

Sorry that's a wrong bisection. The kernel build on previous commit
has errors in header file that hide the below errors.

The real bad commit should be

commit 946cc36ae550ea52adee0f42ac5034a34b5393be
Author:     Peter Ujfalusi <peter.ujfalusi@ti.com>
AuthorDate: Fri Sep 14 15:05:58 2012 +0300
Commit:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CommitDate: Sat Sep 22 11:13:02 2012 -0400

    ASoC: omap-pcm: Convert to use dmaengine

Thanks,
Fengguang

> config: arm-omap2plus_defconfig # make ARCH=arm omap2plus_defconfig
> 
> All error/warnings:
> 
> ERROR: "snd_hwparams_to_dma_slave_config" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] undefined!
> ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undefined!
> 
> ---
> 0-DAY kernel build testing backend         Open Source Technology Center
> Fengguang Wu, Yuanhan Liu                              Intel Corporation
