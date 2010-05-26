From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 5/7] ASoC: TWL4030: Helper to check chip
	default registers
Date: Wed, 26 May 2010 09:28:49 +0300
Message-ID: <201005260928.50075.peter.ujfalusi@nokia.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
	<1274792996.3000.233.camel@odin>
	<201005260900.35587.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ABCF1038F0
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 08:29:09 +0200 (CEST)
In-Reply-To: <201005260900.35587.peter.ujfalusi@nokia.com>
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

On Wednesday 26 May 2010 09:00:35 Ujfalusi Peter (Nokia-D/Tampere) wrote:

...

> I did run some tests.
> The codec registers are in reset state whenever the device boots (either
> power on, or reboot). In our setup the codec is built in the kernel.
> I have measured the time needed to execute the twl4030_init_chip with and
> without rewriting the codec registers (71 register writes):
> No reset_registers: ~51ms
> reset registers:    ~71ms
> =

> I need to optimize for module loading time, and ~20ms extra is quite big.
> =

> Can we make a compromise?
> I propose to have twl4030_setup_data.reset_registers, if it is set by the
> machine driver, than we are going to reset the registers, if it is not se=
t,
> than we skip the restore part (not writing the 71 registers).
> So during development, or if one have the codec as module, the machine can
> set this, so the registers will be restored, but if the testing shows that
> there is no need to do that, than we can speed up the module probe.
> =

> What do you think?

Better thing to do is:
restore the registers in these cases:
if (!setup || (setup && setup->reset_registers))

So if the machine does not provide setup data, than we can assume, than no =
one =

taken a time to tune the platform, so we need to restore to be on the safe =
side.

What do you think?

> =

> > Thanks
> > =

> > Liam

-- =

P=E9ter
