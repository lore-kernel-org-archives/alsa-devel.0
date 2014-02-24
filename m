From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: imx-pcm-fiq: Remove unneeded
	'out' label
Date: Mon, 24 Feb 2014 14:41:24 +0900
Message-ID: <20140224054124.GZ25940@sirena.org.uk>
References: <1393212043-9002-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8969007985740892426=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B7CC265266
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 06:41:27 +0100 (CET)
In-Reply-To: <1393212043-9002-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8969007985740892426==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kgncFjCg7zFjjZvO"
Content-Disposition: inline


--kgncFjCg7zFjjZvO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 12:20:43AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Instead of jumping to the 'out' label, just return the error code immedia=
tely.

Applied, thanks.

--kgncFjCg7zFjjZvO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCtuBAAoJELSic+t+oim9FCUP/jaCxcEUOmwxqLRLaVX4/RYF
JENzBo8EUg63rmknGR0qNaWFqHuXuFbWUAFL0Tm+/LjyNG3JQdKbwOQKFZ62rkUB
W8tn2GsyeYyuWp2s4DDnbyIWHYnGuRPBx/JGNmubfzDTfYKE551codJBB9pO02UV
fXXff9RqymRj+tV6iisxZqhy2uTRNbF0OHNnIma3Lh9Ka19t6XSBf7/kU3uMStio
bAnYWekQbKw/CGaNK3Uk6IIhvucHMzz1/WYqSRwcLiYSVSniGOu1J1vz4HN+0ry4
MVXkUiEE2Ad2hjbrtK+M7RH4Q4L/qIulb4tTsSywLMPv42sJMJqA007HaoVZmz8X
fBoFd6zvQ14bOA3ANZdNtNatLI7X6pEl+/y1NT+M51cODxIQjfKfYRTeMqk2972x
lhxzYv4MdHnxMIyDNmgXfKnSElnULhITN3nfnWkVGo9rV6e3sw0iZnUxzSqi4UV+
aBhjHS6fE7kHVQ1enW1yrfUWLNaMqAPFP88PMJzwTVYoOEDt50GBdB9jdv6OcW76
w4d/l6z7IiLsdpHzOUKF/Ow2ng3u30g0ayaiHjV4o98uqQXaQx/7sNs4KclSqQvR
vmpi9vdGwjN5bOxSaUwnZfXh8ATYegWWEOkb8qcnN9lZTQunrzSjGJbRsCRAc6k8
6xx3emjI3t6hIUL9ULOi
=VGzE
-----END PGP SIGNATURE-----

--kgncFjCg7zFjjZvO--

--===============8969007985740892426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8969007985740892426==--
