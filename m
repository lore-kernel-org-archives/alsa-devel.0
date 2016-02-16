From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC v1 2/9] ASoC: msm8x16: add driver structure
Date: Tue, 16 Feb 2016 19:09:58 +0000
Message-ID: <20160216190958.GD7544@sirena.org.uk>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1455643961-1700-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0675957566537288843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E618260563
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 20:10:07 +0100 (CET)
In-Reply-To: <1455643961-1700-1-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============0675957566537288843==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 05:32:41PM +0000, Srinivas Kandagatla wrote:

> @@ -195,7 +196,6 @@ snd-soc-wm9705-objs := wm9705.o
>  snd-soc-wm9712-objs := wm9712.o
>  snd-soc-wm9713-objs := wm9713.o
>  snd-soc-wm-hubs-objs := wm_hubs.o
> -
>  # Amp
>  snd-soc-max9877-objs := max9877.o
>  snd-soc-tpa6130a2-objs := tpa6130a2.o

Random whitespace change here.

> +	chip->micbias1_cap_mode =
> +		(of_property_read_bool(pdev->dev.of_node, ext1_cap) ?
> +		MICBIAS_EXT_BYP_CAP : MICBIAS_NO_EXT_BYP_CAP);

Please don't abuse the ternery operator, write code as though people
were going to read it.

> +	regs[0].supply = "vddio";
> +	regs[1].supply = "vdd-cp";
> +	regs[2].supply = "vdd-hph";
> +	regs[3].supply = "vdd-tx-rx";
> +	regs[4].supply = "vdd-micbias";
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(regs), regs);
> +	if (ret) {
> +		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
> +		return ret;
> +	}
> +	chip->vddio		= regs[0].consumer;
> +	chip->vdd_cp		= regs[1].consumer;
> +	chip->vdd_hph		= regs[2].consumer;
> +	chip->vdd_tx_rx		= regs[3].consumer;
> +	chip->vdd_micbias	= regs[4].consumer;

Are you *sure* you should be using regulator_bulk_get() here if you
never use the regulators en masse again?

> +static struct snd_soc_dai_driver msm8x16_wcd_codec_dai[] = {
> +};
> +
> +static struct snd_soc_codec_driver msm8x16_wcd_codec = {
> +};

Both empty?  It seems this CODEC does nothing so may as well not have a
driver...

> +	clk_prepare_enable(chip->mclk);

Error checking.

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWw3QEAAoJECTWi3JdVIfQCogH/j7JKaop/lFNqx26EQnT06Wh
R8mKjg9JX6jCPhOqeZMLc5kj3lmAWPzIKfM9bksF1u0VUkc6WG693GK1k7LyHVsr
YSSU/2OfSo8VDKeIPC1RfYBIR1QcZWxwiIZ9jibXcWi4pzJSwSyugCISx9Nb+2KL
z7aVGRNnjCDmYVKYo3nw5flVzM6lmWDjGE8VoY3Ld6HlknPfbinqimOVmAm1A1DL
TBRMEl8146qCIlV0n3HO5FRB67+QgA3jQ5VScyojOxgCPPmf68+4HurcPOXqdrxF
HjY87UNloefFct60WP7MJ/kVsAfQzA5AS6pe3E3cb08ESeEPjjW8aMxZI608myo=
=u8nf
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--

--===============0675957566537288843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0675957566537288843==--
