From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Wed, 17 Aug 2016 08:34:15 +0800
Message-ID: <57B3B107.9080702@nuvoton.com>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
 <20160815140604.GK9347@sirena.org.uk> <57B28F1D.8070409@nuvoton.com>
 <20160816103854.GP9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A7EA2654BD
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 02:34:19 +0200 (CEST)
In-Reply-To: <20160816103854.GP9347@sirena.org.uk>
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

On 8/16/2016 6:38 PM, Mark Brown wrote:
> On Tue, Aug 16, 2016 at 11:57:17AM +0800, John Hsu wrote:
>   
>> On 8/15/2016 10:06 PM, Mark Brown wrote:
>>     
>>> On Mon, Aug 15, 2016 at 05:02:23PM +0800, John Hsu wrote:
>>>       
>
>   
>>> This looks very good overall, a few fairly small things but nothing too
>>> major.
>>>       
>
>   
>>>> +	val = (u16 *)ucontrol->value.bytes.data;
>>>> +	reg = NAU8810_REG_EQ1;
>>>> +	for (i = 0; i < params->max / sizeof(u16); i++) {
>>>> +		regmap_read(nau8810->regmap, reg + i, &reg_val);
>>>> +		reg_val = cpu_to_be16(reg_val);
>>>> +		memcpy(val + i, &reg_val, sizeof(reg_val));
>>>> +	}
>>>>         
>
>   
>>> This looks like it's trying to do regmap_raw_read()?  Raw I/O bypasses
>>> all the endianness conversions.
>>>       
>
>   
>> We also try regmap_raw_read() but it fails because the value width
>> is 9 bits. Therefor, we make the functions by ourselves.
>>     
>
> You're not open coding this, this is using regmap!
>   

Yes, the regmap raw read will use regmap finally. But it needs
format_val to make the value and it is not registered because
no such value width, 9 bits. The system will crash if the driver
uses regmap_raw_read with 9 bits value.

>   
>>>> +static struct snd_soc_codec_driver soc_codec_dev_nau8810 = {
>>>>         
>
>   
>>>> +	.controls = nau8810_snd_controls,
>>>> +	.num_controls = ARRAY_SIZE(nau8810_snd_controls),
>>>> +	.dapm_widgets = nau8810_dapm_widgets,
>>>> +	.num_dapm_widgets = ARRAY_SIZE(nau8810_dapm_widgets),
>>>> +	.dapm_routes = nau8810_dapm_routes,
>>>> +	.num_dapm_routes = ARRAY_SIZE(nau8810_dapm_routes),
>>>>         
>
>   
>>> Move this data into the component driver please.
>>>       
>
>   
>> I don't understand about it clearly. Is the snd_soc_codec_driver
>> not component driver? Could you tell me more details? Thank you.
>>     
>
> You need to set these values in the actual component driver struct, not
> directly in the CODEC driver.  Look at the series of changes
> Morimoto-san made recently for this.
>   

Thank you for the guide. I find the component driver as the
following. I'll change it.
+    .component_driver = {
+        COMPONENT_FUNC(controls,    wm8978_snd_controls),
