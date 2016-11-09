From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: add rt5665 codec driver
Date: Wed, 9 Nov 2016 14:51:44 +0000
Message-ID: <20161109145144.7n5qyu7h4qzex4gx@sirena.org.uk>
References: <1478587987-23999-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2710267439135190091=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7684266802
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:52:02 +0100 (CET)
In-Reply-To: <1478587987-23999-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2710267439135190091==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="drnmc5dtn67heub7"
Content-Disposition: inline


--drnmc5dtn67heub7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 08, 2016 at 02:53:07PM +0800, Bard Liao wrote:

> +- realtek,regulator_1v8
> +- realtek,regulator_3v3
> +- realtek,regulator_5v
> +  The name of regulators

No, this is not how regulator bindings work.  The driver should just
request the supplies with the names they have in the datasheet.  Please
look at other users of regulators for examples.

--drnmc5dtn67heub7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYIzf/AAoJECTWi3JdVIfQ9zMH/0oxOMbcef3JoHCgRV/XITBI
w4wd3+HkaLFc3Jnr4V9vvLi9CHly6r+jEZ77EtWEdpar7euEOTUxZTxgag5sVLUw
PD3WDOV7cgTBRm2JnroEgFNJpV5OwSL5KIRJHpbgHBDu7WHv8YLXcI4L2MRM0Gpt
x1d6fzWMZln5I7FtSXcmyLu/Ez8RA+2BdOlGxeE5hhORds+YUYtLaDesS9OB9dj6
z/E5unZeTtFnnsHDv27qoCtJ7K1sGsO6Y7HgTAH6FouO1vOT64XJpIx28twrNvHx
tWlSPJ8OJexlXPCisFPr0oT0xBCv6d4ujJuJvC74kknc4pSp5YyDi24hmT3fnKg=
=qcgu
-----END PGP SIGNATURE-----

--drnmc5dtn67heub7--

--===============2710267439135190091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2710267439135190091==--
