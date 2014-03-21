From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/12] ASoC: omap: rx51: Convert to
 table based control and DAPM setup
Date: Fri, 21 Mar 2014 18:03:53 +0000
Message-ID: <20140321180353.GH552@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7501764626479748829=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B444265044
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 19:04:08 +0100 (CET)
In-Reply-To: <1394634460-15889-6-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7501764626479748829==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:33PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes. This
> on one hand makes the code a bit shorter and cleaner and on the other hand the
> board level DAPM elements get registered in the card's DAPM context rather than
> in the CODEC's DAPM context.

Applied, thanks.

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLH8GAAoJELSic+t+oim9g9kP/jum6zHqzIk+JnWRAlcAGHbV
XGkyJ0CsIbbJFLEV6uD1c3tgNuCylx25V3OZvpON83GHGwVjGea+pV3AVsH2Pnf4
J05Vz/CS9Nz5cKVypV24dHMiDH5apA3xHKxetjYVtdUKVIQiODXJWm6x8FjqASFS
FMxQUsqe1CXywK0q+/J0T74FFFegvvkw8s7Eey+o77ZAqZqLiAmaLS7smmP6LhLF
pq5IkFKmOc8bLMArYX7W7fUGyMQjj/x6xMzhflvHP9Eaele5NcKInNAfflf1hFp1
D9utldAIxR5+SQpzClVwIXHzKv1VCOeTbb96DFVo9Regl15ZdrcSxCbNyvNYyb/e
zhpvHQqw2x/DoUsChEBuWGJo9IXNsM043XZU4+Ron1v5kt4bbicq5gnfKZz85Zp7
c/4dT/q2Sq3LrulXC1cfH7E1i/rmXZMwnxVP+TXYfvt4uHIwocxDLYet5vY97vvD
5jukjIA6FbtQ7i0RE9Spbp2ucHnJo/gAmsvHu1gi31CwPSxKOrSYDnbLJcsfvFJM
KjhsSgUp/luiXC1UlA82VDfSExpYloC2N3rIzoVCmZ8R1QDoxGqUz3gIyQ8TqOWJ
NxLFW8cQZflA3Trc9QYZIBxXfV0IKT4ElASPi6D3TQDPOm7M4Mn1l9TltT5Z6KEF
Z3aartbA/w4lgbmv77S6
=jbD1
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--

--===============7501764626479748829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7501764626479748829==--
