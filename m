From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: remove unneeded AUDMUX register
 setting from imx-sgtl5000
Date: Thu, 5 Jul 2012 13:47:33 +0100
Message-ID: <20120705124733.GE4111@opensource.wolfsonmicro.com>
References: <1341387507-21015-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2729400208557656957=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 641E8245A8
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 14:47:35 +0200 (CEST)
In-Reply-To: <1341387507-21015-1-git-send-email-jason77.wang@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hui Wang <jason77.wang@gmail.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2729400208557656957==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qzBiUkG7YMMDZbZI"
Content-Disposition: inline


--qzBiUkG7YMMDZbZI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2012 at 03:38:27PM +0800, Hui Wang wrote:
> If we don't set IMX_AUDMUX_V2_PTCR_TCLKDIR in the AUDMUX PTCR
> register (means Tx clock pin is input), we don't need to set
> IMX_AUDMUX_V2_PTCR_TCSEL as well. Since both i.MX35, i.MX51 and
> i.MX6 datasheet says "When Tx clock pin set as an input, the TCSEL
> settings are ignored".

Applied, thanks.

--qzBiUkG7YMMDZbZI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9YzdAAoJEBus8iNuMP3dnYEP/0QhiWegNJFm2gf8Bymy0kK5
guzOeawpFQ54RWaVaYhZ/AAzxJqLWbPcP6dPCt3RXx8X/0fPMJf3erMCQ105mMEg
YWfMbD9k/w52/hht7kan7TLCOaTbYjiN7VwLzkF3YjRZfBjl0e2KJcvgOhfJ/W3x
+AwL+lZx0D63Npsze7mCoFgThMETj78LZ994Lh9l6LQ8iS2+dn3ZSXN7iFybISAX
Eo71zTbCcuIL3BFh6bKfETkzGHL62i7nDE2Cv7ITTk7O8FCFDO5LncYnPtvWv3gR
17wBZvOmD7CgmCYO898qIvyvqJZHlOSn9i0V2E4615zFK12p4SbdxyxIDngX6pB+
VuJYMipD3IVWKcIbPbuDHGTaW6RLfd2PlU8y+beGlMkj1xsupIxVU0tCbMPobadf
bTIk4O7DBal6REJvegQ8iOzipC3NOCxCVhlE2TaUWyT+TXV5nbcJmYBET9o2Vkft
I8pO7zuXUxbaOuXgoev5H+a/cdwdYioFLRewmNRu1Q94Aw0TxEsdvMAtpztm3Z0/
G/1V7vuqDjAAjxpd4exiuw4omq4+LxNiCOfN38FzI/gGhC34EpRc9cRt3EvzKtRz
Btp0JF65k9zAVg2m8QfmCXaYC2+qr4ic8oNhVrx8kRHihP9CZOb8uqOrIuxiJojB
0P/aTValeGbnsUXgavsP
=HbXV
-----END PGP SIGNATURE-----

--qzBiUkG7YMMDZbZI--

--===============2729400208557656957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2729400208557656957==--
