From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: davinci-evm: Move sysclk
 logic away from evm_hw_params
Date: Wed, 18 Sep 2013 10:53:38 +0100
Message-ID: <20130918095338.GN21013@sirena.org.uk>
References: <cover.1379409268.git.jsarha@ti.com>
 <dad0f7eb787d3f65848425a67d668e3935033195.1379409268.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6504736477374074301=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C7BE260818
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 11:53:40 +0200 (CEST)
In-Reply-To: <dad0f7eb787d3f65848425a67d668e3935033195.1379409268.git.jsarha@ti.com>
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


--===============6504736477374074301==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HJakWL7yBo69DI1O"
Content-Disposition: inline


--HJakWL7yBo69DI1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2013 at 12:26:00PM +0300, jsarha@ti.com wrote:
> From: Jyri Sarha <jsarha@ti.com>
>=20
> The sysclk rate does not change runtime so it should be initialized at
> init time.

Applied, thanks.

--HJakWL7yBo69DI1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOXgeAAoJELSic+t+oim9tdkQAIgyk/5gVx36DwsdI70WDHKd
1y+GOA0kjr5H1+Cvoxobh0jGt+LffOpTFq2XuInqwoDC+iMpTJgDkR5jb7UpemZP
ybuYjGQhwUM2oVhWlSUH+k4YX3EeR4ZaQEZS1x/zm9zHqh7ArMHkSiCCq2WjzfCh
/DGhQde6vXF1Da8XjioiDjO5JD84WBAgW8OfXtvv7CfOhMn4yw18YgYLgleog44n
kmCI9cZcfSI4YLU9BLgsEyZizAppKQkFSHs2FasBGE5oh0PmP0Jm1LMzVXG8Bzvc
HxvsKtpqgCh4/hrQetFBczzSbZIZlaAuTQb6qIHjCtv7NI7ta+HEpDKVdhyzn2w7
5qhOKohTB5vGbOsDFlElW2wf3ZiHVueNWaETQPMjgNZcMk0Xrij3cl1gf2f1M/jT
sIb/JfMzIXOT3q3+ujUsZJUfGQBneBXbewbGDZOQf4TZQP9U1VQkn7dolIQQiIWB
eaKPfvzlk/pTihWeLoEcJI7ZyrS4yVqTE2u/jfxaiKfIhI7aw+GYrBpDhiIbuipV
Hcq4HPnojXcXiCAyVJUrcyn4e2fPRMAQHfvtrNITyqqWbnY/ouC3RMt9RKP9GI9R
l9Gd3o3g3eC60uZE72Vohqj2Xaf49SyT0Wp52bGoyjqJ5S/mjktjP9p/65jV8wRF
Ec3hmACEqugEdd0pZz5c
=MvLK
-----END PGP SIGNATURE-----

--HJakWL7yBo69DI1O--

--===============6504736477374074301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6504736477374074301==--
