From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] [VIRTEX] Register AC97 Controller Reference with the
	platform bus
Date: Thu, 9 Aug 2007 12:04:47 -0600
Message-ID: <fa686aa40708091104m36ec9c8es195407487b9ec1d5@mail.gmail.com>
References: <1186655824.7420.27.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
In-Reply-To: <1186655824.7420.27.camel@localhost>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: =?ISO-8859-1?Q?Joachim_F=F6rster?= <mls.JOFT@gmx.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Lorenz Kolb <lorenz.kolb@lkmail.de>, "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On 8/9/07, Joachim F=F6rster <mls.JOFT@gmx.de> wrote:
> From: Joachim Foerster <JOFT@gmx.de>
>
> (Patch for Linus' master branch, date 2007/08/08)
>
> Signed-off-by: Joachim Foerster <JOFT@gmx.de>
> ---
>  arch/ppc/syslib/virtex_devices.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_de=
vices.c
> index 62a9495..0d6f0ac 100644
> --- a/arch/ppc/syslib/virtex_devices.c
> +++ b/arch/ppc/syslib/virtex_devices.c
> @@ -121,6 +121,29 @@
>         }, \
>  }
>
> +#define XPAR_AC97_CONTROLLER_REFERENCE(num) { \
> +       .name =3D "ml403_ac97cr",       \
> +       .id =3D num, \
> +       .num_resources =3D 3, \
> +       .resource =3D (struct resource[]) { \
> +               { \
> +                       .start =3D XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADD=
R, \
> +                       .end =3D XPAR_OPB_AC97_CONTROLLER_REF_0_HIGHADDR,=
 \

This will make each instance try to use the same device!  Replace
'_0_' with '_##num##_'

> +                       .flags =3D IORESOURCE_MEM, \
> +               }, \
> +               { \
> +                       .start =3D XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_RE=
F_0_PLAYBACK_INTERRUPT_INTR, \
> +                       .end =3D XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_=
0_PLAYBACK_INTERRUPT_INTR, \

ditto; in this case you need to change the second _0_.  _INTC_0_ is
already the correct form.

> +                       .flags =3D IORESOURCE_IRQ, \
> +               }, \
> +               { \
> +                       .start =3D XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_RE=
F_0_RECORD_INTERRUPT_INTR, \
> +                       .end =3D XPAR_OPB_INTC_0_OPB_AC97_CONTROLLER_REF_=
0_RECORD_INTERRUPT_INTR, \

ditto

> +                        .flags =3D IORESOURCE_IRQ, \
> +               }, \
> +        }, \
> +}
> +
>  /* UART 8250 driver platform data table */
>  struct plat_serial8250_port virtex_serial_platform_data[] =3D {
>  #if defined(XPAR_UARTNS550_0_BASEADDR)
> @@ -221,6 +244,11 @@ struct platform_device virtex_platform_devices[] =3D=
 {
>  #if defined(XPAR_TFT_3_BASEADDR)
>         XPAR_TFT(3),
>  #endif
> +
> +       /* AC97 Controller Reference instances */
> +#if defined(XPAR_OPB_AC97_CONTROLLER_REF_0_BASEADDR)
> +       XPAR_AC97_CONTROLLER_REFERENCE(0),
> +#endif
>  };
>
>  /* Early serial support functions */
> --
> 1.5.2.4
>
>
>
>


-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
