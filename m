From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sat, 29 Mar 2008 01:42:27 -0500 (CDT)
Message-ID: <20080329064227.58074DBA2@gherkin.frus.com>
References: <47DFCEDA.2020307@uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 4909624368
	for <alsa-devel@alsa-project.org>; Sat, 29 Mar 2008 07:42:39 +0100 (CET)
In-Reply-To: <47DFCEDA.2020307@uwo.ca> "from Tyson Whitehead at Mar 18, 2008
	10:16:58 am"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tyson Whitehead <twhitehe@uwo.ca>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Ok...  I'm back.  Replies to the long queue of messages will be sent as
I have time to try the various patches.

Tyson Whitehead wrote:
> Takashi Iwai wrote:
> > ---
> > 
> > diff -r 82e6201fc907 sound/isa/es18xx.c
> > --- a/sound/isa/es18xx.c	Mon Mar 17 14:36:24 2008 +0100
> > +++ b/sound/isa/es18xx.c	Mon Mar 17 17:32:59 2008 +0100
> > @@ -765,9 +765,10 @@ static irqreturn_t snd_es18xx_interrupt(
> >  		/* Read Interrupt status */
> >  		status = snd_es18xx_mixer_read(chip, 0x7f) >> 4;
> >  	}
> > -#if 0
> > -	else {
> > -		status = 0;
> > +
> > +#ifdef CONFIG_ALPHA
> > +	if (!(status & (AUDIO1_IRQ | AUDIO2_IRQ))) {
> > +		/* status = 0; */
> >  		if (inb(chip->port + 0x0C) & 0x01)
> >  			status |= AUDIO1_IRQ;
> >  		if (snd_es18xx_mixer_read(chip, 0x7A) & 0x80)
> > @@ -777,7 +778,6 @@ static irqreturn_t snd_es18xx_interrupt(
> >  			status |= HWV_IRQ;
> >  	}
> >  #endif
> > -
> >  	/* Audio 1 & Audio 2 */
> >          if (status & AUDIO2_IRQ) {
> >                  if (chip->active & DAC2)
> 
> This looks like it should accomplish the same thing (assuming not bits 
> get set in status on the initial attempt to read it), without affecting 
> other platforms and possible the alpha if anyone has a card that just 
> works for whatever reason.  A better patch all around.  : )

Unfortunately, this does nothing to fix the ES1888 on my system.  Same
broken behavior as described previously.  I'll try something else in
the queue later today after I get some sleep...

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
