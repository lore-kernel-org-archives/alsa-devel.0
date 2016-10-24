From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rt5514: Add the DMIC initial
 delay to wait it ready.
Date: Mon, 24 Oct 2016 18:28:05 +0100
Message-ID: <20161024172805.GJ17252@sirena.org.uk>
References: <1476759497-23660-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6192807185734096875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 773AA266CD9
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 19:28:12 +0200 (CEST)
In-Reply-To: <1476759497-23660-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, woojoo.lee@samsung.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6192807185734096875==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 18, 2016 at 10:58:17AM +0800, Oder Chiou wrote:

> +- realtek,dmic-init-delay
> +  Set the DMIC initial delay to wait it ready.

This should say what units are used (at least in the documentation,
though it's also normal to add the units to the end of the property
name).

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYDkSkAAoJECTWi3JdVIfQq3UH/jjiu5vZif1+v1A0Bk0LAL+H
XpqAV3m0cr+1Tm7gWUuzBYU4XRuVqKIHjclI7QjPHENPWUlLIdVFWpCLUFL/+Ck2
rsDqD/QCKE6l6dTdKhKXItUTmPEIq0r7nHFogcnOkbcitN9vB94OO9bGbhVTiNfb
P0PzepDEENYb4b4LCPTgKV6Vj6zyPin7ZN4LTahnhDp3PR02vBYUJdzxhcbjkBLf
/CkIzcaHgoxmzeZmE1gZHEcnKO0+UNai1se+vLghKtObiObq5NIUQMe33YUfOL3+
gDBJXWPC9e5zUztgA7XTzV0xEf8+I5zZ20zNdR2TQQXnO0+7Mt2aRu1gII/SA28=
=YxZd
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--

--===============6192807185734096875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6192807185734096875==--
