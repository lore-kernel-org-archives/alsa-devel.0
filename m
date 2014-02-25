From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: Intel: Add machine driver for
 Baytrail SST with RT5640 codec
Date: Tue, 25 Feb 2014 13:42:06 +0900
Message-ID: <20140225044206.GW25940@sirena.org.uk>
References: <1393255622-31365-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1393255622-31365-6-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4255088569161978599=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CCF9265488
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 05:42:09 +0100 (CET)
In-Reply-To: <1393255622-31365-6-git-send-email-jarkko.nikula@linux.intel.com>
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


--===============4255088569161978599==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="28D0s+P4XAarnxzm"
Content-Disposition: inline


--28D0s+P4XAarnxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2014 at 05:27:00PM +0200, Jarkko Nikula wrote:

> +static const struct snd_kcontrol_new byt_rt5640_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Headphone"),
> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +	SOC_DAPM_PIN_SWITCH("Int Mic"),
> +	SOC_DAPM_PIN_SWITCH("Ext Spk"),

Is this really an external speaker (you're making this visible as a
control name...)?

> +	fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +	      SND_SOC_DAIFMT_CBS_CFS;
> +
> +	ret = snd_soc_dai_set_fmt(codec_dai, fmt);
> +	if (ret < 0) {
> +		dev_err(codec_dai->dev,
> +			"can't set codec DAI configuration %d\n", ret);
> +		return ret;
> +	}

Set this in the dai_link like with the other Intel machine driver the
other day.

--28D0s+P4XAarnxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDB8bAAoJELSic+t+oim9tEQQAJSy4pBOQ2PjIFvQYLY/HBN4
zYdJQh2HXAJLKjf/NKy7cwqpbYg1i9Xa+Tg857KztRSMpDbKx4szCZy3IKi6GPsP
Ps3haJxBIwF58uFO6syxwjWrB/Bx4GaC2bc8xWKBTMBw2DQTpgIDXQyr451DXdi0
vwzvlnRTmq+E6q+FnvA4TqpOMyJnZaFwXH6sw9l9lxZ/2xcGyVdayyKkr4bzRNlZ
hurZgCTqU5BI99KEEK0AZh3oVWNyyDYnSABuv6XDeU2wVJnFkQ1sLmqx61OE3JcZ
DX0j6mXaQiC2htYPVDRwuetzgaYV8iANiPRjeu9tV3DhuMX4mn/lkDN771skHIx+
qWEtn5qtfT5E1MIX1DSpFncs4pRb9e7fUrPjVLBpPii60d4gIW0zXlthseg/UTW2
aOhTeXpWj79eG8uWDkzA22/xgDEo4FvVEt06fjTgQmUaWmA9MbJ1QxdzzgMhC34l
GrzOkQas/I5k+riT03aBhsqtCMyWraxFsLXpECGcI1t+Th3maF7sDydIZ1sgyTJp
5dIsfK0D1N0CXJdLA+hGSHjyExGoExQcfQ1iXx9Q0yAHYOlsG9DoXh8mdfMQzNky
55TLeSdXZ5fzp1mDUxAffF3TqrlY4MpvUlhVFdEDmK6neTc6BOC5cfPb+iHvKTqX
6XFSTnDVqgvKokvVVtbK
=36Di
-----END PGP SIGNATURE-----

--28D0s+P4XAarnxzm--

--===============4255088569161978599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4255088569161978599==--
