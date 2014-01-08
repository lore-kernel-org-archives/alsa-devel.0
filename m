From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ssm2602: add 16kHz sampling rate
	support
Date: Wed, 8 Jan 2014 12:51:29 +0000
Message-ID: <20140108125129.GC31886@sirena.org.uk>
References: <1389130481-25364-1-git-send-email-apr@cn-eng.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4699008581907991601=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 381B626515C
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 13:51:36 +0100 (CET)
In-Reply-To: <1389130481-25364-1-git-send-email-apr@cn-eng.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Pretzsch <apr@cn-eng.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============4699008581907991601==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqxOpcR7xL0oehj1"
Content-Disposition: inline


--DqxOpcR7xL0oehj1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 07, 2014 at 10:34:41PM +0100, Andreas Pretzsch wrote:
> SSM260x also supports 16kHz with external master clocks of 12.000MHz,
> 12.288MHz and 18.432MHz.
> Add matching coefficients, update constraints and announced rates.

Applied, thanks.

--DqxOpcR7xL0oehj1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzUnOAAoJELSic+t+oim9fq8P/iKSBNvVR4biBU6F13PLdwki
DB8k8M6yg2Onpty3Z33fikuPn3IPuzyNASD0LVpFb4PLKTIFMBXU7CQ2PNry1jfK
cgaHiFlJx1efes4CH85bkzYj6R4Py7JtAOG7K1qWK/jgqW5VP9j3vcb7SO8bhFES
WZAETE1DqAGmywqohpEg6ncBbiUgHSs+mBEPyyTeSio3QWlCS2NAZu6I3AkuyKbe
4Kh/BAp8VREjOGAyRY1u8+pYyRYj87X0VEZLxc4sEoC8fE0GKHDCr7QXbjXT8RyA
4M9oOlT+IlxsNZ6m00rIjEoxnJKB58jrld0Zf5aJVe8d/rr3w20kK2R4iYPTNBlh
3Wr4it/nqs6FI/ic5NZvQXuEum+osMTmdVITEM7J5UIM4SAWYRrS6DNrCTqw8XpT
BLe11AiLdJl3A54e8DSjYcpPqLJrrBB62TaPpo+Zu7DtjDw5dKdzDoGl03gEjxJt
u6OEGb6MajR0ZdOnoXGAg5pZU2rWpmD4kml9YrVETnxAiqNGiHalop5b6vUTNW5L
cEjEWuGJM0kbNquJcfsJdnYSZ52wdMjtCEvF+qkStEXethK2Jz1JbuUL0WleDoL8
6bd7GjbMFBYqu7oSgobXcUewBJE5dP3cxmGAmeo/4RNwC70+HcQTp46crqmyHFx3
bRVwkZHnOVEjyFj/UZr8
=h2qk
-----END PGP SIGNATURE-----

--DqxOpcR7xL0oehj1--

--===============4699008581907991601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4699008581907991601==--
