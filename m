From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Sun, 30 Aug 2015 15:47:17 +0100
Message-ID: <20150830144717.GD12027@sirena.org.uk>
References: <1440805070-39150-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8947175709863018125=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 847322604A9
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 16:47:29 +0200 (CEST)
In-Reply-To: <1440805070-39150-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: alsa-devel@alsa-project.org, benzh@google.com, dgreid@google.com, mfelton1@nuvoton.com, ccchang12@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============8947175709863018125==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q9MHMFK5HFIYBtN1"
Content-Disposition: inline


--q9MHMFK5HFIYBtN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 28, 2015 at 04:37:50PM -0700, Anatol Pomozov wrote:

> +	SOC_SINGLE_TLV("Frontend PGA Gain", NAU8825_REG_POWER_UP_CONTROL,
> +		8, 37, 0, fepga_gain_tlv),

All volume controls need to end in Volume as per ControlNames.txt.

> +	default:
> +		return -EINVAL;
> +	}
> +	regmap_update_bits(nau8825->regmap, NAU8825_REG_I2S_PCM_CTRL1,

Blank line here.

> +	/* Bias and clock are needed for button detection */
> +	regmap_update_bits(nau8825->regmap, NAU8825_REG_BIAS_ADJ,
> +		NAU8825_BIAS_VMID, NAU8825_BIAS_VMID);
> +	regmap_update_bits(nau8825->regmap, NAU8825_REG_BOOST,
> +		NAU8825_GLOBAL_BIAS_EN, NAU8825_GLOBAL_BIAS_EN);

These sound like DAPM widgets which should be being eneabled when jack
detection is enabled.

> +	/* Ground HP Outputs[1:0], needed for headset auto detection
> +	 * Enable Automatic Mic/Gnd switching reading on insert interrupt[6] */
> +	regmap_update_bits(regmap, NAU8825_REG_HSD_CTRL,
> +		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L,
> +		NAU8825_HSD_AUTO_MODE | NAU8825_SPKR_DWN1R | NAU8825_SPKR_DWN1L);

I'm still not happy to see the unconditional enabling of detection and
switching.

> +		if (!nau8825->mclk_freq)
> +			clk_prepare_enable(nau8825->mclk);

You should be checking the return value here.

> +		if (nau8825->mclk_freq != freq) {
> +			nau8825->mclk_freq = freq;
> +
> +			freq = clk_round_rate(nau8825->mclk, freq);
> +			clk_set_rate(nau8825->mclk, freq);

Likewise here and in other cases where you're setting clocks.

> +	nau8825->jkdet_enable = device_property_read_bool(dev,
> +		"nuvoton,jkdet-enable");

This DT parsing stuff should really be moved out into a separate
function which is only called (or only does anything) if there is
actually DT data (if there is an of_node set).

> +	if (nau8825->irq) {
> +		int ret = devm_request_threaded_irq(dev, nau8825->irq, NULL,
> +			nau8825_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +			"nau8825", nau8825);
> +
> +		if (ret) {
> +			dev_err(dev, "Cannot request irq %d (%d)\n",
> +				nau8825->irq, ret);
> +			return ret;
> +		}
> +	}

So we actually handle systems with no interrupt wired up?  That seems to
make all the non-optional enabling of the jack detection interrupts a
bit odd.

> +static struct i2c_driver nau8825_driver = {
> +	.driver = {
> +		.name = "nau8825",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = nau8825_i2c_probe,
> +	.remove = nau8825_i2c_remove,
> +	.id_table = nau8825_i2c_ids,
> +};

This has a DT binding but no OF IDs defined.  It is true that Linux will
currently try to guess a suitable driver based on the I2C ID table but
it is bad practice to rely on this behaviour, we do see ID collisions
sometimes (for example both WonderMedia and Wolfson using WM for their
parts).

--q9MHMFK5HFIYBtN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV4xd0AAoJECTWi3JdVIfQ988H/3ZtmV+FqpZxn7c1+gFMioQy
2Pks1RRrunyj4N8/pA1TNBhRrT0j864Uzbu89/JN3qa+fgwElmECheWVmQ1y/YhB
M/kUwTiygXUI56SbiCaOIsI42Jp9AZkDRdfb2/bBLgnJjLRLKwJVe/Uz4GgazyXh
nLnEWI+K+COOimfWjvYqD69Y2g1lz+/cZo41iOx6QR5RXQnpSkKmqmOdMs94QRSS
VvXPT22B9Z7nT6jhWskFC99vKfNFZ+ZDWvFsGo/CAUhSu2pT1rFvzPCMqzosZJgz
td0Uj2iwqKpIE+Gp+9q3caPJv2KspHCiJcpuIBxziv4ObHgS8hF4Tvvo0Ns1TUI=
=7luk
-----END PGP SIGNATURE-----

--q9MHMFK5HFIYBtN1--

--===============8947175709863018125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8947175709863018125==--
