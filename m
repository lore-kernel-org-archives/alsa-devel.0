From: Fengguang Wu <fengguang.wu@intel.com>
Subject: sound/pci/au88x0/au88x0_core.c:2464 vortex_interrupt()
	warn: if();
Date: Tue, 23 Oct 2012 22:16:42 +0800
Message-ID: <20121023141642.GA22154@localhost>
References: <508695b0.hStka2PI8YeAmkAt%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 623B42652D4
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 16:16:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <508695b0.hStka2PI8YeAmkAt%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Raymond Yau <superquad.vortex2@gmail.com>, yuanhan.liu@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

smatch warns about a weird "if();" in sound/pci/au88x0/au88x0_core.c 
Any ideas to fix it?

        2461 #ifndef CHIP_AU8810
        2462                 for (i = 0; i < NR_WT; i++) {
        2463                         if (vortex->dma_wt[i].fifo_status == FIFO_START) {
==>     2464                                 if (vortex_wtdma_bufshift(vortex, i)) ;
        2465                                 spin_unlock(&vortex->lock);
        2466                                 snd_pcm_period_elapsed(vortex->dma_wt[i].
        2467                                                        substream);
        2468                                 spin_lock(&vortex->lock);
        2469                         }
        2470                 }
        2471 #endif     

Thanks,
Fengguang
