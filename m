From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 21:05:50 +0000
Message-ID: <20120312210550.GC30146@opensource.wolfsonmicro.com>
References: <1331584650-19014-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4596754614778721998=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 420E410410B
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 22:05:53 +0100 (CET)
In-Reply-To: <1331584650-19014-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, javier.martin@vista-silicon.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============4596754614778721998==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 12, 2012 at 05:37:30PM -0300, Fabio Estevam wrote:
> Convert mx27vis-aic32x4 to platform driver.

This doesn't apply against current ASoC, there's some conflicting
arch/arm changes.  Please rebase against my for-3.4 - the conflicts
should be trivially resolvable by Linus when he pulls.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPXmTvAAoJEBus8iNuMP3dg/AP/3yussKDrIFQyAIglXohvJE2
SDD0cTwmseolIC37Drk8Qhag7sgpojQSRkv/2RAiSHDSDH8GdSKqQMCPR+18kz/b
+AAd2w2uWEbo2K2bdFvDrSE+rrFVPZTkdkUKf8H4Y3J8mmlMRCb+shE/P4APUG+S
8TkmlI3btTwq3lr6QO0mNgJBPeHThf/d7KNG8pTNggw6qn/p6I/nG0k9HK/RVGfQ
KMLBu3mBfsYBgGrPNcHIY8dQ0wDurdK43f2UfLsjx0YKK8q+PqY9ryOe7bxbXgOK
NvtrE1mLmnlmII8skrdnw0Qte0xgtClvsy8PwYE6H3ZZ05xWEYUozi9ND3IqCMOm
nl+rnbZ0/HuFV2ucIzrCPAEXuSLMbyQKxw3SkClku+WzMK9eDEhKvwt4pEcpSiN7
VsLTfNb2kjWlgxLMbd11/HRXPso30Nbwn4sBH5niSMZA/LrbkqLjltokszFJcBMo
Q000BwR5nC3Nx40tZ8dBpNBFXvb68v+vt2AxZZyNRoDtACoYq6i9Aq/mMG6nTsOV
jXbo3/VXlAkMw9Il0xgxNUQN0aqiLBfDgAzOpBftFAfwneB8PpNmcivH7I4dUUvG
3EeGAd6pHkO0nLoflrW9m5DEs/0XJIuyLLt6sEsjzsVKfpWhxEaHRIZBTsV6bwtQ
xBcoNx21Xkxxn1lsqZqJ
=5R51
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--

--===============4596754614778721998==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4596754614778721998==--
