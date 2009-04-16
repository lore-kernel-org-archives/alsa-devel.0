From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2 2/6] ARM: DaVinci: ASoC: Add the
	platform devices for ASP
Date: Thu, 16 Apr 2009 10:17:16 -0700
Message-ID: <200904161017.16411.david-b@pacbell.net>
References: <1239921735-26911-1-git-send-email-naresh@ti.com>
	<FF55437E1F14DA4BAEB721A458B67017069809B116@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n18.bullet.mail.mud.yahoo.com (n18.bullet.mail.mud.yahoo.com
	[68.142.206.145]) by alsa0.perex.cz (Postfix) with SMTP id 1E7ED243F9
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 19:17:19 +0200 (CEST)
In-Reply-To: <FF55437E1F14DA4BAEB721A458B67017069809B116@dbde02.ent.ti.com>
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
To: "Medisetty, Naresh" <naresh@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thursday 16 April 2009, Medisetty, Naresh wrote:
> =A0arch/arm/mach-davinci/dm355.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 29 ++++++++=
++++-
> =A0arch/arm/mach-davinci/dm644x.c =A0 =A0 =A0 =A0 =A0 | =A0 27 ++++++++++=
+-
> =A0arch/arm/mach-davinci/dm646x.c =A0 =A0 =A0 =A0 =A0 | =A0 67 ++++++++++=
++++++++++++++++
> =A0arch/arm/mach-davinci/include/mach/asp.h | =A0 39 ++++++++++++++++-

Note the merge dependency:  most of those aren't yet in mainline.
I think Kevin sent the dm644x.c changes to the ARM list for their
first review cycle recently.

My comments below are for the dm355.c changes, but they apply just
as much to the other two SoC-specific setup files.


> +static struct resource dm355_evm_snd_resources[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D DAVINCI_ASP1_BASE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D DAVINCI_ASP1_BASE + SZ_8K -=
 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0=3D IORESOURCE_MEM,
> + =A0 =A0 =A0 },
> +};
> +
> +static struct evm_snd_platform_data dm355_evm_snd_data =3D {
> + =A0 =A0 =A0 .clk_name =A0 =A0 =A0 =3D "asp1",
> + =A0 =A0 =A0 .tx_dma_ch =A0 =A0 =A0=3D DAVINCI_DMA_ASP1_TX,
> + =A0 =A0 =A0 .rx_dma_ch =A0 =A0 =A0=3D DAVINCI_DMA_ASP1_RX,
> +};

If you're going to move to proper driver model support
(good!) ... the DMA channels should be IORESOURCE_DMA
resources, and the clock should be associated directly
with that platform device.

That might seem to leave that current platform data
struct as useless ... not so!  It should tell about how
the audio is configured:  whether RX and TX are both
wired, if they're stereo or what, how *audio* clocks
are set up, and so forth.  All that is specific to the
specific *board* in use, not to that SoC, so it should
be provided by board setup code.  A lot of it is now
encoded in the sound/soc/davinci/davinci-evm.c file.

Example:  dm6446 evm supports six different audio clocks,
but right now one choice is fixed at board setup time.

ASoC seems to have ways to let drivers make that choice.
That could be handled by board-specific callbacks and data
tables, and would be good to package in platform data.
A different dm6446 board may use a different audio clock
setup, with different choices.


> +
> +static struct platform_device dm355_asoc_device =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D "davinci-asoc",
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .dev.platform_data =A0 =A0 =A0=3D &dm355_evm_snd_data,
> + =A0 =A0 =A0 .num_resources =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(dm355_evm_=
snd_resources),
> + =A0 =A0 =A0 .resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D d=
m355_evm_snd_resources,

Looks like the alignment goofage there (for "=3D") is more than
what can be explained by patch mangling from email...


> +};


> @@ -555,6 +579,7 @@ static int __init dm355_init_devices(void)
>
> =A0 =A0 =A0 =A0 davinci_cfg_reg(DM355_INT_EDMA_CC);
> =A0 =A0 =A0 =A0 platform_device_register(&dm355_edma_device);
> + =A0 =A0 =A0 platform_device_register(&dm355_asoc_device);

This does *NOT* belong in the generic dm355 setup code like that.
Not every DM355 board will even have audio!  Or have it wired
exactly like Spectrum's EVM boards.

It'd be appropriate to add dm355_init_asoc(asp_num, platform_data)
or something similar, so that different boards wouldn't need to
repeat the won't-change parts.  That routine might need to set up
some pin, IRQ, and EDMA muxing.  Boards with no audio support would
not call that routine.  Ones with two audio interfaces might need
to call it once for each interface.


> =A0 =A0 =A0 =A0 return 0;
> =A0}
> =A0postcore_initcall(dm355_init_devices);


Similar comments for the two other SoC chips touched by this patch;
although obviously the dm6446 wouldn't need an asp_num, etc.

- dave
