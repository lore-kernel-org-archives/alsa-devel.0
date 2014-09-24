From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-compress: fix double unlock of
	fe card mutex
Date: Wed, 24 Sep 2014 11:39:05 +0100
Message-ID: <20140924103905.GF16977@sirena.org.uk>
References: <1410486091-15293-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7467346250724400914=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 733F3261685
 for <alsa-devel@alsa-project.org>; Wed, 24 Sep 2014 12:39:19 +0200 (CEST)
In-Reply-To: <1410486091-15293-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org


--===============7467346250724400914==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2014 at 09:41:31AM +0800, Qiao Zhou wrote:
> Fix double unlock of fe card mutex introduced by patch 8f70e515a8bb
> "ASoC: soc-pcm: fix dpcm_path_get error handling"

Applied, thanks.

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUIp9IAAoJECTWi3JdVIfQUWIH/0CYNDnE8c8Bp2u7e+GA0Sxa
hWj7Fk+h2HHMyi9ihJSPmWqB9ZGE0JYbcvzxa5x4WZov549aUBpPq+lzaYqttfrG
zT7Ee4LTmacTExehygZqyHsOYKNSfWqccM7vNMoVpM4xMKIoqLNFht0KQPBuAYTN
+n2nYASjIndYIzbB3tS/Z9V+0nBywQPLFkJpACDiSjSYYgVTnZP09JoEnIjKu6QI
mrmKEdFRfrcC1yJDsJ7YH7jcDZa8p/oGK3TVLsi/6YzKWyiihKu0dW69QVDTF269
K+Ja1qUmobUpt7Nl7YZSsA81whq6Mk6DEYmTxg3zTdqtJwOL6oa9TZXhIwZoT7E=
=DQfy
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--

--===============7467346250724400914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7467346250724400914==--
