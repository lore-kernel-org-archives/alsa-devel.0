From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: ad193x: Reset DAC Control 1 register
 at probe
Date: Wed, 26 Jun 2019 12:23:31 +0100
Message-ID: <20190626112331.GB5316@sirena.org.uk>
References: <20190626104947.26547-1-codrin.ciubotariu@microchip.com>
 <20190626104947.26547-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0LPhsWsL1Ga+XLL0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190626104947.26547-2-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lars@metafoo.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--0LPhsWsL1Ga+XLL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 26, 2019 at 01:49:47PM +0300, Codrin Ciubotariu wrote:
> Since the ad193x codecs have no software reset, we have to reinitialize the
> registers after a hardware reset. For example, if we change the
> device-tree between these resets, changing the audio format of the DAI link
> from DSP_A with 8 TDM channels to I2S 2 channels, DAC Control 1 register
> will remain configured for 8 channels. This patch resets this register at
> probe to its default value.

Would it not be more robust/complete to have a set of register defaults
and write the whole lot out rather than individually going through and
adding writes for specific registers as needed?

--0LPhsWsL1Ga+XLL0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0TVbIACgkQJNaLcl1U
h9B5dQf/cxYmztEqqJW7n7EhRXlsxlPo8LHdNVs1D7b4aSBNJZTPs4ydlpRlCQga
MQ7cYmznzzNCJSNwIBi/ra/arsQWHoyM1gHaQH01vhjaEoMYgm3Tbtn2IDR16tR4
sU1ffhFgQmve2BD6q5fRVYdZldcvJuBkY8fnYO5BktFrQXil/YiQXudVjAiP0/tW
tZMoigVLniRxERF9FwQ5XWzVeW8Pa6/tSZ1xAs+MyXNdvXa9jrL1Wrwze6S/i12U
yT0QVxnVBhOBZfgH1bGHO8V3Al2lAn6P1n9uHfvl63HeZgnPp6qfScLVkXLzCpO1
hb2duf3THhcgLRM+qZA88qsgyyRW4w==
=ZAHw
-----END PGP SIGNATURE-----

--0LPhsWsL1Ga+XLL0--
