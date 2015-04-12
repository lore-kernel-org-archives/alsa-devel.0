From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: atmel: Improve machine driver
 compile test coverage
Date: Sun, 12 Apr 2015 12:41:06 +0100
Message-ID: <20150412114106.GY6023@sirena.org.uk>
References: <1428743779-25581-1-git-send-email-lars@metafoo.de>
 <1428743779-25581-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8639184081165063050=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A70E260584
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 13:41:16 +0200 (CEST)
In-Reply-To: <1428743779-25581-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8639184081165063050==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6GuvwqyohCKWtk5k"
Content-Disposition: inline


--6GuvwqyohCKWtk5k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2015 at 11:16:19AM +0200, Lars-Peter Clausen wrote:
> The Atmel ASoC machine drivers don't have any compile time arch dependencies
> anymore. Make it possible to select them when COMPILE_TEST is enabled to get
> better compile test coverage.

Applied both, thanks.

--6GuvwqyohCKWtk5k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKlnRAAoJECTWi3JdVIfQoNcH/1EffPwFC5fPS0ntuGEUsw1f
f39hd4Yl2fu/SeBfwWu5DTmbh7DPk47Mt686V+qPPLaEePAzPRuRzBmPlHmc57l2
5WRAfQkZQfcEMhEuhNuuVQdF4yWDrY08qnP3ACbU18aO9A0W/uj+J27iXAv96Sow
uqNZzf/CyKoRg12+PCYoTSGqTQkaxRJCkHa2GMPnbdteXwySzNC0MFyBAk1yxRjR
nGvHrJnjFuB9J/EG4euwSw3OAdSBqD601KgSuB3e/sIJS8KLAG21lG/1zWWxqNm+
33P1Qka2/oK18EbMN2DcfOs1Q95zE2MDTv1U/h8RjijK7ulczSMkbkchjmoNN3g=
=4a5l
-----END PGP SIGNATURE-----

--6GuvwqyohCKWtk5k--

--===============8639184081165063050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8639184081165063050==--
