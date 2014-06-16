From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] mfd: arizona: Export function to control subsystem
 DVFS
Date: Mon, 16 Jun 2014 17:48:58 +0100
Message-ID: <20140616164858.GI5099@sirena.org.uk>
References: <20140609150013.GA5229@opensource.wolfsonmicro.com>
 <20140609150226.GB5229@opensource.wolfsonmicro.com>
 <20140616164242.GB14323@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A+YNfBJfL1GjoVjN"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140616164242.GB14323@lee--X1>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, sameo@linux.intel.com, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--A+YNfBJfL1GjoVjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 05:42:42PM +0100, Lee Jones wrote:
> On Mon, 09 Jun 2014, Richard Fitzgerald wrote:

> > +	if (arizona->subsys_max_rq != new_flags) {

> I don't really get this.  What's the point in passing the mask
> parameter - I don't see it being used for anything in this routine? No
> matter what is passed in you always just turn on the same regulator.

> What am I missing?

AFAICT it's a bunch of different independently selectable requests for
the voltage to ramped with any one of them causing it to happen.

I did wonder why this wasn't just done by refcounting, that's the more
normal pattern in the kernel, though I guess it's possible some of them
need different ramps on different devices.

--A+YNfBJfL1GjoVjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTnx/3AAoJELSic+t+oim91vgP/3xqnq3yz4symAO68ZBTjY+E
wbzAmXGb8GU9Zjkcl/4A1j7OCvdc5d+ZSKBQkVbG4VuB/umDyt73H7nw/VNfiI8d
mlSb3Ewh9+BIL9gedk5RNV/JHZvgcqmzmKASQWoC32p8h4wS9emhov2OQOy70Ysc
BvD4lm8vjD4sBwDZKhTCMrWnO2kj6JVtH2BPiwnKwW635d/SH98nfi2/+hPorC2n
FYXeleMNlT3kiLuqe2VBQmSx99aSQoqVj8TuzBD18kTgQUc58o8O3JE3ixOmafyh
BVCDtb0ZXJvhE1gyJCNAEaDPgRGhP0jTdl/S48mtEBsaHj7ZaoCYYio8292lX/6F
CRArhYuF7VK1JuYDQMJqRqwvPHRGqxVlntPxekR6S+EdyI5BPoO7ehx+O3pq+1Tv
z33TdzfzSlaRR17l7NdFQj2jLx+ljGvRnlDcNzi2mqxJe+Z1X0d9OQw5ajh8jF3K
veMrBuq/5bJ6mBSjQ2aFiYCEkI6n0dC/RhW+p/kHt7o5/RZIKGSPDHHDeEuJsuHM
i9XFVmt58ky0ZE1EFgR4olx87sEAmvFOrgwMWbReSZcHBTwC4IaRuyHbrmopGyOt
3laIB6rzQi7YOlp51WbLPyUIFK45zPF84GgUVkeB8C+k1m2izg6goq6NuFQr3t3n
n4Tn3f65/YpV2eGAmgF9
=nMGS
-----END PGP SIGNATURE-----

--A+YNfBJfL1GjoVjN--
