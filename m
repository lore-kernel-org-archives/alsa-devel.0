From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v5 2/9] ASoC: sun8i-codec: Don't hardcode
 BCLK / LRCK ratio
Date: Wed, 17 Oct 2018 10:38:20 +0200
Message-ID: <20181017083820.bmxu7j3ctbcmzh36@flea>
References: <20181017073813.14127-1-anarsoul@gmail.com>
 <20181017073813.14127-3-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513455602156464460=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B7002675A4
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 10:38:20 +0200 (CEST)
In-Reply-To: <20181017073813.14127-3-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============1513455602156464460==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wpot4shdyup6zeg6"
Content-Disposition: inline


--wpot4shdyup6zeg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 12:38:06AM -0700, Vasily Khoruzhick wrote:
> BCLK / LRCK ratio should be sample size * channels, but it was
> hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).
>=20
> Calculate it basing on sample size and number of channels.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wpot4shdyup6zeg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvG9PsACgkQ0rTAlCFN
r3TUAw/8D6OARunzGDzkB7vFjWrGmvFUvye4ER/bBn4wI/kt44DM53GL5h4P70gO
iHw4pV2l06mgynyZ3PFCcLn1rwqpfT7lKBpH4OXonTV0L4W2lSWqZNk81QTdPjJ3
PFC1cz1f51XxsjZK/ATffW1c+V7daEeDLdmNhP16rS3m+BYS8UEgPJX9c08Djuti
FpX5WNDL5GBwufICJnAtIa3VqBXmyOzCosGIZ4vUpDcsKsKvHMcP0mY9uv2GcESe
89gdKpEsbRqozCiDkUcwzuts8NeS890tTri7pmEtJz6Ou27da5g6mEwurHs4ZVjW
577JsvtbiANAhVMLyYHemWgqz/EY5He/dExwH/zgNMxVcrfXjz5e4scHUMbq+Swu
skD1ZqbyQqp0iVoXISGGJVOPSXz+WIIgNZRRuokyBhzzA714Vt4/7vTnt29bbyut
aVec+QUHC+SI+ni42oJF7CsVSkVPavUFbFtxUwrChr1HS0xl2tJN3WRMRzYG6D0K
fDLYg8EiLjcxbtmvrPjGLN7SN7TJ+wzhEmbY9R3bStLo6ljetEdlyaSI5LS9zhn1
+W8X5BrkK86QVorhycfyYufUSjJnATU5gMJuhDQm2U2ESGa0EiQyGI2yNq3sp/gO
dpYKgvfQEvv/lLDxLxV4wxQ/FOEu7tQbt2mqG4e03W5audoPthU=
=G+lj
-----END PGP SIGNATURE-----

--wpot4shdyup6zeg6--

--===============1513455602156464460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1513455602156464460==--
