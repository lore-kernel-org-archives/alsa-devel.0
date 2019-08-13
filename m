From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Tue, 13 Aug 2019 20:18:27 +0100
Message-ID: <20190813191827.GI5093@sirena.co.uk>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 02:15:18PM -0500, Pierre-Louis Bossart wrote:
> On 8/13/19 1:06 PM, Srinivas Kandagatla wrote:

> > sorry for the confusion. It was too quick reply. :-)
> > I was suppose to say sdw_stream_add_slave() instead of set_sdw_stream().

> ok, so get_sdw_stream() and set_sdw_stream() are not meant to be mirrors or
> both implemented. It's just a helper to respectively get a context or set a
> context but a get-modify-set type of operation is not expected.

> Do I get this right?

This seems like it's going to be confusing...

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1TDQIACgkQJNaLcl1U
h9CEJgf/WNOBdWoFpepTAzRC/SOiL/VJjBnXIPHLxH3lof4Yx/1pbBvUPjYOwCHy
bBVUntfQnRhu7zgAjp1M5uC97VkFZbrj9s+32Tvcb43ye0dto5d63K3c3edekkjQ
ngfPnOA+yWL1BcfMLOAGY3OmTBIuUknyiMWfiLUVIDozt5dTHB0f9W02Qclp7J5I
BtoyMIUdvCVbUMc0KnQkZ19K/IZqBvqNQ6ca9T8gn3K50X30ab0jBgsbm1IXckpH
zmV/b4T553l8j47i/CyXS6K4trYVQ06tUcqyIRWzJZrPHQ/Ji/N62kTq2SOQV56w
nL8ZqN1yL7MUwJM3Qu7yx1MpwPJYYA==
=Xi1X
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
