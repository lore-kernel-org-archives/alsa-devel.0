From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] Gallant SC-6000 driver (3rd version)
Date: Wed, 5 Sep 2007 06:42:41 +0200
Message-ID: <20070905064241.321972d5.krzysztof.h1@wp.pl>
References: <20070904211122.dfeed6d7.krzysztof.h1@wp.pl>
	<46DDE48E.4000508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D372103878
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 06:36:23 +0200 (CEST)
In-Reply-To: <46DDE48E.4000508@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 05 Sep 2007 01:04:46 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> On 09/04/2007 09:11 PM, Krzysztof Helt wrote:
> 
> By the way -- something along the email path to you rejects my messages due 
> to taking an SPF-neutral result from gmail as negative...
> 
I'll contact portal administrators.

> > +#define SNDRV_LEGACY_FIND_FREE_IRQ
> > +#define SNDRV_LEGACY_FIND_FREE_DMA
> > +#include <sound/initval.h>
> 
> Personally I rather detest ISA autoprobing, so if you only included it as a 
> "I see that the ALSA thing to do", feel free to try without as far as I'm 
> concerned...

ok.

> > +/*
> > + * sc6000_dma_to_softcfg - Decode dma number into cfg code.
> > + */
> > +static inline unsigned char sc6000_dma_to_softcfg(int dma)
> > +{
> > +	unsigned char val = 0;
> > +
> > +	switch (dma) {
> > +	case 0:
> > +		val = 1;
> > +		break;
> > +	case 1:
> > +		val = 2;
> > +		break;
> > +	case 3:
> > +		val = 3;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +	return val;
> > +}
> 
> Deja vu from sgalaxy...
> 
> But also -- please no inlines. There's no point to them. Kernel policy is 
> basically "no inlines other than for things that would definitely be macros 
> if we weren't fond of the typesafety inline functions give". GCC will figure 
> things out on its own...
> 

These things were actually macros in the 2.4 driver.

> > +/*
> > + * We must request the port region because these are the I/O
> > + * ports to access card's control registers.
> > + */
> > +	if (!request_region(port[dev], 0x10, "sc-6000 (base)")) {
> > +		snd_printk(KERN_ERR
> > +			   "SC-6000 port I/O port region is already in use.\n");
> > +		return -EBUSY;
> > +	}
> > +
> > +	err = sc6000_init_board(port[dev], irq, dma,
> > +				mss_port[dev], mpu_irq[dev]);
> > +
> > +	release_region(port[dev], 0x10);
> 
> So what happens if now someone starts poking at port[dev]? You probably want 
> to keep these requested no?
> 

Sgalaxy dejavu.

> > +	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
> > +	    (mpu_port[dev] & ~0x30l) != 0x300) {
> 
> Eh, what?
> 

Checking if mpu_port[dev] is one 0x3X0 where X is from 0 to 3

> > +		printk(KERN_ERR PFX "invalid MPU-401 port %lx\n",
> > +			mpu_port[dev]);
> > +		return 0;
> > +	}
> > +	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
> > +	    mpu_irq[dev] != SNDRV_AUTO_IRQ && mpu_irq[dev] != 0 &&
> > +	    !sc6000_mpu_irq_to_softcfg(mpu_irq[dev])) {
> > +		printk(KERN_ERR PFX "invalid MPU-401 IRQ %d\n", mpu_irq[dev]);
> > +		return 0;
> > +	}
> > +	return 1;
> > +}
> > +
> > +static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
> > +{
> > +	static int possible_irqs[] = { 7, 9, 10, 11, -1 };
> 
> In the above, IRQ 5 also seems to be allowed. This is all rather massive 
> sgalaxy deja-vu...
> 

Do you think that this card can be handled by sgalaxy driver (with minimal changes to sgalaxy)?

Regards,
Krzysztof
