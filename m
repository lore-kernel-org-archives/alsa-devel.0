From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
Date: Tue, 9 Jul 2013 15:59:17 +0100
Message-ID: <20130709145917.GA27646@sirena.org.uk>
References: <1373372929-17800-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-1-git-send-email-richard.genoud@gmail.com>
 <1373379933-32749-2-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6669786607820216829=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1373379933-32749-2-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss@lists.ozlabs.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6669786607820216829==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BqlgNdmPmeObzZTR"
Content-Disposition: inline


--BqlgNdmPmeObzZTR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 09, 2013 at 04:25:27PM +0200, Richard Genoud wrote:

> +/*
> + * Authorized rates are:
> + * Rate = MCLK_RATE / (n * 2)
> + * Where n is in [1..4095]
> + * (cf register SSC_CMR)
> + */
> +static unsigned int rates[] = {
> +	8000,
> +	16000,
> +	32000,
> +	48000,
> +	64000,
> +	96000,
> +};

Shouldn't the SSC driver be enforcing this constraint if it comes from
the SSC hardware?  If the clock is reprogrammable the usual convention
for drivers is to not constrain if the clock is set to zero so a machine
driver could remove the constraint.

> +	ret = atmel_ssc_set_audio(0);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev,
> +			"ASoC: Failed to set SSC 0 for audio: %d\n", ret);
> +		return ret;
> +	}

Shouldn't this be a parameter in the DT too?

> +	cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
> +	if (!cpu_np) {
> +		dev_err(&pdev->dev, "ssc controller node missing\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	at91sam9x5ek_dai.cpu_of_node = cpu_np;
> +	at91sam9x5ek_dai.platform_of_node = cpu_np;

After all we're looking things up in the DT...

> +	at91sam9x5ek_dai.dai_fmt = snd_soc_of_parse_daifmt(np, "atmel,");

Is this really something that machines would want to reconfigure?  If so
why?

--BqlgNdmPmeObzZTR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3CVCAAoJELSic+t+oim97HcP/iKE7rM71nsMuTZlWymXsf7U
swALhpMthbc4uqAj6NVisdrXjSbdoLP8FtxYl+AaLuksxFobpACcQOxNcfji1AIi
Rs0ma5auifrRD4M04lscZAeA8Y1NgG2ktd8QdFLeT435roAjg8lkKtHb077xmCVC
NtpiNip3YUDN0x/o0dnOCksnLYeCEDGovIpNK1aO8iQBreKZbHK0/Nkc5L7PQp8L
lVu2EuY/1k78GzOzjKtHYB14Fz+dfQ8JtiJ0NkJFefNPi3DWxYTsAZL9NLYkYog1
zcDcP1M6yNjBlyjPHqy0Wrw6ua5Bk9qHoCWru1LfQlcJ8yWVJHPNlAsc++gmt7d0
V/0DPPzqnj52m8RzzZboMGFdn5o3c/ZEEgz32tHjd6+UuHPXx0JAG6DVMXPe1ZRf
uKNwLwLD+PPJvRL4joJwwrUjn8jJzjcgZLVXwdog7mMFSKN1biIRycLBfc5TtRIh
W8tFmShCm0MW0UFPVkEpk0mxNhFxC+eNfJGGqyiEm7Sg+/ae/oQMAGqw9vG+h2xj
mB5HW2uOtIKINSzoLJD7BxCPl2HaTCmHH3+63AfbFujhNOHaSVr8HKnXquF5WrPD
FIMA2qrcIjcedaGwWlZKj6yGr9Vua5dRySq5FVtxdwmX7boDmQWEDm3gpBpVGIUZ
rRIIp9OcfiNjG9KEG/Yg
=RwPv
-----END PGP SIGNATURE-----

--BqlgNdmPmeObzZTR--


--===============6669786607820216829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6669786607820216829==--
