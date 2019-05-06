From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] regmap: soundwire: fix Kconfig select/depend issue
Date: Mon, 6 May 2019 13:40:12 +0900
Message-ID: <20190506044012.GM14916@sirena.org.uk>
References: <20190419194649.18467-1-pierre-louis.bossart@linux.intel.com>
 <20190419194649.18467-3-pierre-louis.bossart@linux.intel.com>
 <20190503043957.GA14916@sirena.org.uk>
 <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hS2jB1L/urRucW8g"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <535dfeac-77d8-1307-0329-33b8f2675bbd@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: alsa-devel@alsa-project.org


--hS2jB1L/urRucW8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2019 at 09:32:53AM -0500, Pierre-Louis Bossart wrote:

> As I mentioned it'll compile the bus even if there is no user for it, but
> it's your call: alignment or optimization.

You can have both.  Alignment is a requirement.  If you want to optimize
this then it'd be better to optimize all the bus types rather than just
having the one weird bus type that does something different for no
documented reason.

--hS2jB1L/urRucW8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzPuqsACgkQJNaLcl1U
h9C3gwf/aCYXhO7xjzbVx9t1Sndb/c/UMHT0O5CXlHTDLFHr1Qjt+C6/EVAM0ku7
LgY7KpSCoMzqDf1AsI/kB2YyjCxC6h/7t0VRLGqulLDxELKXocOqISneW1WjuDrt
UehqoT/opy+sONl7v68Rqf4hAEZ/pM9IPQ6yDFB2HzZ9eqRE7OC6HC5V9NfwX2/q
V3399AowQFYUI9CtlPDkBV/uWEUOysqSLVLUq8gDbuptte2zLy3M+tiycCu/sNpG
9ZUrqC/M7TqjyeX9VT8U0aN1Ij2eL2+eqkR8p6LyUtR7z5e0jH9Spe+tJK1LcwlY
RhcJzggLimdE8hFYlTAtdBaWO+gPpA==
=LwsG
-----END PGP SIGNATURE-----

--hS2jB1L/urRucW8g--
