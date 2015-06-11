From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/3] ASoC: wm_adsp: Add codec_probe and
 codec_remove stubs
Date: Thu, 11 Jun 2015 11:40:07 +0100
Message-ID: <20150611104007.GR14071@sirena.org.uk>
References: <1434018752-523-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1872721238286570622=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31DD0260612
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 12:40:23 +0200 (CEST)
In-Reply-To: <1434018752-523-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1872721238286570622==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CR5S1WJ1/E083K3u"
Content-Disposition: inline


--CR5S1WJ1/E083K3u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2015 at 11:32:30AM +0100, Richard Fitzgerald wrote:
> Currently the only init function in wm_adsp is called by the
> codec driver early in its probe before the codec has been
> registered with SOC.

I've applied these but for some reason it seems you've generated these
ADSP patches against topic/arizona.  In general I'm going to expect
things to apply against the most obvious topic branch or at a push -next
(and to merge cleanly into -next), if you've got non-obvious
dependencies or dependencies on multiple branches then say so in your
cover letter. =20

--CR5S1WJ1/E083K3u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVeWWGAAoJECTWi3JdVIfQzmcH/09rIdqv2JrmRfUUl5gNAfDv
VK7hI38qFqedxNP67zSVaDrCS3OC91/Xi6y3MAJjKrCeaEnSxBFtm+YykPOBl3IT
fvXTMyf9Z+DCLmfQfKCnb0HbUKvbA1SsUTL82/cA3h85BVuhuZmBdeDZXHAmuQ6K
L0feoRC8XYKk13x1+5erqEz0wuYGK96Bjn4N0P+YfSICOOzhx0B38n5LVd1xekBI
4t3yff5MSxBzrVreOcNojaQ+g2+Hhh5aYf5d9JzftLSoPRZDGYTI8/Xuv4r0fnju
KhaAh+2+vaZi4nUHKxOYId7HoqAgJVqwPB3+mPhoWDZWTF73coO5lgrhpgElIY0=
=245T
-----END PGP SIGNATURE-----

--CR5S1WJ1/E083K3u--

--===============1872721238286570622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1872721238286570622==--
