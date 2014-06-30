From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
Date: Mon, 30 Jun 2014 05:38:59 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D75C87D9@RTITMBSV03.realtek.com.tw>
References: <1402028138-27444-1-git-send-email-bardliao@realtek.com>
 <20140627153143.GP23300@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E5612615F3
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 07:39:10 +0200 (CEST)
In-Reply-To: <20140627153143.GP23300@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Friday, June 27, 2014 11:32 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou
> Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
> 
> > +static int check_dac_monor_asrc_source(struct snd_soc_dapm_widget
> *source,
> > +			 struct snd_soc_dapm_widget *sink) {
> > +	struct snd_soc_codec *codec = source->codec;
> > +
> > +	return is_using_asrc(codec, RT5670_ASRC_2, 4); }
> 
> I have to say I'm not convinced all these wrapper functions are really
> adding much - just making is_using_asrc() take a widget and passing the
> arguments directly seems as simple.

Do you mean use is_using_asrc() as the checking function for all of those
widgets, and use different arguments for different widgets?

> 
> > +	/* ASRC */
> > +	SND_SOC_DAPM_SUPPLY_S("I2S1 ASRC", 1, RT5670_ASRC_1,
> > +			      11, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("I2S2 ASRC", 1, RT5670_ASRC_1,
> > +			      12, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("DAC STO ASRC", 1, RT5670_ASRC_1,
> > +			      10, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("DAC MONO L ASRC", 1,
> RT5670_ASRC_1,
> > +			      9, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("DAC MONO R ASRC", 1,
> RT5670_ASRC_1,
> > +			      8, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("ADC STO1 ASRC", 1, RT5670_ASRC_1,
> > +			      3, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("ADC STO2 ASRC", 1, RT5670_ASRC_1,
> > +			      2, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("ADC MONO L ASRC", 1,
> RT5670_ASRC_1,
> > +			      1, 0, NULL, 0),
> > +	SND_SOC_DAPM_SUPPLY_S("ADC MONO R ASRC", 1,
> RT5670_ASRC_1,
> > +			      0, 0, NULL, 0),
> 
> These are all _S but they seem not to have different sequence numbers -
> do they really need to be _S.

Yes, all of them should be powered up after filter powers. But it doesn't
matter which ASRC power is power up first. That's why we set the same
sequence for each ASRC widget.

> ------Please consider the environment before printing this e-mail.
