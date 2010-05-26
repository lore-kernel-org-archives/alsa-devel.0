From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/7] ASoC: TWL4030: Helper to check chip
	default registers
Date: Wed, 26 May 2010 10:15:08 +0300
Message-ID: <201005261015.09376.peter.ujfalusi@nokia.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005260928.50075.peter.ujfalusi@nokia.com>
	<20100526063459.GA16085@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 415FA1038F0
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 09:15:21 +0200 (CEST)
In-Reply-To: <20100526063459.GA16085@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 26 May 2010 09:35:00 ext Mark Brown wrote:
> On Wed, May 26, 2010 at 09:28:49AM +0300, Peter Ujfalusi wrote:
> > Better thing to do is:
> > restore the registers in these cases:
> > if (!setup || (setup && setup->reset_registers))
> > =

> > So if the machine does not provide setup data, than we can assume, than
> > no one taken a time to tune the platform, so we need to restore to be on
> > the safe side.
> > =

> > What do you think?
> =

> This sounds like a sensible optimisation.  May also be an idea to
> explicitly do a reset of the registers on unload - I guess nobody will
> ever do that if they're not developing, and that'd probably mean that
> many of the people who might actually need to reset the registers purely
> for development will get the benefit of it without the risk of leaving
> the option on in production by mistake.

I can add the restore also to the unload path, good idea.

> =

> I can't remember if you're doing this already (and don't even know if
> it's possible with the hardware) but if you can do a bulk read of the
> registers rather than reading register by register then the overhead
> from the I/O should be noticably reduced if you do do the reset.

No I'm not doing that, but at least the twl core (and HW) supports burst wr=
ite, =

and burst read as well.
To add the burst restore support needs a bit bigger change here, and there =
in =

the codec driver from the first look.

For now, I'm planning to put back the 'old' for (...) style of register res=
tore.
Is it OK if I add the burst support later, not in this series?

Also is it OK, if I add the restore support as a new patch in the series (s=
o the =

restore will be gone for 3 commits)?

Thanks,
P=E9ter
