From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5639 CODEC driver
Date: Wed, 26 Mar 2014 10:52:24 +0000
Message-ID: <20140326105224.GI2269@sirena.org.uk>
References: <1395627397-6580-1-git-send-email-oder_chiou@realtek.com>
 <20140325133017.GY2269@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D126943581B0@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8233988567594477834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 91C91265130
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 11:52:29 +0100 (CET)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D126943581B0@RTITMBSV03.realtek.com.tw>
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
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============8233988567594477834==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yvzb+MHGXtbPBi5F"
Content-Disposition: inline


--Yvzb+MHGXtbPBi5F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 26, 2014 at 06:39:38AM +0000, Oder Chiou wrote:

> > There have been some API changes here this release cycle, you should be able to
> > just remove the cache_io() and regmap setting code here.

> Do you mean that the cache_io() can be removed here?

Yes.

> Please tell us which codec driver can be for our reference, thank you.

All of them, the API has been changed.

--Yvzb+MHGXtbPBi5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMrFlAAoJELSic+t+oim9GgEQAIQxaBrnttMC8KO2741qQR+p
z4RTuElAtgwuL79/r6kho+pMr3SUwRZ57UPDXmFJQLHCyTSBuxS3drR6V9d4c0Zk
klRUavvMGxjitG2tj/bfUkx40cU+KBs8mhYKITtns2CNhNcJnOSniRefBmwINi1h
HpLNC/mUXIwl1scqlYly/fMcDx+iDvXC7g23x+NSspssZZcJjrixFYHvbkQS5Cfg
mIKjcRjaaDRpRb29+oR0zFeQ/5gQkAGcU//95100AcPiyZdyPQUoGc2OgNp8oqCz
fJjVYYxZ/1PjEvJpIOWME6FoTyX1SU1ZWCQ1urxj3DkOAWR6C1Muvq5zywARMeKk
qcbEiUSPREWO2cTxDiGbv5qS3h1LqngVWUlETvr6ynLKgTH1cveNkZ2HdruIHHQL
mHJsK7HgdEfpSEqeTmvZ1bJmeYSyNp8KvWHgaq/x0axsWkLUYMJ4WIqe7uPf2tm+
ncvT/a2kcqy/OsCyMc9+0b+xojv8huMPL1qjIu3N4iQj8/ZJ4BxLZ17HFJxHWlVn
pnAmEdRldoCHDnhh/y/swD7zPKYYfpBCuJLAFfiX9x1pGhCZYkJCSs57TUnz3zE0
V3xsoApT2OdIUt29r7ArRgDWwqgPUtg66Bntm/3Es/gichByc31Zn3BX4l0HK1rg
3TkrvCh94vGuRMZqCXX1
=WW2+
-----END PGP SIGNATURE-----

--Yvzb+MHGXtbPBi5F--

--===============8233988567594477834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8233988567594477834==--
