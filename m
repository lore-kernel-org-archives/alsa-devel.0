From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] ALSA: hda: fix to wait for RIRB &
	CORB DMA to set
Date: Mon, 9 May 2016 10:08:24 +0530
Message-ID: <20160509043823.GW2274@localhost>
References: <1462427683-3646-1-git-send-email-vinod.koul@intel.com>
 <1462427683-3646-2-git-send-email-vinod.koul@intel.com>
 <s5h8tzksx0x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1351D260670
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 06:32:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h8tzksx0x.wl-tiwai@suse.de>
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

On Sun, May 08, 2016 at 11:45:50AM +0200, Takashi Iwai wrote:
> > +/* wait for cmd dmas till they are stopped */
> > +static void hdac_wait_for_cmd_dmas(struct hdac_bus *bus)
> > +{
> > +	unsigned long timeout;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(100);
> > +	while ((snd_hdac_chip_readb(bus, RIRBCTL) & AZX_RBCTL_DMA_EN)
> > +		&& time_before(jiffies, timeout))
> > +		udelay(10);
> > +
> > +	timeout = jiffies + msecs_to_jiffies(100);
> > +	while ((snd_hdac_chip_readb(bus, CORBCTL) & AZX_CORBCTL_RUN)
> > +		&& time_before(jiffies, timeout))
> > +		udelay(10);
> 
> This will end up with doubled timeout.  But it doesn't matter so much
> in practice.  So I applied the patch as is.

Thanks Takashi

-- 
~Vinod
