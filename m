From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 6/6] ASoC: TWL4030: Add analog loopback
	support
Date: Tue, 27 Jan 2009 16:28:35 +0200
Message-ID: <200901271628.35272.peter.ujfalusi@nokia.com>
References: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
	<200901271505.34354.peter.ujfalusi@nokia.com>
	<20090127140316.GB11870@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C0621037F0
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 15:29:06 +0100 (CET)
In-Reply-To: <20090127140316.GB11870@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: sakoman@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Tuesday 27 January 2009 16:03:16 ext Mark Brown wrote:
> This one should be dealable with in-kernel without any work by
> applications - WM8350 does a similar dance (for different reasons),
> providing a shadow volume control while some of the amplifiers are
> powered off.

I'm going to check the code. But I think the driver still needs to keep on =

track of the bypass switch states in order to do the right thing.

>
> > But than I played a bit with the registers, enabled the bypass (while t=
he
> > PLL was off) and the readings were: 0.020 A, in short:
> > bypass on  + PLL on  =3D 0.016 A
> > bypass on  + PLL off =3D 0.020 A
>
> I suspect the increased power consumption here is due to the PLL being
> required to clock the DAC properly.  Or you've transposed the figures :)

I have checked it several times, the numbers are correct. Probably the DAC =

clocking, but how it is working without the PLL on - because the bypass was =

working...

>
> > bypass off + PLL on  =3D 0.006 A
> > bypass off + PLL off =3D 0.002 A
> >
> > Grrr, and I gave up. Oh, and we don't have control for the PLL (it is
> > enabled
>
> > all the time at the moment). I was thinking to use the SND_SOC_DAPM_PRE
> > and SND_SOC_DAPM_POST for it but I don't know how to use those.
>
> Just declare them as widgets - the event function you supply will be
> called back when the state changes.  The event function interface is the
> same as for the _E versions of normal DAPM controls, see WM8900 for one
> example of how to use them.

I'll take a look.

>
> > So I thought that I will write it in a way I have sent it and revisit
> > later, when I (or someone else) have better idea to handle this.
>
> I suspect that if the core were able to automatically push the codec
> down into BIAS_OFF as well as BIAS_STANDBY that'd probably be enough to
> deal with the issue?  Probably in concert with fixing the core to bring
> the codec up to BIAS_ON when bypass paths are active.  It looks like
> what you're implementing here is a combination of the fixes for those
> two issues.
>
> My main concern is that it feels like this is breaking the model that
> the core has of what the codec driver should be doing - I think some
> (much?) of this is a case of the core needing more functionality and
> that if that is the case then we'd be better off not carrying driver
> specific workarounds in case they get broken when things are fixed in
> the core.

Right, I agree. I'll send this last patch back to the drawing board ;)

>
> > Sorry for the long and most probably boring details...
> >
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> >
> > I can wait till it gets there and send the series on top of it.
>
> Like I said, I've already applied all your other patches.

I missunderstand that, sorry, I'll focus on the analog bypass redesign than=
...

Thanks,
P=E9ter
