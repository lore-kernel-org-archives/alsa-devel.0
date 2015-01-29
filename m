From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: rt5677: fix SPI dependency
Date: Thu, 29 Jan 2015 11:52:29 +0000
Message-ID: <20150129115229.GE21293@sirena.org.uk>
References: <19778554.1IDiTWklUc@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8842071490379884341=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C06FF260451
 for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2015 12:52:33 +0100 (CET)
In-Reply-To: <19778554.1IDiTWklUc@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8842071490379884341==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vBa0138eRxZmLUag"
Content-Disposition: inline


--vBa0138eRxZmLUag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 10:31:30PM +0100, Arnd Bergmann wrote:
> The rt5677 codec has gained code that requires SPI to work correctly,
> but there is no provision in Kconfig to prevent the driver from
> being used when SPI is disabled or a loadable module, resulting
> in this build error:

Applied, thanks.

--vBa0138eRxZmLUag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyh78AAoJECTWi3JdVIfQUMUH/3X+aJmcEv7AvCguvFOQP6nr
pB5XfRXIOr1xQ2JxpECkFEG5hUaRFtbRWGZ9ZlU/Ewv13kJvW+v00PJS9EegqlRu
/0JIXIWh4jcidmaFPxNP7rA4skdaXiszdcAH34tBVyf0GfLtMk+w/rh8XUTlvMsL
g8FIBSUcDMr+qhQxJ3Idx6rD/D2JRuXMJbHYEqDRDlBJ03AXpJK4SiqJSDPhSndA
+qIX2hVA21+6DXT/iWaSTvOsNp2TZCmxk2K0DUvsO7cWDVEcT1+1bvH+MJT6a+yT
5XyxIXyP7e/SpOGPnpMZCp1BzncTd6tAyEFtfOJ80ROZ2BzbXaPFaDLvR4k40kk=
=CPa7
-----END PGP SIGNATURE-----

--vBa0138eRxZmLUag--

--===============8842071490379884341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8842071490379884341==--
