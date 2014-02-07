From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] sound: soc: codecs: Add es8328 codec
Date: Fri, 7 Feb 2014 18:12:38 +0000
Message-ID: <20140207181238.GL1757@sirena.org.uk>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com>
 <1391749517-11787-2-git-send-email-xobs@kosagi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6372449661311466367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DEC2C265473
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 19:12:55 +0100 (CET)
In-Reply-To: <1391749517-11787-2-git-send-email-xobs@kosagi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sean Cross <xobs@kosagi.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============6372449661311466367==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
Content-Disposition: inline


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2014 at 01:05:15PM +0800, Sean Cross wrote:

Please use subject likes matching the style for the subsystem.  If your
changelog looks different to others in the same area it probably needs
an update.

In general this looks like it should be making much more use of the
framework rather than open coding, it looks like it's very much hard
coded for one use cae.

> +config SND_SOC_ES8328
> +	tristate
> +

It looks like you're going to use this on an ARM system, you should add
DT support and make it visible in Kconfig.

> +static const struct snd_soc_dapm_widget es8328_dapm_widgets[] = {
> +	SND_SOC_DAPM_DAC("Speaker Volume", "HiFi Playback", SND_SOC_NOPM, 0, 0),

Don't declare a stream by name, use DAPM routes to connect the stream to
the widget.

> +	SND_SOC_DAPM_OUTPUT("VOUTL"),
> +	SND_SOC_DAPM_OUTPUT("VOUTR"),
> +        SND_SOC_DAPM_INPUT("LINE_IN"),
> +        SND_SOC_DAPM_INPUT("MIC_IN"),
> +        SND_SOC_DAPM_OUTPUT("HP_OUT"),
> +        SND_SOC_DAPM_OUTPUT("SPK_OUT"),

Something is messed up with your indentation, spaces vs tabs I expect.

> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {

An else clause is more idiomatic here.

> +		snd_soc_write(codec, ES8328_ADCCONTROL5, adc);

It's more idiomatic to use update_bits() here and save doing a manual
read/modify/write cycle - it also avoids the write if not needed.

> +static int es8328_adc_enable(struct snd_soc_codec *codec)
> +{
> +	u16 reg = snd_soc_read(codec, ES8328_CHIPPOWER);
> +	reg &= ~(ES8328_CHIPPOWER_ADCVREF_OFF |
> +		 ES8328_CHIPPOWER_ADCPLL_OFF |
> +		 ES8328_CHIPPOWER_ADCSTM_RESET |
> +		 ES8328_CHIPPOWER_ADCDIG_OFF);
> +	snd_soc_write(codec, ES8328_CHIPPOWER, reg);

This looks like it should be done in DAPM.

> +
> +	/* Set up microphone to be differential input */
> +	snd_soc_write(codec, ES8328_ADCCONTROL2, 0xf0);

This looks like something that should be platform data and/or DAPM -
other platforms may be wired differently.

> +	/* Set ADC to act as I2S master */
> +	snd_soc_write(codec, ES8328_ADCCONTROL3, 0x02);

set_dai_fmt().

> +	/* Set I2S to 16-bit mode */
> +	snd_soc_write(codec, ES8328_ADCCONTROL4, 0x18);

This should be being done in hw_params.

> +	/* Frequency clock of 272 */
> +	snd_soc_write(codec, ES8328_ADCCONTROL5, 0x02);

What is the frequency clock in this context?

> +	/* Power up LOUT2 ROUT2, and power down xOUT1 */
> +	snd_soc_write(codec, ES8328_DACPOWER,
> +			ES8328_DACPOWER_ROUT2_ON |
> +			ES8328_DACPOWER_LOUT2_ON);

This looks like it should be being done in DAPM.

> +	/* Enable click-free power up */
> +	snd_soc_write(codec, ES8328_DACCONTROL6, ES8328_DACCONTROL6_CLICKFREE);
> +	snd_soc_write(codec, ES8328_DACCONTROL3, 0x36);

Just do this once on startup?

> +	/* Set I2S to 16-bit mode */
> +	snd_soc_write(codec, ES8328_DACCONTROL1, ES8328_DACCONTROL1_DACWL_16);

hw_params().

> +	/* No attenuation */
> +	snd_soc_write(codec, ES8328_DACCONTROL4, 0x00);
> +	snd_soc_write(codec, ES8328_DACCONTROL5, 0x00);

This and the rest of the function looks like it should be done in a
combination of DAPM and normal ALSA controls.

> +	for (i = 0; i < 4; i++)
> +		snd_soc_write(codec, i + ES8328_DACCONTROL24, old_volumes[i]);

You are probably looking for something like SOC_DAPM_SINGLE_AUTODISABLE.

> +static const struct snd_soc_dai_ops es8328_dai_ops = {
> +	.hw_params	= es8328_hw_params,
> +	.prepare	= es8328_pcm_prepare,
> +	.shutdown	= es8328_pcm_shutdown,
> +//	.digital_mute	= es8328_mute,

Hrm?

> +static const struct of_device_id es8328_of_match[] = {
> +	{ .compatible = "everest,es8328", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, es8328_of_match);

Any device tree device needs a binding document.

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9SISAAoJELSic+t+oim968sP/AljPRXE7d0Umq4B6ZGg5/To
IQN5yU+ZLmwlHdv46yJk1+ym8mS9WaoHZqDOK+qQjh1vuFyXTHNyegMhK66+9x9k
LO6UoYBQCooUoRqnoDUtJt5wBWO4gMamIwH3UKP3fqy88TvmJ0Nl5MlW9sAn2A6n
1Li1PqiL+YZZwV9D3PDUaKsdSh/XOY0Ew1saxM2mGNzWuKhZL6AsBmGwXjHrsL/C
tR/FPUCE0hieZrRbWBenwcRyUlNDyROUsp2ZNmMPja4oNLNOragXGDcpYJo+N8kD
i9Om4KdA7+LlQWQjd5FNGvxEdNn6nQqKpjOfB+KCK7I5ROEXDMJcNgQFsx8ECKoy
Txko5hxmFUHe1tW/yb/0FIwNpD1nZDKZ1BjBSPwCe5Fm8DxNwhnoOvEoYoD+rzDD
z/Rp4LLX43FYXmhWaq1R1JFRpwDElP3vKVV+yZmGS1c98LQtN/El65b6HSLbVtUW
XWwTQ/RbVVxf3SxW4Y0LcwFmZ8UpsCHni+M14BxZJPwKc8dLdWxzS5YXka0at34V
F+lDUuz7CrZ8bPToe0Frpo5JRfyJB4VvlBzomEj7YUUfB/kkwpqZ9C1laoR15Xjr
iB/QXIpxAl/Njexym57bi9Es1H+OLtjg2Iw86cHIGiH1/PbXzc50YzERQ9uyjoJE
gxlufESrtzevYh/8hqvT
=XETB
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--

--===============6372449661311466367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6372449661311466367==--
