From: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Subject: Re: [PATCH ] ASoC: Add support for TI LM49453 Audio
	codec
Date: Fri, 3 Feb 2012 04:19:00 -0800
Message-ID: <290463D19D2E064191F1F96ECA480A89434ABCAEDD@EXMAIL02.scwf.nsc.com>
References: <290463D19D2E064191F1F96ECA480A89434AB423B2@EXMAIL02.scwf.nsc.com>
	<20120202231427.GG3112@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sc-mailgw05.nsc.com (mail2.nsc.com [12.238.8.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D25C2436A
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 13:20:56 +0100 (CET)
Received: from SCNTRDCSS6.nsc.com (scntrdcss6.nsc.com [10.188.130.177])
	by sc-mailgw05.nsc.com (Tumbleweed MailGate 3.7.1) with ESMTP id
	29E2417AA248
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 04:20:48 -0800 (PST)
In-Reply-To: <20120202231427.GG3112@opensource.wolfsonmicro.com>
Content-Language: en-US
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

Hi Mark,

Apologies for missing a few review comments:

>> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQL_REG, (state->in & 0xff));
>> +       snd_soc_write(codec, LM49453_P0_FLL_REF_FREQH_REG,
>> +                            ((state->in >> 8) & 0xff));
>> +
>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLL_REG,
>> +                            state->out & 0xff);
>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETLH_REG,
>> +                            (state->out >> 8) & 0xff);
>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHL_REG,
>> +                            (state->out >> 16) & 0xff);
>> +       snd_soc_write(codec, LM49453_P0_VCO_TARGETHH_REG,
>> +                            (state->out >> 24) & 0xff);

The above code used to set the reference frequencies for FLL and VCO. Ideally, this code can be removed, because these registers are used for reference only.

 
>> +       switch (lm49453->sysclk) {
>> +       case 12288000:
>> +       case 26000000:
>> +       case 19000000:
>> +               /* PLL CLK slection */
>> +               pll_clk = ~BIT(4);
>> +               break;
>> +       case 48000:
>> +       case 32576:
>> +               /* FLL CLK slection */
>> +               pll_clk = BIT(4);
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }

The above code used to set for CLOCK type (ie either PLL or  FLL). The sysclk is PLL (HIGH FREQ mode) or FLL (LOW FREQ mode). So based on the sysclk, the BIT(4) will be set.

>> +       case SND_SOC_BIAS_STANDBY:
>> +               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
>> +                       regcache_sync(lm49453->regmap);
>> +       
>> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
>> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
>> +               break;
>> +
>> +       case SND_SOC_BIAS_OFF:
>> +               snd_soc_update_bits(codec, LM49453_P0_PMC_SETUP_REG,
>> +                                   LM49453_PMC_SETUP_CHIP_EN, 0);
>> +               break;
>> +       }

Setting CHIP_EN bit as '0'. In the _STANDBY mode, CHIP_EN bit setting not needed and will remove in the next patch.

Thanks
Swami
