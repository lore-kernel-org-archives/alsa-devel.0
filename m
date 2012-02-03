From: "M R Swami Reddy" <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH ] ASoC: Add support for TI LM49453 Audio
	codec
Date: Fri, 03 Feb 2012 19:03:30 +0530
Message-ID: <4F2BE22A.7070006@nsc.com>
References: <290463D19D2E064191F1F96ECA480A89434AB423B2@EXMAIL02.scwf.nsc.com>
	<20120202231427.GG3112@opensource.wolfsonmicro.com>
	<290463D19D2E064191F1F96ECA480A89434ABCAEDD@EXMAIL02.scwf.nsc.com>
	<20120203132504.GK3151@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw05.nsc.com (mail2.nsc.com [12.238.8.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 01429103EAB
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 14:34:28 +0100 (CET)
Received: from SCNTRDCSS6.nsc.com (scntrdcss6.nsc.com [10.188.130.177])
	by sc-mailgw05.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	2B56E17AA44F
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 05:34:19 -0800 (PST)
In-Reply-To: <20120203132504.GK3151@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Feb 03, 2012 at 04:19:00AM -0800, Reddy, MR Swami wrote:
>
> Fix your mailer to word wrap within paragraphs.  I'm sure I've mentioned
> this before...
>   
Done. I have switched to Mozilla Thunderbird email client and will use 
the same for all ALSA email communication.
>   
>>>> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQL_REG, (state->in & 0xff));
>>>> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQH_REG,
>>>> +                            ((state->in >> 8) & 0xff));
>>>> +
>>>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLL_REG,
>>>> +                            state->out & 0xff);
>>>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLH_REG,
>>>> +                            (state->out >> 8) & 0xff);
>>>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHL_REG,
>>>> +                            (state->out >> 16) & 0xff);
>>>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHH_REG,
>>>> +                            (state->out >> 24) & 0xff);
>>>>         
>
>   
>> The above code used to set the reference frequencies for FLL and VCO.
>> Ideally, this code can be removed, because these registers are used
>> for reference only.
>>     
>
> You're saying that the PLL is actually not user configurable at all and
> the above register writes have no effect?
>   
Yes, thats right.
>   
>>>> +       switch (lm49453->sysclk) {
>>>> +       case 12288000:
>>>> +       case 26000000:
>>>> +       case 19000000:
>>>> +               /* PLL CLK slection */
>>>> +               pll_clk = ~BIT(4);
>>>> +               break;
>>>> +       case 48000:
>>>> +       case 32576:
>>>> +               /* FLL CLK slection */
>>>> +               pll_clk = BIT(4);
>>>> +               break;
>>>> +       default:
>>>> +               return -EINVAL;
>>>> +       }
>>>>         
>
>   
>> The above code used to set for CLOCK type (ie either PLL or  FLL). The
>> sysclk is PLL (HIGH FREQ mode) or FLL (LOW FREQ mode). So based on the
>> sysclk, the BIT(4) will be set.
>>     
>
> This doesn't address my comment (which you've deleted from my reply)
> at all.  Why is this being done in hw_params()?  It appears to be
> totally unrelated to hw_params().
>
> The clocking configuration in this driver seems very confused, the
> system clock for the device should be being configured by some
> combinantion of set_sysclk() and set_pll() and hw_params() should do any
> adjustment of the clock dividers and so on to configure the rest of the
> chip for the sample rate based on the current clocking configuration.
>
>   
OK. I will move this code to set_sysclk().

>>>> +       case SND_SOC_BIAS_STANDBY:
>>>> +               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
>>>> +                       regcache_sync(lm49453->regmap);
>>>> +       
>>>> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
>>>> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
>>>> +               break;
>>>> +
>>>> +       case SND_SOC_BIAS_OFF:
>>>> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
>>>> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
>>>> +               break;
>>>> +       }
>>>>         
>
>   
>> Setting CHIP_EN bit as '0'. In the _STANDBY mode, CHIP_EN bit setting
>> not needed and will remove in the next patch.
>>     
>
> This also sounds broken, as I repeatedly said when reviewing previous
> versions of the driver if disabling the chip does anything at all then
> why don't you need to reenable the chip later?
>   

OK. I will remove chip disable code in case if _STANDBY and _OFF modes.

Thanks
Swami
