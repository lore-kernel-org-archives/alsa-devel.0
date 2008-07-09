From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH] ALSA driver for SGI O2 audio board
Date: Wed, 9 Jul 2008 19:50:59 +0200
Message-ID: <20080709175059.GA10046@alpha.franken.de>
References: <20080704234559.C959CFB63A@solo.franken.de>
	<s5hy74dvga5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FFB82448E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jul 2008 19:57:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy74dvga5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 07, 2008 at 05:57:06PM +0200, Takashi Iwai wrote:
> Thanks for the patch.
> Below is a quick review.

thank you.

> > +	wmb();
> > +	val = readq(&mace->perif.audio.codec_control); /* flush bus */
> > +	udelay(200);
> 
> It'd be nicer if this long delay can be avoided.  Or, could it be
> mutex?
> 
> This isn't a fatal problem, so it's OK as is, though.

I'm not quite sure, what delay really is sufficient at the moment. It
worked without delay on my slow O2, but caused problems on faster
maschines. I want to figure out a good value and if it's just a
few microsecons simply use an udelay(). If a longer delay is needed
I'll switch over to something more kernel friendly.

> > +	/* allocate IRQs */
> > +	for (i = 0; i < ARRAY_SIZE(snd_sgio2_isr_table); i++) {
> > +		if (request_irq(snd_sgio2_isr_table[i].irq,
> > +				snd_sgio2_isr_table[i].isr,
> > +				IRQF_SHARED,
> > +				snd_sgio2_isr_table[i].desc,
> > +				&chip->channel[snd_sgio2_isr_table[i].idx])) {
> > +			snd_sgio2audio_free(chip);
> > +			printk(KERN_ERR "sgio2audio: cannot allocate irq %d\n",
> > +			       snd_sgio2_isr_table[i].irq);
> > +			return -EBUSY;
> > +		}
> > +	}
> 
> If there are shared interrupts, they could be called before the
> initialization below.  So, safer to move after the init.

they can't be shared and it's already done before any hardware init.
We only check, whether there is a sound module installed before
that.

I'll post an updated patch in a couple of minutes.

Thomas,

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
