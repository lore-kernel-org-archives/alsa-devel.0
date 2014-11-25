From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/9] ASoC: ipq806x: Add machine driver for IPQ806X SOC
Date: Tue, 25 Nov 2014 22:03:39 +0000
Message-ID: <20141125220339.GW7712@sirena.org.uk>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-7-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EL5yXklJx2AX5bob"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-7-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--EL5yXklJx2AX5bob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 10:52:46AM -0800, Kenneth Westfield wrote:

> +static struct snd_soc_dai_link ipq_snd_dai[] = {
> +	/* Front end DAI Links */
> +	{
> +		.name		= "IPQ806x Media1",
> +		.stream_name	= "MultiMedia1",
> +		.cpu_dai_name	= "lpass-cpu-dai",
> +		.platform_name	= "lpass-pcm-mi2s",
> +		.codec_dai_name	= "snd-soc-dummy-dai",
> +		.codec_name	= "snd-soc-dummy",
> +	},
> +};

OK, so the CODEC here is actually a dumb DAC with a GPIO enable?  You
should write a driver for this CODEC that imposes the constraints the
device has and manages the GPIO, then it looks like you should be able
to use simple-card.

--EL5yXklJx2AX5bob
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdPy6AAoJECTWi3JdVIfQqEMH/3K6ksTwXoRAHbI6Od5W2lB9
hyuiU05khwQVgdJ93V5V6a5MzVm60VZ3Rpzl8JJ7QsUn9QODZRN4JzZWls6eMy7P
uFmRZ+Ysb89nwAmTNl/cGTWsFwENtkFmwwmz2PUSeyhU7/EwQsAjT2NLL9/a+sP2
dZ/y2edimnrthD1QRGkS+P28pOhuDlpqPbcscDXBhpUcBtXDL+YJoZ7bIxNPMjjy
xRFlrm7ftI+0U5DnZCXi169waN+gzfdOH+IECNCXMV+TEh4/F8j/DcCYWzafV/gp
Ngk1/Fj5GP85YlaRrk4CnETTrEfHA6Z5O32G/r6hJD4+bnTDYd5/jcJ2Cl/IlyM=
=jale
-----END PGP SIGNATURE-----

--EL5yXklJx2AX5bob--
