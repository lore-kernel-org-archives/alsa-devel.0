From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-ssi: Allow to use driver with
 generic audio card
Date: Sat, 26 Apr 2014 17:55:19 +0100
Message-ID: <20140426165519.GT12304@sirena.org.uk>
References: <1398523756-9740-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8600854780700378843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EB49626087D
 for <alsa-devel@alsa-project.org>; Sat, 26 Apr 2014 18:55:38 +0200 (CEST)
In-Reply-To: <1398523756-9740-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8600854780700378843==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bs5RQlqYmu7M9nOU"
Content-Disposition: inline


--Bs5RQlqYmu7M9nOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2014 at 06:49:16PM +0400, Alexander Shiyan wrote:
> Generic sound card checks return value of functions for setup format,
> clock and slot for -ENOTSUPP error. Add this compatibility to fsl-ssi
> driver.
> ---
> I'm really not sure that's a good solution, please correct me if I'm wron=
g.

The intention behind -ENOTSUPP is to handle the case where a device has
no configuration facilities (eg, a fixed hardware CODEC) to save having
to have a dummy stub that just checks a parameter.

> @@ -764,7 +764,7 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cp=
u_dai, unsigned int fmt)
>  			ssi_private->i2s_mode |=3D CCSR_SSI_SCR_I2S_MODE_SLAVE;
>  			break;
>  		default:
> -			return -EINVAL;
> +			return -ENOTSUPP;
>  		}
> =20
>  		/* Data on rising edge of bclk, frame low, 1clk before data */

These are cases where we can do configuration but an invalid
configuration has been provided and we have spotted an error.  Ignoring
that should cause runtime problems - I guess it isn't for you though so
there may be something else going on?

Especially for cases like DAI format we should probably enhance the
framework so that these devices can set a variable in their struct
saying what they do support but for now we don't do that.

--Bs5RQlqYmu7M9nOU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTW+T0AAoJELSic+t+oim9ig4P/1CY+COWIco4flAQPUK+z0Xa
shcZV1wmY09pXNnK4eeXJd3qp9BNxOlnd+RoSQ+z4NMmD1mNcpk4k+LwAJsCVVSK
gb/e+G4VG752UXr2FmgEAU7dZul8ATgSnMMD/KlBqvDaUhKWnNuW9qKX3vAWKEhb
tN7gyCLUgrqoq8waaOKzjyefpIRj2Kwijdxsmv3GOG1FjtFwegCbDQ7bapnTcVNc
qDiXjzL5ou4n17qbM25d7IXi41PodcPFHY5CCfLSj/rHfMxY3Hi11Vpo7hUA0jzs
1DmX8WXQH9Iv2roDZ7R/swTQWB/wr/7I8tPCruQXfrpcshvH7QK0pyK2vCJxTNZ6
pXX3gstSPNnX8Fd025P4EiKK6YGXGAY8zHJ2Swrbtirr3O4ukq9YMYm1tXes0Eci
65GRTtYcVp63BQtKnItNvKlCBO6kFt5isdY+haWnwxGLS9orUklWQ6Nxto+HVFiB
ez3vNnw3zAP+kNXrEPrId9l5Y1avYsE6XaBlshXCgBcBOoDn9VUZTo4VH1BILuZb
yyQFBJhtrWmthZ4pwLZEKIBXjlr5gAliy2SMEVq0rL9FoXOzNAGnkRIUqNa1XbEA
/mEmt/953eBhVpcVXwEsSQQthNK70cI+790DC/wK1al0wPVGszucENAmE7uhNZ1U
M4EbLtGLNMNAdHy9fYvC
=hpJN
-----END PGP SIGNATURE-----

--Bs5RQlqYmu7M9nOU--

--===============8600854780700378843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8600854780700378843==--
