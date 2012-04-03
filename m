From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix warning due to the
 lack of REGULATOR_CHANGE_VOLTAGE
Date: Wed, 4 Apr 2012 00:51:31 +0100
Message-ID: <20120403235129.GE11910@opensource.wolfsonmicro.com>
References: <1333487120-13500-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0513732758964226211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 88DFF2438C
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Apr 2012 01:51:35 +0200 (CEST)
In-Reply-To: <1333487120-13500-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============0513732758964226211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 06:05:20PM -0300, Fabio Estevam wrote:
> Fix the following warning during kernel boot:
>=20
> 0-000a: 850 <--> 1600 mV at 1200 mV normal=20
> 0-000a: Voltage range but no REGULATOR_CHANGE_VOLTAGE

Applied, thanks.

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPe4zoAAoJEBus8iNuMP3dmP4QAIth7epxtc5QMWh7VY05aeYY
HsPk7RbAohQFt6RzctXZPqu8kvrNtDCFK5KKiFeSXx1a3cZXfXl8PnUTduzb9hY5
6u7EQinHXOhiUxG4BcKtqyJL9O+3qfjFJMQcDGLDz8oU+2gfNzxLXUd4N0jux8pX
KDlF2sBR6zyvVIMnfRdt7/dzfBn6iCAItp5elxAEfMRNKwFEA6BiQ4SUbI4rSnbk
MpONpTP+J77+zlFu/53ynPNdyz9AjVBATBMJ0BNKuOUfA1Q01dLvYrLVRgmFsSrf
LUTu3PgKLz1w9xycWuJWQOL1EP5TCdUHwoI72Wjac1kLGWsiUsChdjPHIeGIzbYe
1REjOmNxgIgM6yBHC+2by2aPOkKG7J9qy1YDX7wZsudlaS6cBecL/+4t29NmHObb
1dJTxDH4XCLI6K2yDvwZ6NlG0X6ameNlrmBrVu/7WcSdelBlFlMG0DIBoZspAfrJ
AuFJl5kq3YLla5hSAQGYpPErHfJSIu2Vt2izFTcSWP0crtFelOutJH7Le6S9B4Xx
FShdbDb5MMH1tKiNRkD46b5SEZdTQmVFnmCoYY0T8NlBI/0TK9wsFEavzw5Ht8xW
20rrMZQ7Ig9P9tqhkyIoFLMtvX4iCN44PovV65+v2Xu8ogh5ly5Zfy/v1zHYCsrL
UstTs0uKYuhcVI/AOWAK
=HiHU
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--

--===============0513732758964226211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0513732758964226211==--
