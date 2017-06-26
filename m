From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v13 05/14] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls.
Date: Mon, 26 Jun 2017 21:21:00 +0200
Message-ID: <20170626192100.h5o366tawcnkqosx@flea.lan>
References: <20170624062419.23778-1-dannym@scratchpost.org>
 <20170624062419.23778-6-dannym@scratchpost.org>
 <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rtkmkjogvbtycwif"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBJ55YXFAKGQEXKPPPTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--rtkmkjogvbtycwif
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Mon, Jun 26, 2017 at 09:48:59AM +0800, Chen-Yu Tsai wrote:
> On Sat, Jun 24, 2017 at 2:24 PM, Danny Milosavljevic
> <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
> > Since it's now possible to have a DAPM mixer control with multiple channels,
> > use it to cut down the total number of controls.
> >
> > Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
> > ---
> >  sound/soc/sunxi/sun4i-codec.c | 27 ++++++++++++---------------
> >  1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> > index c69b55c..3718137 100644
> > --- a/sound/soc/sunxi/sun4i-codec.c
> > +++ b/sound/soc/sunxi/sun4i-codec.c
> > @@ -685,15 +685,12 @@ static const struct snd_kcontrol_new sun7i_codec_extra_controls[] = {
> >                        sun7i_codec_micin_preamp_gain_scale),
> >  };
> >
> > -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
> > -       SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > -                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> > -};
> > -
> > -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
> > -       SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
> > +       SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> >                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
> 
> This changes the mixer control names exposed to userspace. While I think
> consolidating mixer controls is nice, giving the user a less cluttered
> view, I'm not sure about the changing a possible userspace ABI.
> 
> Maxime, ALSA and ASoC people, any comments about this?

Yeah, breaking userspace is definitely not ok.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--rtkmkjogvbtycwif--
