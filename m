From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: add DT bindings documentation
 for ROHM BD28623 codec
Date: Wed, 21 Feb 2018 12:13:54 +0000
Message-ID: <20180221121354.GG8334@sirena.org.uk>
References: <20180221043311.25840-1-suzuki.katsuhiro@socionext.com>
 <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8949939869198474218=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 80961267564
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 13:13:59 +0100 (CET)
In-Reply-To: <20180221043311.25840-2-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8949939869198474218==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hcut4fGOf7Kh6EdG"
Content-Disposition: inline


--hcut4fGOf7Kh6EdG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 21, 2018 at 01:33:10PM +0900, Katsuhiro Suzuki wrote:

> +Optional properties:
> +- VCCA-supply : regulator phandle for the VCCA supply
> +- VCCP1-supply: regulator phandle for the VCCP1 supply
> +- VCCP2-supply: regulator phandle for the VCCP2 supply

These should be documented as mandatory unless the device genuinely
operates without power which seems unlikely.

--hcut4fGOf7Kh6EdG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNYoEACgkQJNaLcl1U
h9A53Qf/WmJ8q4PvAqNeknQqNme9JDwOBoQujRRtz76hfLuFEw4mUHLzudT9RE9p
hOHPYtcBlcMgPGKRkW5E5OUxleVhjaTxrpBaHTRTEkbEdAfycje6RtqjqQ2sezfi
xyzMBu0cf1ynMV5zIVqOSlsPVGX6Ih0Ypx4JsHSQ2np9u4CqSzVYIcuUpgHEtaiN
9u+xVjnmr1NomCYFrpZWbtruqQMpsj0bYSPsU33fgy+fiVMaRn3qNRpEXgiOfJtJ
R+KmdvUs6/VfhGY1oQS2E/JF46ldohQGCLlgGkvwfsT4OLO8BwL/UZ0hVcG/Q0Qv
QYicnuQjfzlC7HjlbtZ6/lAfYZ5oYQ==
=5fLQ
-----END PGP SIGNATURE-----

--hcut4fGOf7Kh6EdG--

--===============8949939869198474218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8949939869198474218==--
