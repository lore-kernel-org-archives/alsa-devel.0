From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] [POWERPC] Update MPC8610 HPCD to support audio drivers
Date: Tue, 8 Jan 2008 11:56:54 +1100
Message-ID: <20080108115654.d0ac909b.sfr@canb.auug.org.au>
References: <1199732204949-git-send-email-timur@freescale.com>
	<1199732204578-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1119939838=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1199732204578-git-send-email-timur@freescale.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Timur Tabi <timur@freescale.com>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org

--===============1119939838==
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__8_Jan_2008_11_56_54_+1100_heGnggeRpHB3xyv5"

--Signature=_Tue__8_Jan_2008_11_56_54_+1100_heGnggeRpHB3xyv5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Timur,

On Mon,  7 Jan 2008 12:56:43 -0600 Timur Tabi <timur@freescale.com> wrote:
>
> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> @@ -34,9 +34,27 @@
> =20
>  #include <asm/mpic.h>
> =20
> +#include <linux/of_platform.h>
>  #include <sysdev/fsl_pci.h>
>  #include <sysdev/fsl_soc.h>
> =20
> +static struct of_device_id mpc8610_ids[] =3D {

__initdata

> +	{ .compatible =3D "fsl,mpc8610", },
> +	{}
> +};
> +
> +static int __init mpc8610_declare_of_platform_devices(void)
> +{
> +	if (!machine_is(mpc86xx_hpcd))
> +		return 0;
> +
> +	/* Without this call, the SSI device driver won't get probed. */
> +	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
> +
> +	return 0;
> +}
> +device_initcall(mpc8610_declare_of_platform_devices);

We have machine_device_initcall for this now.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_11_56_54_+1100_heGnggeRpHB3xyv5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgspiTgG2atn1QN8RAmsHAJ9D1TDq1jyQQQuMJ9nM/pYYWAZxaQCfdEeZ
m1WSdEY6ixVcax7dV6nQczw=
=xiB3
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_11_56_54_+1100_heGnggeRpHB3xyv5--

--===============1119939838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1119939838==--
