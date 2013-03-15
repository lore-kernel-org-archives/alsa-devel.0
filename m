From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ALSA: ASoC: cs4271: convert to direct
	regmap API usage
Date: Fri, 15 Mar 2013 01:24:10 +0000
Message-ID: <20130315012410.GC4931@opensource.wolfsonmicro.com>
References: <1362696792-11681-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3668435670564795016=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 81A5426163E
 for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2013 02:24:12 +0100 (CET)
In-Reply-To: <1362696792-11681-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, subaparts@yandex.ru, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3668435670564795016==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GZVR6ND4mMseVXL/"
Content-Disposition: inline


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2013 at 11:53:12PM +0100, Daniel Mack wrote:
> By using the regmap API directly, we can make use of the
> .write_flag_mask for SPI, which allows us to drop the strange register
> hacks that were necessary so far.

Applied, but please do use subject lines appropraite to the subsystem.

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQngzAAoJELSic+t+oim9OrkP/itBSN6xJDMuFeZ/aEcyB4EW
9MBM6idNJNiTVSSZMTjgPvFPhQEVxsDZXxcyc3j0a0aKyhHwcaYuyH2mfBNZboV5
ob9zRm43NDoPkvoXpWnmZGN10+nwWTjkj37rvRTvoVuwBwWcH/gQUF1m6F4kWF3W
CL6oN7k5n/WGj0cC7FNe2yyFKPywLgcL7B/u9OMvqWb9GIi163diKcyB1z9H4V52
nB7cwc0OE/eX2ysctSc8BiFlfcxuh1Js62RfuQl5mDZ98nS+fMqUqu72p12771f4
rEhlAStxr1idoHuJpyJPq4Du+NKQfdVaxD5bBCcgWJeav2cUGUf/r2zZEjj82LSy
ic0r0E3pW2KS7ZhQLk1vS7cKQaVEIrylG+ZNNCSU6gnoVrHAF1s124uY72MbZlt/
O1OjzKGkGXWGT4vVQ9Ng1373iyRCGMAFVtMA0TKVwu/oMvJGTv2lLhrveZrvxzM0
1vuHazhounF+TX0p/lNvZTSqofQr/1QorFvmCqAg8S5bP6EsiSL2Q3ZLLRJsXCmW
OHl7ld05glpA5+UxSR9crkcA+sT32HFmJ6Lv0XDhJTsf12pPFir/U2BNzuraIf3G
QhLmMpQ/WCTrqN+wcl8/qCy84OHmre2/o6/3aPMK0irz10mM3BMROQZ7yJYFLOvl
L6Zz7wtd2UUJkf1UlLGe
=8N/D
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--

--===============3668435670564795016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3668435670564795016==--
