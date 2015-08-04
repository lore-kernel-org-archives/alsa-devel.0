From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ALSA: HDA: wait for RIRB,
	CORB DMA to finish
Date: Tue, 4 Aug 2015 14:40:48 +0530
Message-ID: <20150804091048.GD11789@localhost>
References: <1438660720-30033-1-git-send-email-vinod.koul@intel.com>
 <1438660720-30033-4-git-send-email-vinod.koul@intel.com>
 <s5hlhdrd4bb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2985126587B
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 11:09:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hlhdrd4bb.wl-tiwai@suse.de>
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

On Tue, Aug 04, 2015 at 07:13:12AM +0200, Takashi Iwai wrote:
> > @@ -86,10 +86,24 @@ EXPORT_SYMBOL_GPL(snd_hdac_bus_init_cmd_io);
> >   */
> >  void snd_hdac_bus_stop_cmd_io(struct hdac_bus *bus)
> >  {
> > +	unsigned long timeout;
> > +
> >  	spin_lock_irq(&bus->reg_lock);
> >  	/* disable ringbuffer DMAs */
> >  	snd_hdac_chip_writeb(bus, RIRBCTL, 0);
> >  	snd_hdac_chip_writeb(bus, CORBCTL, 0);
> > +
> > +	/* poll DMAs to check if they stopped or not */
> > +
> > +	timeout = jiffies + msecs_to_jiffies(100);
> > +	while ((snd_hdac_chip_readb(bus, RIRBCTL) & AZX_RBCTL_DMA_EN) &&
> > +	       time_before(jiffies, timeout))
> > +		usleep_range(500, 1000);
> 
> You must not use *sleep() inside atomic context.
Right, not sure why it didnt crib when we tested, will send updated one soon

Thanks for the super quick review :)

-- 
~Vinod
