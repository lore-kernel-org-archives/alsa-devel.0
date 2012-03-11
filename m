From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] mx31moboard: Add ssi configuration
Date: Sun, 11 Mar 2012 11:41:04 +0000
Message-ID: <20120311114104.GC3233@opensource.wolfsonmicro.com>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-2-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8159186316946377795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3184D2433F
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 12:41:07 +0100 (CET)
In-Reply-To: <1331304916-4724-4-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: juergen.lambrecht@gmail.com, s.hauer@pengutronix.de, festevam@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8159186316946377795==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qbvjkv9qwOGw/5Fx"
Content-Disposition: inline


--Qbvjkv9qwOGw/5Fx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2012 at 03:55:15PM +0100, Philippe R=E9tornaz wrote:

> +	mxc_audmux_v2_configure_port(MX31_AUDMUX_PORT1_SSI0,
> +		MXC_AUDMUX_V2_PTCR_SYN |
> +		MXC_AUDMUX_V2_PTCR_TFSDIR |

This will need to be rebased off current code, the audmux has been moved
into sound/soc.

--Qbvjkv9qwOGw/5Fx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAEBAgAGBQJPXI9KAAoJEBus8iNuMP3dgCoP9R1CmdPZ7RKVzaRiwlIBpOh/
6ZU//fMnuDK3aB9YKStBh63mPITQWZ+u5MKHsArm3dnln8Z824u9VCIpoqqMfiaj
vWcq7ZbK1l2G9OSJpXfOQt2J5mvPWx/ryUhcBMYLptQ676Ss0Vmxm8fC75Cl78pN
Up6U2rBU73Y8KWfb9xEgkVWZmZ5DPK7oyE90vO/GhNu/72wxQkv7ymUeNonJXWHi
M765M/CDmr/CcDnTBwUQHb/sr63sp/IbWQssEE6xbhLIR7lJ4FpYbxC5UO21z8D8
oXDj202S5/NhyIfZceSv1SRj7ZCVkKX6lb847DdPuL+L7Bp/FsdeCk53FxxwtDGL
DeJwNmpHJZJf0pSinuYmnrXBuCkopJ5wY6bvRdPqdj63fscTtMYRu3zSyDoqEU01
aCGREScmKT1ubM7YJDCM2+qmRfIik2oM54YsWEfJ0wCcxi9gIadL9P1qQjTLm38X
RGtIaf0YvqLA/5yN9+0nR7CfRzKzqvLYcNzmli2eVMavv7Uldf9icbekQoKRITpj
Vwnxijukn3F/X5xTNkehqxOQkFu/kvBvrO/zPmH9rvyU9jDkCG0O7HT8XIJ2D8D2
J6fuEtSpumK1Uxr7OzwFl0c4z4Gp/ND4yAprecLLLZmdCuwLadrihHZE4Vn4cnMO
N1l0FSBn0dQDM47LrL0=
=uxd2
-----END PGP SIGNATURE-----

--Qbvjkv9qwOGw/5Fx--

--===============8159186316946377795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8159186316946377795==--
