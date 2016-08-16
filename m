From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Tue, 16 Aug 2016 11:57:17 +0800
Message-ID: <57B28F1D.8070409@nuvoton.com>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
 <20160815140604.GK9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F61B265C98
 for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2016 05:57:21 +0200 (CEST)
In-Reply-To: <20160815140604.GK9347@sirena.org.uk>
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

On 8/15/2016 10:06 PM, Mark Brown wrote:
> On Mon, Aug 15, 2016 at 05:02:23PM +0800, John Hsu wrote:
>
> This looks very good overall, a few fairly small things but nothing too
> major.
>
>   
>> +	val = (u16 *)ucontrol->value.bytes.data;
>> +	reg = NAU8810_REG_EQ1;
>> +	for (i = 0; i < params->max / sizeof(u16); i++) {
>> +		regmap_read(nau8810->regmap, reg + i, &reg_val);
>> +		reg_val = cpu_to_be16(reg_val);
>> +		memcpy(val + i, &reg_val, sizeof(reg_val));
>> +	}
>>     
>
> This looks like it's trying to do regmap_raw_read()?  Raw I/O bypasses
> all the endianness conversions.
>
>   

We also try regmap_raw_read() but it fails because the value width
is 9 bits. Therefor, we make the functions by ourselves.

>> +static int nau8810_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct nau8810 *nau8810 = snd_soc_codec_get_drvdata(codec);
>> +	struct regmap *regmap = nau8810->regmap;
>> +	struct nau8810_pll *pll = &nau8810->pll;
>> +
>> +	switch (nau8810->div_id) {
>> +	case NAU8810_MCLK_DIV_PLL:
>> +		/* master clock from PLL and enable PLL */
>>     
>
> I'd really not expect new drivers to need to have a set_clkdiv()
> operation.  Most things should just be worked out by the driver, that
> means less duplicated code in machine drivers and that things like
> simple-card have more chance of working for a device.  This one I'm not
> really sure what the divider is so it's hard to make specific
> recommendations.
>
>   

I agree to remove the function. The clock divider has done by PLL
function if the clock source through PLL.

>> +
>> +	case NAU8810_MCLK_DIV_MCLK:
>> +		/* Defer the master clock prescaler configuration to DAI
>> +		 * hardware parameter if master clock from MCLK because
>> +		 * it needs runtime fs information to get the proper div.
>> +		 */
>> +		break;
>>     
>
> This is obviously not good since it means that we just ignore anything
> that's set - if the caller is trying to set a divider we shouldn't just
> be silently discarding what they set.  It looks like this can just be
> removed since the driver is able to calcuate 
>
>   

Yes, it's able to calculate and remove it.

>> +	case NAU8810_BCLK_DIV:
>> +		regmap_update_bits(regmap, NAU8810_REG_CLOCK,
>> +			NAU8810_BCLKSEL_MASK, (div << NAU8810_BCLKSEL_SFT));
>> +		break;
>>     
>
> If this is really needed by anything the set_bclk_ratio() call is more
> appropriate.
>
>   

I can study it. The function is used seldom and maybe I won't
provide the function.

>> +static int nau8810_probe(struct snd_soc_codec *codec)
>> +{
>> +	return 0;
>> +}
>>     
>
> Remove empty functions, if they can reasonably be empty then the
> framework will handle them being missing.
>
>   

OK, I'll do it.

>> +static struct snd_soc_codec_driver soc_codec_dev_nau8810 = {
>>     
>
>   
>> +	.controls = nau8810_snd_controls,
>> +	.num_controls = ARRAY_SIZE(nau8810_snd_controls),
>> +	.dapm_widgets = nau8810_dapm_widgets,
>> +	.num_dapm_widgets = ARRAY_SIZE(nau8810_dapm_widgets),
>> +	.dapm_routes = nau8810_dapm_routes,
>> +	.num_dapm_routes = ARRAY_SIZE(nau8810_dapm_routes),
>>     
>
> Move this data into the component driver please.
>   

I don't understand about it clearly. Is the snd_soc_codec_driver
not component driver? Could you tell me more details? Thank you.
