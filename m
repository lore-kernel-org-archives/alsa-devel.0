From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: kirkwood: Fix invalid SPDIF format
Date: Wed, 27 Nov 2013 16:48:45 +0000
Message-ID: <20131127164845.GK14725@sirena.org.uk>
References: <20131126104140.16e3eb87@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3040311793308258330=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 35C1E264F23
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 17:48:48 +0100 (CET)
In-Reply-To: <20131126104140.16e3eb87@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>
List-Id: alsa-devel@alsa-project.org


--===============3040311793308258330==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QSIxHKMNNe9U+x7e"
Content-Disposition: inline


--QSIxHKMNNe9U+x7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 10:41:40AM +0100, Jean-Francois Moine wrote:
> This patch removes the 32 bits format which is not supported by S/PDIF
> output.

Applied, thanks.

--QSIxHKMNNe9U+x7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSliJqAAoJELSic+t+oim9TMoP/j2I6GGppf019euD6aglzwI/
dENJ0FOUsrfD9pc4jlIe1Ud8aIKv6xZSKd+6LmEdirzcaY/qdsTD79OHdXIt6U22
fvD0qkjWGinIV92q2RGns2vWpgcnrdKZes3sfMuccrWomSa2mkrvQ0yauMDQStUe
1VBUEUDTRPLanUn/xTQDBpdojryx5wTSNWzX7eHn+WbHiDMWKBNrCralmvEScX4O
wpbB5Cs1D5BeOSfGeTWtnbs9Mesef5ArybNF/KVsC2opdNIR98pcLBa+ddt5485C
p2hm9o8FTODFW/CdnrT5ro6Mnh3Rp3V348Uvj00AFx+MFulYW6mfofMPMXD95rgA
mE1CwYh52GkGfMCoZmPhprz206Ki64iuvWmdJlp149+pKwsVmUuj3Z2Zqaxu6Yuv
Hfqw9XleAqYSoEkGMe7UyIvekgMYcu5uqAepq/sRLxRb+TEvKFcJQG5kcwelVU9K
eiV2cDo+OqCMobvztoU00W9WiBchor1/E9FU/871LHjCzW0EOC8ou3e/cGYhe1QV
8QBzbJBi0+YVovPFEZDnyjYUE9vXxXEdpg3nBeRzCcsuequiyyeYbpwcsgkrhsGu
cfE8bah3pOK6YlhWDUna7SvAnTHq65fOJWBUxcCayL5E/HyWmxCSDVIeHPOwbhSV
zZyRQ1FsC4lh6ylt1vno
=woIz
-----END PGP SIGNATURE-----

--QSIxHKMNNe9U+x7e--

--===============3040311793308258330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3040311793308258330==--
