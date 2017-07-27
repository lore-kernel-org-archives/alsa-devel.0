From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: add support for TAS6424 digital amplifier
Date: Thu, 27 Jul 2017 17:41:54 +0100
Message-ID: <20170727164154.vzfxwv4xc6sxvgty@sirena.org.uk>
References: <1500405604-23511-1-git-send-email-m-stecklein@ti.com>
 <1500405604-23511-3-git-send-email-m-stecklein@ti.com>
 <20170719110842.lb2f5cqawnkenhsb@sirena.org.uk>
 <f94172dc-3e29-999f-ffb5-7eb955fcb1a5@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rh7wvcwhcbzyhtly"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f94172dc-3e29-999f-ffb5-7eb955fcb1a5-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Stecklein <m-stecklein-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--rh7wvcwhcbzyhtly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2017 at 12:44:34PM -0500, Michael Stecklein wrote:
> On 07/19/2017 06:08 AM, Mark Brown wrote:
> > On Tue, Jul 18, 2017 at 02:20:04PM -0500, Michael Stecklein wrote:

Please leave blank lines between paragraphs, it makes things easier to
read.

> >> +	if (!tx_mask) {
> >> +		dev_err(codec->dev, "tdm mask must not be 0\n");
> >> +		return -EINVAL;
> >> +	}

> > Setting the mask to 0 is used when turning off TDM.

> When turning off TDM, will the set_tdm_slot function ever get
> called? (Since the TDM was turned off the slots don't need to

Of course, that's how you turn off TDM mode.

> be set.) Also, for this device TDM mode is automatically
> selected based on the presence of a TDM clock, so there is
> nothing to do to switch into or out of TDM mode. Similar
> parts handle this the same way, such as: tlv320aic3x.c,
> tas2552.c, tas5720.c, ssm4567.c

It's possible there's bugs in older drivers, sometimes things get missed
in review.

> >> +	if ((reg & TAS6424_WARN_VDD_UV) && !(tas6424->last_warn & TAS6424_WARN_VDD_UV))
> >> +		dev_warn(dev, "experienced a VDD under voltage condition\n");
> >> +
> >> +	if ((reg & TAS6424_WARN_VDD_POR) && !(tas6424->last_warn & TAS6424_WARN_VDD_POR))
> >> +		dev_warn(dev, "experienced a VDD POR condition\n");

> > These look like they are errors rather than warnings and should be
> > critical prints like the other errors.

> These conditions happened on the previous shutdown/reset
> of the device. We are letting the user know about them, but
> they are not critical to the current device state, so I have left
> them as warnings.

I'd expect errors from previous uses of the driver to be discarded,
especially things that might've resulted from something like the reboot
process.

> >> +static int tas6424_codec_probe(struct snd_soc_codec *codec)
> >> +{
> >> +	struct tas6424_data *tas6424 = snd_soc_codec_get_drvdata(codec);
> >> +	int ret;
> >> +
> >> +	tas6424->codec = codec;
> >> +
> >> +	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
> >> +				    tas6424->supplies);
> >> +	if (ret != 0) {
> >> +		dev_err(codec->dev, "failed to enable supplies: %d\n", ret);
> >> +		return ret;
> >> +	}
> > This init stuff should be in either the main I2C probe, DAPM or bias
> > level management.  The CODEC probe should be very minimal.
> This is a single codec device, does it make sense to leave the
> device running without its codec? Other single codec devices
> initialize regulators in codec probe similarly.

I'm not sure what you mean by a "single CODEC device".  Most devices are
so CODEC enables in I2C probe and then either leave everything on all
the time or manage the regulators with runtime power management of some
kind (either actual runtime PM or DAPM).  Managing things only in the
ASoC level probe increases complexity and in actual running systems
makes a marginal difference to real systems (you'd need to enable the
CODEC but not the card).

> >> +	switch (level) {
> >> +	case SND_SOC_BIAS_ON:
> >> +	case SND_SOC_BIAS_PREPARE:
> >> +		msleep(500);
> >> +		break;
> > You need a 500ms sleep in all these cases?  That's a lot of sleeping.
> Unfortunately, the device runs diagnostics at this point,
> which take upwards of 480ms.

On both entry to _ON and both entries to _PREPARE (from _ON and from
_STANDBY)?  How does the device know we made these state changes?  It's
a total sleep of 1s on power on.


> >> +	case SND_SOC_BIAS_OFF:
> >> +		ret = snd_soc_update_bits(codec, TAS6424_CH_STATE_CTRL_REG,
> >> +					  0xff, TAS6424_CH1_STATE_HIZ | TAS6424_CH2_STATE_HIZ |
> >> +					  TAS6424_CH3_STATE_HIZ | TAS6424_CH4_STATE_HIZ);
> >> +
> >> +		if (ret < 0) {
> >> +			dev_err(codec->dev, "error suspending device: %d\n", ret);
> >> +			return ret;
> >> +		}

> > These mutes seem very random disassociated from anything else?

> What do you mean by this comment? The control register is
> set to STATE_MUTE and STATE_HIZ depending on what the
> device needs for the new BIAS level.

This doesn't seem very joined up with the rest of the power control of
the device - you're setting the high impedence state here, it's not
clear what undoes that and there's other power control in the suspend
and resume stuff.  I didn't notice anything in a nearby place that
cleared this state for example.

--rh7wvcwhcbzyhtly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll6F9EACgkQJNaLcl1U
h9AG2gf/WCImb0pKbOcS//ns+AxWN1NGDYa57kuYStjgwJixeNZPJFddv34XdjmN
RWTUZNNyK67Dsm3QX31J71icKb92NbkEEkrAGEe/Y0Eyn+gMP52unIv7GtsP92gQ
ALmlQktg/dsMzC86SoMGUArysdXxjtPtJfFv8Je0CQuFxiJXn+WnbXZ4EosxiORI
A/50V6bFfIOXbvkYPFBy/pIAX33PmyWd4Chy1dU4vLqoSNFU76w65vcdQFJxjSHX
UpzgaSYH2GfePAO93izhbzP4qrAW6cs5W13671nzKVJJci0jr79Sm8XEEr/GWlFB
755w2MnqyZHZyhH5rp6pFGH3V8WP1g==
=FA1k
-----END PGP SIGNATURE-----

--rh7wvcwhcbzyhtly--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
