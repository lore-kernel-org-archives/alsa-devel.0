From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Remove unused IRQ chip data of
 HDMI LPE audio
Date: Mon, 29 Jan 2018 19:09:22 +0200
Message-ID: <20180129170922.GR5453@intel.com>
References: <20171208093323.2212-1-augustine.chen@intel.com>
 <20171208114404.GN10981@intel.com>
 <alpine.DEB.2.20.1712082340400.2301@nanos>
 <F6867404AABACB4D8EC371BF802A4B7C5790D206@fmsmsx101.amr.corp.intel.com>
 <alpine.DEB.2.20.1712121804570.1794@nanos>
 <F6867404AABACB4D8EC371BF802A4B7C5790F9A8@fmsmsx101.amr.corp.intel.com>
 <alpine.DEB.2.20.1712131232090.1885@nanos>
 <s5hshce7skk.wl-tiwai@suse.de>
 <alpine.DEB.2.20.1712131452550.1885@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1712131452550.1885@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Takashi Iwai <tiwai@suse.de>, "Anand, Jerome" <jerome.anand@intel.com>, "Chen, Augustine" <augustine.chen@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jiang Liu <jiang.liu@linux.intel.com>, Juergen Gross <jgross@suse.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 03:06:55PM +0100, Thomas Gleixner wrote:
> On Wed, 13 Dec 2017, Takashi Iwai wrote:
> > On Wed, 13 Dec 2017 12:35:54 +0100,
> > Thomas Gleixner wrote:
> > > 
> > > > > On Mon, 11 Dec 2017, Anand, Jerome wrote:
> > > > > > > On Fri, 8 Dec 2017, Ville Syrjälä wrote:
> > > > > > >
> > > > > > > > On Fri, Dec 08, 2017 at 05:33:23PM +0800, Augustine.Chen wrote:
> > > > > > > > > The chip data of HDMI LPE audio is set to drm_i915_private which
> > > > > > > > > is not consistent with the expectation by x86 APIC driver.
> > > > > > > >
> > > > > > > > Hmm. Why is the apic code looking at data for an irq chip it
> > > > > > > > hasn't created?
> > > > > > > >
> > > > > >
> > > > > > apic code expects an irq domain to be place as generic approach.
> > > > > 
> > > > > APIC code does not even see that interrupt at all. It's completely disconnected.
> > > > > 
> > > > 
> > > > That's the problem - APIC just converts the chip data to its internal
> > > > format and fails.
> > > 
> > > How does APIC code end up to touch that interrupt at all? Call stack please.
> > 
> > It's found in the bugzilla referred in the patch:
> >   https://bugs.freedesktop.org/show_bug.cgi?id=103731
> > 
> > [   87.353072] irq 298 idata->chip->name hdmi_lpe_audio_irqchip
> > [   87.353072] irq 298 apic_chip_data
> > [   87.353073] irq 298 data->domain is NULL
> > [   87.353120] BUG: unable to handle kernel NULL pointer dereference at (null)
> > [   87.353132] IP: setup_vector_irq+0x1ba/0x230
> > [   87.353133] PGD 0
> > 
> > If my understanding is correct, it happens only with 4.14 and earlier
> > kernels where __setup_vector_irq() loops over the all irqs:
> > 
> > static void __setup_vector_irq(int cpu)
> > {
> > 	struct apic_chip_data *data;
> > 	struct irq_desc *desc;
> > 	int irq, vector;
> > 
> > 	/* Mark the inuse vectors */
> > 	for_each_irq_desc(irq, desc) {
> > 		struct irq_data *idata = irq_desc_get_irq_data(desc);
> > 
> > 		data = apic_chip_data(idata);
> > 		if (!data || !cpumask_test_cpu(cpu, data->domain))
> > 			continue;
> > 		....
> > 
> > And since we have assigned a non-APIC chip data in the driver, the
> > code above refers to a wrong object, leading to Oops.
> 
> Bah crap. This information should have been provided earlier instead of
> handwavy 'doesnt work with CONFIG_FOO and hotplug'.
> 
> > As a further note, the setup_vector_irq() code has been changed in
> > 4.15, and such a reference won't happen any longer.  So the patch
> > isn't necessary for now, although it's not bad to take as a cleanup.
> > And we can eventually put Cc to stable there since it actually works
> > around the issue above for the older kernels -- of course, with more
> > detailed descriptions about the background.
> 
> No, that's just tinkering. The proper fix is to make that code robust.
> 
> Something like the completely untested patch below should do the trick.
> 
> Thanks,
> 
> 	tglx
> ---
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index f3557a1eb562..02e6a3cc0d74 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -58,6 +58,9 @@ static struct apic_chip_data *apic_chip_data(struct irq_data *irq_data)
>  	while (irq_data->parent_data)
>  		irq_data = irq_data->parent_data;
>  
> +	if (irq_data->domain != x86_vector_domain)
> +		return NULL;
> +
>  	return irq_data->chip_data;
>  }
>  
> 

Did this patch resolve the issue?

-- 
Ville Syrjälä
Intel OTC
