From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 09/11] ASoC: qcom: Add ability to build QCOM drivers
Date: Tue, 9 Dec 2014 16:07:20 +0000
Message-ID: <20141209160720.GH1934@sirena.org.uk>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
 <1418076073-12623-10-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418076073-12623-10-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 02:01:11PM -0800, Kenneth Westfield wrote:

> +config SND_SOC_CPU_MI2S
> +	tristate
> +	depends on SND_SOC_QCOM
> +
> +config SND_SOC_IPQ806X
> +	tristate "SoC Audio support for IPQ806x based platforms"
> +	depends on SND_SOC_QCOM || ARCH_QCOM
> +	select SND_SOC_PCM_MI2S
> +	select SND_SOC_CPU_MI2S
> +        select SND_SOC_MAX98357A

Any reason for these not to have an || COMPILE_TEST dependency?

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhx44AAoJECTWi3JdVIfQ04IH/RQcQF3sWkegmmrSWSHGT735
VVReUFdGXE7AJAPdiB089Ok6scv4NpG0JhVOkH0S7GFkJfQ+XRLZECZf3qPF0xUD
v2I7hqkSUPD7J6WO0eYr7hxtk8R67KCFB49BmaLuKJzR5BEMxro6lQmnu9BgK8MM
R2jm/2ORdU6qz4qmoeon51gQGN2XbkUOelCxqAweroQbOl2ys27xcsnCyN4bnDWA
YSoDJCqyD2YbU3tQT3cM8FZs3xUzuT4PcXDUtX1VDZCmBHznIdqkywYDnU/rjYpL
MvvGqfFHZ5Ej55BE7VTXe6VA5t53iCn+QXGexyAbXSV0/GNNBgqLInujEJB5FJA=
=2OUI
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
