From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] Turtle Beach Multisound Classic/Pinnacle
 driver (3rd rev)
Date: Fri, 23 Jan 2009 15:08:50 +0100
Message-ID: <20090123150850.4231fb76.krzysztof.h1@poczta.fm>
References: <20090122215237.d749c92b.krzysztof.h1@poczta.fm>
	<s5hwscmii34.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 9652C1038B5
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 15:05:45 +0100 (CET)
In-Reply-To: <s5hwscmii34.wl%tiwai@suse.de>
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

On Fri, 23 Jan 2009 08:42:39 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 22 Jan 2009 21:52:37 +0100,
> Krzysztof Helt wrote:

> > +	.rate_min =		8000,
> > +	.rate_max =		48000,
> > +	.channels_min =		1,
> > +	.channels_max =		2,
> > +	.buffer_bytes_max =	0x3000,
> > +	.period_bytes_min =	0x40,
> > +	.period_bytes_max =	0x1800,
> > +	.periods_min =		2,
> > +	.periods_max =		3,
> 
> Wow, I didn't notice this restriction...  Really up to 3 periods?
> 

I have to check but probably it is. 

> > --- linux-rc5/sound/isa/msnd/msnd.h	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-git/sound/isa/msnd/msnd.h	2009-01-22 21:17:09.125632934 +0100
> ...
> > +#ifdef SLOWIO
> > +#  undef outb
> > +#  undef inb
> > +#  define outb			outb_p
> > +#  define inb			inb_p
> > +#endif
> 
> This is too hackish.  If SLOWIO is only for alpha, and the driver is
> configured to be X86-only, I'd suggest to get rid of this hack.
> 

I would leave it as it allows Alpha guys to fix it later (if ever).

> > --- linux-rc5/sound/isa/msnd/msnd_midi.c	1970-01-01 01:00:00.000000000 +0100
> > +++ linux-git/sound/isa/msnd/msnd_midi.c	2009-01-22 18:35:00.942072608 +0100
> > @@ -0,0 +1,179 @@
> > +/*
> > + *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
> > + *  Routines for control of MPU-401 in UART mode
> 
> Better to put your name here and there, too...
> 

I can put my name along as the file is almost a strict copy
of the mpu401 code. It was put this way in the Kirsten's driver
and I did only cut some code from there.

> > +static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
> > +static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
> > +
> > +module_param_array(index, int, NULL, S_IRUGO);
> > +MODULE_PARM_DESC(index, "Index value for msnd_pinnacle soundcard.");
> > +module_param_array(id, charp, NULL, S_IRUGO);
> > +MODULE_PARM_DESC(id, "ID string for msnd_pinnacle soundcard.");
> > +
> > +static long io[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
> > +static int irq[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_IRQ;
> > +static long mem[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
> > +
> > +static long cfg[SNDRV_CARDS] __devinitdata = SNDRV_DEFAULT_PORT;
> 
> The modules parameters aren't __devinitdata.  Remove these
> annotations.
> 

I haven't known that. Could you explain?

Thanks,
Krzysztof

----------------------------------------------------------------------
Speak Up. Angielski szybko i skutecznie. 3 miesiace nauki gratis.
Sprawdz. >> http://link.interia.pl/f2019
