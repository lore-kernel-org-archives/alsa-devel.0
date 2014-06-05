From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: MMP audio needs sram support
Date: Thu, 5 Jun 2014 12:35:26 +0100
Message-ID: <20140605113526.GU2520@sirena.org.uk>
References: <4367111.vzeoBg4u5h@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1716150280973364167=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B379B26549C
 for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2014 13:36:06 +0200 (CEST)
In-Reply-To: <4367111.vzeoBg4u5h@wuerfel>
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
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, lgirdwood@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1716150280973364167==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Rh48Y0bnrojh5Wm"
Content-Disposition: inline


--/Rh48Y0bnrojh5Wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 05, 2014 at 12:40:04PM +0200, Arnd Bergmann wrote:

> Building the pxa/mmp audio driver without support for the mmp
> sram driver enabled results in this link error:

applied, thanks.

--/Rh48Y0bnrojh5Wm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTkFX7AAoJELSic+t+oim9ms8QAI6NlhA3aSo/JDHjJVxauVAM
AI8INH57X/wPNptBQDvoigRcTnleT9b3P164ECQUm9bgB71sbpf0QadGt19FAux5
gYm8MyBf6QpJH/ZHohNryjwNnx/28dsJE1reC2dIpRx9beFriLapGQNIOo7Srhrp
qznbtXWcMLI05LCniJsX+W59qeL3LkW0JH5Y/rX3yjLvjJDdM7DU55RhjVc6xWYs
i2kGIYWH1dVGjg+XsX/da+rQUyXwnEbD5F12wglzwI5NBglJL1X0P/TDjSHAmGNq
AF0VNrU2ZJHcg0wK70LhjMhuIFFVFW7onFz1oRUo1hBEnOCCgCMx1yxsXDXvcKpB
/9j7egkM2xGYU8YJ6AIYdxAZpI1Iv2vOd/yo/Aa2iyW8Ti155ZOl8hXgrSb7zz0v
ahLIUECDFBVjlfGkSVGZnNWNqQyBQB05o7bichU0gVRR7nEel4fz2Jq47MeZ9eHs
bdY88WPDcI5vSNlU8Hm4jeJlEFp86V8VVy/fQJ72J0zUw9XgBQoVcL63HgmANmAO
/XOydStHB/xl1c4b1493ejFJftF5l2lsD6KjyE+nzzs4SCCirW01T9+4V+9JBGH2
9ak4bU5cTF/A12zZRIHILdrqQFKl6Lx/ORRHVFxexpRTV6yH4+R68LaJlDYna/nF
beTRoUvSUSsGyMBQpwKt
=nLay
-----END PGP SIGNATURE-----

--/Rh48Y0bnrojh5Wm--

--===============1716150280973364167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1716150280973364167==--
