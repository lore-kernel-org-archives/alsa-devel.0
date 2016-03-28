From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: add support for TAS5720 digital
 amplifier
Date: Mon, 28 Mar 2016 20:01:43 +0100
Message-ID: <20160328190143.GC2350@sirena.org.uk>
References: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
 <1458580107-4632-3-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458580107-4632-3-git-send-email-dannenberg@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 21, 2016 at 12:08:27PM -0500, Andreas Dannenberg wrote:

> +static int tas5720_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
> +				  unsigned int freq, int dir)
> +{
> +	/*
> +	 * Nothing to configure here for TAS5720. It's a simple codec slave.
> +	 * However we need to keep this function in here otherwise the ASoC
> +	 * platform driver will throw an ENOTSUPP at us when trying to play
> +	 * audio.
> +	 */
> +
> +	return 0;
> +}

Remove empty funnctions, -ENOTSUPP is expected behaviour for anything
that isn't explicitly supported by a driver.

> +	if (unlikely(!tx_mask)) {

unlikely() is for optimising hot paths, just write the logic clearly
unless there's a reason for it.

> +static irqreturn_t tas5720_irq_handler(int irq, void *_dev)
> +{
> +	/*
> +	 * Immediately disable TAS5720 FAULTZ interrupts inside the low-level
> +	 * handler to prevent the system getting saturated or even overrun
> +	 * by interrupt requests. Normally the fact that we create a threaded
> +	 * interrupt with IRQF_ONESHOT should take care of this as by design
> +	 * it masks interrupts while the thread is processed however testing
> +	 * has shown that at the high frequency the FAULTZ signal triggers
> +	 * (every 300us!) occasionally the system would lock up even with a
> +	 * threaded handler that's completely empty until the Kernel breaks the
> +	 * cycle, disables that interrupt, and reports a "nobody cared" error.
> +	 *
> +	 * Disabling the interrupt here combined with a deferred re-enabling
> +	 * after the thread has run not only prevents this lock condition but
> +	 * also helps to rate-limit the processing of FAULTZ interrupts.
> +	 */
> +	disable_irq_nosync(irq);

No, this is completely broken.  Whatever is going on in your system with
the interrupt core you need to address that at the appropriate level not
by putting a nonsensical bodge in here.  The interrupt is disabled while
the threaded handler is running, if that's not having the desired effect
then whatever causes that needs to be fixed.

> +static int tas5720_dapm_post_event(struct snd_soc_dapm_widget *w,
> +				   struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec =3D snd_soc_dapm_to_codec(w->dapm);
> +	int ret;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		/*
> +		 * Check if the codec is still powered up in which case exit
> +		 * right away also skipping the shutdown-to-active wait time.
> +		 */
> +		ret =3D snd_soc_test_bits(codec, TAS5720_POWER_CTRL_REG,
> +					TAS5720_SDZ, 0);

I don't understand this.  Why on earth would we be calling the PMU
handler if the widget was not previously powered?=20

> +		/*
> +		 * Take TAS5720 out of shutdown mode in preparation for widget
> +		 * power up.
> +		 */
> +		ret =3D snd_soc_update_bits(codec, TAS5720_POWER_CTRL_REG,
> +					  TAS5720_SDZ, TAS5720_SDZ);
> +		if (ret < 0) {
> +			dev_err(codec->dev, "error waking codec: %d\n", ret);
> +			return ret;
> +		}

This is a _POST_PMU handler not a pre-PMU handler...

> +	/* Events used to control the TAS5720 SHUTDOWN state */
> +	SND_SOC_DAPM_PRE("Pre Event", tas5720_dapm_pre_event),
> +	SND_SOC_DAPM_POST("Post Event", tas5720_dapm_post_event),

Oh, we're using _PRE() and _POST() events...  this almost certainly
indicates a problem, there are very few circumstances where these are a
good idea and I'm not seeing anything in this driver which indicates
that this is going on.  Please just use normal DAPM widgets (I'm
guessing a PGA) to represent the device and work within DAPM, don't
shoehorn some bodge around the side.

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+X+TAAoJECTWi3JdVIfQWewH/0jWhvFcvkxvr2R5G0BlWuzo
HCWg3vTQQjqkKT3l9wcBS9HTIy5FVGHI/fWeGXTzsG4J8t23kvQa5cw4qLXwyGCb
oXZhnsB5JmK8CKvZItGdf4AbAIvUMe+TVfHgwDr+f8/A9C3P2S5SofY7ANHQ4i1t
8r7qrpp1IyOBjJPj1tYZAq4f5voJ63gKA2FLqdUjEA+Eh+eEcKPCETLk+Uf8Y91X
U1DKtYH/RMDrZkQJ/vMDswbsYu775eBTqkjeUUVdR45o4caXyv3TwtJAhUgQvq6N
KBVub/iYVjhU0XtVuYKfdZUnNBHJjk/S8qoM7vaXksClUHoP56bISR4f7DO4O6M=
=kbD0
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
