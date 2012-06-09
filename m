From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [RFC] usb-audio: Use a table of mixer controls
Date: Sat, 9 Jun 2012 13:13:00 +0100 (BST)
Message-ID: <alpine.LNX.2.01.1206091310410.13043@stax.localdomain>
References: <1336757328-22649-1-git-send-email-mark@pogo.org.uk>
	<s5hzk9ems3i.wl%tiwai@suse.de>
	<alpine.LNX.2.01.1205120014250.23046@stax.localdomain>
	<s5htxzln8qr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wes.ijneb.com (mx.ij.cx [212.13.201.15])
	by alsa0.perex.cz (Postfix) with ESMTP id A3AE424456
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 14:13:06 +0200 (CEST)
In-Reply-To: <s5htxzln8qr.wl%tiwai@suse.de>
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

On Sat, 12 May 2012, Takashi Iwai wrote:

> At Sat, 12 May 2012 00:21:14 +0100 (BST),
> Mark Hills wrote:
> > 
> > On Fri, 11 May 2012, Takashi Iwai wrote:
> > 
> > > > +/*
> > > > + * The mixer units for Ebox-44 are corrupt, and even where they
> > > > + * are valid they presents mono controls as L and R channels of
> > > > + * stereo. So we create provide a good mixer here.
> > > > + */
> > > > +struct std_mono_table ebox44_table[] = {
> > > > +	{ 4, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Headphone Playback Switch", NULL },
> > > > +	{ 4, 2, 0x1, USB_MIXER_S16, "Headphone A Mix Playback Volume", NULL },
> > > > +	{ 4, 2, 0x2, USB_MIXER_S16, "Headphone B Mix Playback Volume", NULL },
> > > > +
> > > > +	{ 7, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Output Playback Switch", NULL },
> > > > +	{ 7, 2, 0x1, USB_MIXER_S16, "Output A Playback Volume", NULL },
> > > > +	{ 7, 2, 0x2, USB_MIXER_S16, "Output B Playback Volume", NULL },
> > > > +
> > > > +	{ 10, 1, 0x0, USB_MIXER_INV_BOOLEAN, "Input Capture Switch", NULL },
> > > > +	{ 10, 2, 0x1, USB_MIXER_S16, "Input A Capture Volume", NULL },
> > > > +	{ 10, 2, 0x2, USB_MIXER_S16, "Input B Capture Volume", NULL },
> > > > +
> > > > +	{ }
> > > 
> > > C99 style struct initialization is preferred.  Then NULL settings can
> > > be omittted.
> > 
> > Do you mean like this?
> > 
> >   ebox44_table[] = {
> >       {
> >           .unitid = 4,
> >           .control =  1
> >           .cmask = 0x0
> >           /* etc. */
> >       }
> > 
> > Because then it becomes a lot less concise and a lot less readable?
> 
> I can't count fields more than two, so to me, C99 style is more
> readable :)

I know you can count more than two, because I see you do it with function 
calls all the time :-)

Nevertheless, I'll follow-up with revised (and tested) patches, ready for 
inclusion.
 
> > Of course, if there are more optional params in the future, then maybe.
> 
> Yep.

I see now in doing this that likely to happen is that the table becomes a 
full 'quirks' table with a mix of mono and stereo entries etc..

[...]
> Takashi

-- 
Mark
