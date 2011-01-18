From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Subject: Re: [PATCH v2] ASoC: Add FreeScale SGTL5000 codec
	suppor
Date: Tue, 18 Jan 2011 10:32:55 +0800
Message-ID: <20110118023255.GA9481@ubuntu.localdomain>
References: <20110117064816.GA2158@ubuntu.localdomain>
	<20110117153210.GJ21113@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE009.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id BC8DD10380C
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 11:33:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110117153210.GJ21113@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, Zeng Zhaoming <zengzm.kernel@gmail.com>, lrg@slimlogic.co.uk, arnaud.patard@rtp-net.org, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon 2011-01-17 15:32:11, Mark Brown wrote:
> On Mon, Jan 17, 2011 at 02:48:54PM +0800, Zeng Zhaoming wrote:
> > v1 url:
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2010-December/034615.html
> >
> > Changes since v1:
> >   - Add DAPM widges as Mark and Arnaud point out.
> >   - cleanup regulator code
> >   - new implement dai_ops functions
> >   - sort configs in Kconfig and Makefile
> 
> > From 1704fd5e7cf2540e247aa8a4f69d81ae5e6cbd4e Mon Sep 17 00:00:00 2001
> > From: Zeng Zhaoming <zengzm.kernel@gmail.com>
> > Date: Mon, 17 Jan 2011 10:34:42 +0800
> 
> Please submit patches in the form documented in SubmittingPatches.  In
> particular please don't send as an attachement, particularly not with
> extraneous stuff before the changelog.
> 
> > +struct sgtl5000_priv {
> > +     int sysclk;     /* sysclk rate */
> > +     int master;     /* i2s master or not? */
> > +     int fmt;        /* i2s data format */
> > +     int lrclk;      /* frame clock rate */
> > +     int capture_channels;   /* the num of channels for capture. */
> > +     int small_pop;  /* hw assistant to eliminate pop */
> 
> It's not clear why you're storing some of this stuff in the private data
> - for example, capture_channels is only referred to in the place where
> it is set (so you may as well use the original value) and small_pop is
> set unconditionally (it looks like the intention was to have platform
> data for it?).
>
yes, you are right. lrclk and capture_channels fields can be remove.
small_pop is a configurable option of platform data.

> > +static int mic_bias_event(struct snd_soc_dapm_widget *w,
> > +     struct snd_kcontrol *kcontrol, int event)
> > +{
> > +     /* change mic bias resistor to 4Kohm */
> > +     snd_soc_write(w->codec, SGTL5000_CHIP_MIC_CTRL, SGTL5000_BIAS_R_4k);
> > +
> > +     return 0;
> > +}
> 
> This seems really odd - this does the write unconditionally regardless
> of event and never turns anything off.  If this can't just be set once
> at startup then a comment explaining why an event is needed would be
> good.
>
the odd code is cuased by:
If this is set to zero the micbias block is powered off, and 4Kohm is common case
for enabled micbias.
0x0 = Powered off
0x1 = 2Kohm
0x2 = 4Kohm
0x3 = 8Kohm
when turn on micbias, it will set to 2Kohm, so we need to change it to 4Kohm after widget powerup.

> > +static int dac_event(struct snd_soc_dapm_widget *w,
> > +     struct snd_kcontrol *kcontrol, int event)
> > +{
> > +     switch (event) {
> > +     case SND_SOC_DAPM_PRE_PMU:
> > +             snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> > +                     SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP,
> > +                     SGTL5000_VAG_POWERUP|SGTL5000_DAC_POWERUP);
> > +             break;
> > +
> > +     case SND_SOC_DAPM_POST_PMD:
> > +             snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> > +                     SGTL5000_DAC_POWERUP, 0);
> > +             break;
> 
> Why does the powerdown not disable VAG_POWERUP?  My first thought was
> that VAG_POWERUP ought to be a supply widget...
>

My first version, VAG_POWERUP is a supply widget, but spec says:
The headphone (and/or lineout) powerup should be set BEFORE clearing this bit.

But the powerdown sequence go against it.
So I turn to powerup VAG with DAC, and powerdown it before HP and Line_out.
> > +static int adc_event(struct snd_soc_dapm_widget *w,
> > +     struct snd_kcontrol *kcontrol, int event)
> > +{
> > +     snd_soc_update_bits(w->codec, SGTL5000_CHIP_ANA_POWER,
> > +             SGTL5000_ADC_POWERUP,
> > +             SGTL5000_ADC_POWERUP);
> > +
> 
> Again, this is really unclear.
>

ADC powerup be controlled by both CHIP_ANA_POWER and CHIP_DIG_POWER.
It seems we need to set both of them.

> > +/* custom function to get of PCM playback volume */
> > +static int dac_get_volsw(struct snd_kcontrol *kcontrol,
> > +                      struct snd_ctl_elem_value *ucontrol)
> > +{
> > +     struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> > +     int reg, l, r;
> > +
> > +     reg = snd_soc_read(codec, SGTL5000_CHIP_DAC_VOL);
> > +     l = (reg & SGTL5000_DAC_VOL_LEFT_MASK) >> SGTL5000_DAC_VOL_LEFT_SHIFT;
> > +     r = (reg & SGTL5000_DAC_VOL_RIGHT_MASK) >> SGTL5000_DAC_VOL_RIGHT_SHIFT;
> > +     l = l < 0x3c ? 0x3c : l;
> > +     l = l > 0xfc ? 0xfc : l;
> > +     r = r < 0x3c ? 0x3c : r;
> > +     r = r > 0xfc ? 0xfc : r;
> > +
> > +     /* revert it */
> > +     l = 0xfc - l;
> > +     r = 0xfc - r;
> 
> This is really unclear.  The lack of any comments and use of the ternery
> operator isn't helping...  I'd suggest describing the register semantics
> in a comment.
>
Ok, I will add more useful comment for this.
spec says:
Set the Right channel DAC volume with 0.5017 dB steps from 0 to -90 dB
0x3B and less = Reserved
0x3C = 0 dB
0x3D = -0.5 dB
0xF0 = -90 dB
0xFC and greater = Muted

> It also looks like you're missing some locking.
> 
> > +     l = ucontrol->value.integer.value[0];
> > +     r = ucontrol->value.integer.value[1];
> > +
> > +     l = l < 0 ? 0 : l;
> > +     l = l > 0xfc - 0x3c ? 0xfc - 0x3c : l;
> > +     r = r < 0 ? 0 : r;
> > +     r = r > 0xfc - 0x3c ? 0xfc - 0x3c : r;
> > +     l = 0xfc - l;
> > +     r = 0xfc - r;
> 
> Likewise.
> 
> > +     /* we need SOC_DOUBLE_S8_TLV with invert */
> > +     {
> > +             .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> > +             .name = "PCM Playback Volume",
> > +             .access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |
> > +                     SNDRV_CTL_ELEM_ACCESS_READWRITE,
> > +             .info = dac_info_volsw,
> > +             .get = dac_get_volsw,
> > +             .put = dac_put_volsw,
> > +     },
> 
> Perhaps implementing the abstract type would help with the clarity
> issues?
>
> > +     case SND_SOC_DAIFMT_CBM_CFS:
> > +     case SND_SOC_DAIFMT_CBS_CFM:
> > +             return -EINVAL;
> > +             break;
> > +     default:
> > +             return -EINVAL;
> > +     }
> 
> Could just have the default: case.
> 
> > +     if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> > +             sgtl5000->capture_channels = channels;
> > +
> > +             reg = snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER);
> > +             reg |= SGTL5000_ADC_POWERUP;
> > +
> > +             if (sgtl5000->capture_channels == 1)
> > +                     reg &= ~SGTL5000_ADC_STEREO;
> > +             else
> > +                     reg |= SGTL5000_ADC_STEREO;
> > +
> > +             snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER, reg);
> > +     }
> 
> snd_soc_update_bits().
> 
> > +     /* get devided factor of frame clock */
> > +     switch (sys_fs / sgtl5000->lrclk) {
> > +     case 4:
> > +             clk_ctl |= SGTL5000_RATE_MODE_DIV_4 << SGTL5000_RATE_MODE_SHIFT;
> > +             break;
> > +     case 2:
> > +             clk_ctl |= SGTL5000_RATE_MODE_DIV_2 << SGTL5000_RATE_MODE_SHIFT;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> 
> I'd expect to see this error out if it can't find an appropriate
> divider?

the default means sys_fs / lrclk = 1, not a error.
