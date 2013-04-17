From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: define playback and capture streams
	in dummy codec
Date: Wed, 17 Apr 2013 14:31:04 +0100
Message-ID: <20130417133104.GI13687@opensource.wolfsonmicro.com>
References: <5167E7C4.7080501@list.ru>
 <20130412105943.GU9243@opensource.wolfsonmicro.com>
 <20130417163406.4a3b339c@stas>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1962801912424953936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B2DA26164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:31:06 +0200 (CEST)
In-Reply-To: <20130417163406.4a3b339c@stas>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@list.ru>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>, stsp@users.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1962801912424953936==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline


--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2013 at 04:34:06PM +0400, Stas Sergeev wrote:

> This patch adds a playback and capture streams to the dummy codec DAI
> configuration. Most permissive set of sampling rates and formats is used.
>=20
> This patch is needed for playback and capturing on a codec-less systems,
> as otherwise the PCM device nodes are not even created.
>=20
> Signed-off-by: Stas Sergeev <stsp@users.sourceforge.net>

> From 9a498275e59c2c6ef933fe7d0cff79a13ba790ff Mon Sep 17 00:00:00 2001
> From: Stas Sergeev <stsp@users.sourceforge.net>
> Date: Thu, 11 Apr 2013 19:07:20 +0400
> Subject: [PATCH] ASoC: define playback and capture streams in dummy codec

Applied, but please do send patches as covered in SubmittingPatches -
send patches inline, not as attachments.  That makes them harder to
apply.

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqQSAAoJELSic+t+oim9Q/AP/1Hv5o9jZbWEvGQXGv02aTHU
eOlW7gCpfIt+x0Ys+fUBOGfAQHi5SOgYUtZldPaVmZWRxmAgpMxqIHndZHFnBLzb
d9bWHDst61vOS5j9ExoNTkOXkMa0mkNrbcT1IEs5xzzoB8tfJyubsZfSSJywUeYo
zBNQUpj1T1RwJLcuPNBTL++C+3LqRhfCQbgB6Ts8iXu0ahFyUf298OgA98+/Ujuy
o9bCyWj/IekDmToU6t4EH20aDbuvsZ6sb2EyKtI4VnNliSha0DgrMMFwXVWWNJUP
WJP40bn86grPxmu45m4TMXDDa/KoHjoQyr+u/jtZirpB4AHiqXMnGL8m2EGlMhGW
aNanqjQCSjbC+fqCO8ygb4D9xsfrNpBYERlT9e+LYGi98/kcy+7WoLsSO77NI5uO
MVmw0Ap0YYkEaJIbSjf2d3HHZYBt9w5mkMJV8OvOHA9PYxtA9KzyKOhOJDGY//5r
G3G0IH75B/+vsLOjNrmPnZmTYfgQMN6l8mdHKXYVZdYBWt7rSzq19L763EsHd/MU
Pkxp0kASdTXQK+d3P7qPtYMtiTNJ1Is2G9rVmyk83T557yeK9k/DC/CtMiJY9adN
2Sb+fhkC4/lSTVmHqzSDU9Mu6H72MoSt/gCVQWtIRimQ6q5GfswnEOGti+7RW7mX
SJcoUIIrB5epzebI87EM
=ur6L
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--

--===============1962801912424953936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1962801912424953936==--
