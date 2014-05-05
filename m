From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt5645: Add codec driver
Date: Mon, 5 May 2014 11:15:24 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D1269436CBBD@RTITMBSV03.realtek.com.tw>
References: <1398686350-29771-1-git-send-email-oder_chiou@realtek.com>
 <20140503174237.GF22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EDAAA26072A
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 13:15:31 +0200 (CEST)
In-Reply-To: <20140503174237.GF22111@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> > +	/* I2S2 function select */
> > +	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
> > +		1, 1),
> 
> What functions is this switching?
> 
It is the pin share switch. The I2S data pins are the pin share to GPIO3/4/5/6.
If we want to use the GPIO3/4/5/6, we need to set it. We will modify it using the
platform data to set it.

> > +	/* TDM */
> > +	SOC_ENUM("TDM Adc Slot0 1 Data", rt5645_tdm_adc_slot0_1_enum),
> > +	SOC_ENUM("TDM Adc Slot2 3 Data", rt5645_tdm_adc_slot2_3_enum),
> > +	SOC_ENUM("TDM Adc Slot4 5 Data", rt5645_tdm_adc_slot4_5_enum),
> > +	SOC_ENUM("TDM Adc Slot6 7 Data", rt5645_tdm_adc_slot6_7_enum),
> > +	SOC_ENUM("TDM IF1 ADC DATA Sel", rt5645_tdm_adc_sel_enum),
> > +	SOC_SINGLE("TDM IF1_DAC1_L Sel", RT5645_TDM_CTRL_3, 12, 7, 0),
> > +	SOC_SINGLE("TDM IF1_DAC1_R Sel", RT5645_TDM_CTRL_3, 8, 7, 0),
> > +	SOC_SINGLE("TDM IF1_DAC2_L Sel", RT5645_TDM_CTRL_3, 4, 7, 0),
> > +	SOC_SINGLE("TDM IF1_DAC2_R Sel", RT5645_TDM_CTRL_3, 0, 7, 0),
> 
> These look like they should be part of DAPM, they're about routing data as far as I
> can tell.
> 
These are the data related controls with TDM function, not related the routing path.
For instance, it likes the L and R channel data swap, or copy function.
