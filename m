From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v13 3/3] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Tue, 28 Jul 2015 11:24:10 +0100
Message-ID: <20150728102410.GD11162@sirena.org.uk>
References: <cover.1437397270.git.moinejf@free.fr>
 <e036c88aa945e72b40ec965c9358dacf564e79f2.1437397272.git.moinejf@free.fr>
 <20150720180606.GL11162@sirena.org.uk>
 <20150728121945.560f82a5@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wi3pZ2QcHnFkMeXm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150728121945.560f82a5@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--wi3pZ2QcHnFkMeXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 28, 2015 at 12:19:45PM +0200, Jean-Francois Moine wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > > +int tda9998x_codec_register(struct device *dev,
> > > +			struct tda998x_audio_s *tda998x_audio_i,
> > > +			struct tda998x_ops_s *tda998x_ops);
> > > +void tda9998x_codec_unregister(struct device *dev);

> > I'd expect these to be internal to the DRM driver.

> I don't see where. What is your idea?

What I said above - put them in the DRM driver.  They're just
registering a device IIRC.

> > > +config SND_SOC_TDA998X
> > > +	def_tristate y
> > > +	select SND_PCM_ELD
> > > +	depends on DRM_I2C_NXP_TDA998X

> > def_tristate y?  Why?

> The TDA998x CODEC is always generated when the DRM TDA998x is generated
> and when audio is wanted.
> Its type, built-in or module, depends on the TDA998x driver type.

Just make this like any other driver with no default specified.

> > > +/* functions in tda998x_drv */
> > > +static struct tda998x_ops_s *tda998x_ops;

> > I'd expect this to be stored in the driver data rather than a static
> > global, what if a system has two HDMI outputs?

> Each TDA998x has only one HDMI output and there is only one driver.

Someone might put two chips on the board.

> > > +static int tda998x_codec_startup(struct snd_pcm_substream *substream,
> > > +                       struct snd_soc_dai *dai)
> > > +{
> > > +       struct snd_pcm_runtime *runtime = substream->runtime;
> > > +       u8 *eld;
> > > +
> > > +       eld = tda998x_ops->get_eld(dai->dev);
> > > +       if (!eld)
> > > +               return -ENODEV;
> > > +       return snd_pcm_hw_constraint_eld(runtime, eld);
> > > +}

> > Do we really need a device specific mechanism for fishing the ELD out of
> > the graphics code?  I'd have expected this to be more generic.

> I will put the ELD in the private data of the DRM driver.

That's not the issue here - the issue is that the need to get the ELD
out of the video subsystem is not specific to this driver, it's pretty
common and something that it seems we should factor out.

--wi3pZ2QcHnFkMeXm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVt1hKAAoJECTWi3JdVIfQCIUH/0KPko0OHwHJPhqmzHEF8l74
u4+5accPOStXR08xnSyxGRihoeDdTUsZmJdeCsSS7X3ORZyd2qur1AjbNQS9LgzZ
LFMaWPugwQEomxaHWZ3/dosNl6P4h7VoEjL1bubut4TApN0fmGdjqTsN1Gp8E9wy
o/zBGxencQtzUCrud4EzgZYaRT26tcK/y61c54bO/0rdusdVhIuQuz5LjjXD737e
JBEwrD092Ztk+21tg1UbsCgYjnX/Gu9fxDDifuHSKI5MsbYQYjIG4S7q1qqROmk7
YEhDY29cAutIrikxezkaQYnni5ZDOzSJso/j5aGjlLOMmnQZ1dECFjhc6RFiC0w=
=Vm1R
-----END PGP SIGNATURE-----

--wi3pZ2QcHnFkMeXm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
