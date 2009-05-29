From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v3 2/6] ARM: DaVinci: ASoC: Add the
	platform devices for ASP
Date: Fri, 29 May 2009 08:07:03 -0700
Message-ID: <200905290807.03545.david-b@pacbell.net>
References: <1243501774-28446-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com (smtp120.sbc.mail.sp1.yahoo.com
	[69.147.64.93]) by alsa0.perex.cz (Postfix) with SMTP id E3FEC244D7
	for <alsa-devel@alsa-project.org>;
	Fri, 29 May 2009 17:07:07 +0200 (CEST)
In-Reply-To: <1243501774-28446-1-git-send-email-chaithrika@ti.com>
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
To: Chaithrika U S <chaithrika@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

This looks like the wrong approach.

On Thursday 28 May 2009, Chaithrika U S wrote:
> --- a/arch/arm/mach-davinci/dm355.c
> +++ b/arch/arm/mach-davinci/dm355.c

> @@ -278,6 +282,7 @@ static __init void dm355_evm_init(void)
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0dm355_init_spi0(BIT(0), dm355_evm_spi_info,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0A=
RRAY_SIZE(dm355_evm_spi_info));
> +=A0=A0=A0=A0=A0=A0=A0dm355_init_asp(&dm355_evm_snd_data);

Surely that should be "init_asp1()"?  You are hard-wiring
an assumption that only ASP1 will ever be used on a DM355,
which is unwise.

What will happen when a board uses ASP0 instead?

What will happen when a board uses ASP0 *and* ASP1?

What will happen when a board wants to use ASP1, but
not the same way the EVM uses it?


> --- a/arch/arm/mach-davinci/dm355.c
> +++ b/arch/arm/mach-davinci/dm355.c

> @@ -624,6 +625,32 @@ static struct platform_device dm355_edma_device =3D {
> =A0=A0=A0=A0=A0=A0=A0=A0.resource=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=3D edma_resources,
> =A0};
> =A0
> +/* DM335 EVM uses ASP1; line-out is a stereo mini-jack */

Why are you putting EVM-specific assumptions into a file
which is intended to be generic for *ALL* boards using
the DM355 chip?


> +static struct resource dm355_asp_resources[] =3D {
> +=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.start=A0=A0=3D DAVINCI_ASP=
1_BASE,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.end=A0=A0=A0=A0=3D DAVINCI=
_ASP1_BASE + SZ_8K - 1,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.flags=A0=A0=3D IORESOURCE_=
MEM,
> +=A0=A0=A0=A0=A0=A0=A0},
> +=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.start=A0=A0=3D DAVINCI_DMA=
_ASP1_TX,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.end=A0=A0=A0=A0=3D DAVINCI=
_DMA_ASP1_TX,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.flags=A0=A0=3D IORESOURCE_=
DMA,
> +=A0=A0=A0=A0=A0=A0=A0},
> +=A0=A0=A0=A0=A0=A0=A0{
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.start=A0=A0=3D DAVINCI_DMA=
_ASP1_RX,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.end=A0=A0=A0=A0=3D DAVINCI=
_DMA_ASP1_RX,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.flags=A0=A0=3D IORESOURCE_=
DMA,
> +=A0=A0=A0=A0=A0=A0=A0},
> +};
> +
> +static struct platform_device dm355_asp_device =3D {
> +=A0=A0=A0=A0=A0=A0=A0.name=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D "davinci-=
asp",
> +=A0=A0=A0=A0=A0=A0=A0.id=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D -1,
> +=A0=A0=A0=A0=A0=A0=A0.num_resources=A0=A0=3D ARRAY_SIZE(dm355_asp_resour=
ces),
> +=A0=A0=A0=A0=A0=A0=A0.resource=A0=A0=A0=A0=A0=A0=A0=3D dm355_asp_resourc=
es,
> +};
> +
> =A0/*--------------------------------------------------------------------=
--*/
> =A0
> =A0static struct map_desc dm355_io_desc[] =3D {
> @@ -733,6 +760,16 @@ static struct davinci_soc_info davinci_soc_info_dm355
> =3D { .sram_len=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D SZ_32K,
> =A0};
> =A0
> +void __init dm355_init_asp(struct evm_snd_platform_data *pdata)
> +{

This would sort of make sense as a "dm355_init_asp1()" routine,
except that you're hard-wiring the platform data to use a data
type that's specific to the EVM.  Also, hard-wiring the use of
both DMA channels ... even though there's no reason a board would
not want to use ASP1 in input-only or output-only mode, and
use the other DMA channel for something other than ASP1_[RT]X.

This is no way to have a generic platform device creation hook;
but that's the only kind of hook that belongs in this file.


> +=A0=A0=A0=A0=A0=A0=A0/* we don't use ASP1 IRQs, or we'd need to mux them=
 ... */
> +=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM355_EVT8_ASP1_TX);
> +=A0=A0=A0=A0=A0=A0=A0davinci_cfg_reg(DM355_EVT9_ASP1_RX);
> +
> +=A0=A0=A0=A0=A0=A0=A0dm355_asp_device.dev.platform_data =3D pdata;
> +=A0=A0=A0=A0=A0=A0=A0platform_device_register(&dm355_asp_device);
> +}
> +
> =A0void __init dm355_init(void)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0davinci_common_init(&davinci_soc_info_dm355);
