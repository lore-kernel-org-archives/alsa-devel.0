From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: i.MX SSI: Fix DSP_A format.
Date: Thu, 23 Feb 2012 18:59:12 +0000
Message-ID: <20120223185911.GB7245@opensource.wolfsonmicro.com>
References: <1330008198-31142-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9179235104749949291=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8645A24360
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 19:59:19 +0100 (CET)
In-Reply-To: <1330008198-31142-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: axel.lin@gmail.com, alsa-devel@alsa-project.org, lrg@ti.com, s.hauer@pengutronix.de, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============9179235104749949291==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2012 at 03:43:18PM +0100, Javier Martin wrote:
> According to i.MX27 Reference Manual (p 1593) TXBIT0 bit selects
> whether the most significant or the less significant part of the
> data word written to the FIFO is transmitted.

Applied, thanks.

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRoxxAAoJEBus8iNuMP3dp7EP/1+GdoImAtkg8UH0BXTenJ5q
Ujms7b9IkKF+FiJYz1Zxtkn8ab2DNXS9RQQcsKlmi61IkhjDdxL/OaW0eRY/wSmH
plTDvLtUh6uptImS+wssdXLz3WhNlzpVdb2eo4yRXEqK0Vm0tudDg3l4FZi7Dzj5
SQOaIHDlURGNvnGsoZRpm4gc46lwu+9PtomhjnQwlf+EztkFx9nBwqTLAgDogk4T
u0fwBdc2o7c38DTtbbxZqnGNRzJa4FCLVBGq/qzFh9QWgxFdJYX5cRPq/UQA4+w8
Tlcfg3K7irkIV5uesosbMvSCYBN0GqzVXIc24EbZ+4EufmukTcWuWR8P/OZkc3Mb
bUOI5yefL5tlSbI50GTPp5MLO45hZO4BfbL9eQuP3lMP4pSP9H5NpLK/vySsDz2I
sI4aGcIRX9OKw7rptjKQo3Zp3v4eQSwW0KFuQGEEK/msrGWKvC7XPa3ZZMJrqnr5
8gNXnadaLc+9hd77wxo/836Tl1G6Mtl6lxPBJFtqA+Yjw/cs+UHN/nJTyoS7t9jn
X7cDUJ7qNd8q89aLYmkFxIyFp5yyHJ4a7J0/i4v9sGdkCrxcBPLbDiTwxI3KNbJT
RFF1P93Vw7HocJauf/Sx56RjP11jJoMimRY+RYWZm4s5niZiXLNTjhJO5RMSYzze
XcRvZawJ+FOH78uHqU/h
=11Ib
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--

--===============9179235104749949291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9179235104749949291==--
