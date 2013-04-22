From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/8] ASoC: generic-dmaengine-pcm: Add
 support for half-duplex
Date: Mon, 22 Apr 2013 11:28:00 +0100
Message-ID: <20130422102800.GD30351@opensource.wolfsonmicro.com>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3267840597174432350=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C2D692610CF
 for <alsa-devel@alsa-project.org>; Mon, 22 Apr 2013 12:33:53 +0200 (CEST)
In-Reply-To: <1366478947-9377-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3267840597174432350==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 20, 2013 at 07:29:00PM +0200, Lars-Peter Clausen wrote:
> Some platforms which are half-duplex share the same DMA channel between the
> playback and capture stream. Add support for this to the generic dmaengine PCM
> driver.

Applied, thanks.

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdRCfAAoJELSic+t+oim9WtcP/jlk7wKlE/0WVy5jCxMCZf9q
TEUxERgZDUlUoG1bMsX7qcsYSfikIgd0kBEv182begKBbtEvf7txc2HKKSBmWTKr
HKbOE2KsspWMq0ZjOytVOA2Q1BUX2UcDY/IBpE5rRXAvwSy404OBlzbJkwUSPjpD
te9RLSsB7tzG2F5JF0RpV2L+nvfNPoGjie3mZ8O5877NhYf1xCqhiCTXD2S/ajih
GguI1yEkmR2Nkvv3uAyk4gq5MeMxejgQRSPPGi8bLG1B6TY3zHQGAgdLdSpU+kMH
AxOjy+4EIn+bsvgxk1if6Qr1uRuRiMquvs6qEdJgz1MTJK/zzhED8cUP5evZMN8l
FYkv8UqstmI9orQDRcB0f1f1c5GuIhJFSS1QMdVYRD0Bd+lsiDiCoKhN3FocYY+b
ullMKMOHAeU1iqDgFoeLuHZ6v5QPRQebywOBsYKVbFN9cf6sbInqYDG5b3sE/bY0
kYlL3Tftn1IRxXEMh0/dXN4CT9AGSUjuOKVTPzxJhCgVRw6V+Ja/nRFhsUG6WAIK
XO0qYk3lKTKCusKOzsu51ZUvcShlAs1OETK+Otc7VRIL2vkrA4c/jX2aM++B4cg9
GN9JvNAUbb5aAR7/0zhW6jRgviN3zfpDFQMikTaafqHMVsNSjak9ZS4iNMfnj4/t
eBKKmqEgDse/ezLDp/Nd
=6i44
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--

--===============3267840597174432350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3267840597174432350==--
