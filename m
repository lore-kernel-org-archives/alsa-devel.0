From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Wed, 17 Jul 2013 11:36:51 +0100
Message-ID: <20130717103651.GP22506@sirena.org.uk>
References: <1373024862.3233.63.camel@matrix>
 <20130705114456.GV27646@sirena.org.uk>
 <1373031306.3233.131.camel@matrix>
 <20130705133752.GX27646@sirena.org.uk>
 <1373270091.11222.12.camel@matrix>
 <20130708112613.GQ27646@sirena.org.uk>
 <1373542576.9286.101.camel@matrix>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2289676716755927921=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B626526512F
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 12:36:55 +0200 (CEST)
In-Reply-To: <1373542576.9286.101.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============2289676716755927921==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N709L9vpgywc1qLv"
Content-Disposition: inline


--N709L9vpgywc1qLv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2013 at 05:06:16PM +0530, Ashish Chavan wrote:

> accommodate this level of change. Is it possible that in first go we
> just fix the breakage due to name collision so that both drivers remain
> usable. And in second iteration, we restructure both of them as you
> suggested?

To be honest I'm really not terribly happy about this - I don't have all
that much confidence that the second step will happen, the fact that
this has been broken for a considerable time isn't inspiring here.
However I guess...

--N709L9vpgywc1qLv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5nPAAAoJELSic+t+oim90+EP/1ARV4T5aPfB98kWihLAKs4s
OYVCuerUjkXFtmhps/tYsKggB3BL2XdIue8/a/6lYIFBHwziRy2rEXlXN8Xb0Isz
V9J+pzxt0kisFD58tkmdp3mXDeLxp4clBdXKg+YEquyxGmItoJyPSujXL0CjCnCh
1Dp1QulmEpxNUyBX5Zce8a7hp49XJNg75wSQ/rVnebg2wW01h6TfddfiZI+TZeus
azlS7o58wixSRWcBE6EDCDFtN9n6CsiWx/70AtBLc4Kj1CRufoa5sxjZkwbCqTHo
zbvl9tX/qCTm8N2PXzIB4VIR7ETVsTJogQUNptAUJvtD3ySH35YbLKSYJUHdSY4x
hboKhO388o6I/kCVtw2OVFONGkS3iJffECZkVBg/TabFrmb3QHaNtHCdDBlZx3ee
LZ+3ScF6Clb8UshBx1E6f9Piii7425QTer/7DLQSZfJvpabTKipGyYQgfF0Y0opX
V/mGlxP3p3J0o01hdPFocLMfi4nHMX3BmXLtKEBGlwY73U3j/GYaadinMn3CrqIV
Vi/odibXNDaYBxE5jsej/qSqqcrp0wB9q9cwtoe7oCW9onaVv34dsw5+ZPAqf8E0
pAugVEyjmLX4NMBQX067XWGNW2yW2QR0XJtQvSbXyBkDXEajApL6rsStm+jm22lq
cJUxvPVr7jKM6ERlFO4t
=wUT7
-----END PGP SIGNATURE-----

--N709L9vpgywc1qLv--

--===============2289676716755927921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2289676716755927921==--
