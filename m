From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: davinci-sffsdr: Staticize non
	exported struct
Date: Wed, 15 May 2013 08:54:45 +0400
Message-ID: <20130515045445.GJ24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3365097406234315378=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E5F5265132
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:54:50 +0200 (CEST)
In-Reply-To: <1368562797-10440-11-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3365097406234315378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ofZMSlrAVk9bLeVm"
Content-Disposition: inline


--ofZMSlrAVk9bLeVm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:57PM +0200, Lars-Peter Clausen wrote:
> The pcm3008_codec struct is not used outside of davinci-sffsdr.c, so make it
> static.

Applied, thanks

--ofZMSlrAVk9bLeVm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxUSAAoJELSic+t+oim9+sUQAJYpEgIXmkEAGS3iOKuDyXZW
m6F6ptaLmHVGfViPG+ou1leRKwGHuUU5vCbq+rcwDxcEZGa+s6al/lSk3K7VaSCL
HlSbd/4XuoSGUAT370zIQVDQ0bks5B1K99wB8vjMmA4anjyGSolbgqHIj1+j2uVz
KWYTRGfASbQFX4PEXPCzutp5jZJ5B3cGKo1CyrU6NMZ/s1vtV6FSlGqY4qmdjRlm
6AYT2HuBNfESAxBhdCm4QZ2gayGMPCQo64i0ze19IVLCC5KnVJ1m7fL0vhDKKO5s
icW61yCgoib8dIqos8vO4PYqMK1inKkXfbUUpG8JWMe/mode9lAAYXo+FF7Zu/ff
pVS33O0KsWyKPcwi7A2H02OVCSix2+IzRR3aYfi1ajpi6MYpHfYlts30c5tSUWZQ
N+FORycgZ073buwDAwoXd8gg074aXzhcjRJP7QGG8Ny8nj+kuRhCn82/k4rzpwpp
iwinsxe8v3UvGLuuzcsOl2hm1jHr+1TLZ8QHkhL+T/026xQITZ+cka+iWJwZeAVX
KrIVVCUU+DVtt9WZ5CAbmMxpGOXsCw/cEEefeyxZ8/n4u29baqn2YoSReCGHDGB4
37CkOHb7KFVXuwOupzte7ZVryaOByqZaGGAD5qAyDXU51axySfM0OaC/+UsTdJy3
A9oZt9TI0pCKvXgecz1/
=TMCb
-----END PGP SIGNATURE-----

--ofZMSlrAVk9bLeVm--

--===============3365097406234315378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3365097406234315378==--
