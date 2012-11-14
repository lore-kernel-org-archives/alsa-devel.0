From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/2] ASoC: mxs-saif: Remove platform data
Date: Wed, 14 Nov 2012 10:02:07 +0900
Message-ID: <20121114010205.GB4415@opensource.wolfsonmicro.com>
References: <1351792632-30649-1-git-send-email-fabio.estevam@freescale.com>
 <1351792632-30649-2-git-send-email-fabio.estevam@freescale.com>
 <20121102150312.GC4413@opensource.wolfsonmicro.com>
 <CAOMZO5DCjg+SxDDxUD1cxbYyu5QdohmoXQs4XtfgbFfoW59ePQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6614980195590128438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CBDCE261616
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 02:02:14 +0100 (CET)
In-Reply-To: <CAOMZO5DCjg+SxDDxUD1cxbYyu5QdohmoXQs4XtfgbFfoW59ePQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, dong.aisheng@linaro.org, DWinner@tc-helicon.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============6614980195590128438==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2012 at 10:25:06AM -0200, Fabio Estevam wrote:

> fix/mxs branch misses commit 730963f81 (ASoC: mxs-saif: Use devm_clk_get()).

> This patch applies cleanly against your for-next and also against linux-next.

That commit appears to have been added somewhere prior to v3.6 so should
be in mainline now in which case it's surprising that it's not in a
branch based off v3.7-rc3, and indeed when I look at both the fix/mxs
branch and mainline I can see the commit.  This suggests that it isn't
the problem.

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQou1gAAoJELSic+t+oim9t+IQAIzAt9obwpP1uUDjSjYx9k0F
WhC2GuxIccLQgB4c5jqZ/RHvHIDp6FchpNqLp5EoESDFTMuH9b2wnxpUAlBLUcwS
/t+8VpknHafpMsBxYQFVRlToKMg11SL99CFKypVp9t5CAJFhYkM8oEHmHAi4ApQ3
eZ9+3M6ZxEptQvGFQYiycW2MMTNLYHwZBEy9AX0lYyypGFoNz1YA+FnQihw+zYyg
2F58TIKS00dw9QZllCZvdBe+M6aHcgz8vPhFrmU8wCpXK219LefZk1oxAtPipZJR
KimD00PEm8+GfGXe5RSnOsDIKj5Ura/l3Za9yLAYeRndcb1/BAWg4sL0/fnsFTJM
o8RP+rLxHd3V2aJdsBNDIWdJu8R2Bj9Ok4UgnRuyn5J1a1aGqUyMp2edVh2uG0Im
icHGpKipI6JNlwd5m3Ng3h2tuvc/7/R/MLdEfuC7kOTRL8IJ/2nABgCoy8FiFox9
0HAXZQQ6hUP6AZRbMR/Xdtd/JOMqlIIHJr3o1/3zjzL+c5ILLyafzBd+SSh4WyLK
144rvcIAecZNIO4xM1qCDVnY0CmDeCy5B/1xNVAvzoC+A49UhJk4ClYw89hAaKd0
z/7fbd5RmCF4zdn+endW/XEgq6uDB2/r4x2zVfohpeu9am46Mwfg8CstE5+pWBbZ
ukT8dhtmWTsM5krE9lOi
=eV+P
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============6614980195590128438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6614980195590128438==--
