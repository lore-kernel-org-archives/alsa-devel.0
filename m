From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Wed, 14 Aug 2019 10:08:56 +0100
Message-ID: <20190814090856.GA4640@sirena.co.uk>
References: <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190814041142.GU12733@vkoul-mobl.Dlink>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 09:41:42AM +0530, Vinod Koul wrote:
> On 13-08-19, 20:58, Mark Brown wrote:

> > There is something to be said for not abusing the TDM slot API if it can
> > make things clearer by using bus-idiomatic mechanisms, but it does mean
> > everything needs to know about each individual bus :/ .

> Here ASoC doesn't need to know about sdw bus. As Srini explained, this
> helps in the case for him to get the stream context and set the stream
> context from the machine driver.

Other drivers interoperating with the Soundwire DAI might want to do
something, it looks like that's the case for SOF.

> Nothing else is expected to be done from this API. We already do a set
> using snd_soc_dai_set_sdw_stream(). Here we add the snd_soc_dai_get_sdw_stream() to query

Well, if the API is not expected to do anything we can optimize it and
just remove it!

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Tz6UACgkQJNaLcl1U
h9B7fgf+PvYlFGtuBj37wZOpu/dVlS5vmQbNkNVdhUbDbjO5oYTemRTIB5PukA4R
tO6idhVUsIlMWCvN6MZKJXPGgZfB7Heu84YAn3GvBmIFmY3J4c3QwsD1pIf1gmGH
X+xV//bbiewRLrA7LvbQalQanUpCVVlCrjsJ8FeDg+PFs4wPO9gE2N7pevVhzknu
tIaB6HO88+eAx0FfUUvXjWKo5qov/1LjhsI8Z2DJuKfpi9zfBatUz+/Q75d2WEJS
0G8ATi/5aZueU+YB1T6xdQtkS/lPIFRYN7dyMZrLyidtwkttiii8UzStBh64F6QO
MSoasP9IToaTUPdzqxcH3bIYBg2R3Q==
=pxWA
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
