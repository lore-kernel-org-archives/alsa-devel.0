From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] sgalaxy: checkpatch fixes
Date: Wed, 05 Sep 2007 00:24:33 +0200
Message-ID: <46DDDB21.9000003@gmail.com>
References: <20070904234925.d96c021c.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id A0E1C2434F
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Sep 2007 00:30:57 +0200 (CEST)
In-Reply-To: <20070904234925.d96c021c.krzysztof.h1@wp.pl>
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

On 09/04/2007 11:49 PM, Krzysztof Helt wrote:

A few comments, but also note that while I've been "dragging my feet" (grin) 
on getting the thing tested on more cards, I've a new driver for these cards 
in the works. Was already posted a while ago -- just need to clean it up, 
integrate some more and then test and submit it for real...

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes white spaces and errors pointed by
> the checkpatch.pl script.

That thing is not actually intended for existing code...

> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> A nice side effect: sgalaxy.c gets shorter.
> 
> diff -urp linux-2.6.23.orig/sound/isa/sgalaxy.c linux-2.6.23/sound/isa/sgalaxy.c
> --- linux-2.6.23.orig/sound/isa/sgalaxy.c	2007-07-09 01:32:17.000000000 +0200
> +++ linux-2.6.23/sound/isa/sgalaxy.c	2007-09-04 23:41:11.860030310 +0200
> @@ -47,7 +47,8 @@ static int index[SNDRV_CARDS] = SNDRV_DE
>  static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
>  static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
>  static long sbport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240 */
> -static long wssport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x530,0xe80,0xf40,0x604 */
> +static long wssport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
> +						/* 0x530,0xe80,0xf40,0x604 */

Please don't. The idea of coding style fixes is to make things _easier_ to read.

>  static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 7,9,10,11 */
>  static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3 */
>  
> @@ -69,14 +70,10 @@ MODULE_PARM_DESC(dma1, "DMA1 # for Sound
>  
>  #define PFX	"sgalaxy: "
>  
> -/*
> +#define AD1848P1(port, x) (port + c_d_c_AD1848##x)
>  
> - */
> -
> -#define AD1848P1( port, x ) ( port + c_d_c_AD1848##x )
> -
> -/* from lowlevel/sb/sb.c - to avoid having to allocate a struct snd_sb for the */
> -/* short time we actually need it.. */
> +/* from lowlevel/sb/sb.c - to avoid having to allocate a struct snd_sb */
> +/* for the short time we actually need it.. */
>  
>  static int snd_sgalaxy_sbdsp_reset(unsigned long port)
>  {
> @@ -98,7 +95,7 @@ static int __devinit snd_sgalaxy_sbdsp_c
>  					       unsigned char val)
>  {
>  	int i;
> -       	
> +
>  	for (i = 10000; i; i--)
>  		if ((inb(SBP1(port, STATUS)) & 0x80) == 0) {
>  			outb(val, SBP1(port, COMMAND));
> @@ -115,45 +112,39 @@ static irqreturn_t snd_sgalaxy_dummy_int
>  
>  static int __devinit snd_sgalaxy_setup_wss(unsigned long port, int irq, int dma)
>  {
> -	static int interrupt_bits[] = {-1, -1, -1, -1, -1, -1, -1, 0x08, -1, 
> +	static int interrupt_bits[] = {-1, -1, -1, -1, -1, -1, -1, 0x08, -1,
>  				       0x10, 0x18, 0x20, -1, -1, -1, -1};
>  	static int dma_bits[] = {1, 2, 0, 3};
>  	int tmp, tmp1;
>  
> -	if ((tmp = inb(port + 3)) == 0xff)
> -	{
> +	tmp = inb(port + 3);
> +	if (tmp == 0xff) {
>  		snd_printdd("I/O address dead (0x%lx)\n", port);
>  		return 0;
>  	}
> -#if 0
> -	snd_printdd("WSS signature = 0x%x\n", tmp);
> -#endif

Please don't just kill debug code. It's very useful for the next person 
stepping in -- it's "functional commentary".

> -        if ((tmp & 0x3f) != 0x04 &&
> -            (tmp & 0x3f) != 0x0f &&
> -            (tmp & 0x3f) != 0x00) {
> +	tmp &= 0x3f;
> +	if (tmp != 0x04 && tmp != 0x0f && tmp != 0x00) {
>  		snd_printdd("No WSS signature detected on port 0x%lx\n",
>  			    port + 3);
>  		return 0;
>  	}
>  
> -#if 0
> -	snd_printdd(PFX "setting up IRQ/DMA for WSS\n");
> -#endif

Same.

> -
> -        /* initialize IRQ for WSS codec */
> -        tmp = interrupt_bits[irq % 16];
> -        if (tmp < 0)
> -                return -EINVAL;
> -
> -	if (request_irq(irq, snd_sgalaxy_dummy_interrupt, IRQF_DISABLED, "sgalaxy", NULL)) {
> +	/* initialize IRQ for WSS codec */
> +	tmp = interrupt_bits[irq % 16];
> +	if (tmp < 0)
> +		return -EINVAL;
> +
> +	tmp = request_irq(irq, snd_sgalaxy_dummy_interrupt, IRQF_DISABLED,
> +			  "sgalaxy", NULL);
> +	if (tmp) {

NAK -- you just overwrote tmp with the return value from request_irq() 
meaning we're now poking garbage:

>  		snd_printk(KERN_ERR "sgalaxy: can't grab irq %d\n", irq);
>  		return -EIO;
>  	}
>  
> -        outb(tmp | 0x40, port);
> -        tmp1 = dma_bits[dma % 4];
> -        outb(tmp | tmp1, port);
> +	outb(tmp | 0x40, port);
> +	tmp1 = dma_bits[dma % 4];
> +	outb(tmp | tmp1, port);
>  
>  	free_irq(irq, NULL);
>  
> @@ -162,10 +153,6 @@ static int __devinit snd_sgalaxy_setup_w
>  
>  static int __devinit snd_sgalaxy_detect(int dev, int irq, int dma)
>  {
> -#if 0
> -	snd_printdd(PFX "switching to WSS mode\n");
> -#endif

Same.

> -
>  	/* switch to WSS mode */
>  	snd_sgalaxy_sbdsp_reset(sbport[dev]);
>  
> @@ -177,8 +164,10 @@ static int __devinit snd_sgalaxy_detect(
>  }
>  
>  static struct ad1848_mix_elem snd_sgalaxy_controls[] = {
> -AD1848_DOUBLE("Aux Playback Switch", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 7, 7, 1, 1),
> -AD1848_DOUBLE("Aux Playback Volume", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 0, 0, 31, 0)
> +AD1848_DOUBLE("Aux Playback Switch", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT,
> +		7, 7, 1, 1),
> +AD1848_DOUBLE("Aux Playback Volume", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT,
> +		0, 0, 31, 0)

I'd leave these on single lines again.

>  };
>  
>  static int __devinit snd_sgalaxy_mixer(struct snd_ad1848 *chip)
> @@ -190,28 +179,34 @@ static int __devinit snd_sgalaxy_mixer(s
>  
>  	memset(&id1, 0, sizeof(id1));
>  	memset(&id2, 0, sizeof(id2));
> -	id1.iface = id2.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
> +	id1.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
> +	id2.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>  	/* reassign AUX0 to LINE */
>  	strcpy(id1.name, "Aux Playback Switch");
>  	strcpy(id2.name, "Line Playback Switch");
> -	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
> +	err = snd_ctl_rename_id(card, &id1, &id2);
> +	if (err < 0)
>  		return err;
>  	strcpy(id1.name, "Aux Playback Volume");
>  	strcpy(id2.name, "Line Playback Volume");
> -	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
> +	err = snd_ctl_rename_id(card, &id1, &id2);
> +	if (err < 0)
>  		return err;
>  	/* reassign AUX1 to FM */
>  	strcpy(id1.name, "Aux Playback Switch"); id1.index = 1;
>  	strcpy(id2.name, "FM Playback Switch");
> -	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
> +	err = snd_ctl_rename_id(card, &id1, &id2);
> +	if (err < 0)
>  		return err;
>  	strcpy(id1.name, "Aux Playback Volume");
>  	strcpy(id2.name, "FM Playback Volume");
> -	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
> +	err = snd_ctl_rename_id(card, &id1, &id2);
> +	if (err < 0)
>  		return err;
>  	/* build AUX2 input */
>  	for (idx = 0; idx < ARRAY_SIZE(snd_sgalaxy_controls); idx++) {
> -		if ((err = snd_ad1848_add_ctl_elem(chip, &snd_sgalaxy_controls[idx])) < 0)
> +		err = snd_ad1848_add_ctl_elem(chip, &snd_sgalaxy_controls[idx]);
> +		if (err < 0)
>  			return err;
>  	}
>  	return 0;
> @@ -241,44 +236,50 @@ static int __devinit snd_sgalaxy_probe(s
>  	struct snd_ad1848 *chip;
>  
>  	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
> -	if (card == NULL)
> +	if (!card)
>  		return -ENOMEM;
>  
>  	xirq = irq[dev];
>  	if (xirq == SNDRV_AUTO_IRQ) {
> -		if ((xirq = snd_legacy_find_free_irq(possible_irqs)) < 0) {
> +		xirq = snd_legacy_find_free_irq(possible_irqs);
> +		if (xirq < 0) {
>  			snd_printk(KERN_ERR PFX "unable to find a free IRQ\n");
>  			err = -EBUSY;
>  			goto _err;
>  		}
>  	}
>  	xdma1 = dma1[dev];
> -        if (xdma1 == SNDRV_AUTO_DMA) {
> -		if ((xdma1 = snd_legacy_find_free_dma(possible_dmas)) < 0) {
> +	if (xdma1 == SNDRV_AUTO_DMA) {
> +		xdma1 = snd_legacy_find_free_dma(possible_dmas);
> +		if (xdma1 < 0) {
>  			snd_printk(KERN_ERR PFX "unable to find a free DMA\n");
>  			err = -EBUSY;
>  			goto _err;
>  		}
>  	}
>  
> -	if ((err = snd_sgalaxy_detect(dev, xirq, xdma1)) < 0)
> +	err = snd_sgalaxy_detect(dev, xirq, xdma1);
> +	if (err < 0)
>  		goto _err;
>  
> -	if ((err = snd_ad1848_create(card, wssport[dev] + 4,
> -				     xirq, xdma1,
> -				     AD1848_HW_DETECT, &chip)) < 0)
> +	err = snd_ad1848_create(card, wssport[dev] + 4, xirq, xdma1,
> +				AD1848_HW_DETECT, &chip);
> +	if (err < 0)
>  		goto _err;
>  	card->private_data = chip;
>  
> -	if ((err = snd_ad1848_pcm(chip, 0, NULL)) < 0) {
> +	err = snd_ad1848_pcm(chip, 0, NULL);
> +	if (err < 0) {
>  		snd_printdd(PFX "error creating new ad1848 PCM device\n");
>  		goto _err;
>  	}
> -	if ((err = snd_ad1848_mixer(chip)) < 0) {
> +	err = snd_ad1848_mixer(chip);
> +	if (err < 0) {
>  		snd_printdd(PFX "error creating new ad1848 mixer\n");
>  		goto _err;
>  	}
> -	if ((err = snd_sgalaxy_mixer(chip)) < 0) {
> +	err = snd_sgalaxy_mixer(chip);
> +	if (err < 0) {
>  		snd_printdd(PFX "the mixer rewrite failed\n");
>  		goto _err;
>  	}
> @@ -290,7 +291,8 @@ static int __devinit snd_sgalaxy_probe(s
>  
>  	snd_card_set_dev(card, devptr);
>  
> -	if ((err = snd_card_register(card)) < 0)
> +	err = snd_card_register(card);
> +	if (err < 0)
>  		goto _err;
>  
>  	dev_set_drvdata(devptr, card);
> @@ -327,7 +329,8 @@ static int snd_sgalaxy_resume(struct dev
>  
>  	chip->resume(chip);
>  	snd_ad1848_out(chip, SGALAXY_AUXC_LEFT, chip->image[SGALAXY_AUXC_LEFT]);
> -	snd_ad1848_out(chip, SGALAXY_AUXC_RIGHT, chip->image[SGALAXY_AUXC_RIGHT]);
> +	snd_ad1848_out(chip, SGALAXY_AUXC_RIGHT,
> +			chip->image[SGALAXY_AUXC_RIGHT]);

Definitely would keep this on one line.

>  
>  	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
>  	return 0;

Rene.
