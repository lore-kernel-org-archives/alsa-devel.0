From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: sgtl5000: defer the probe if
	clock is not found
Date: Mon, 1 Jul 2013 10:45:25 +0100
Message-ID: <20130701094525.GY27646@sirena.org.uk>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3362735048498532692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ABE672625D8
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 11:45:28 +0200 (CEST)
In-Reply-To: <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, marex@denx.de, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3362735048498532692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W0OM0P+/SpWvhefz"
Content-Disposition: inline


--W0OM0P+/SpWvhefz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 01, 2013 at 04:16:09PM +0800, Shawn Guo wrote:
> It's not always the case that clock is already available when sgtl5000
> get probed at the first time, e.g. the clock is provided by CPU DAI
> which may be probed after sgtl5000.  So let's defer the probe when
> devm_clk_get() call fails and give it chance to try later.

Why not fix this in the clock API - the same logic is going to apply to
a great proportion of clocks?

--W0OM0P+/SpWvhefz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0U+yAAoJELSic+t+oim9zfEP/3mUJFAeLL+2knKPDbU7t6KN
h0bsJhvnn6p8iC48uN1mLaf7Zg4vApZ4tCfe6oHXm5GmBJcHtCr6IbDIBPnLh6+8
BTYkz3peYjHPjfdAH7ex0pw8yldkpJnQBPMlx9zmbHZk7DYvmaVBLSEpcf8Zo5xt
yi49EmW5p73sqzhof8Se+cO/AhptCRDYctaJPzhaA/BuPZNtOQsSOcszNRqgmPlY
X6gkHNa7sg6ahO8CYNstYCNAtgwdDW4NakRhRfbP3OUS5aM+ql9FQgxyty65iH+2
TDu8lz00jvaD16akQGI3tKY/lTOEsLVvhJZbAFcSg+F7dHIFCC6IeZMvf94wW340
8DIC6kyOUi0Tqs5n0yTLY2cTKwc141FB3lDJeu1Gld2GgrukRm6T8Jmj+BTQRyzw
4tYmnluA6itFjHvwRa6O9CjnOV5U/4ae3mU+SNg4G3S2B9B8QSMom6moDVU12/OE
Iki3Ld/03md0/MK+cYtpawLTIPAH8pm74rzo40BogR1OHpvyi2hLkfghHXXcQWv8
D4sTMQwfBWOc//GOKKOuM/Ld6D0SafQyIbJufVVpQ/EHrn9fW3dF3roL5HRPq2ka
D4MyZZF1Ng6QpE0BSji1/lqzpXyw7agzlIckmJsivSn4LGwiYhI+AzCEefDVSjCV
w72izECOaAv+pnkVfnyu
=HqBf
-----END PGP SIGNATURE-----

--W0OM0P+/SpWvhefz--

--===============3362735048498532692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3362735048498532692==--
