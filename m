From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: delay the initial jack detect by
	debounce_time
Date: Mon, 24 Feb 2014 10:28:51 +0900
Message-ID: <20140224012851.GQ25940@sirena.org.uk>
References: <1393137892-21007-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8390487537938669945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EB97265266
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 06:34:40 +0100 (CET)
In-Reply-To: <1393137892-21007-1-git-send-email-xiaoxiang@xiaomi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xiangxiao <xiaoxiang@xiaomi.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8390487537938669945==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QOZ7m5QMypAqX/qh"
Content-Disposition: inline


--QOZ7m5QMypAqX/qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2014 at 02:44:52PM +0800, xiangxiao wrote:
> so the hardware could get time to initialize and debounce

Applied, thanks.

--QOZ7m5QMypAqX/qh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCqBQAAoJELSic+t+oim9cA4P/jyJWWy5YH46dLy6cc1myFs5
hYbcglLPLiZavjqPaVMyDeK/jJst0y1m28V6G/iNyogmE1g49Jrom/WjuFe+pM24
ppgiyDPGesIqHibP5Sa1qsItpAS7Eln3OH3oqUEYC31xpaQZX6jJ6vwfGkvfRjzr
F2e/CnrHGEh9QvSd2PO1V+f0zNlBiAYUA65oz+wUjQwEaY7WvVfWiTIWmR5BNRqL
HLJen/651PgoPQ6xA6zV6X+yucpA8FD6+Pk4KljboEYJohmBN5KIJcieRXbnqIcY
vYGyrjO4kxT9xtpujhufdwvzozAPV/d4sIhF4gDSfbVWTkFXKW4kiObMJsdQCUSO
EOzifjMa2bdXCZz74RAf3ZeRltRCv+wdmRdtsrj3YjDCjT+ooxoQi2IYWIJ7Hc3r
tGiRPNjLb4NxyY2xKuYTmojouww8U7LGPfUtS55cTH5kV2qyS5aSz9KtwGNeD5sv
UTHk9QcxAddjBAAtLf4CLQtvCGOND2MvJRiJfQz80m2NQkfgESO0wIteQhDmNGDf
+Iq7Oz+PR0qYYB2n8cAOYWVvlqSXwDesZD+m98iiY7TxaT5MpI0Z4g6nuk1A5+YO
f2K+Wqr+WT8HGlWlmDWkPqJoFy02tGJIuIoaCEKqp3PXAWM5Bp5K/HLtBu6wfBCQ
yKMMntRVcxJsoZWgXPBV
=abhk
-----END PGP SIGNATURE-----

--QOZ7m5QMypAqX/qh--

--===============8390487537938669945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8390487537938669945==--
