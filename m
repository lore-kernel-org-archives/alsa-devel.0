From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v13 3/3] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Tue, 28 Jul 2015 12:19:45 +0200
Message-ID: <20150728121945.560f82a5@armhf>
References: <cover.1437397270.git.moinejf@free.fr>
 <e036c88aa945e72b40ec965c9358dacf564e79f2.1437397272.git.moinejf@free.fr>
 <20150720180606.GL11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150720180606.GL11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 20 Jul 2015 19:06:06 +0100
Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Fri, May 08, 2015 at 10:41:12AM +0200, Jean-Francois Moine wrote:
>=20
> > +
> > +	if (!priv->is_hdmi_sink
> > +	 || !encoder->crtc)
> > +		return NULL;
>=20
> That's weird indentation.

But the conditions are aligned... This sequence will be removed.

> > +	list_for_each_entry(connector, &drm->mode_config.connector_list, =
head) {
> > +		if (connector->encoder =3D=3D encoder)
> > +			return connector->eld;
> > +	}
>=20
> What guarantees that connector->eld stays valid after it's returned?

You are right, the ELD content may change. I will use a pointer to a
stable content.

> > +struct tda998x_ops_s {
> > +	u8 *(*get_eld)(struct device *dev);
>=20
> Why _ops_s - what does the _s mean?  If it's sound perhaps it makes
> sense to spell it out so people aren't guessing.

I will remove it.

> > +int tda9998x_codec_register(struct device *dev,
> > +			struct tda998x_audio_s *tda998x_audio_i,
> > +			struct tda998x_ops_s *tda998x_ops);
> > +void tda9998x_codec_unregister(struct device *dev);
>=20
> I'd expect these to be internal to the DRM driver.

I don't see where. What is your idea?

> > +config SND_SOC_TDA998X
> > +	def_tristate y
> > +	select SND_PCM_ELD
> > +	depends on DRM_I2C_NXP_TDA998X
> > +
>=20
> def_tristate y?  Why?

The TDA998x CODEC is always generated when the DRM TDA998x is generated
and when audio is wanted.
Its type, built-in or module, depends on the TDA998x driver type.

> > +/* functions in tda998x_drv */
> > +static struct tda998x_ops_s *tda998x_ops;
>=20
> I'd expect this to be stored in the driver data rather than a static
> global, what if a system has two HDMI outputs?

Each TDA998x has only one HDMI output and there is only one driver.

I will put the pointer to the HDMI driver in the device private area.

> > +static int tda998x_codec_startup(struct snd_pcm_substream *substre=
am,
> > +                       struct snd_soc_dai *dai)
> > +{
> > +       struct snd_pcm_runtime *runtime =3D substream->runtime;
> > +       u8 *eld;
> > +
> > +       eld =3D tda998x_ops->get_eld(dai->dev);
> > +       if (!eld)
> > +               return -ENODEV;
> > +       return snd_pcm_hw_constraint_eld(runtime, eld);
> > +}
>=20
> Do we really need a device specific mechanism for fishing the ELD out=
 of
> the graphics code?  I'd have expected this to be more generic.

I will put the ELD in the private data of the DRM driver.

> > +/* ask the HDMI transmitter to activate the audio input port */
> > +static int tda998x_codec_hw_params(struct snd_pcm_substream *subst=
ream,
> > +				   struct snd_pcm_hw_params *params,
> > +				   struct snd_soc_dai *dai)
> > +{
> > +	return tda998x_ops->set_audio_input(dai->dev, dai->id,
> > +					params_rate(params));
> > +}
>=20
> The set_audio_input() function doesn't appear to have anything that
> checks if the device is busy before enabling things, what happens if =
the
> user tries to switch between I2S and S/PDIF?  It looks like only one =
DAI
> can be active at once.

Right. I will check this double streaming.

> > +	for (i =3D 0, p_dai =3D dais; i < ndais ; i++, p_dai++) {
> > +		memcpy(p_dai, &tda998x_dai_i2s, sizeof(*p_dai));
> > +		p_dai->id =3D i;
> > +		if (tda998x_audio->port_types[i] =3D=3D AFMT_SPDIF) {
> > +			p_dai->name =3D "spdif-hifi";
> > +			p_dai->playback.stream_name =3D "HDMI SPDIF Playback";
> > +			p_dai->playback.channels_max =3D 2;
> > +			p_dai->playback.rate_min =3D 22050;
> > +		}
> > +	}
>=20
> It would be a bit clearer if the template were just a template and th=
is
> copying initialised both I2S and S/PDIF specific settings.

OK, I will change this.

> > +	return snd_soc_register_codec(dev,
> > +				&tda998x_codec_drv,
> > +				dais, ndais);
> > +}
> > +EXPORT_SYMBOL(tda9998x_codec_register);
>=20
> ASoC is all EXPORT_SYMBOL_GPL, you shouldn't reexport functionality w=
ith
> plain EXPORT_SYMBOL.

Sorry, bug of mine.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
