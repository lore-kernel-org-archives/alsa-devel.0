From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V4 03/10] ASoC: qcom: Document LPASS CPU bindings
Date: Sat, 7 Feb 2015 06:18:23 +0800
Message-ID: <20150206221823.GF31311@finisterre.sirena.org.uk>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <1423169626-22166-4-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423169626-22166-4-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2015 at 12:53:39PM -0800, Kenneth Westfield wrote:

> +- qcom,system-clock-shift		: Add this bool property if the default
> +					  frequency of the system clock needs to
> +					  be reduced.
> +- qcom,system-clock-shift-compare	: A numerical value used to right-shift
> +					  the default system clock frequency for
> +					  comparison with the target bit clock
> +					  frequency.
> +- qcom,system-clock-shift-amount	: A numerical value used to right-shift
> +					  the default system clock frequency.
> +- qcom,alternate-sysclk			: Add this bool property if the default
> +					  frequency of the system clock cannot
> +					  divide down to the target bit clock
> +					  frequency.
> +- qcom,alternate-sysclk-bitwidth	: A numerical value representing the
> +					  sample bitwidth which requires use of
> +					  the alternate system clock frequency.
> +- qcom,alternate-sysclk-frequency	: A numerical value representing the new
> +					  system clock frequency to use.

None of these seem like they are appropriate for device tree properties,
they appear to be choosing a specific clocking configuration which is
something that would normally be done as part of the system integration
in the machine driver rather than in the DAI driver.  This binding won't
work in cases where the clocks are being changed at runtime and would
limit systems where that becomes possible in future.

Further, the interface seems too low level - it's specifying individual
dividers and so on which would normally be things that can trivially be
calculated or inferred given the input and target clock rates.

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1T2vAAoJECTWi3JdVIfQDYEH/0bFK5D7l5T902ASpsFINTPt
G4CByMDNqKzDcqKMiAmzC9mffbc6uYDpvP54eaoehzYx2kiOjPp9ps49ac5l6zS5
ETmIqAnhChpKGmfO8A4gNtW12uSLHY83HigZd9LoOwk7227tQxh5za8kHAijxkes
mXqhfHS7krbniUOb657hatC6Z5vT6uD8EfjYvOW8VZA9u+vtks8lkPKVIVNKvi1A
W1N1QCLo2O+u+ZNNVI2Tf0Hg0QtrjJCkDj/a8ByKZA2sKZpC5ugbZ+iIrcPSwARf
pKbhIroWnGgQBVYJVBpcfgSv/YlK+v4Rpf3nAiXcBkfVwygdPjoJYuyFiMvEJMQ=
=i3mm
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
