From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/11] ASoC: spear: spdif_out: Staticize
 unexported function
Date: Wed, 15 May 2013 08:49:03 +0400
Message-ID: <20130515044903.GE24524@sirena.org.uk>
References: <1368562797-10440-1-git-send-email-lars@metafoo.de>
 <1368562797-10440-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5900200924972316499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D1CE626516A
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 06:49:07 +0200 (CEST)
In-Reply-To: <1368562797-10440-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5900200924972316499==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2013 at 10:19:50PM +0200, Lars-Peter Clausen wrote:
> The spdif_soc_dai_probe function is only used in spdif_out.c, so make it static.

Applied, thanks.

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRkxO8AAoJELSic+t+oim90aQP/1w4+HreXM4n2aTDYnOEVBCp
uQH5dkaBfW0tgZDkySC6cRrz3p9ivignSy3WtJk4/fuY0o1ov2TW8QxpElHka1iv
4+7cCXbPgeAiF8yl+BJex3bFxrpx8Tpv69UrrWsBqQS59OJR7sa/LJftiKIoejNS
Ft90fKsZKU/y3aPsIQmfEqwWKO3Asr5crUH3uQji3IQxy2tTQl8EQZu8L5M5STd7
GYbPRLS2Jnu9nEodNsqM70iWZiILpbLXp4o6RONJR+yUbPg07o3xMOzDuT4ZvhlR
EhPwJxueWs2K7Lb1a1KDYByFoAjfa50ildmR8TUD8khQJ5zkypExvfXTMfK8tqrV
wkz+n1GQbe/NqER4oKbwQdkUeE7/3i6Em2+nO54sU9SSwDOkjhFfjlDC70ZC3QKY
xo5jFS8c3Fcvj7OAJAhfA9c5wlkAgrv3O84buPv2RkWiTVUAgck37wOUqGTeD0xe
3ME1pPUY6y+5fya4WU8Gc5rrFj7S8NS+tlE55Vf1k6ENswP93BvbtqlTUEfJako4
6wBn6g8C1sZdEt+djFX3FIWEn8ZFOJnyle2mxT9L6mxuxfojADxsAgPiZr5NMVsv
FisPwzzui79vinsey+ceMGwfPAwFZZZwzyl9yW9F4BHjX8ktsqcm6hkyQawjZuDM
OPchWhzec6siBnOu0/De
=u0wo
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--

--===============5900200924972316499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5900200924972316499==--
