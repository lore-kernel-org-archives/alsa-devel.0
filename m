From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: Re: [PATCH v13 05/14] ASoC: sun4i-codec: Merge
 sun4i_codec_left_mixer_controls and sun4i_codec_right_mixer_controls into sun4i_codec_mixer_controls.
Date: Wed, 28 Jun 2017 10:25:20 +0200
Message-ID: <20170628102520.29c50592@scratchpost.org>
References: <20170624062419.23778-1-dannym@scratchpost.org>
	<20170624062419.23778-6-dannym@scratchpost.org>
	<CAGb2v64i_S5HCsLHJGg0WbkFodOFFc5masUYQ53JaLTO7N2BMw@mail.gmail.com>
	<20170626192100.h5o366tawcnkqosx@flea.lan>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCPKHTHNWIPBB46PZXFAKGQEC55INEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170626192100.h5o366tawcnkqosx-ZC1Zs529Oq4@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> > > -static const struct snd_kcontrol_new sun4i_codec_left_mixer_controls[] = {
> > > -       SOC_DAPM_SINGLE("Left DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > > -                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
> > > -};
> > > -
> > > -static const struct snd_kcontrol_new sun4i_codec_right_mixer_controls[] = {
> > > -       SOC_DAPM_SINGLE("Right DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > > +static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
> > > +       SOC_DAPM_DOUBLE("DAC Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > > +                       SUN4I_CODEC_DAC_ACTL_LDACLMIXS,
> > >                         SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),  
> > 
> > This changes the mixer control names exposed to userspace. While I think
> > consolidating mixer controls is nice, giving the user a less cluttered
> > view, I'm not sure about the changing a possible userspace ABI.
> > 
> > Maxime, ALSA and ASoC people, any comments about this?  

>Yeah, breaking userspace is definitely not ok.

Okay.  I can restore DAC Playback Switch as two different controls with the same
names as before.

Is the mixer itself (SND_SOC_DAPM_MIXER) - not talking about its controls -
exposed to userspace?

Because if not, I can still merge the left mixer and right mixer and just fix up
the control names for DAC Playback Switch to be the same as before, something
like this:

static const struct snd_kcontrol_new sun4i_codec_mixer_controls[] = {
        SOC_DAPM_SINGLE("Left Mixer Left DAC Playback Switch", // !!!
                        SUN4I_CODEC_DAC_ACTL,
                        SUN4I_CODEC_DAC_ACTL_LDACLMIXS, 1, 0),
        SOC_DAPM_SINGLE("Right Mixer Right DAC Playback Switch", // !!!
                        SUN4I_CODEC_DAC_ACTL,
                        SUN4I_CODEC_DAC_ACTL_RDACRMIXS, 1, 0),
        SOC_DAPM_SINGLE("Right Mixer Left DAC Playback Switch",
                        SUN4I_CODEC_DAC_ACTL,
                        SUN4I_CODEC_DAC_ACTL_LDACRMIXS, 1, 0),
        SOC_DAPM_DOUBLE("Line Playback Switch", SUN4I_CODEC_DAC_ACTL,
                        SUN4I_CODEC_DAC_ACTL_LLNS,
                        SUN4I_CODEC_DAC_ACTL_RLNS, 1, 0),
        SOC_DAPM_DOUBLE("FM Playback Switch", SUN4I_CODEC_DAC_ACTL,
                        SUN4I_CODEC_DAC_ACTL_LFMS,
                        SUN4I_CODEC_DAC_ACTL_RFMS, 1, 0),
        SOC_DAPM_DOUBLE("Mic1 Playback Switch", SUN4I_CODEC_DAC_ACTL,
                        SUN4I_CODEC_DAC_ACTL_MIC1LS,
                        SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
        SOC_DAPM_DOUBLE("Mic2 Playback Switch", SUN4I_CODEC_DAC_ACTL,
                        SUN4I_CODEC_DAC_ACTL_MIC2LS,
                        SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
};

static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
...
        SND_SOC_DAPM_MIXER("Left Mixer", SND_SOC_NOPM, 0, 0,
                           sun4i_codec_mixer_controls,
                           ARRAY_SIZE(sun4i_codec_mixer_controls)), // !!!
        SND_SOC_DAPM_MIXER("Right Mixer", SND_SOC_NOPM, 0, 0,
                           sun4i_codec_mixer_controls,
                           ARRAY_SIZE(sun4i_codec_mixer_controls)), // !!!
};

Would this be a good way?
