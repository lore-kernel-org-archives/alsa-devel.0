From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [Patch V4 00/10] ASoC: QCOM: Add support for
 ipq806x SOC
Date: Thu, 12 Feb 2015 10:53:41 +0800
Message-ID: <20150212025341.GT2593@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <20150206223229.GG31311@finisterre.sirena.org.uk>
 <20150209064511.GB19870@kwestfie-linux.qualcomm.com>
 <20150211022634.GO2593@finisterre.sirena.org.uk>
 <20150212010551.GA7330@kwestfie-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OowMmFE4aK71mEhh"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150212010551.GA7330@kwestfie-linux.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--OowMmFE4aK71mEhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 11, 2015 at 05:05:52PM -0800, Kenneth Westfield wrote:

> Replacing DSP-based drivers with LPASS-based drivers would be something that
> should be handled by Kconfig selections.  For the DT, the DSP-related

No, it shouldn't be.  We should have the ability to build a single
kernel image which will run on many systems, including both your
system with a DSP and other systems without.

> nodes and the LPASS-related nodes shouldn't overlap.  There should be a
> DSP-based DT binding and a separate LPASS-based DT binding.  Tying one
> or the other to the sound node (but not both), should work.

The selection of DSP use sounds like something which isn't part of the
description of the hardware but rather a runtime policy decision (at
least in so far as non-DSP is ever an option).

--OowMmFE4aK71mEhh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3BW0AAoJECTWi3JdVIfQHskH/jrSXZ+RgMhL/KtEwenuYO3D
ZJ4Ts5kKJRjgid3y6wFQDbLzDJrVaboFq4TGpK/y0q+ExHOcUDA/jGMDhiv9+p9k
VUd7xG5N63CVNatbNMOyPCGFz6iqGTi/X60ThmeJiWzJHv4bfzOetNom3COhnwHd
1T5/QXxLnT95c6m+zmBQsfEPmeqd/SonHtuompCLLCWKyE6SmYI71jMXyApMXudB
yM9A+VkDQF8qcJLZ+9hFlQt1Hnezy7N2+vGxdH3d2ZFDrjeuzrysMF2LMw9pkkLd
uxgnlCZBeJcYjPIXoGzs0E/kBGvvQqLj2OHw7Gv8g8WSnnVMG/nSIRb1DATsjSY=
=3GOw
-----END PGP SIGNATURE-----

--OowMmFE4aK71mEhh--
