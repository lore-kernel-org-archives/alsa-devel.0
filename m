From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4 v2] regulator: arizona-ldo1: Do not
 control clocking from regulator
Date: Sat, 21 Jun 2014 21:53:49 +0100
Message-ID: <20140621205349.GD24291@sirena.org.uk>
References: <1403275273-22713-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2313735520678446106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AD85264EF1
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 23:10:35 +0200 (CEST)
In-Reply-To: <1403275273-22713-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============2313735520678446106==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2014 at 03:41:13PM +0100, Charles Keepax wrote:
> From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>=20
> Using the driver for the internal regulator to also control
> the clock frequency of blocks inside the codec is an
> unexpected side-effect for a regulator, and also means that
> the core clocks won't be changed as expected if an external
> regulator is used to power the codec.
>=20
> The clocking control is now handled by the core arizona MFD
> driver so can be removed from the LDO1 driver.

I would expect this to be squashed into the first patch since otherwise
there's a bisection issue with both drivers trying to maintain the same
thing at the same time.

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpfDZAAoJELSic+t+oim9wE8P/jCMqhUKCZgVIKN0HW+e1PN3
d6Oe8bbiCkh8mWX7euay6bsFVqrYduPTzG45My7FaMChFQ0YwYCZ88SfuEszTqAq
E5bqiZPcntfaNLLaxEKJ7rjrV7gT3GcTRE4KFHelRKZ2/g6xV6uj4lSEy9v8VpIC
Okazbd0OGAYoaKZK6yy233qdAoExFaXw5G5KqhcoGO/pE2fJLPmGBZKSI4KW2Nwz
hYpz2zgcV3hqqJt1VIbjNvgAEENknPD0oURTpBFkCh432ffqTJ9HMkcUqB4wXrTq
JSaKLa+W5uscm4hEVvN9jrec8IUo2KE1Y8gKGHTcdeOpbQMQyry3spAebj/7ZHKz
iTWZ+vXh4IX34NKp/08CSrJCpaFujOEmx5PhJwbMkfMQuXRWlV2MWZiEoqLU+U2T
RXtrRgNHVFH1NOzh9Ri+5SRwHuS2ZkswAUCG43R/aDVgjZnmkSR0XQha/wckbGp1
88wrvoAV48nDRTQg2Voc9yun3RpwNs5JBk2IV9KXuah19LQoyd8sXCzA1VKRZc1m
gA4FosnRE7V+p9zIQatHI0Diboyq7y5NXmf9uM4lSjPsPtv2BEPc8djlw2z2QKBx
3nmOw377k4/zxFQj6Lji+6mEIOeFKm66da5wAmJ9nDpRKFVjHegKw6pnfQcTUFsg
+olJ/0mO/bip70LTbqq/
=TwON
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

--===============2313735520678446106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2313735520678446106==--
