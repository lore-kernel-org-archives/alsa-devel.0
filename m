From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 3/3] arm: mxs: disable clock-gates when
 setting saif-clocks
Date: Mon, 29 Aug 2011 15:07:47 +0200
Message-ID: <20110829130747.GL24524@pengutronix.de>
References: <1313946314-3891-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2881957927175006922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 58DA224368
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Aug 2011 15:07:51 +0200 (CEST)
In-Reply-To: <1313946314-3891-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, s.hauer@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2881957927175006922==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0qVF/w3MHQqLSynd"
Content-Disposition: inline


--0qVF/w3MHQqLSynd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 22, 2011 at 01:05:14AM +0800, Dong Aisheng wrote:
> From: Dong Aisheng-B29396 <B29396@freescale.com>

Please take care of the correct author when sending out patches from other
people. Doesn't harm here since it was an RFC.

> New divides should only be written when gates are off.
>=20
> Reported-by: Dong Aisheng <b29396@freescale.com>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>=20
> ---
> BTW, i did a minus change based on wolfram's patch or the saif will
> not work.
>=20
> Change
> +       __raw_writel(clkgate, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs##_SET);=
 \
> to
> +       __raw_writel(reg & ~clkgate,
> 			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs##_SET); \

Huh? Luckily you are not really using _SET below otherwise you would have s=
et
all other bits except the one we captured. Will have a look at this.

> It seemed HW_CLKCTRL_##rs##_SET did not work well.
> (i did not find HW_CLKCTRL_SAIFx_SET in spec).
> ---
>  arch/arm/mach-mxs/clock-mx28.c        |    7 +++++--
>  arch/arm/mach-mxs/regs-clkctrl-mx28.h |    2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx2=
8.c
> index 2a2db65..d1d119a 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -438,7 +438,7 @@ _CLK_SET_RATE1(xbus_clk, XBUS)
>  static int name##_set_rate(struct clk *clk, unsigned long rate)		\
>  {									\
>  	u16 div;							\
> -	u32 reg;							\
> +	u32 reg, clkgate;						\
>  	u64 lrate;							\
>  	unsigned long parent_rate;					\
>  	int i;								\
> @@ -455,7 +455,8 @@ static int name##_set_rate(struct clk *clk, unsigned =
long rate)		\
>  		return -EINVAL;						\
>  									\
>  	reg =3D __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> -	reg &=3D ~BM_CLKCTRL_##rs##_DIV;					\
> +	clkgate =3D reg & BM_CLKCTRL_##rs##_CLKGATE;			\
> +	reg &=3D ~(BM_CLKCTRL_##rs##_DIV | BM_CLKCTRL_##rs##_CLKGATE);	\
>  	reg |=3D div << BP_CLKCTRL_##rs##_DIV;				\
>  	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
>  									\
> @@ -468,6 +469,8 @@ static int name##_set_rate(struct clk *clk, unsigned =
long rate)		\
>  		return -ETIMEDOUT;					\
>  	}								\
>  									\
> +	__raw_writel(reg & ~clkgate,					\
> +			CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
>  	return 0;							\
>  }

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0qVF/w3MHQqLSynd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5bjyMACgkQD27XaX1/VRvuRQCffQK6xOkuV5QgiHQs1z6H5q2b
HvQAnRzmXdAZjXuLwnVz1fB/qseVTmlZ
=JPe3
-----END PGP SIGNATURE-----

--0qVF/w3MHQqLSynd--

--===============2881957927175006922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2881957927175006922==--
