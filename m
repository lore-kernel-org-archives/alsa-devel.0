From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASOC: imx: add machine driver using
	wm8962 codec
Date: Thu, 31 Jan 2013 11:23:36 +0800
Message-ID: <20130131032334.GB6027@opensource.wolfsonmicro.com>
References: <1359445790-2070-1-git-send-email-b13634@freescale.com>
 <20130129085831.GC32597@opensource.wolfsonmicro.com>
 <8D894AC610DA3944965280D4097EAC4603CCB754@039-SN2MPN1-021.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6968715574010966344=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A8172615ED
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 04:23:43 +0100 (CET)
In-Reply-To: <8D894AC610DA3944965280D4097EAC4603CCB754@039-SN2MPN1-021.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhang Quan-B13634 <B13634@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6968715574010966344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2013 at 03:02:21AM +0000, Zhang Quan-B13634 wrote:

> >  > +	if (!codec_dai->active)
> >  > +		clk_enable(data->codec_clk);

> >  Should be clk_prepare_enable() but it's not clear to me why you need
> >  this...   Also the clock API does refcounting so there should be no ne=
ed
> >  to check for active, you should get matching startups and shutdowns.
> > =20
> >  This will also fail for analogue bypass paths, set_bias_level() would =
be a good
> >  place to cover those.

> [Gary-b13634] for power saving consideration. For now remove this feature=
 to
> Implement a basic feature

I get why you're doing this at all but doing it in startup seems odd -
like I say set_bias_level() is the most idiomatic place to implement
this usually.  There's a few machine drivers doing that you should be
able to refer to for examples.

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCeOsAAoJELSic+t+oim9oUcP/2aMecVYxdWe1u+7pd2SoMeO
/okav5aOxSY5IVSKrC57cG9FRBogFtVZRTXO5I+KV4WycEZzV06Wp62iHzidT0vK
Fxn9UWKqKhbgjY0u3lGwnyDRS1RPywKai2q2PgXArfB9dyqMplxRIcNeFdHitk3T
muEAXcdDIzOwe6O1692RDjaYWuSVFTzfqIlc61gJP4IvGqPilViRxg87EZmudoWi
p/891lx/godwmfcLRGSSsH8aUvo2AretbEYhT9pHzmMQrL223nee5Nh5tU/+tYFS
q0Tq57XZxtkr7gNZDAoW/vXE7vXWVw4M6o8EEF13F8w0DL6uEC0VgM6UoPQqBSqL
LjSXUrtdtDB+7XP8nMPj+3kEMelQo8x6GcWZbB3KbXaFQFpyk7bNjZSFXssFZmDK
4koBlnw0KX7u4BdVRNzyG0L/K2MvJ3RZjXUv1/EWSGpOoZ/fDxWdSznvrJsOzgXU
nRU0pKh+ScRzoAfmBC6seIxu5SBuyPvM5a++j2zuIrPlVoJycgTccSHkZ9MFwEwl
lBbnGNGlV5ppAeKQPhDD/kGuFsP8Evn/b+0Py5eQmA32h+6zMBZmWJ8UZtiLL8mM
cV8uV9HZvJ7PMlDzQSIxlM9CrexsvkUrtHldIftza874RYoTtm0vyXSKyRvsy6X5
jj+R7HXrne54t6wQkUse
=PBKg
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

--===============6968715574010966344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6968715574010966344==--
