From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove return value checking for
	gpiochip_remove()
Date: Wed, 17 Sep 2014 09:50:01 -0700
Message-ID: <20140917165001.GL7960@sirena.org.uk>
References: <1410958682.18482.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0600839418102733582=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F35BB264EAA
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 18:50:18 +0200 (CEST)
In-Reply-To: <1410958682.18482.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0600839418102733582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S2mBhmCV/xKTH8gV"
Content-Disposition: inline


--S2mBhmCV/xKTH8gV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 17, 2014 at 08:58:02PM +0800, Axel Lin wrote:
> gpiochip_remove() will return void eventually.
> Thus this patch removes return value checking for gpiochip_remove().

Applied, thanks.

--S2mBhmCV/xKTH8gV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGbu5AAoJECTWi3JdVIfQe74IAIHDHXyMn3Y5qz5R552muJcS
08WFlNR2HqMXjOQ4acksMaIyi4tAdSvuYK7YVH1xoyPrh7EhZh9x+dlc3CZWBj1X
XHKrIcvVdg63llW6V3oni1p7ZvUEmmr55UPDi3wB/oxL63OsKG/UgO70ikuVLwDU
gVDkh1Ufafct71+Q5tpkHdj0siCWOQ9Wh/bJRsnSBdton9pFX3agrxnvx2UWyxjI
bUXlk5ivmCnGJbyjXF0MBqshAr+GwiWwEnA54Dbln+3IswV9YIaangqeZWtbMU+v
7ho/KQ76JTXcCETaLOoJ29VS91ap2RwEHSVfJVBnHrH4NRoxPpekzy9WL4wEc9o=
=OYDt
-----END PGP SIGNATURE-----

--S2mBhmCV/xKTH8gV--

--===============0600839418102733582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0600839418102733582==--
