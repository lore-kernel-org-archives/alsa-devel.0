From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH v2] ASoC: wm8960: add dapm kcontrols to
 select left/right ADC input source
Date: Wed, 17 Jun 2015 16:58:30 +0800
Message-ID: <20150617085828.GA17972@shlinux2>
References: <1434435799-26829-1-git-send-email-zidan.wang@freescale.com>
 <20150616121839.GM32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150616121839.GM32730@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 16, 2015 at 01:18:39PM +0100, Charles Keepax wrote:
> On Tue, Jun 16, 2015 at 02:23:19PM +0800, Zidan Wang wrote:
> > Add dapm kcontrols to select left/right ADC input source, one to select
> > the left ADC input source and one for the right ADC input source.
> > 
> > In default, the left ADC will select the left input, and the right ADC will
> > select the right input. When the left(right) ADC select the right(left) input,
> > the left(right) input path will be powered down.
> > 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > ---
> >  sound/soc/codecs/wm8960.c | 24 ++++++++++++++++++++++--
> >  1 file changed, 22 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> > index 023e898..3ea12b7 100644
> > --- a/sound/soc/codecs/wm8960.c
> > +++ b/sound/soc/codecs/wm8960.c
> > @@ -141,6 +141,8 @@ static const char *wm8960_3d_upper_cutoff[] = {"High", "Low"};
> >  static const char *wm8960_3d_lower_cutoff[] = {"Low", "High"};
> >  static const char *wm8960_alcfunc[] = {"Off", "Right", "Left", "Stereo"};
> >  static const char *wm8960_alcmode[] = {"ALC", "Limiter"};
> > +static const char *wm8960_adcl_src_text[] = {"Left", "Right"};
> > +static const char *wm8960_adcr_src_text[] = {"Right", "Left"};
> >  
> >  static const struct soc_enum wm8960_enum[] = {
> >  	SOC_ENUM_SINGLE(WM8960_DACCTL1, 5, 4, wm8960_polarity),
> > @@ -150,6 +152,10 @@ static const struct soc_enum wm8960_enum[] = {
> >  	SOC_ENUM_SINGLE(WM8960_ALC1, 7, 4, wm8960_alcfunc),
> >  	SOC_ENUM_SINGLE(WM8960_ALC3, 8, 2, wm8960_alcmode),
> >  };
> > +static SOC_ENUM_SINGLE_DECL(wm8960_adcl_src_enum,
> > +			    WM8960_ADDCTL1, 3, wm8960_adcl_src_text);
> > +static SOC_ENUM_SINGLE_DECL(wm8960_adcr_src_enum,
> > +			    WM8960_ADDCTL1, 2, wm8960_adcr_src_text);
> >  
> >  static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
> >  
> > @@ -281,6 +287,11 @@ SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
> >  	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
> >  };
> >  
> > +static const struct snd_kcontrol_new wm8960_adcl_mux =
> > +	SOC_DAPM_ENUM("ADCL Source", wm8960_adcl_src_enum);
> > +static const struct snd_kcontrol_new wm8960_adcr_mux =
> > +	SOC_DAPM_ENUM("ADCR Source", wm8960_adcr_src_enum);
> > +
> >  static const struct snd_kcontrol_new wm8960_lin_boost[] = {
> >  SOC_DAPM_SINGLE("LINPUT2 Switch", WM8960_LINPATH, 6, 1, 0),
> >  SOC_DAPM_SINGLE("LINPUT3 Switch", WM8960_LINPATH, 7, 1, 0),
> > @@ -344,6 +355,9 @@ SND_SOC_DAPM_ADC("Right ADC", "Capture", WM8960_POWER1, 2, 0),
> >  SND_SOC_DAPM_DAC("Left DAC", "Playback", WM8960_POWER2, 8, 0),
> >  SND_SOC_DAPM_DAC("Right DAC", "Playback", WM8960_POWER2, 7, 0),
> >  
> > +SND_SOC_DAPM_MUX("ADCL Source", SND_SOC_NOPM, 0, 0, &wm8960_adcl_mux),
> > +SND_SOC_DAPM_MUX("ADCR Source", SND_SOC_NOPM, 0, 0, &wm8960_adcr_mux),
> > +
> >  SND_SOC_DAPM_MIXER("Left Output Mixer", WM8960_POWER3, 3, 0,
> >  	&wm8960_loutput_mixer[0],
> >  	ARRAY_SIZE(wm8960_loutput_mixer)),
> > @@ -399,8 +413,14 @@ static const struct snd_soc_dapm_route audio_paths[] = {
> >  	{ "Right Input Mixer", NULL, "RINPUT2" },
> >  	{ "Right Input Mixer", NULL, "RINPUT3" },
> >  
> > -	{ "Left ADC", NULL, "Left Input Mixer" },
> > -	{ "Right ADC", NULL, "Right Input Mixer" },
> > +	{ "ADCL Source", "Left", "Left Input Mixer" },
> > +	{ "ADCL Source", "Right", "Right Input Mixer" },
> > +
> > +	{ "ADCR Source", "Left", "Left Input Mixer" },
> > +	{ "ADCR Source", "Right", "Right Input Mixer" },
> > +
> > +	{ "Left ADC", NULL, "ADCL Source" },
> > +	{ "Right ADC", NULL, "ADCR Source" },
> 
> Are you sure this is correct? My reading is that those bits don't
> affect routing at all, they mearly determine how the channel is
> sent out on the AIF.
> 
I have tested on my board, it can works, but it has something wrong.

If set "ADCR Source" to "Left", RINPUT1(RINPUT2 and RINPUT3)->"Right Input Mixer" will
be powered down, but "Right ADC" is still powered up. Do you have some best method to 
set the audio route?

Thanks,
Zidan Wang


> Thanks,
> Charles
