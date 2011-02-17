From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Subject: Re: [PATCH v3] ASoC: Add Freescale SGTL5000 codec
 support
Date: Thu, 17 Feb 2011 09:21:40 +0800
Message-ID: <20110217012140.GA4111@ubuntu.localdomain>
References: <1297810576-2575-1-git-send-email-zhaoming.zeng@freescale.com>
	<87aahvoxej.fsf@lechat.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 616CB10390B
	for <alsa-devel@alsa-project.org>; Thu, 17 Feb 2011 10:28:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87aahvoxej.fsf@lechat.rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, zengzm.kernel@gmail.com, lrg@slimlogic.co.uk, linuxzsc@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu 2011-02-17 09:52:52, Arnaud Patard wrote:
> <zhaoming.zeng@freescale.com> writes:
> 
> Hi,
> 
> 
> > From: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> >
> > Add Freescale SGTL5000 codec support
> >
> > Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
> > ---
> > changes since v2:
> > 1. clean up register default values
> > 2. rewrite codec power up code, add sgtl5000_set_power_regs()
> > 3. rewrite codec clock configure code sgtl5000_set_clock()
> > 4. reimplement PM hooks, restore register by particular order.
> > 5. clean up dapm code, remove dac and adc event hooks.
> > 6. clean up codec private structure, remove unnecessary fields.
> > 7. add comments for uncommon code.
> >
> > Thanks for Mark's review.
> 
> [...]
> 
> > +/*
> > + * custom put function for PCM playback volume
> > + * PCM volume with 0.5017 dB steps from 0 to -90 dB
> > + * 0x3B and less = Reserved
> > + * 0x3C = 0 dB
> > + * 0x3D = -0.5 dB
> > + * 0xF0 = -90 dB
> > + * 0xFC and greater = Muted
> > + */
> > +static int dac_put_volsw(struct snd_kcontrol *kcontrol,
> > +			 struct snd_ctl_elem_value *ucontrol)
> > +{
> > +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> > +	int reg, l, r;
> > +
> > +	l = ucontrol->value.integer.value[0];
> > +	r = ucontrol->value.integer.value[1];
> > +
> > +	l = l < 0 ? 0 : l;
> > +	l = l > 0xfc - 0x3c ? 0xfc - 0x3c : l;
> > +	r = r < 0 ? 0 : r;
> > +	r = r > 0xfc - 0x3c ? 0xfc - 0x3c : r;
> > +	l = 0xfc - l;
> > +	r = 0xfc - r;
> > +
> > +	reg = l << SGTL5000_DAC_VOL_LEFT_SHIFT |
> > +	    r << SGTL5000_DAC_VOL_RIGHT_SHIFT;
> > +
> > +	snd_soc_update_bits_locked(codec, SGTL5000_CHIP_DAC_VOL, reg, reg);
> 
> Why are you using update_bits_locked and not snd_soc_write ?
> Here snd_soc_update_bits_locked is just good at making the PCM playback
> mixer acting weird (I even got to a point that with a 0 value in the
> mixer, I was unable to raise the volume). snd_soc_write just works.
> 
> [...]
>
hi, Arnaud, thanks. I just find this problem too.
It will be changed to snd_soc_write() in v4.

> > +
> > +static int sgtl5000_probe(struct snd_soc_codec *codec)
> > +{
> > +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> > +	u16 reg;
> > +	int ret;
> > +	int rev;
> > +	int i;
> > +
> > +	/* setup i2c data ops */
> > +	ret = snd_soc_codec_set_cache_io(codec, 16, 16, SND_SOC_I2C);
> > +	if (ret < 0) {
> > +		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* read chip information */
> > +	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
> 
> I've a problem with doing that here. You do assume that the regulators
> are enabled at this point which is not always the case. This results on
> a timeout on i2c and then reg contains 0. Please enable regultors firsts
> And no, I don't see having the regulators for things like vddio set to
> "always on" in the machine file as a good idea. If the driver is not
> loaded, having the codec off is good for power consumption.
>
you are right, I always enable regulator in platform code,
it is better to enable it when driver is loading. I will fix it in v4.

> Arnaud
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
