From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Tue, 2 Jun 2015 17:59:03 +0530
Message-ID: <20150602122903.GO3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
 <20150601051358.GI3140@localhost> <s5hy4k46lk1.wl-tiwai@suse.de>
 <20150602104233.GG14071@sirena.org.uk>
 <s5hvbf6e67h.wl-tiwai@suse.de>
 <20150602111034.GP14071@sirena.org.uk>
 <s5hoakye3lx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F93265057
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 14:27:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hoakye3lx.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2015 at 01:44:58PM +0200, Takashi Iwai wrote:
> At Tue, 2 Jun 2015 12:10:34 +0100,
> Mark Brown wrote:
> > 
> > On Tue, Jun 02, 2015 at 12:48:50PM +0200, Takashi Iwai wrote:
> > > Mark Brown wrote:
> > 
> > > > Why does the driver care though?  IRQF_SHARED is advertising the
> > > > capabilities of the hander, not a requirement on the hardware - if the
> > > > interrupt physically can't be shared then the ability to share it will
> > > > never get used but that shouldn't matter.
> > 
> > > Because the kernel doesn't guarantee the exclusiveness of irq handler
> > > registration as long as you pass IRQF_SHARED.  That is, if we keep
> > > IRQF_SHARED and another driver tries to request_irq() for the same irq
> > > with again IRQF_SHARED.  But this shouldn't happen with MSI.
> > 
> > Sure, but how could that happen (given that the interrupt physically
> > can't be shared) and surely individual client drivers are the wrong
> > place to do this -
> 
> Oh how can you trust BIOS setup? :)  A wrong numbered IRQ is a most
> frequently seen problem (mostly not about MSI, though).
well for SKL the systems are supposed to be not using MSI(my orignal thought
removing msi part and going to shared irq only), but we know how easily
these things get messed up, so having this sounds better here

-- 
~Vinod
> 
> > it's not like MSI is the only interrupt type that has
> > trouble with sharability, if this is an issue we need to have checks and
> > enforcement for I'd expect the interrupt controller to be flagging
> > itself as unsharable.
> 
> Rather the sharable interrupt is exceptional, I'd say.  That's the
> reason we have IRQF_SHARED, not IRQF_EXCLUSIVE.
> 
> 
> Takashi

-- 
