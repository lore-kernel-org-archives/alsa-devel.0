From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2] ASoC: sgtl5000: Fix VAG_POWER
	enabling/disabling order
Date: Tue, 4 Jun 2013 18:47:14 +0100
Message-ID: <20130604174714.GS31367@sirena.org.uk>
References: <1369767356-8496-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4167156933550451546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 14A4B261A6C
 for <alsa-devel@alsa-project.org>; Tue,  4 Jun 2013 19:47:21 +0200 (CEST)
In-Reply-To: <1369767356-8496-1-git-send-email-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Dong Aisheng <dong.aisheng@linaro.org>, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org


--===============4167156933550451546==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MgcI0aUO3vrRQI/Z"
Content-Disposition: inline


--MgcI0aUO3vrRQI/Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2013 at 08:55:56PM +0200, Marek Vasut wrote:
> The VAG_POWER must be enabled after all other bits in CHIP_ANA_POWER
> and disabled before any other bit in CHIP_ANA_POWER. See the SGTL5000
> datasheet (Table 31, BIT 7, page 42-43). Failing to follow this order
> will result in ugly loud "POP" noise at the end of playback.

Applied, thanks.

--MgcI0aUO3vrRQI/Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrigeAAoJELSic+t+oim97SwP/Rt79UKZZzrQvB4ZdUf3t2uW
nO84Lp2sQtJgHix8n2Y56UpcAdzMsVa0vpHSRH9pn7k/UW1EzGTDnvyP7HqW9Ui5
SiAMd/erMTlQguO0UnW5c6gKiRSbT2KkQAZ1g0MVJa9G6Dcbwg5Sy/N0jSE5ZYZt
SgSzcphZuV9Wj2OdAWAI8y7/BzD24mm4KsHdZlUipmIj1Jomms2AddOIeyyHlMsw
5V7vDKdqpVQ3/U/agIdC75O3daoQLGYJaNX8fSU4BOYRsfscxL96BF3ZOa5WqROa
ixuvBCdogJjjjJjte19xR1Bjo4afSUqIERo0ttGmceKRMlSMoFFNpD9W9C1fKZeu
QgoHxG7Kn1WqfihiR2VvuqSlN4SntcCCVsTl3hi3Va01anicJnBy+VIsjGjnqL2H
Ij1ewC1WYZ9yrEPaY1hHVzW5Vbyw7goSe5f2F5/O/Veb0kAetBXBnj4Sm6HjFrym
nYgrbJMCeGIcEZ2Tvwn8rEaxPXK9j8mfGjrV+POsPRiGsJPPQvKEJ8R8FJsTj6cV
s09zUdsYRuADZYQZ1hH+e9Uz7gf1KuqlCb3SHrq5RkKSb2c/VPg50RXaXfOXKT9n
ZjrUWGMT9tg53aKd/ULU+w8BpoL/inRlGpWp5I61yBb1Wa23OE/K3Gdbym0+OLkr
YIIcm9UiTFLcy7NtqKQT
=c7Wj
-----END PGP SIGNATURE-----

--MgcI0aUO3vrRQI/Z--

--===============4167156933550451546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4167156933550451546==--
