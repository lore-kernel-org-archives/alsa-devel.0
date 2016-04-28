From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda: fix to wait for RIRB & CORB
	DMA to set
Date: Thu, 28 Apr 2016 19:25:54 +0530
Message-ID: <20160428135553.GX2274@localhost>
References: <1461848765-20212-1-git-send-email-vinod.koul@intel.com>
 <1461848765-20212-2-git-send-email-vinod.koul@intel.com>
 <s5hinz1ub4n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 049DD26696A
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 15:49:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hinz1ub4n.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2016 at 03:16:24PM +0200, Takashi Iwai wrote:
> On Thu, 28 Apr 2016 15:06:05 +0200,
> Vinod Koul wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > After setting the stop bit of RIRB/CORB DMA, we should wait for
> > stop bit to be set.
> 
> What does this actually fix?

We some some stablity issues on SKL that were attributed to DMAs not being
quisced properly so recommendation was to to wait till DMAs are stopped

> > @@ -88,8 +117,8 @@ void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus)
> >  {
> >  	spin_lock_irq(&bus->reg_lock);
> >  	/* disable ringbuffer DMAs */
> > -	snd_hdac_chip_writeb(bus, RIRBCTL, 0);
> > -	snd_hdac_chip_writeb(bus, CORBCTL, 0);
> > +	hdac_stop_rirb_dma(bus);
> > +	hdac_stop_corb_dma(bus);
> 
> Doing these one after another sequentially is a waste of time.
> Clear two once, then sync them.

Yes agreed, that sounds better, something like adding a new wait function:

	hdac_stop_rirb_dma(bus);
	hdac_stop_corb_dma(bus);
	hdac_wait_for_cmd_dmas(bus);


Thanks
-- 
~Vinod
