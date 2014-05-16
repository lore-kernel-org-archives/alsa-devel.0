From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add Baytrail byt-max98090
	machine driver
Date: Fri, 16 May 2014 19:54:29 +0100
Message-ID: <20140516185429.GR22111@sirena.org.uk>
References: <1400248684-21960-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4719344538337692641=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 840542615B6
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 20:54:48 +0200 (CEST)
In-Reply-To: <1400248684-21960-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4719344538337692641==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="waqf3ldl5CnEMrQn"
Content-Disposition: inline


--waqf3ldl5CnEMrQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 16, 2014 at 04:58:04PM +0300, Jarkko Nikula wrote:

> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
> +	snd_soc_dapm_enable_pin(dapm, "Headphone");
> +	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
> +	snd_soc_dapm_enable_pin(dapm, "Int Mic");
> +
> +	snd_soc_dapm_sync(dapm);

None of the above code should have any effect - pins are enabled by
default and syncs suppressed until probe is complete.

> +
> +	/*
> +	 * ASoC still uses legacy GPIOs so we look both GPIOs using
> +	 * descriptors here, convert them to numbers and release the
> +	 * acquired descriptors. Once ASoC switches over to GPIO descriptor
> +	 * APIs we can pass them directly.
> +	 */

You could just add the required support to the framework...  it seems
quicker and simpler.

> +	hp_desc = gpiod_get_index(card->dev->parent, NULL, 0);
> +	if (IS_ERR(hp_desc))
> +		return 0;

This just eats errors, it's broken for deferred probe.

> +	snd_soc_jack_report(jack, SND_JACK_LINEOUT | SND_JACK_LINEIN,
> +			    SND_JACK_HEADSET | SND_JACK_LINEOUT |
> +			    SND_JACK_LINEIN);

Why is this here?

> +#ifdef CONFIG_PM_SLEEP
> +static const struct dev_pm_ops byt_max98090_pm_ops = {
> +	.suspend = snd_soc_suspend,
> +	.resume = snd_soc_resume,
> +};
> +
> +#define BYT_MAX98090_PM_OPS	(&byt_max98090_pm_ops)
> +#else
> +#define BYT_MAX98090_PM_OPS	NULL
> +#endif

Why not just use snd_soc_pm_ops?

> +	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
> +	if (!drv) {
> +		dev_err(&pdev->dev, "allocation failed\n");
> +		return -ENOMEM;
> +	}

The allocator is already quite noisy of it goes OOM, no need to print.

> +	ret_val = snd_soc_register_card(&byt_max98090_card);
> +	if (ret_val) {

devm_snd_soc_register_card().

> +static int byt_max98090_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *soc_card = platform_get_drvdata(pdev);
> +	struct byt_max98090_private *drv = snd_soc_card_get_drvdata(soc_card);
> +
> +	snd_soc_jack_free_gpios(&drv->jack, ARRAY_SIZE(hs_jack_gpios),
> +				hs_jack_gpios);

> +	snd_soc_card_set_drvdata(soc_card, NULL);
> +	snd_soc_unregister_card(soc_card);
> +	platform_set_drvdata(pdev, NULL);

Setting the data to NULL on removal is just a waste of time and is done
by the core anyway.

You're freeing these in the device level remove path but allocating them
in the ASoC level probe path.  They should be managed consistently.

--waqf3ldl5CnEMrQn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTdl7iAAoJELSic+t+oim96dQP/3JQTyEp8Od8VeDc8JVeNO5N
l3Ufo9H0Tu+T6/opuS0LxR/yIpM4415Ote091L27yXQFenSmy1zH29h3Vj6nqnQG
8ACSvUK2RilB+nF2WYjBH+K6meqQytPuzo5US72QoeTYh0LQzOLdBVVZ5oA0NRUr
Kx+4utEqwSRsqIOk6tjjlPzk92Nypg2VnogRCFlqZKT1hB9K5S06f0rk60i14euY
UF1PWjTWz2Od8oSAgeGQKzBIyQPYsz9iGjaRQ2NQ5Nyrdw4Oc4jBruf7EeQ+HECR
hbToiop3eW88JtEGtjjvy663RfV3TfvLL0xLjoczvW+2e2YLQP/Ly/qd3Ha/GMCM
PNAi/KCo5pFgJwHS3dCv0fz3t7P+SqlySTd7f5wggMm/OJYzcPukcRcaNtMGQuVf
IEbdNlcMqY5PdKMHUd9FxeE6QFiVlzlbc+rhBhUOrS7LiGqDU3G/SXBJfr/GB/XF
50jkke/KRAK07LmE0NBrJx+LOLMYxEQMrhfyNkR8zK9FidXDLdrb3edGAzGiBoeb
PwcAoqECr9gdrqaE8RK27rTx7iakAOTqnS+22k7+drJoNNIDVO99wl2EuoLbtVOy
U6a2GFIjPe/4cWIwE+dwyINs8FRzbWhxcrCCdDtXxnPg8l3HdKW08C2QqHIfNCm2
eCFVS4vn/qiNDcDClJEW
=21PA
-----END PGP SIGNATURE-----

--waqf3ldl5CnEMrQn--

--===============4719344538337692641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4719344538337692641==--
