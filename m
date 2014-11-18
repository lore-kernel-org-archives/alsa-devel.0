From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Fix memory leak in
	wm_adsp_setup_algs
Date: Tue, 18 Nov 2014 16:21:46 +0000
Message-ID: <20141118162146.GS22111@sirena.org.uk>
References: <1416326843-25994-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0318207003125065234=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D45426048B
 for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2014 17:22:05 +0100 (CET)
In-Reply-To: <1416326843-25994-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, aitdark.park@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============0318207003125065234==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ig5MTpp3LwprTX9"
Content-Disposition: inline


--3ig5MTpp3LwprTX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 04:07:22PM +0000, Charles Keepax wrote:
> From: JS Park <aitdark.park@samsung.com>
>=20
> Signed-off-by: JS Park <aitdark.park@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Please provide more of a changelog, for example in this case it's
important to know that this isn't so urgent since it's fixing the error
handling if we're out of memory which for all practical purposes isn't
such a big deal.

--3ig5MTpp3LwprTX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUa3IaAAoJECTWi3JdVIfQK+4H/iTYQ6UmYAzf1YcmvH+drNWL
m/r+lRHXcKpl+bcCz5U5cNXKwuayhgwCFwvAnuBiIEguaAzBU0/i/NYEPQS8WG4F
+Z4R8jFiIVXuFvHvw5AQaRiAvtf8ux7cF1t3pQ48Xoe8KYhKgJADKGdmZvxH10Q7
/WHRE7UsBZLqKNW6ALqCz7SFkhwYp5wsC+hwsDimj/nlXdhJpim+GBr4XkBWWaxG
l0cRtMMK2AWsIrM9Fawotk9PFZlcSMZd1wM6s5do9gRYR1x1MZSc/G4h1v1vQZoe
2dO+3UpPY6PiDhHTRG37g9Bu5NZmD1of/GumjGdnMZBoshNRa1iTBDF9fCuo+/k=
=pHNx
-----END PGP SIGNATURE-----

--3ig5MTpp3LwprTX9--

--===============0318207003125065234==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0318207003125065234==--
