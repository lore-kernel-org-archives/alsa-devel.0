From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 1/2] ASoC: hdmi: Add a transmitter interface to the
 HDMI CODEC
Date: Mon, 29 Dec 2014 17:08:18 +0000
Message-ID: <20141229170818.GB17800@sirena.org.uk>
References: <cover.1414053169.git.moinejf@free.fr>
 <d63bb11d345ab1f1b7723ce5f82d42f56b0f1715.1414053169.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HqU/NDEOKApT+6Er"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d63bb11d345ab1f1b7723ce5f82d42f56b0f1715.1414053169.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--HqU/NDEOKApT+6Er
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2014 at 09:09:35AM +0200, Jean-Francois Moine wrote:

> +struct hdmi_data {
> +	int (*get_audio)(struct device *dev,
> +			 int *max_channels,
> +			 int *rate_mask,
> +			 int *fmt);
> +	void (*audio_switch)(struct device *dev,
> +			     int port_index,
> +			     unsigned sample_rate,
> +			     int sample_format);

I can't really tell from these function names what these functions are
supposed to do.  I think get_audio() should be get_audio_caps() or
similar since it reads the capabilities and audio_switch() is supposed
to be set_audio_params() or similar to set the settings for the running
stream.

> +	snd_pcm_hw_constraint_list(runtime, 0,
> +				   SNDRV_PCM_HW_PARAM_RATE,
> +				   rate_constraints);
> +
> +	formats =3D 0;
> +	if (fmt & 1)
> +		formats |=3D SNDRV_PCM_FMTBIT_S16_LE;
> +	if (fmt & 2)
> +		formats |=3D SNDRV_PCM_FMTBIT_S20_3LE;
> +	if (fmt & 4)
> +		formats |=3D SNDRV_PCM_FMTBIT_S24_LE |
> +			   SNDRV_PCM_FMTBIT_S24_3LE |
> +			   SNDRV_PCM_FMTBIT_S32_LE;

Magic numbers here - can't we have some constants defined?

> +	priv->hdmi_data.audio_switch(dai->dev, dai->id,
> +				     params_rate(params),
> +				     params_format(params));

I'd be happier if this were able to return an error; even if the
constraints are satisfied perhaps something changed or some operation
fails for some reason.

> +static void hdmi_shutdown(struct snd_pcm_substream *substream,
> +			  struct snd_soc_dai *dai)
> +{
> +	struct device *cdev;
> +	struct hdmi_priv *priv;
> +
> +	cdev =3D hdmi_get_cdev(dai->dev);
> +	if (!cdev)
> +		return;
> +	priv =3D dev_get_drvdata(cdev);
> +
> +	priv->hdmi_data.audio_switch(dai->dev, -1, 0, 0);	/* stop */
> +}

So the set parameters operation has to support these magic values as
being "off" - why not have an explicit shutdown operation here?

> +static int hdmi_codec_probe(struct snd_soc_codec *codec)
> +{
> +	struct hdmi_priv *priv;
> +	struct device *dev =3D codec->dev;	/* encoder device */
> +	struct device *cdev;			/* codec device */
> +
> +	cdev =3D hdmi_get_cdev(dev);
> +	if (!cdev)
> +		return -ENODEV;

This is (I think) only called for cases where the driver is being used
=66rom a parent device with ops but the name makes it sound like it should
be called all the time so errors like that shouldn't happen.  This
should be clearer, or perhaps we should just have a separate device
(perhaps rename the existing one to say that it's for a dumb device with
no control?).

--HqU/NDEOKApT+6Er
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoYqBAAoJECTWi3JdVIfQu8UH/30bGmCST0NnrWXxo4iph7LT
P1WK69Bg2+E+BgihILZ9v/RFDA6lw8PI/dLmfVaF2gpiJoxMphalPhvRFpksCkLb
5hAHWCwA+j7lcQ9+4YmweOqVSiDHhoP186Zxtv5z6vKGAKwIXpY0nfQrzJV+WHxI
1YzwLSGpQH0RWeU8YJjEK3VLXlmqQxP0ApicOe0sVH+JAzFVsqI2Nj8RW75RydVp
Jk+2xxy6mJqu3uD0NNHPWqNQ7VJINejon9AWvdgmNMn7NQHPWjN2qY/fdk5Y8dmF
1wiZJyOESU2kz3KeiYvlHhrf36cS9ZQTZkoSh9vf83pDycPk7ynZyW1YAHARAew=
=5C1c
-----END PGP SIGNATURE-----

--HqU/NDEOKApT+6Er--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
