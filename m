From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 1/2] opti93x: fix irq releasing if the irq
 cannot be allocated
Date: Tue, 1 Dec 2009 13:07:37 +0100
Message-ID: <20091201130737.6da195d2.krzysztof.h1@poczta.fm>
References: <20091130201309.e40785f8.krzysztof.h1@poczta.fm>
	<s5h638r0xyz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id DA7F710380F
	for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2009 13:05:38 +0100 (CET)
In-Reply-To: <s5h638r0xyz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 01 Dec 2009 11:50:44 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 30 Nov 2009 20:13:09 +0100,
> Krzysztof Helt wrote:
> > 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Fix the bug that an irq is released if the irq's allocation fails.
> > Move irq allocation earlier so the codec->irq is not set if the request_irq() fails. 
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> > A different approach than the previous one.
> 
> Basically this isn't recommended in general.  The IRQ might be issued
> (mistakenly, e.g. on a buggy board), the handler might access to
> uninitialized ports, etc.  So, on PCI, it's definitely no-go, but on
> ISA, it would work in most cases because the IRQ line is exclusive.
> 
> Another problem, however, is that code->irq is still checked for
> freeing...
> 

It is ok, because the condition is "if (codec && codec->irq > 0)" and
the codec is chip->codec pointer.

The chip->codec == NULL before it is assigned. First, the irq is allocated.
The chip->codec is still NULL so there is no problem if the request_irq() fails.
Then the snd_wss_create() is called. If the snd_wss_create() is successful
the chip->codec is assigned to the pointer created in the snd_wss_create().
The irq is freed since then (which is correct). It is a correct code even with
a shared irq.

I see a small defect now - if the snd_wss_create() fails one should call free_irq().
I'll redo the patch.

Regards,
Krzysztof

> 
> thanks,
> 
> Takashi
> 
> 
> > 
> >  sound/isa/opti9xx/opti92x-ad1848.c |   25 ++++++++++++++-----------
> >  1 files changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
> > index 5cd5553..fd32001 100644
> > --- a/sound/isa/opti9xx/opti92x-ad1848.c
> > +++ b/sound/isa/opti9xx/opti92x-ad1848.c
> > @@ -558,10 +558,13 @@ __skip_mpu:
> >  
> >  static irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id)
> >  {
> > -	struct snd_wss *codec = dev_id;
> > -	struct snd_opti9xx *chip = codec->card->private_data;
> > +	struct snd_opti9xx *chip = dev_id;
> > +	struct snd_wss *codec = chip->codec;
> >  	unsigned char status;
> >  
> > +	if (!codec)
> > +		return IRQ_HANDLED;
> > +
> >  	status = snd_opti9xx_read(chip, OPTi9XX_MC_REG(11));
> >  	if ((status & OPTi93X_IRQ_PLAYBACK) && codec->playback_substream)
> >  		snd_pcm_period_elapsed(codec->playback_substream);
> > @@ -690,7 +693,7 @@ static void snd_card_opti9xx_free(struct snd_card *card)
> >  		struct snd_wss *codec = chip->codec;
> >  		if (codec && codec->irq > 0) {
> >  			disable_irq(codec->irq);
> > -			free_irq(codec->irq, codec);
> > +			free_irq(codec->irq, chip);
> >  		}
> >  #endif
> >  		release_and_free_resource(chip->res_mc_base);
> > @@ -738,6 +741,14 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
> >  	if (error)
> >  		return error;
> >  
> > +#ifdef OPTi93X
> > +	error = request_irq(chip->irq, snd_opti93x_interrupt,
> > +			    IRQF_DISABLED, DEV_NAME" - WSS", chip);
> > +	if (error < 0) {
> > +		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
> > +		return error;
> > +	}
> > +#endif
> >  	error = snd_wss_create(card, chip->wss_base + 4, -1,
> >  			       chip->irq, chip->dma1, chip->dma2,
> >  #ifdef OPTi93X
> > @@ -762,14 +773,6 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
> >  	if (error < 0)
> >  		return error;
> >  #endif
> > -#ifdef OPTi93X
> > -	error = request_irq(chip->irq, snd_opti93x_interrupt,
> > -			    IRQF_DISABLED, DEV_NAME" - WSS", codec);
> > -	if (error < 0) {
> > -		snd_printk(KERN_ERR "opti9xx: can't grab IRQ %d\n", chip->irq);
> > -		return error;
> > -	}
> > -#endif
> >  	strcpy(card->driver, chip->name);
> >  	sprintf(card->shortname, "OPTi %s", card->driver);
> >  #if defined(CS4231) || defined(OPTi93X)
> > -- 
> > 1.6.4
> > 
> > 
> > ----------------------------------------------------------------------
> > KONKURS! Kliknij i wygraj luksusowe auto na weekend
> > lub jedn_ z 650 innych nagr_d od L&#8217;Oreal Men Expert!! >> 
> > http://link.interia.pl/f2428
> > 
> > [2  <text/plain; us-ascii (7bit)>]
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

----------------------------------------------------------------------
Zbieraj punkty - wygrywaj nagrody!
Kliknij >>> http://link.interia.pl/f24a8
