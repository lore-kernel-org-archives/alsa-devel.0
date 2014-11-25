From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/9] ASoC: qcom: Add ability to build QCOM drivers
Date: Tue, 25 Nov 2014 22:07:38 +0000
Message-ID: <20141125220737.GX7712@sirena.org.uk>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-8-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cLQvRfYaHwHCueo/"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-8-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--cLQvRfYaHwHCueo/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 10:52:47AM -0800, Kenneth Westfield wrote:

> +++ b/sound/soc/qcom/Kconfig
> @@ -0,0 +1,43 @@
> +#
> +# Copyright (c) 2013-2014 The Linux Foundation. All rights reserved.

Is there some kind of copyright assignment on file or something?  It's
weird to have someone else without obvious authorship own the
copyright...

> +# Permission to use, copy, modify, and/or distribute this software for any
> +# purpose with or without fee is hereby granted, provided that the above
> +# copyright notice and this permission notice appear in all copies.
> +#
> +# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
> +# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> +# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
> +# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
> +# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> +# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> +# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

Please just license the file under the GPL, all the drivers that get
built from here are GPLed - I can't see any reason for this to have an
odd license.

> +config SND_SOC_QCOM
> +	bool "SoC Audio support for QCOM platforms"
> +	help
> +          Support for audio in Qualcomm Technologies SOC-based systems.
> +          Say Y if you want to use audio devices that will run on IPQ806x and similar SOCs.
> +

I'd expect this to be the first thing in the file not the last.  Why are
things in here bools, shouldn't they be tristates?

> index 0000000000000000000000000000000000000000..0a74177df75f7aa5f7fbaab35da9b92689fa3d6a
> --- /dev/null
> +++ b/sound/soc/qcom/Makefile
> @@ -0,0 +1,11 @@
> +#QCOM SOUNDCARDS
> +

This appears to be CPU drivers as well as sound cards (as you'd expect
for machine drivers) so the comment isn't quite right - just remove it.

--cLQvRfYaHwHCueo/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdP2pAAoJECTWi3JdVIfQgzgH/1G4c/kwG6+/EwQCxwAVK3PZ
ipvWtstY/0vxzRMfXUL42oBy0NHenudNLmcAZ8bhaAejxG2G7gxXdMvonwFssx+4
4JQBkJ5WyY7JWm/LZVINDAxTaJllEkCPmVoI4rUXt4W2Zi5VlOa5Xt3CsQIcW3gp
D8Roo4eUjjSBPGrzA2jIvBqR5z0YIA9c/EtBO9/dZVzmfE0/py8OpMfX9GLyDyv9
ErLAumSZTVpq+Ar/+J4ES/Odo8hrwG/1KFYVrFJICrGUnlg0turS2dlQCVS5sWGO
5Sf8cVw+bRbpq7MVC82/EzZiyWuVrr3SHrnTGsNJyEXirsnfz+EfHuQG4usxmco=
=+oBh
-----END PGP SIGNATURE-----

--cLQvRfYaHwHCueo/--
