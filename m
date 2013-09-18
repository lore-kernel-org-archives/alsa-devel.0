From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/11] ASoC: davinci-mcasp: Add DMA
 register locations to DT
Date: Wed, 18 Sep 2013 15:39:34 +0100
Message-ID: <20130918143934.GS21013@sirena.org.uk>
References: <cover.1379409268.git.jsarha@ti.com>
 <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4320976697184205775=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CDA026109C
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 16:39:42 +0200 (CEST)
In-Reply-To: <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379409268.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jsarha@ti.com
Cc: nm@ti.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, joelf@ti.com, gururaja.hebbar@ti.com, detheridge@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4320976697184205775==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="doRsZBpDQ+I4/+/t"
Content-Disposition: inline


--doRsZBpDQ+I4/+/t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 12:26:02PM +0300, jsarha@ti.com wrote:
> From: Jyri Sarha <jsarha@ti.com>
>=20
> This patch adds DMA register location to mcasp DT bindings. On am33xx
> SoCs the McASP registers are mapped trough L4 interconnect, which is
> not accessible by the DMA controller, so McASP data port is mapped
> trough L3 to a different location.

Looks good to me but again you ought to CC the DT maintainers directly.

--doRsZBpDQ+I4/+/t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSObsiAAoJELSic+t+oim9iTYP/AgI7eXO+NlMt5PnJhovg8aq
zJhHPngULD3s+IqIYRSg8hH2/fxdhyInWzbbP/RAhXyHqGW9ezS9d9QHufCKc17V
T3pig31aZcfJajt0sbpvY2vvEavbN9JZqdzOP/hxEF+aS7DBaeYtj455q9Em/cmG
94/FyT0g+5Cs6T/3Ex4OJ18rL+iFBbkjeOL0DvyUgD9/OZgWxFHl699wkBCaYL+T
OiICftOxw7PvmKM8hX16QcxgR3o5APsQnIvVuPh8Alhiuf1VD5hxPIV//s72rAd8
99m+rhvlmx2o5PbkVYj0r8De8GM15DzUcJ6pQWWT/IE4gc5XGdS0WZmhIPxRLIS0
jvFpTvzuSq5QzuvNOvZFsI1jYTp/JcenAgihqrDhexsMyYsfOd/8rUs1tUButzUq
6sYzydjA809e6JT5F/++hRCkPfhTIi4jMwbNoG9pDldjZpnCtPwbGO9mecCLt0IY
j1xBzsmKio7KiEOuJuK+XpMfXUQWf8Z696o42HUE/vEkmhBjXy+uJE3zfR+XwPMU
6p7qs113FBLNZ8kzjmcXHSHdmwUhmjqjDWLSEGbLTMBw8N/q/082S2FxWQRsfbGz
U+gLjgqui3ZvR9f4OxyVoHuHOepLe6yAfy/a4JBV75Ue7mRae4WSoa1fbL+zB2AC
JmReV8W4RYeI2qIyUlNx
=hOlP
-----END PGP SIGNATURE-----

--doRsZBpDQ+I4/+/t--

--===============4320976697184205775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4320976697184205775==--
