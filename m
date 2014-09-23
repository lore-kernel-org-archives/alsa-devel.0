From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Remove locking in snd_soc_{new,
	free}_ac97_codec()
Date: Mon, 22 Sep 2014 18:20:07 -0700
Message-ID: <20140923012007.GB27755@sirena.org.uk>
References: <1411426588-27149-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1359617873201157610=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9B6C261696
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 03:20:27 +0200 (CEST)
In-Reply-To: <1411426588-27149-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1359617873201157610==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2014 at 12:56:28AM +0200, Lars-Peter Clausen wrote:
> snd_soc_new_ac97_codec() and snd_soc_free_ac97_codec() are called from
> within a CODEC's probe() and remove() callbacks. Those will not run
> concurrently against each other for the same CODEC instance, hence it is not
> necessary to protect the two functions with a mutex.

Applied, thanks.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIMrGAAoJECTWi3JdVIfQWuUH/1Xoozj24bIAmhGcHif50CYa
ZdwxzjIHRUGdKPVQxIT9BlLokrbghXwV3U9cxwP+oMaQbOoCwFM6nT9dPGn9kSLs
j4GBk8LCRwIEcoCnF6OsuykVkyJdFyfjsyWaKjjeJ+mEgZr25+a4sMLkLdbUs2+Z
V+qU6t7yCSNCWiSB/aNab9mWEUzwp3+B5HL9hnbyZ8xCstGHCME92qp4PLRjevg6
9w2LfV3HQ7SNckFR0QEfhgxFRGVfs/8Jflz07S2lVCnsT+BAe1KtvbU0e73Y5HSg
MpFyMbrSBA/BkBAV9tCCSojD5JP/82SCiOxVbmApofySvyctOEM9zck65SjVtWk=
=F4jn
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

--===============1359617873201157610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1359617873201157610==--
