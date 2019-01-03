From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: virtuoso: add de-emphasis control
Date: Thu, 3 Jan 2019 23:19:47 +0800
Message-ID: <CAGnHSEk9=5WjE6Dd6OPeQpHg2mk+QoOhunb-YkRM2iKti24eeQ@mail.gmail.com>
References: <5c2e0218.1c69fb81.b8dff.5bbb@mx.google.com>
 <s5htvip6fov.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by alsa0.perex.cz (Postfix) with ESMTP id AD50D267BD4
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 16:19:59 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id a20so22497812edc.8
 for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2019 07:19:59 -0800 (PST)
In-Reply-To: <s5htvip6fov.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Oh sorry. They are just resend. Thanks a lot!

On Thu, 3 Jan 2019 at 21:20, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 03 Jan 2019 13:37:26 +0100,
> tom.ty89@gmail.com wrote:
> >
> > From: Tom Yan <tom.ty89@gmail.com>
> >
> > Add control for the de-emphasis filter in the PCM179x DACs
> >
> > Signed-off-by: Tom Yan <tom.ty89@gmail.com>
>
> Is this just a resend of the previous same patch?
>
> The patches are already tracked for post-4.21 material, so they'll be
> merged after 4.21-rc1 release.  Just be patient for a while.
>
>
> thanks,
>
> Takashi
>
> >
> > diff --git a/sound/pci/oxygen/pcm1796.h b/sound/pci/oxygen/pcm1796.h
> > index 34d07dd2d22e..d5dcb09e44cd 100644
> > --- a/sound/pci/oxygen/pcm1796.h
> > +++ b/sound/pci/oxygen/pcm1796.h
> > @@ -10,7 +10,6 @@
> >  #define PCM1796_MUTE         0x01
> >  #define PCM1796_DME          0x02
> >  #define PCM1796_DMF_MASK     0x0c
> > -#define PCM1796_DMF_DISABLED 0x00
> >  #define PCM1796_DMF_48               0x04
> >  #define PCM1796_DMF_441              0x08
> >  #define PCM1796_DMF_32               0x0c
> > diff --git a/sound/pci/oxygen/xonar_pcm179x.c b/sound/pci/oxygen/xonar_pcm179x.c
> > index 24109d37ca09..a1c6b98b191e 100644
> > --- a/sound/pci/oxygen/xonar_pcm179x.c
> > +++ b/sound/pci/oxygen/xonar_pcm179x.c
> > @@ -331,7 +331,7 @@ static void pcm1796_init(struct oxygen *chip)
> >       struct xonar_pcm179x *data = chip->model_data;
> >
> >       data->pcm1796_regs[0][18 - PCM1796_REG_BASE] =
> > -             PCM1796_DMF_DISABLED | PCM1796_FMT_24_I2S | PCM1796_ATLD;
> > +             PCM1796_FMT_24_I2S | PCM1796_ATLD;
> >       if (!data->broken_i2c)
> >               data->pcm1796_regs[0][18 - PCM1796_REG_BASE] |= PCM1796_MUTE;
> >       data->pcm1796_regs[0][19 - PCM1796_REG_BASE] =
> > @@ -621,6 +621,23 @@ static void update_pcm1796_oversampling(struct oxygen *chip)
> >               pcm1796_write_cached(chip, i, 20, reg);
> >  }
> >
> > +static void update_pcm1796_deemph(struct oxygen *chip)
> > +{
> > +     struct xonar_pcm179x *data = chip->model_data;
> > +     unsigned int i;
> > +     u8 reg;
> > +
> > +     reg = data->pcm1796_regs[0][18 - PCM1796_REG_BASE] & ~PCM1796_DMF_MASK;
> > +     if (data->current_rate == 48000)
> > +             reg |= PCM1796_DMF_48;
> > +     else if (data->current_rate == 44100)
> > +             reg |= PCM1796_DMF_441;
> > +     else if (data->current_rate == 32000)
> > +             reg |= PCM1796_DMF_32;
> > +     for (i = 0; i < data->dacs; ++i)
> > +             pcm1796_write_cached(chip, i, 18, reg);
> > +}
> > +
> >  static void set_pcm1796_params(struct oxygen *chip,
> >                              struct snd_pcm_hw_params *params)
> >  {
> > @@ -629,6 +646,7 @@ static void set_pcm1796_params(struct oxygen *chip,
> >       msleep(1);
> >       data->current_rate = params_rate(params);
> >       update_pcm1796_oversampling(chip);
> > +     update_pcm1796_deemph(chip);
> >  }
> >
> >  static void update_pcm1796_volume(struct oxygen *chip)
> > @@ -653,9 +671,11 @@ static void update_pcm1796_mute(struct oxygen *chip)
> >       unsigned int i;
> >       u8 value;
> >
> > -     value = PCM1796_DMF_DISABLED | PCM1796_FMT_24_I2S | PCM1796_ATLD;
> > +     value = data->pcm1796_regs[0][18 - PCM1796_REG_BASE];
> >       if (chip->dac_mute)
> >               value |= PCM1796_MUTE;
> > +     else
> > +             value &= ~PCM1796_MUTE;
> >       for (i = 0; i < data->dacs; ++i)
> >               pcm1796_write_cached(chip, i, 18, value);
> >  }
> > @@ -777,6 +797,49 @@ static const struct snd_kcontrol_new rolloff_control = {
> >       .put = rolloff_put,
> >  };
> >
> > +static int deemph_get(struct snd_kcontrol *ctl,
> > +                    struct snd_ctl_elem_value *value)
> > +{
> > +     struct oxygen *chip = ctl->private_data;
> > +     struct xonar_pcm179x *data = chip->model_data;
> > +
> > +     value->value.integer.value[0] =
> > +             !!(data->pcm1796_regs[0][18 - PCM1796_REG_BASE] & PCM1796_DME);
> > +     return 0;
> > +}
> > +
> > +static int deemph_put(struct snd_kcontrol *ctl,
> > +                    struct snd_ctl_elem_value *value)
> > +{
> > +     struct oxygen *chip = ctl->private_data;
> > +     struct xonar_pcm179x *data = chip->model_data;
> > +     unsigned int i;
> > +     int changed;
> > +     u8 reg;
> > +
> > +     mutex_lock(&chip->mutex);
> > +     reg = data->pcm1796_regs[0][18 - PCM1796_REG_BASE];
> > +     if (!value->value.integer.value[0])
> > +             reg &= ~PCM1796_DME;
> > +     else
> > +             reg |= PCM1796_DME;
> > +     changed = reg != data->pcm1796_regs[0][18 - PCM1796_REG_BASE];
> > +     if (changed) {
> > +             for (i = 0; i < data->dacs; ++i)
> > +                     pcm1796_write(chip, i, 18, reg);
> > +     }
> > +     mutex_unlock(&chip->mutex);
> > +     return changed;
> > +}
> > +
> > +static const struct snd_kcontrol_new deemph_control = {
> > +     .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> > +     .name = "De-emphasis Playback Switch",
> > +     .info = snd_ctl_boolean_mono_info,
> > +     .get = deemph_get,
> > +     .put = deemph_put,
> > +};
> > +
> >  static const struct snd_kcontrol_new hdav_hdmi_control = {
> >       .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> >       .name = "HDMI Playback Switch",
> > @@ -1011,6 +1074,10 @@ static int add_pcm1796_controls(struct oxygen *chip)
> >                                 snd_ctl_new1(&rolloff_control, chip));
> >               if (err < 0)
> >                       return err;
> > +             err = snd_ctl_add(chip->card,
> > +                               snd_ctl_new1(&deemph_control, chip));
> > +             if (err < 0)
> > +                     return err;
> >       }
> >       return 0;
> >  }
> > --
> > 2.20.1
> >
