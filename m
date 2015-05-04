From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Mon, 4 May 2015 12:39:43 +0100
Message-ID: <20150504113943.GB15510@sirena.org.uk>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430493319-23808-8-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 04:15:18PM +0100, Richard Fitzgerald wrote:

> +	switch (event) {
> +	case SND_SOC_DAPM_PRE_PMU:
> +		val = snd_soc_read(codec, ARIZONA_ASRC_RATE1);
> +		val &= ARIZONA_ASRC_RATE1_MASK;
> +		val >>= ARIZONA_ASRC_RATE1_SHIFT;
> +
> +		val = snd_soc_read(codec, ARIZONA_SAMPLE_RATE_1 + val);
> +		if (val >= 0x11)
> +			dev_warn(codec->dev, "Unsupported ASRC rate1\n");

Shouldn't we be returning an error if the rate is unsupported?  It'd
also be helpful to log what the invalid value that's been set is.

> +		val = snd_soc_read(codec, ARIZONA_ASRC_RATE2);
> +		val &= ARIZONA_ASRC_RATE2_MASK;
> +		val >>= ARIZONA_ASRC_RATE2_SHIFT;
> +		val -= 0x8;

What if the value we read back is set (invalidly I guess) to less than
8?  We'll just read...

> +
> +		val = snd_soc_read(codec, ARIZONA_ASYNC_SAMPLE_RATE_1 + val);
> +		if (val >= 0x11)
> +			dev_warn(codec->dev, "Unsupported ASRC rate2\n");

...some random other register.

> +static const char * const wm8998_inmux_texts[] = {
> +	"A",
> +	"B",
> +};
> +
> +static const SOC_ENUM_SINGLE_DECL(wm8998_in1muxl_enum,
> +				  ARIZONA_ADC_DIGITAL_VOLUME_1L,
> +				  ARIZONA_IN1L_SRC_SHIFT,
> +				  wm8998_inmux_texts);

Those are some fun input names...

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR1p/AAoJECTWi3JdVIfQ/+YH/Ajj2a+CpJDiOruFT/pHURp1
v97sJgk5S68xVyOxr01iBCoZlviEgBMfcgl8TREnS4THeIgvRhRauIsLaBotqZoF
0Z+qPi5KnLzEZZdFzDcZ2K3BDv2mF4s3VH8e9iRV7HI1Rp+plHx5dwO0tyQFmFq5
v/DGF63n4BKfrZ2MmoRdXyBlbQdODzxIh2WO3EgMnAnNe0Jq0nzGy8Ss+ucTpkS8
H1oZyB0A5LMYVxHTXm7Xvi8SMeoFZGh8XHxUcYmgoXr2dOcPcjtdLJatm/44hGA0
L/4HnTvCoV+Pvmxi6Cucxo6o6QqRLE2s/GczmPO8HSnvA+WSQoH1uJpxQsiRAUk=
=QNEv
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
