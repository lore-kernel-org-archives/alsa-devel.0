From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5645: Add headset detect
	function
Date: Wed, 1 Oct 2014 19:31:21 +0100
Message-ID: <20141001183121.GM4273@sirena.org.uk>
References: <1411125345-16935-2-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1332422910958799815=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C5962604CE
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 20:31:25 +0200 (CEST)
In-Reply-To: <1411125345-16935-2-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1332422910958799815==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V2Kn1ZfDiPlyQ6Qk"
Content-Disposition: inline


--V2Kn1ZfDiPlyQ6Qk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 07:15:45PM +0800, Oder Chiou wrote:
> Add headset detect function

I've applied this but I can't help thinking that it'd be good to reuse
the jack GPIO code here for the debouncing, what it's doing with the use
of a workqueue is more friendly.  Either that or add similar workqueue
code to this driver.

--V2Kn1ZfDiPlyQ6Qk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULEh4AAoJECTWi3JdVIfQqRcH/3PpCSdJIpV1/ISAPWsA0Hs9
uqJkULWugQmURDSv9rTgIOpAYpvjvMx4fRZMpkY21092qsZcL/RvwwexZcRaNWm2
423Va0jPMNkqr6KU3+oXIVzwycwrQPV8U9HAjeXbrJUGNpNTMeiOtgB9dMBGiDC6
vH0NK1gp58KlN/66UY1pzRftRU3xzQC908ip2XCUre35lQWdUcvW3PZwNazCICBl
CnZCtguyw1euIZHwcZdCZaCH5zwhQQac5oopHsGfLFpcgIlB+2LK6TsYb04ip9d0
9oSLSz+aMFlCN+ijajwcmNB18eFAGivvfOukKCN39dgatHgscM0WlFrJKsN4wlY=
=a+Ij
-----END PGP SIGNATURE-----

--V2Kn1ZfDiPlyQ6Qk--

--===============1332422910958799815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1332422910958799815==--
