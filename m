From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v13 3/3] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Mon, 20 Jul 2015 19:06:06 +0100
Message-ID: <20150720180606.GL11162@sirena.org.uk>
References: <cover.1437397270.git.moinejf@free.fr>
 <e036c88aa945e72b40ec965c9358dacf564e79f2.1437397272.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D1fPXr6nrXZW0cyN"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e036c88aa945e72b40ec965c9358dacf564e79f2.1437397272.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--D1fPXr6nrXZW0cyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 08, 2015 at 10:41:12AM +0200, Jean-Francois Moine wrote:

> +
> +	if (!priv->is_hdmi_sink
> +	 || !encoder->crtc)
> +		return NULL;

That's weird indentation.

> +	list_for_each_entry(connector, &drm->mode_config.connector_list, head) {
> +		if (connector->encoder == encoder)
> +			return connector->eld;
> +	}

What guarantees that connector->eld stays valid after it's returned?

> +struct tda998x_ops_s {
> +	u8 *(*get_eld)(struct device *dev);

Why _ops_s - what does the _s mean?  If it's sound perhaps it makes
sense to spell it out so people aren't guessing.

> +int tda9998x_codec_register(struct device *dev,
> +			struct tda998x_audio_s *tda998x_audio_i,
> +			struct tda998x_ops_s *tda998x_ops);
> +void tda9998x_codec_unregister(struct device *dev);

I'd expect these to be internal to the DRM driver.

> +config SND_SOC_TDA998X
> +	def_tristate y
> +	select SND_PCM_ELD
> +	depends on DRM_I2C_NXP_TDA998X
> +

def_tristate y?  Why?

> +/* functions in tda998x_drv */
> +static struct tda998x_ops_s *tda998x_ops;

I'd expect this to be stored in the driver data rather than a static
global, what if a system has two HDMI outputs?

> +static int tda998x_codec_startup(struct snd_pcm_substream *substream,
> +                       struct snd_soc_dai *dai)
> +{
> +       struct snd_pcm_runtime *runtime = substream->runtime;
> +       u8 *eld;
> +
> +       eld = tda998x_ops->get_eld(dai->dev);
> +       if (!eld)
> +               return -ENODEV;
> +       return snd_pcm_hw_constraint_eld(runtime, eld);
> +}

Do we really need a device specific mechanism for fishing the ELD out of
the graphics code?  I'd have expected this to be more generic.

> +/* ask the HDMI transmitter to activate the audio input port */
> +static int tda998x_codec_hw_params(struct snd_pcm_substream *substream,
> +				   struct snd_pcm_hw_params *params,
> +				   struct snd_soc_dai *dai)
> +{
> +	return tda998x_ops->set_audio_input(dai->dev, dai->id,
> +					params_rate(params));
> +}

The set_audio_input() function doesn't appear to have anything that
checks if the device is busy before enabling things, what happens if the
user tries to switch between I2S and S/PDIF?  It looks like only one DAI
can be active at once.

> +	for (i = 0, p_dai = dais; i < ndais ; i++, p_dai++) {
> +		memcpy(p_dai, &tda998x_dai_i2s, sizeof(*p_dai));
> +		p_dai->id = i;
> +		if (tda998x_audio->port_types[i] == AFMT_SPDIF) {
> +			p_dai->name = "spdif-hifi";
> +			p_dai->playback.stream_name = "HDMI SPDIF Playback";
> +			p_dai->playback.channels_max = 2;
> +			p_dai->playback.rate_min = 22050;
> +		}
> +	}

It would be a bit clearer if the template were just a template and this
copying initialised both I2S and S/PDIF specific settings.

> +	return snd_soc_register_codec(dev,
> +				&tda998x_codec_drv,
> +				dais, ndais);
> +}
> +EXPORT_SYMBOL(tda9998x_codec_register);

ASoC is all EXPORT_SYMBOL_GPL, you shouldn't reexport functionality with
plain EXPORT_SYMBOL.

--D1fPXr6nrXZW0cyN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVrTiNAAoJECTWi3JdVIfQ7osH/0ynfbV4ZmV4dn9/7chvbdqW
mO1sdPD9iZVh+bVyNF/RA5XlJVNNxuYwk+7PwOl4wSNDA3cxgsPQwFel+HdwQ3Yv
FRkw/vyKb/2Ew4fdEw4a0QamZ2OzoJEasJrxaEvDT3Pq2cn9dtcLEeS0N8P2P5OB
9cgciMzfpTTE0NHu1lybDWAAjEYK0mpLowU4utiLsvR2RtDid+Qo0oBRHkuKMdSg
m5bo3xbNq/wRGwtUzhxlaCMojzc0V+3ud+tkyvDXz0b/6E6PwJN3W2PHrrgtxeKa
Z63Jk3SXlN5moRDHRGNczDxBtsxEVSFqUYCNNEHrw04uK/X6tIhrfSuwdcY3llc=
=wKcR
-----END PGP SIGNATURE-----

--D1fPXr6nrXZW0cyN--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
