From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 1/3] ALSA: hdac_ext: add extended HDA bus
Date: Mon, 8 Jun 2015 21:00:14 +0530
Message-ID: <20150608153014.GN28601@localhost>
References: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
 <1433411602-5444-2-git-send-email-vinod.koul@intel.com>
 <s5hh9qik21f.wl-tiwai@suse.de> <20150608100822.GC28601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A94B3260442
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 17:35:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150608100822.GC28601@localhost>
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

On Mon, Jun 08, 2015 at 03:38:22PM +0530, Vinod Koul wrote:
> > > +#define snd_hdac_ext_bus_ppcap_updateb(dev, reg, mask, val) \
> > > +	snd_hdac_ext_bus_ppcap_writeb(dev, reg, \
> > > +			       (snd_hdac_ext_bus_ppcap_readb(dev, reg) & \
> > > +				~(mask)) | (val))
> > 
> > It's not necessarily good to wrap all with such macros.
> > For azx_write*(), I kept them as is for reducing the amount of useless
> > code rewrites.  But for new codes, I don't think it's always worth...
> Actually while updating the patch for ext I was wondering about this too.
> 
> So we cna remove these and use snd_hdac_chip_writel/w/b here
As Jeeja pointed we can't use snd_hdac_chip_writel as we need to use a
different base. So we cna move this to use plain writel only

Any other ideas?

-- 
~Vinod
