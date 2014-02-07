From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v3] ASoC: add RT286 CODEC driver
Date: Fri, 7 Feb 2014 07:27:44 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D702946A@RTITMBSV03.realtek.com.tw>
References: <1386727090-15543-1-git-send-email-bardliao@realtek.com>
 <20131218192040.GN31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A56D2652CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 08:27:51 +0100 (CET)
In-Reply-To: <20131218192040.GN31886@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, "leon@leon.nu" <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, December 19, 2013 3:21 AM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou;
> leon@leon.nu
> Subject: Re: [PATCH v3] ASoC: add RT286 CODEC driver
> 
> 
> > +	if (rt286->pdata.irq_en)
> > +		rt286_index_update_bits(codec,
> > +			NODE_ID_VENDOR_REGISTERS, 0x33, 0x0002, 0x0002);
> 
> Why would the system ever want to supply an interrupt and not use it?

The codec support a configurable irq pin which can be disable or enable.
Some customers may not use it.
So, I add a flag in platform data to configure it.

> 
> > +	/* Set configuration default  */
> > +	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
> > +		NODE_ID_MIC1, 0x00);
> > +	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
> > +		NODE_ID_DMIC1, 0x00);
> > +	rt286_write(codec, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
> > +		NODE_ID_DMIC2, 0x00);
> 
> Why are the silicon defaults not adequate?

Actually, they are hardware dependency.
I will add a configuration flag in platform data.

> 
> > +static int rt286_hp_event(struct snd_soc_dapm_widget *w,
> > +			   struct snd_kcontrol *kcontrol, int event) {
> > +	struct snd_soc_codec *codec = w->codec;
> > +	unsigned int val;
> > +
> > +	switch (event) {
> > +	case SND_SOC_DAPM_POST_PMU:
> > +		val = snd_soc_read(codec, NODE_ID_HP_OUT) & 0x8080;
> > +		switch (val) {
> > +		case 0x0:
> > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > +				NODE_ID_HP_OUT, 0xb000);
> > +			break;
> > +		case 0x8000:
> > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > +				NODE_ID_HP_OUT, 0x9000);
> > +			break;
> > +		case 0x0080:
> > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > +				NODE_ID_HP_OUT, 0xa000);
> > +			break;
> > +		}
> 
> This is rather unclear.  What is it doing?

SOC_DOUBLE_EXT("Headphone Playback Switch", NODE_ID_HP_OUT,
			   15, 8, 1, 1, rt286_playback_switch_get,
			   rt286_playback_switch_put),
We use NODE_ID_HP_OUT bit 15, 8 to store the mute/unmute status for headphone L/R channel.
rt286_hp_event will mute both channels when power down.
And it will read the status from RT286_HP_OUT to unmute the corresponding channel(s) when power on.


> 
> 
> > +static int rt286_set_bias_level(struct snd_soc_codec *codec,
> > +				 enum snd_soc_bias_level level)
> > +{
> > +	switch (level) {
> > +	case SND_SOC_BIAS_PREPARE:
> > +		if (SND_SOC_BIAS_STANDBY == codec->dapm.bias_level)
> > +			rt286_write(codec, AC_VERB_SET_POWER_STATE,
> > +				NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D0);
> > +		break;
> > +
> > +	case SND_SOC_BIAS_OFF:
> > +		rt286_write(codec, AC_VERB_SET_POWER_STATE,
> > +			NODE_ID_AUDIO_FUNCTION_GROUP, AC_PWRST_D3);
> > +		break;
> 
> These aren't matched - you power up when leaving standby but only power
> down when you go to off.  That's a bit odd and probably won't do the right
> thing and will leave the CODEC powered up all the time since you don't set
> idle_bias_off (though perhaps you should).

I will power off the codec in standby.

> 
> I'm also not seeing any code for interrupts even though there appears to be
> some code to initialise them in the driver.

I will add it along with jack detection function in another patch later.

Thanks.

> 
> ------Please consider the environment before printing this e-mail.
