From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (3rd version)
Date: Wed, 05 Sep 2007 01:04:46 +0200
Message-ID: <46DDE48E.4000508@gmail.com>
References: <20070904211122.dfeed6d7.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F35124338
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 01:11:10 +0200 (CEST)
In-Reply-To: <20070904211122.dfeed6d7.krzysztof.h1@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/04/2007 09:11 PM, Krzysztof Helt wrote:

By the way -- something along the email path to you rejects my messages due 
to taking an SPF-neutral result from gmail as negative...

> The two issues pointed by Takashi are fixed.

[ ... ]

> +#include <linux/module.h>
> +#include <linux/isa.h>
> +#include <asm/dma.h>
> +#include <sound/driver.h>

He probably forgot to request that sound/driver.h come first. It's an issue 
with fixing up things for 2.4 compiles with the standalone driver package.

> +#include <sound/core.h>
> +#include <sound/ad1848.h>
> +#include <sound/opl3.h>
> +#include <sound/mpu401.h>
> +#include <sound/control.h>
> +#define SNDRV_LEGACY_FIND_FREE_IRQ
> +#define SNDRV_LEGACY_FIND_FREE_DMA
> +#include <sound/initval.h>

Personally I rather detest ISA autoprobing, so if you only included it as a 
"I see that the ALSA thing to do", feel free to try without as far as I'm 
concerned...

> +#define DSP_RESET	0x06	/* offset of DSP RESET		(wo) */
> +#define DSP_READ	0x0a	/* offset of DSP READ		(ro) */
> +#define DSP_WRITE	0x0c	/* offset of DSP WRITE		(w-) */
> +#define DSP_COMMAND	0x0c	/* offset of DSP COMMAND	(w-) */
> +#define DSP_STATUS	0x0c	/* offset of DSP STATUS		(r-) */
> +#define DSP_DATAVAIL	0x0e	/* offset of DSP DATA AVAILABLE	(ro) */

One of these days I'm going to stick that snd_sbdsp_reset() in the midlayer...

> +
> +#define PFX "sc6000: "
> +
> +/* hardware dependent functions */
> +
> +/*
> + * sc6000_irq_to_softcfg - Decode irq number into cfg code.
> + */
> +static inline unsigned char sc6000_irq_to_softcfg(int irq)
> +{
> +	unsigned char val = 0;
> +
> +	switch (irq) {
> +	case 5:
> +		val = 0x28;
> +		break;
> +	case 7:
> +		val = 0x8;
> +		break;
> +	case 9:
> +		val = 0x10;
> +		break;
> +	case 10:
> +		val = 0x18;
> +		break;
> +	case 11:
> +		val = 0x20;
> +		break;
> +	default:
> +		break;
> +	}
> +	return val;
> +}
> +
> +/*
> + * sc6000_dma_to_softcfg - Decode dma number into cfg code.
> + */
> +static inline unsigned char sc6000_dma_to_softcfg(int dma)
> +{
> +	unsigned char val = 0;
> +
> +	switch (dma) {
> +	case 0:
> +		val = 1;
> +		break;
> +	case 1:
> +		val = 2;
> +		break;
> +	case 3:
> +		val = 3;
> +		break;
> +	default:
> +		break;
> +	}
> +	return val;
> +}

Deja vu from sgalaxy...

But also -- please no inlines. There's no point to them. Kernel policy is 
basically "no inlines other than for things that would definitely be macros 
if we weren't fond of the typesafety inline functions give". GCC will figure 
things out on its own...

> +static int __devinit snd_sc6000_detect(int dev, int irq, int dma)
> +{
> +	int err = -ENODEV;
> +
> +	snd_printd("Initializing BASE[0x%lx] IRQ[%d] DMA[%d] MIRQ[%d]\n",
> +		   port[dev], irq, dma,
> +		   mpu_irq[dev] == SND_AUTO_IRQ ? 0 : mpu_irq[dev]);
> +
> +/*
> + * We must request the port region because these are the I/O
> + * ports to access card's control registers.
> + */
> +	if (!request_region(port[dev], 0x10, "sc-6000 (base)")) {
> +		snd_printk(KERN_ERR
> +			   "SC-6000 port I/O port region is already in use.\n");
> +		return -EBUSY;
> +	}
> +
> +	err = sc6000_init_board(port[dev], irq, dma,
> +				mss_port[dev], mpu_irq[dev]);
> +
> +	release_region(port[dev], 0x10);

So what happens if now someone starts poking at port[dev]? You probably want 
to keep these requested no?

> +static int __devinit snd_sc6000_match(struct device *devptr, unsigned int dev)
> +{
> +	if (!enable[dev])
> +		return 0;
> +	if (port[dev] == SNDRV_AUTO_PORT) {
> +		printk(KERN_ERR PFX "specify IO port\n");
> +		return 0;
> +	}
> +	if (mss_port[dev] == SNDRV_AUTO_PORT) {
> +		printk(KERN_ERR PFX "specify MSS port\n");
> +		return 0;
> +	}
> +	if (port[dev] != 0x220 && port[dev] != 0x240) {
> +		printk(KERN_ERR PFX "Port must be 0x220 or 0x240\n");
> +		return 0;
> +	}
> +	if (mss_port[dev] != 0x530 && mss_port[dev] != 0xe80) {
> +		printk(KERN_ERR PFX "MSS port must be 0x530 or 0xe80\n");
> +		return 0;
> +	}
> +	if (irq[dev] != SNDRV_AUTO_IRQ && !sc6000_irq_to_softcfg(irq[dev])) {
> +		printk(KERN_ERR PFX "invalid IRQ %d\n", irq[dev]);
> +		return 0;
> +	}
> +	if (dma[dev] != SNDRV_AUTO_DMA && !sc6000_dma_to_softcfg(dma[dev])) {
> +		printk(KERN_ERR PFX "invalid DMA %d\n", dma[dev]);
> +		return 0;
> +	}
> +	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
> +	    (mpu_port[dev] & ~0x30l) != 0x300) {

Eh, what?

> +		printk(KERN_ERR PFX "invalid MPU-401 port %lx\n",
> +			mpu_port[dev]);
> +		return 0;
> +	}
> +	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
> +	    mpu_irq[dev] != SNDRV_AUTO_IRQ && mpu_irq[dev] != 0 &&
> +	    !sc6000_mpu_irq_to_softcfg(mpu_irq[dev])) {
> +		printk(KERN_ERR PFX "invalid MPU-401 IRQ %d\n", mpu_irq[dev]);
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
> +{
> +	static int possible_irqs[] = { 7, 9, 10, 11, -1 };

In the above, IRQ 5 also seems to be allowed. This is all rather massive 
sgalaxy deja-vu...

Rene.
