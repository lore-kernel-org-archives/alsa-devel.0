From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Tue, 4 Aug 2015 18:37:22 +0100
Message-ID: <20150804173722.GC20873@sirena.org.uk>
References: <1438659669-12433-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0741210952862065720=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E4D5260532
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 19:37:32 +0200 (CEST)
In-Reply-To: <1438659669-12433-1-git-send-email-anatol.pomozov@gmail.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, mfelton1@nuvoton.com, kcso@nuvoton.com, ccchang12@nuvoton.com, dgreid@google.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org


--===============0741210952862065720==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lFkFGF0KRT3zlcK3"
Content-Disposition: inline


--lFkFGF0KRT3zlcK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2015 at 08:41:09PM -0700, Anatol Pomozov wrote:
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>

My previous comments about the magic number sequences still apply.
Also...

> +	codec: nau8825@1a {
> +		compatible = "nuvoton,nau8825";
> +		reg = <0x1a>;
> +		nuvoton,jkdet-pullup = "true";

...this isn't how boolean properties are done, the property simply needs
to exist.

> +static int nau8825_output_driver_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
> +	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
> +	struct regmap *regmap = nau8825->regmap;
> +
> +	if (SND_SOC_DAPM_EVENT_ON(event)) {
> +		/* Power Up L and R Output Drivers */
> +		regmap_update_bits(regmap, NAU8825_REG_POWER_UP_CONTROL, 0x3c,
> +			0x3c);
> +		/* Power up Main Output Drivers (The main driver must be turned
> +		   on after the predriver to avoid pops) */
> +		regmap_update_bits(regmap, NAU8825_REG_POWER_UP_CONTROL, 0x3,
> +			0x3);
> +	} else {
> +		/* Power Down L and R Output Drivers */
> +		regmap_update_bits(regmap, NAU8825_REG_POWER_UP_CONTROL, 0x3f,
> +			0x0);

You should be able to implement this with _S widgets without requiring
explicit code, they're designed for exactly this situation.

> +int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
> +				struct snd_soc_jack *jack)
> +{
> +	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> +	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);

The driver shouldn't do this - it's up to the system integration to
define how the buttons are mapped.

> +
> +	nau8825->jack = jack;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);

This function doesn't appear to affect the hardware.  I would expect
that the jack detection hardware is turned off when not in use.

> +static void nau8825_setup_buttons(struct regmap *regmap)
> +{
> +	/* Setup Button Detect (Debounce, number of buttons, and Hysteresis) */
> +	regmap_write(regmap, NAU8825_REG_KEYDET_CTRL, 0x7311);
> +
> +	/* Setup 4 buttons impedane according to Android specification
> +	 * https://source.android.com/accessories/headset-spec.html
> +	 * Button 0 - 0-70 Ohm
> +	 * Button 1 - 110-180 Ohm
> +	 * Button 2 - 210-290 Ohm
> +	 * Button 3 - 360-680 Ohm
> +	 */
> +	regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_1, 0x0f1f);
> +	regmap_write(regmap, NAU8825_REG_VDET_THRESHOLD_2, 0x325f);
> +}

This looks like system configuration...

> +	/* The interrupt clock is gated by x1[10:8],
> +	 * one of them needs to be enabled all the time for
> +	 * interrupts to happen. */
> +	snd_soc_dapm_force_enable_pin(&codec->dapm, "DDACR");
> +	snd_soc_dapm_sync(&codec->dapm);

This should be tied to jack detection, not done unconditionally.

--lFkFGF0KRT3zlcK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwPhRAAoJECTWi3JdVIfQcnQH/0ZPIg84HpmqjYoMdb01V/9G
Os6yFUdFr8KdHEe28kiWlJIHPC6zwNhcTCQtvTRE3Ig519EZNaCdN9V5J3ts3Lrt
HxaNgwg0cLt7hzB15gOFmrBrmp39GRVp5q9iqqb/YE7xVprFY08YMXhvdundrI6c
czzGBysT3NsilRf9YYP/g0Jq8CqnNIyjBXL9uH37h7K+EJUZki4rFIpNXm2w9oB9
XovRuGaoDXL4TpdUK8HaopThbFJt2WnZJ53XgzA1Xu9UEebr9mwrwnTw+V/GyGbX
SzJgUjl3SaMB1eFWKFvJ5njiMssYN6CK6+Xkzl+Fv/M/Y27RAp7r+xXpwJRf24Q=
=c5Im
-----END PGP SIGNATURE-----

--lFkFGF0KRT3zlcK3--

--===============0741210952862065720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0741210952862065720==--
