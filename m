From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: check suspend state in
	dapm_dai_check_power()
Date: Mon, 3 Jun 2013 19:51:20 +0100
Message-ID: <20130603185120.GS31367@sirena.org.uk>
References: <1370281000-1120-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0823373773176651045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DC08264F40
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 20:51:27 +0200 (CEST)
In-Reply-To: <1370281000-1120-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0823373773176651045==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ll0BBk1HBk/f94B0"
Content-Disposition: inline


--Ll0BBk1HBk/f94B0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2013 at 11:36:40AM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>=20
> Currently, when the system enters suspend with audio playing, since the
> DAI widgets are active, the associated CODEC is considered active, and
> hence is not transition into a low-power bias state as the system
> suspends. This likely causes audio failure after resume, since the CODEC
> power has quite possibly been removed during suspend, and the bias level
> transitions in the CODEC driver are needed to recover from this. At the
> very least, this issue likely causes warnings in the kernel log due to
> the CODEC being left on over the suspend transition.
>=20
> To solve this, modify dapm_dai_check_power() not to consider DAI widgets
> active if the system is entering suspend.

I would expect us to be dealing with this as part of quiescing the DMA
operations on the links - it's not just the CODEC that needs handling
here.  This feels like it ought to be more joined up somewhere along the
line.

--Ll0BBk1HBk/f94B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrOWlAAoJELSic+t+oim9pJIP/i0ppe6Pc7HAclyMJ+M2l+jc
aq/ZiQnuY6XYneBn+it+HxKIeIuoizOksKfmy/shL2Zh+0T35OcMTDiNsaimx75Q
4hQuAa7eD+aTwfL64m3DeEkxKqhApU0Ua9+Vm3dmlkVd3Y2AMb16677hK1Znh0+w
iAfjXIcRiHJUdzNGyGWw6WKufhvW/CSn2q1psqjfNk5Kr6M/mK7Whs9d8lPFvDkc
NEduJFjN/tvuW0W7m6hTlI3JR6m55Bsf4DK9ijyGdvT+sn8Nqm+SHP/aoNQNDLUG
Lh9gBEDkh11wBoU5/f7wcCRyJVEev9DWwx9ypkEDxx1+u6JD8motHIK7GM1VpoHk
j5yP+mTbVpJx+GiFiWq+2uOUcq0nj7xhqLHdYCRAdBx2rsP565Tl/81cSq3YWqDy
ZrJ9SxLZiZC1SAY7CSpzZT9QeDfqb1Lir+Q9oxpIMm8EjjqFIPeSGC1d5XQjmARF
qyKxTfAsu6zyqpGZy9wMrQXc2RcvuneB72n3XyHJC+I4uDkDLL/z1+V/FALUAmZ0
ClQqddGa15317iVa/o02LiZXJwN4aUp+utNQAboKyEij+TZggMuG8QXrDII8Muy+
staoL6w9dxbk1ArREyu9fImXz0UE44iqfHNV3URfNKlNheXxe0Yq1wpuf9nbCtwS
WE29bPVdGTJGYcoMSj1o
=Tm4c
-----END PGP SIGNATURE-----

--Ll0BBk1HBk/f94B0--

--===============0823373773176651045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0823373773176651045==--
