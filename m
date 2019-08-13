From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Date: Tue, 13 Aug 2019 20:58:04 +0100
Message-ID: <20190813195804.GL5093@sirena.co.uk>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart wrote:

> Indeed. I don't have a full understanding of that part to be honest, nor why
> we need something SoundWire-specific. We already abused the set_tdm_slot API
> to store an HDaudio stream, now we have a rather confusing stream
> information for SoundWire and I have about 3 other 'stream' contexts in
> SOF... I am still doing basic cleanups but this has been on my radar for a
> while.

There is something to be said for not abusing the TDM slot API if it can
make things clearer by using bus-idiomatic mechanisms, but it does mean
everything needs to know about each individual bus :/ .

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1TFksACgkQJNaLcl1U
h9BHfQgAhhh0D7Hg5E7dHFAw9gfqCTOCQFEV16Tm0f23eAZ2yPanGpNNC0hohDnH
y77jzS/Zh0WxkcN5gH7rQI0bTrbDVeZpQd0+Wo1egQK9eqfVkjZi+gE2O8v/VjCW
Hcou9+7P7205uP/LB7vuMzVbhKpTF4fPpbhIuJ44MV39BO+sQ+nptMl4ialTd/Y2
kjLdoCl/v6TIAY3GztKKmOvUo58xPak85st45COal2f5bUIBbKxs1Ss/x8VMSPlE
OvPxl5aUzKuFFiVXGekHr+hR/INMri9LWuBQpqrTatdyS0P2p/Sc/r9oNzrl8z+7
PKRpKAk3EYaOsSo49DWaJw3wREGyqQ==
=REil
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
