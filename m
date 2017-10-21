From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Sat, 21 Oct 2017 10:03:48 +0100
Message-ID: <20171021090348.3wjl6nwoiklgdbrp@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zr7fpkts36fgjypc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Takashi <tiwai@suse.de>, Pierre <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Shreyas NC <shreyas.nc@intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--zr7fpkts36fgjypc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:

> +	ret = dev_pm_domain_attach(dev, false);
> +	if (ret) {
> +		dev_err(dev, "Failed to attach PM domain: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = drv->probe(slave, id);
> +	if (ret) {
> +		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> +		return ret;
> +	}

We don't detach the power domain if the probe fails.

--zr7fpkts36fgjypc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrDXMACgkQJNaLcl1U
h9Ar0Af/T7qO4x2xlt8fTJYwi5j7edhrXFLn6k/GrWYw7zcjBkmek5fAICx0ZMfY
zgab49wQk15NIb+NmnghM5KR/wpvsME3FLkQLkEub8SNc6BEEEsQ3HJdRZHsODr+
sbfQeqACEokS4aYdhXZmQr0vBAjV6pSHcpt68QKvbgvOApFk37iNryYzZh1UdEKA
nNovkf5jA4GUha6XM7Q8I8gqpP3llQbprfMOnJ/LEvpsjGxecpDL70ppkfo3drlP
18KTvFhbiXDSqN40U/xROOFqrM3XRgJfyVNffbzRJNX+vCao6cJjqdvXYpsksZq+
fbQS/xsSdxCsjOKkJlsTbh/9oqo3jg==
=a72b
-----END PGP SIGNATURE-----

--zr7fpkts36fgjypc--
