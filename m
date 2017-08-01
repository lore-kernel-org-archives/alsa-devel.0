From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] drm/bridge: adv7511: restrict audio
 sample sizes
Date: Tue, 1 Aug 2017 13:28:40 +0100
Message-ID: <20170801122840.6demhukafhtpeaby@sirena.org.uk>
References: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
 <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
 <7d700845-da72-5c40-31f9-c3faa7ca93a2@st.com>
 <ce018632-0b7a-7e34-6a3d-c191155a17ae@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ddnwx6gmg6fvnqle"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ce018632-0b7a-7e34-6a3d-c191155a17ae@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: alsa-devel@alsa-project.org


--ddnwx6gmg6fvnqle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 01, 2017 at 01:24:03PM +0100, Srinivas Kandagatla wrote:
> On 01/08/17 09:42, Arnaud Pouliquen wrote:
> > On 08/01/2017 12:49 AM, srinivas.kandagatla@linaro.org wrote:

> > I already used ADV7513 and i did not observe this limitation.

> > I had a look to ADV7533 data-sheet. it should support 32 and 64 bits I2S

> ADV7511_REG_AUDIO_CFG3(0x14) register definition in datasheet and the code
> in this driver suggest that It only supports 16Bit and 24Bit samples.

The amount of data it pays attention to in the frame is not the same as
the size of the frame.

> > format bus, with 16 or 24 bits precision sample. So it should support
> > SNDRV_PCM_FMTBIT_S32_LE and SNDRV_PCM_FMTBIT_S32_BE

> > As example, if you configure bus in Left justified format with 24 bits
> > sample length, 32 bits application samples should be truncated to 24
> > bits samples at ADV7533 I2S interface level (LSB dropped).

> May be we can do that to make the user happy but isn't this just truncate
> the resolution to 24Bit then?

> And it's a false indication that we are supporting 32bit samples.
> Which am not very happy with.

This is what the sample_bits field in the DAI structure is for.

--ddnwx6gmg6fvnqle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmAc/cACgkQJNaLcl1U
h9AHxAf/cfD2Oxtod1b0UknZgBlPpTK/wQyWhWNHuyCLB6Jk5ZajYBqE6B1ZkgtX
FGLxq+8K5O2vtOGI7N7d/tthXi+dyZyYfD95UujbB3xADH8QDr002h9SDS0RASE4
vPiSyYsrcB2BuS93fQ7cVnyYgRGr1yUPjz8/9vJjgrVQBMMh2hudNUJdzWo9yArB
RDzyhefYzrBNE7uWfYTW3X1NYIGaKYPcMyI1Mn3ewWEe8Z4ZKoCS3UKzpUTSWP9A
+K/5u8f9GaTyxAjAHAyHg3NP0lUyPTkW+zIDUibm/DZxbXiE7rFFsZBW27gJ8um9
CaDTKvwNpHOBDRkH5kzJRI87qoCZyA==
=YlHQ
-----END PGP SIGNATURE-----

--ddnwx6gmg6fvnqle--
