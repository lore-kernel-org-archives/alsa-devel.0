From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/3] Fix jack detection for Chromebook
	Pixel
Date: Thu, 18 Apr 2019 10:07:14 +0100
Message-ID: <20190418090714.GB6702@sirena.org.uk>
References: <20190405204257.87095-4-fletcherw@chromium.org>
 <20190415194557.9182-1-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0898098927781472221=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3AA83F896E3
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2019 11:07:21 +0200 (CEST)
In-Reply-To: <20190415194557.9182-1-fletcherw@chromium.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============0898098927781472221==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 01:45:56PM -0600, Fletcher Woodruff wrote:
> Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.
>=20
> This patch changes the irq implementation to support polarity flipping
> and fixes the configuration code so that correct GPIO pins are read
> from ACPI.

I only have patch 1 here...

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4PkEACgkQJNaLcl1U
h9AKBgf/d6flxv24JGmWelSWiY4bgbJoRjqeAQSiS+Vl86GgHlxJlsZ9GGS1okMX
JGvRgvtmaAVYSlyaCq/HPj6OBdDbxZkkzFgeVbP29akcS3l4zaDhwX04N9Ae5lHU
FzEUrhW/QkOrhFqxD6H8Y/K/gimOWH2Pt6vK6uRvbk58+VCCe6X3Vtq1dbagR8a9
zFMCOru7kGfrrcsl9VXnBkFVlivx36Mnakoh2RiVEPz5NHlGkURWpiHQY+B0qrtX
kx4Z2YF8QKrekCFUPzbu8gDYslAql/e8ngmjM268OqSGiFWXC73jT7rW1nijftaN
BG+679ghjWE0qX17Up/cjQLBbi0MAQ==
=vBBN
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============0898098927781472221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0898098927781472221==--
