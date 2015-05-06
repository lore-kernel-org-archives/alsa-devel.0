From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-twl4030: Use card DAPM context
 to access widgets
Date: Wed, 6 May 2015 18:54:06 +0100
Message-ID: <20150506175406.GF22845@sirena.org.uk>
References: <1430129702-16408-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3362110767046245469=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C22D1260631
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 19:54:16 +0200 (CEST)
In-Reply-To: <1430129702-16408-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3362110767046245469==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cY/F5WiWmvpOcyyS"
Content-Disposition: inline


--cY/F5WiWmvpOcyyS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 12:15:02PM +0200, Lars-Peter Clausen wrote:
> Use the card DAPM context instead of the CODEC DAPM context since only card
> level widgets are accessed here.

Applied, thanks.

--cY/F5WiWmvpOcyyS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSlU+AAoJECTWi3JdVIfQVu4IAIaubtmdo1w5I4ilon/+vdnw
e7Hqj0MXOGLGa3PmWZeQ5mGGYtRoqZQKN2jcjCqqrQP9/CsjfMNpsYa5DKVTRhlY
U5IR4yRHODpzBe3c+NhQG/7MOkbSRjxs+9a4ZU+moJVHHeLu1t5T1xkbUKkSX/T3
ogNwJJ167J7GlwfAYNkaiORZyVNf4KCY7Lgg/8vFM+qOBgeveskfgEhe8f76uhGL
SyaT/yBQRA6h3/O39ppsbN0IQyCRt0eksqF3/Q5Yw2/UkI6QkQdAJa/1vEF8iS7g
csI2DStRF4evrVczOnsrgClZHoVXstMfQrwi5zjqNc4l7lT/2FRKHoj8OoCemaU=
=6vx5
-----END PGP SIGNATURE-----

--cY/F5WiWmvpOcyyS--

--===============3362110767046245469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3362110767046245469==--
