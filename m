From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 07/14] regmap: Add SoundWire bus support
Date: Fri, 5 Jan 2018 17:05:52 +0000
Message-ID: <20180105170552.GF9076@sirena.org.uk>
References: <1513230585-13882-1-git-send-email-vinod.koul@intel.com>
 <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HCdXmnRlPgeNBad2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513230585-13882-8-git-send-email-vinod.koul@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, ALSA <alsa-devel@alsa-project.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, alan@linux.intel.com, Charles Keepax <ckeepax@opensource.cirrus.com>, Sagar Dharia <sdharia@codeaurora.org>, srinivas.kandagatla@linaro.org, plai@codeaurora.org, Sudheer Papothi <spapothi@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--HCdXmnRlPgeNBad2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 14, 2017 at 11:19:38AM +0530, Vinod Koul wrote:
> SoundWire bus provides sdw_read() and sdw_write() APIs for Slave
> devices to program the registers. Provide support in regmap for
> SoundWire bus.

I can't apply this because you've changed the soundwire Kconfig in this
patch :(

--HCdXmnRlPgeNBad2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpPsG8ACgkQJNaLcl1U
h9AXQwf+L0xAWV6Vu7FscpyRL3npnaA9L3r+A1Q5M2AfVlw8G6x1mHRlk4eGFrNf
jdQuX4OqEgVpSaTZr4gOa4aerflZ71cFcuITafVKUA6KKX9M8hgd3q4vJGJEmJxw
w3AwGg21Rjq7JG1NCC55RG3Sz0Jz3RqoZY5ihMmmJ32YDzcQi04O6xLcLlYbUZfv
gWV4I6E+mOA/NtTYik5gLTVrAEXzLPP+bcB2eflR6sWIQYBZV52ZhL+nI3zJpWAj
Yo9P8MDAaJrs++ERmoBJ/2RJ/ykEFVDvKfd3MS5agC/RMjUNIh3sBuykC2QhlSIX
kvTUIJ2Dfq0yJqWckRTIE21neo3lTg==
=g57T
-----END PGP SIGNATURE-----

--HCdXmnRlPgeNBad2--
