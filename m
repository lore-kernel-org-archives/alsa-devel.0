From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000
	machine driver
Date: Mon, 5 Mar 2012 14:46:01 +0000
Message-ID: <20120305144601.GQ3224@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6079259155072799630=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4AA26104285
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 15:46:05 +0100 (CET)
In-Reply-To: <1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============6079259155072799630==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U5J2I87mWnf1KeOw"
Content-Disposition: inline


--U5J2I87mWnf1KeOw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 05, 2012 at 10:31:05PM +0800, Shawn Guo wrote:

> +	ret = snd_soc_dai_set_fmt(rtd->codec_dai, SND_SOC_DAIFMT_I2S |
> +						  SND_SOC_DAIFMT_NB_NF |
> +						  SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret) {
> +		dev_err(dev, "could not set codec driver audio format\n");
> +		return ret;
> +	}

This you can just set in the card struct, no need for explicit code at
all.

> +	ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
> +	if (ret) {
> +		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
> +		return -EINVAL;
> +	}
> +	ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);
> +	if (ret) {
> +		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
> +		return -EINVAL;
> +	}

It seems very odd to have namespacing on the individual property names.
Why are you doing that?  The properties are already defined in terms of
the device binding.  Though everyone else is doing it so not really a
problem.

> +	/*
> +	 * The port numbering in the hardware manual starts at 1, while
> +	 * the audmux API expects it starts at 0.
> +	 */
> +	int_port--;
> +	ext_port--;

Should have error checking somewhere to make sure that the user
remembered this.

> +	imx_audmux_v2_configure_port(int_port,
> +			IMX_AUDMUX_V2_PTCR_SYN |
> +			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
> +			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
> +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> +			IMX_AUDMUX_V2_PTCR_TCLKDIR,
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));

I'm not sure we've really gained much from converting to a platform
driver given that the device just registers something globally...

--U5J2I87mWnf1KeOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVNGjAAoJEBus8iNuMP3dm/EP/R/sj4QxcMIR1LFDlZdo0nmo
ExwEHu+xdBTsWbQvMYO+USAg4bQWF40KlcwHUnXNTAkXhYyDFhWapJZTfTyE4FMZ
oqInS4R9iV/nAscB5ExZ+cNKP4c9mwlqjx/VzEKOmuHhekH2ZGTgMqfk38b1Ugmf
qZoh7gh6Do4gc0/0j0A5/Yh495+psM/P2F4Kco7lBr5wDr9yb57qqmF2e7nGuRsP
4jibsR4Qx9ELH2NISH84YQeG565e/x/H073qZ8IGW94VEUGr95lhs0ZxAUomfBoJ
JFoCre+0c85lb0zh1yf6d7DNHbiJvjzayBXA0mzPCaHK5dhWIXr9zX130xUCAxBX
Ar+uGihV4sEBvjWAXpOSdqaaTx1A5Ww8xdlohj5LXpTPw18VAZgTU/J8lS48pMKh
Pw5/RS6LD6smtBmFLWh6C1gOTQj3knq2WdNHn/V93SRDfzJ5nBdjLJV0w4mEz3iE
6Z+B4J86cBDpJV604S+7xZv1HgR6WhmQgcmvSAEhRknqwS2wqFo2LmBKFRDkF/gX
UQ1J58fIf5pUARuMkf8+XJHqTZbB3+hDJUdigX6uc6h0AQz9/+z9V7vq70pdyH2p
GulHNRBdRWOMg0ofWV2uDoCVWYpHVqPNM6SINx4dREpD4QYp7habpuB4fQjbo5TW
w6Bp7AWPqDn0O1aG44PH
=7B2k
-----END PGP SIGNATURE-----

--U5J2I87mWnf1KeOw--

--===============6079259155072799630==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6079259155072799630==--
