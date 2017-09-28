From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: Re: [RFC] ASoC: codecs: msm8916-wcd-analog: use btn0 released
 detection
Date: Thu, 28 Sep 2017 15:10:52 -0400
Message-ID: <20170928191052.gzckp24s4qxlrvbz@workotop.localdomain>
References: <20170913204355.26186-1-damien.riegel@savoirfairelinux.com>
 <3485d646-12fd-4435-1bae-87af9a1a857e@linaro.org>
 <20170919121147.wtpebx6p377cctvc@sirena.co.uk>
 <20170919132237.ctjcpe27pmwu36mm@workotop.localdomain>
 <8bc3ca17-ea40-bedf-0d2f-8f08b66b6f6e@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8bc3ca17-ea40-bedf-0d2f-8f08b66b6f6e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Mark,


I think Srinivas' Ack was only for the snippet quoted below, not for the
original patch of this thread. I don't know if you still want to take
that patch without his Ack or not.

On Thu, Sep 28, 2017 at 11:18:26AM -0700, Srinivas Kandagatla wrote:
> 
> 
> On 19/09/17 06:22, Damien Riegel wrote:
> > Definitely. I also noticed an issue with the first very detection
> > because the micbias will only be set the first time the driver gets a
> > mechanical insertion interrupt. Following snippet seems to solve the
> > problem:
> Does that mean that you do not need the "ASoC: codecs: msm8916-wcd-analog:
> use btn0 released detection" patch anymore?

No, configuring the bias in setup_mbhc only fixes an issue with the very
first detection, we are dealing with two different issues. But I haven't
had the time recently to capture the signal on our board to show you how
our hardware behaves.

> Below changes seems to fine as it is.
> 
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks, I'll resend a proper patch with a real commit message then.

-- 
Damien

> 
> 
> > diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> > index f562f2d86907..5045dabd9ea9 100644
> > --- a/sound/soc/codecs/msm8916-wcd-analog.c
> > +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> > @@ -446,6 +446,7 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
> >   static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
> >   {
> >          struct snd_soc_codec *codec = wcd->codec;
> > +       bool micbias_enabled = false;
> >          u32 plug_type = 0;
> >          u32 int_en_mask;
> > 
> > @@ -477,6 +478,11 @@ static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
> >                              DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
> >                              DIG_CLK_CTL_D_MBHC_CLK_EN);
> > 
> > +       if (snd_soc_read(codec, CDC_A_MICB_2_EN) & CDC_A_MICB_2_EN_ENABLE)
> > +               micbias_enabled = true;
> > +
> > +       pm8916_mbhc_configure_bias(priv, micbias_enabled);
> > +
> >          int_en_mask = MBHC_SWITCH_INT;
> >          if (wcd->mbhc_btn_enabled)
> >                  int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
> > 
