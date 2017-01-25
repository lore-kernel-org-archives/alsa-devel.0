From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8540: new codec driver
Date: Wed, 25 Jan 2017 11:45:26 +0800
Message-ID: <58881F56.3080007@nuvoton.com>
References: <1483597244-9761-1-git-send-email-KCHSU0@nuvoton.com>
 <20170109200052.szyldvyxnki2jggj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 678C726754E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2017 04:45:41 +0100 (CET)
In-Reply-To: <20170109200052.szyldvyxnki2jggj@sirena.org.uk>
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
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 1/10/2017 4:00 AM, Mark Brown wrote:
> On Thu, Jan 05, 2017 at 02:20:44PM +0800, John Hsu wrote:
>
> This looks good overall, a couple of small points though:
>
>
>> +static int nau8540_config_sysclk(struct nau8540 *nau8540,
>> +       int clk_id, unsigned int freq)
>> +{
>> +       struct regmap *regmap = nau8540->regmap;
>> +
>> +       switch (clk_id) {
>> +       case NAU8540_CLK_DIS:
>> +       case NAU8540_CLK_MCLK:
>> +               regmap_update_bits(regmap, NAU8540_REG_CLOCK_SRC,
>> +                       NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_MCLK);
>> +               regmap_update_bits(regmap, NAU8540_REG_FLL6,
>> +                       NAU8540_DCO_EN, 0);
>> +               break;
>> +
>> +       case NAU8540_CLK_INTERNAL:
>> +               regmap_update_bits(regmap, NAU8540_REG_FLL6,
>> +                       NAU8540_DCO_EN, NAU8540_DCO_EN);
>> +               regmap_update_bits(regmap, NAU8540_REG_CLOCK_SRC,
>> +                       NAU8540_CLK_SRC_MASK, NAU8540_CLK_SRC_VCO);
>> +               break;
>>
>
> The above are fine but...
>
>
>> +
>> +       case NAU8540_CLK_FLL_MCLK:
>> +               regmap_update_bits(regmap, NAU8540_REG_FLL3,
>> +                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_MCLK);
>> +               break;
>> +
>> +       case NAU8540_CLK_FLL_BLK:
>> +               regmap_update_bits(regmap, NAU8540_REG_FLL3,
>> +                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_BLK);
>> +               break;
>> +
>> +       case NAU8540_CLK_FLL_FS:
>> +               regmap_update_bits(regmap, NAU8540_REG_FLL3,
>> +                       NAU8540_FLL_CLK_SRC_MASK, NAU8540_FLL_CLK_SRC_FS);
>> +               break;
>>
>
> ...these look like they're mixing in FLL configuration which I'd expect
> to be done with set_pll() via the source argument and I'm not seeing
> anything that sets the device to use the FLL here.  I'd expect the
> source selection to go into set_pll() and I'd expect this function to
> have a setting which tells the device to use the FLL.
>
>

I see. These source selection about FLL can move to the set_pll().

>> +static int nau8540_set_sysclk(struct snd_soc_codec *codec,
>> +       int clk_id, int source, unsigned int freq, int dir)
>> +{
>> +       struct nau8540 *nau8540 = snd_soc_codec_get_drvdata(codec);
>> +
>> +       return nau8540_config_sysclk(nau8540, clk_id, freq);
>> +}
>>
>
> This wrapper isn't really adding anything.
>
>

We will change it and move the config_sysclk to here.

>> +static void nau8540_init_regs(struct nau8540 *nau8540)
>> +{
>> +       struct regmap *regmap = nau8540->regmap;
>> +
>> +       /* Enable Bias/VMID/VMID Tieoff */
>> +       regmap_update_bits(regmap, NAU8540_REG_VMID_CTRL,
>> +               NAU8540_VMID_EN | NAU8540_VMID_SEL_MASK,
>> +               NAU8540_VMID_EN | (0x2 << NAU8540_VMID_SEL_SFT));
>> +       regmap_update_bits(regmap, NAU8540_REG_REFERENCE,
>> +               NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN,
>> +               NAU8540_PRECHARGE_DIS | NAU8540_GLOBAL_BIAS_EN);
>> +       mdelay(2);
>> +       regmap_update_bits(regmap, NAU8540_REG_MIC_BIAS,
>> +               NAU8540_PU_PRE, NAU8540_PU_PRE);
>> +       regmap_update_bits(regmap, NAU8540_REG_CLOCK_CTRL,
>> +               NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN,
>> +               NAU8540_CLK_ADC_EN | NAU8540_CLK_I2S_EN);
>> +       /* ADC OSR selection, CLK_ADC = Fs * OSR */
>> +       regmap_update_bits(regmap, NAU8540_REG_ADC_SAMPLE_RATE,
>> +               NAU8540_ADC_OSR_MASK, NAU8540_ADC_OSR_64);
>> +}
>>
>
> Does this sequence need to be done as part of resume as well?
>

These initiation just only need to do once when the codec boots.
I think it's better to do it when driver module is loaded.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
