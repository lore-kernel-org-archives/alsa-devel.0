From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: add clock source selection
	controls
Date: Sat, 16 Aug 2014 14:11:23 +0100
Message-ID: <20140816131123.GF28623@sirena.org.uk>
References: <1405588163-31631-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1485081251756269735=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AB4F5261721
 for <alsa-devel@alsa-project.org>; Sat, 16 Aug 2014 23:37:52 +0200 (CEST)
In-Reply-To: <1405588163-31631-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1485081251756269735==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V4b9U9vrdWczvw78"
Content-Disposition: inline


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 05:09:23PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> We can select the clock source of some digital widgets in rt5645.
> This patch adds the controls of those selections.

This is exposing the clocking configuration directly to userspace.  I'm
really not sure we should be doing this, it's not how we typically
handle clocking in ASoC - usually the clock management is done in the
kernel as it typically needs to be coordinated with other things such as
clock API operations.  Userspace control tends to be a system level
thing offered by the machine driver.

It's possible that there's a case for doing this directly in userspace
but you need to make it in the changelog.

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT71h4AAoJELSic+t+oim9O0wP/2X02BIOLxEyaDsxobEBIvl/
T9zOWMBZDg0sCxfBgseczLzfiQ5vyeJ2Uyqd3U0nC3InlurWlcfYQyxzOpWK+jv9
QCQZNEIgKgTdOIU4guyoKheFDWFOJNckUkoHhnLlJFn7NYSF8NicuZruuNZPiIJh
vJ4iD36D8n+dfCB4DXO82lPvxfiwbMi3AK+hKeTSaMI18Io0/HpUK4R8Igc2yJHX
6+x9lKexfsn6dvUVhPlO5hN8JGtBn3wZIF22vv+IbXmso3pLzWFVtuaVXh23Ewwb
CYalVR1fNJkee+MJqUB+Q+2Z1kWBZe1fZGJKLBbmqLRTwWEVAlLamVVbRleGS9SL
8uGYJghdEG9YDFSZVBHfdF/55qygWkMqGd6mhQM1rRRdZ7WMmvO1BwIfpSa77li/
EodLcCYllhckFepTBE4WGpaRw3NaSyDUxM/NakKWloL9Wk/60aHKn7MXsASJskSj
zPmPNmS/UTdX0O00oKgsOM7DoVE3q6DFU5ePxCh/HluASUzJoUCGLgQLwdxeABF7
d8ql0H4RfFZRPJADyaFEE15Anw4rxdJCryN3IxgNqu1xXte0qRqcOJJyapKqLkwt
Oa9m6Va3XVtruqBPtnTugBkc9zu0mXYVVLsSNpECV4sBZqAP92TowrlyEuJNkbsJ
HIu99w0mO9M0adMmrhx7
=CRvF
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--

--===============1485081251756269735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1485081251756269735==--
