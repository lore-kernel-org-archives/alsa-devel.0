From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/7] ASoC: TWL4030: Helper to check chip
	default registers
Date: Wed, 26 May 2010 09:00:35 +0300
Message-ID: <201005260900.35587.peter.ujfalusi@nokia.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
	<201005251520.40206.peter.ujfalusi@nokia.com>
	<1274792996.3000.233.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 94A7124661
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 08:00:57 +0200 (CEST)
In-Reply-To: <1274792996.3000.233.camel@odin>
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
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

You and Mark has a valid point...

On Tuesday 25 May 2010 16:09:56 ext Liam Girdwood wrote:
> On Tue, 2010-05-25 at 15:20 +0300, Peter Ujfalusi wrote:
> > > Is this purely for information/debug purposes ?
> > =

> > Yes, the driver support twl4030, twl5030, twl5031, tps*something* chips.
> > If someone, who have access to those chips, and in doubt, can check it.
> =

> So it's more a debug aid.

I'll change the dev_info to dev_dbg to reflect that correctly.

> =

> > > Why do we need to check default vales at init(). Is there another
> > > driver changing the audio codec registers ?
> > =

> > This driver is going to change it.
> > It is also possible that the bootloader changed them (startup tone?).
> =

> Yeah, that's what I thought. In the past I've always forced the CODEC
> registers to their default values during probe(). Very handy if the
> driver is a module and you are recovering from a buggy state.

Yeah, during development this is really handy.

> =

> > So it is not really bulletproof, but at least it helped me to find out
> > the the ARXR2_APGA_CTL register does not have the reset value, which it
> > supposed to have.
> > =

> > Well, I can remove it, but I thought that it is a nice touch ;)
> =

> It's nice ;) But maybe we should reset the default values at probe() to
> be sure.

I did run some tests.
The codec registers are in reset state whenever the device boots (either po=
wer =

on, or reboot). In our setup the codec is built in the kernel.
I have measured the time needed to execute the twl4030_init_chip with and =

without rewriting the codec registers (71 register writes):
No reset_registers: ~51ms
reset registers:    ~71ms

I need to optimize for module loading time, and ~20ms extra is quite big.

Can we make a compromise?
I propose to have twl4030_setup_data.reset_registers, if it is set by the =

machine driver, than we are going to reset the registers, if it is not set,=
 than =

we skip the restore part (not writing the 71 registers).
So during development, or if one have the codec as module, the machine can =
set =

this, so the registers will be restored, but if the testing shows that ther=
e is =

no need to do that, than we can speed up the module probe.

What do you think?

> =

> Thanks
> =

> Liam
> =


-- =

P=E9ter
