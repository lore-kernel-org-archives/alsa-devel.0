From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/8] ASoC: pxa: tosa: Convert to table
 based DAPM and control setup
Date: Mon, 3 Mar 2014 11:03:32 +0900
Message-ID: <20140303020332.GS2411@sirena.org.uk>
References: <1393685300-5307-1-git-send-email-lars@metafoo.de>
 <1393685300-5307-7-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3585174585399114662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E70B265528
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 03:03:54 +0100 (CET)
In-Reply-To: <1393685300-5307-7-git-send-email-lars@metafoo.de>
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
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3585174585399114662==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JWOY2/vB4uO4FuME"
Content-Disposition: inline


--JWOY2/vB4uO4FuME
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 03:48:19PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes. This
> on one hand makes the code a bit shorter and cleaner and on the other hand the
> board level DAPM elements get registered in the card's DAPM context rather than
> in the CODEC's DAPM context.

This doesn't apply, please check and resend.

--JWOY2/vB4uO4FuME
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE+LxAAoJELSic+t+oim9MwQP/3Fnj+/vv7O2OLitgBVVJIBB
6msl4aiLJczgHZGnNZ0oUytY1xXq3Hq9MpQqiqDRoMtWd8gSqXV167PUkdT/TZ0k
ugLiQVIcgaUHH2Ceyq4l8rghOO0J/NGYpXs7AJMhTTbr3ltozfhD3UJscD3eyi3U
E9vCBWCTq0otq8LBpahKiwKoeKT5H0slQW3XBekTrhlijzGJn0q//OeeOmpqwSUo
mNEwFaFw4m+/lJKUoNiuqJwI+uwv8By4HOVF+UjjCMKJ/vOp6wREqcFgF6HNV5ob
NisemNMOjqA1xZcGeJJWbgDT8cj9NMG2mvbn6vvTX7E/5/BEe2pn82g+5OIvOjyB
DwI6nxmii+03FBCn/1kGtCyc7Qco6cSaUCRQqoN910zdnp4DTTF9R7FPHuYwU5nI
CqmoasTooZVOGwgPSmjbc7IyGQVCZkYYwXIx3yqJUzX6freVfd1WNPvY0hQ0AMFb
mjvb5zEFDE09N7OtGnqY9xBXNN/b/sdCgwKS1E6V/0yvNKGm1Nkw5THFlYJlF7vG
mCHpRwk3ybJhVAbgSiE0u8dpZN6MLsW4todnwB/hV+ep8uBw8fi7/R4egOWU9eUz
XlsArrKqZIixqMqA4YvxJzDehyd5HIT/WU8V4QkiZc/UpBhpN5B2gvnFPNdegyOL
neCigEgtnmh/sZmrCKPO
=SgIj
-----END PGP SIGNATURE-----

--JWOY2/vB4uO4FuME--

--===============3585174585399114662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3585174585399114662==--
