From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH v3] ASoC: add RT286 CODEC driver
Date: Fri, 7 Feb 2014 13:45:45 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70297E2@RTITMBSV03.realtek.com.tw>
References: <1386727090-15543-1-git-send-email-bardliao@realtek.com>
 <20131218192040.GN31886@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D702946A@RTITMBSV03.realtek.com.tw>
 <20140207125103.GJ32298@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 15A69265319
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2014 14:45:53 +0100 (CET)
In-Reply-To: <20140207125103.GJ32298@sirena.org.uk>
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
> Sent: Friday, February 07, 2014 8:51 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Flove; Oder Chiou;
> leon@leon.nu
> Subject: Re: [PATCH v3] ASoC: add RT286 CODEC driver
> 
> On Fri, Feb 07, 2014 at 07:27:44AM +0000, Bard Liao wrote:
> 
> > > > +	if (rt286->pdata.irq_en)
> > > > +		rt286_index_update_bits(codec,
> > > > +			NODE_ID_VENDOR_REGISTERS, 0x33, 0x0002, 0x0002);
> 
> > > Why would the system ever want to supply an interrupt and not use it?
> 
> > The codec support a configurable irq pin which can be disable or enable.
> > Some customers may not use it.
> > So, I add a flag in platform data to configure it.
> 
> Should it not be possible to do this based on if an interrupt is specified - why is
> a separate configuration option needed for this when the user also needs to
> specify if an interrupt is used and which interrupt is used?
> 

You are right. I will do that base on if an interrupt is specified.

> > > > +static int rt286_hp_event(struct snd_soc_dapm_widget *w,
> > > > +			   struct snd_kcontrol *kcontrol, int event) {
> > > > +	struct snd_soc_codec *codec = w->codec;
> > > > +	unsigned int val;
> > > > +
> > > > +	switch (event) {
> > > > +	case SND_SOC_DAPM_POST_PMU:
> > > > +		val = snd_soc_read(codec, NODE_ID_HP_OUT) & 0x8080;
> > > > +		switch (val) {
> > > > +		case 0x0:
> > > > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > > > +				NODE_ID_HP_OUT, 0xb000);
> > > > +			break;
> > > > +		case 0x8000:
> > > > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > > > +				NODE_ID_HP_OUT, 0x9000);
> > > > +			break;
> > > > +		case 0x0080:
> > > > +			rt286_write(codec, AC_VERB_SET_AMP_GAIN_MUTE,
> > > > +				NODE_ID_HP_OUT, 0xa000);
> > > > +			break;
> > > > +		}
> > >
> > > This is rather unclear.  What is it doing?
> >
> > SOC_DOUBLE_EXT("Headphone Playback Switch", NODE_ID_HP_OUT,
> > 			   15, 8, 1, 1, rt286_playback_switch_get,
> > 			   rt286_playback_switch_put),
> > We use NODE_ID_HP_OUT bit 15, 8 to store the mute/unmute status for
> headphone L/R channel.
> > rt286_hp_event will mute both channels when power down.
> > And it will read the status from RT286_HP_OUT to unmute the
> corresponding channel(s) when power on.
> 
> So how does the mute control work when the headphone is powered up then?
> You may be looking for a SOC_DAPM_SINGLE_AUTODISABLE() control here, I
> think that's what you're implementing here.

rt286_playback_switch_put will mute/unmute headphone immediately.
So, when the headphone is already powered on, headphone will be muted if "Headphone Playback Switch" is set to off.
And I think it is no problem if user unmute the headphone during headphone is powered off.
Yes, what I am implementing here is what SOC_DAPM_SINGLE_AUTODISABLE() does.
The problem I meet is rt286 uses different registers for read and write the same bits.
That's why I didn't use SOC_DAPM_SINGLE_AUTODISABLE() control here.

> 
> ------Please consider the environment before printing this e-mail.
