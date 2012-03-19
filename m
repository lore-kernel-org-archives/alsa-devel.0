From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs4270: Check that we can enable
 regulators on resume
Date: Mon, 19 Mar 2012 18:37:31 +0000
Message-ID: <20120319183713.GD12384@opensource.wolfsonmicro.com>
References: <1332173777-9786-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F6770F0.70002@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2943954319284822943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85CAA24152
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 19:37:34 +0100 (CET)
In-Reply-To: <4F6770F0.70002@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2943954319284822943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 19, 2012 at 12:46:24PM -0500, Timur Tabi wrote:

> When I add 'int ret;', it compiles and works.  Note, however, that I have
> no regular support on this board, so I don't know what I'm really testing.

I'll assume that's an ack for the fixed version, BTW...

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ3zgAAoJEBus8iNuMP3d93wP/RP7ZQ6h+NIfakUsnOSMu6Tt
n+F+LTVImNazRoaLa4gwgN+LP9Wlj5ScQlw1J4o2Qmfj7ng6Zzs4GwAnpB9bXonK
Xk66nnMi5Z9uGx+aeClpum2ZS66xJJxC/JXj9dcOgElyyzp1Zp7W3sz4tAWiEX3k
fxzJZCpp2hnlhqbqMUns3ALO7LwWtcaW6JKjXLFoZMVdsFxqQ7YeMFRmu29uc0fL
RMjJPPJXpAuObUNsdQFQewcO/K95mML2xpITsSEfz6Gg78iGilmvlZIqwc2bIzhK
BHUVmjkLk6hMfgsUPin6d7CniWvMtO5OpAuNPi+ZAgX6kkint+jnBmgcoBVhQJT7
Z71HSLszubrNUpYxfXUrx90ufPG3i0fvUKMrDaAQkURmyzwnnoeoKa/YaD8Xn2js
vjowK3GBPxmg7m60Mx4WPUKQRdkZExasVSaexzPejSo0V0L8yaTHpm3SXTX5o0bh
SVZFAnE6uXq15zyd0I7m1U9wGtJRLFwqtbfJROji4iUc1WDbn+4Ui+a/f336TS4R
twf/0tyHvqzzDoFhxQdZdxvOYPHooqvF5elUZZQ3Vh1Mqd2PUBSIgjM0iDosT5Ez
xB9hNYY9XM30iphC8rnAGMDeeZY3gAlX8desQ9lzKZqwAciSglqEfEaJQpLF0Qcc
Feboiij38aLzGnuuD8Ye
=qkX3
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

--===============2943954319284822943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2943954319284822943==--
