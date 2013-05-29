From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: blackfin: Remove unused
 bf5xx-{i2s, tdm, ac97}-pcm.h
Date: Wed, 29 May 2013 20:27:26 +0100
Message-ID: <20130529192726.GA5180@sirena.org.uk>
References: <1369761738-29503-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0001897204751519451=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8030C26500C
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 21:27:45 +0200 (CEST)
In-Reply-To: <1369761738-29503-1-git-send-email-lars@metafoo.de>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, Scott Jiang <scott.jiang.linux@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Steven Miao <realmz6@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0001897204751519451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2013 at 07:22:09PM +0200, Lars-Peter Clausen wrote:
> The structs defined in these files are completely unused, so remove both the
> structs and the files.

This series doesn't appear to apply cleanly to my topic/blackfin or the
merge of that and v3.10-rc3 - can you please check what's going on
there?

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRplabAAoJELSic+t+oim9J5QP/0nh0WJfGvAB01Sw9+1P/LZx
gkL4HDtZGh2Heg+5V9Av/tilNEZ/QMKd+7jSqw4Gj3lQTJGymU2DuHtfaaMfdwt5
p6GXMbETya/izjHu9hgtOPhehwDXQ28XaJL30wSouKWmTC/2ubpwWezjqgD0U3wX
1GchBdxgqQUPhguVFN4hxfmCzsoGmoAV1n2z9UY4WYnrJQlzTiCBe+ipbc2RzEnt
GF0+zT1aBhXMlZvTXz9fEkZMFgKq3R9JI+P+zsK44u5wKtVhg4ZPvJUfKm3xP4FX
+Ex8MhrwIRJ7d2YTjncjp8u+CUsatUnIxtuRftnkcOdP6YBFerYWvvoGiGPMl3RA
WkajrhvbBqoq/jOsRKn9SV34o0Rp8BBydxiqplN1kVe+qxYs0iqtyLNAPZj/8Pmn
I7I4O2xy3nj0a7ELtFSl/FK4/EtstoGV9NXKUMjhyI44qqhxOBdq5lkN3VrgufCu
bVYfTNG4dcZ47OMA+WVrmnB3muIzAWMksrrCYLG1+ogVvsa1FGCRmfSL9Mv5NSpM
WDLpIOIZeYgz5IC6t61pRGpLGsHng7D8RMbZn5DpAZdqiIRrDNeaxM9aeb6iavOf
6wNHVELR+zCGV9qLx4ay51CwjeMsHLKq4Jd4jX9S/nqvFCsCK+5m2Hx8yfiY5xcB
o3lFrsUhVsPc2xeL4tw8
=3rcp
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

--===============0001897204751519451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0001897204751519451==--
