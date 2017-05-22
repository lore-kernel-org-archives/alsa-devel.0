From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH v4 2/3] ASoC: stm32: Add I2S driver
Date: Mon, 22 May 2017 15:11:45 +0000
Message-ID: <3b507e82-d8d1-c2c4-8a50-ca130382171a@st.com>
References: <1495120793-11687-1-git-send-email-olivier.moysan@st.com>
 <1495120793-11687-3-git-send-email-olivier.moysan@st.com>
 <20170519173359.277lyg6fzwksqnin@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 6F9F4266E84
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 17:11:49 +0200 (CEST)
In-Reply-To: <20170519173359.277lyg6fzwksqnin@sirena.org.uk>
Content-Language: en-US
Content-ID: <9D8D9CB309872E4A9834C53F7980614B@st.com>
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

Thanks, for applying the patches.

On 05/19/2017 07:33 PM, Mark Brown wrote:
> On Thu, May 18, 2017 at 05:19:52PM +0200, olivier moysan wrote:
> 
> This looks good so I'm going to apply it, a few things below though -
> can you please send a followup patch for the issue with the Kconfig
> symbol?
> 
>> --- a/sound/soc/stm/Kconfig
>> +++ b/sound/soc/stm/Kconfig
>> @@ -5,4 +5,4 @@ menuconfig SND_SOC_STM32
>>   	select SND_SOC_GENERIC_DMAENGINE_PCM
>>   	select REGMAP_MMIO
>>   	help
>> -	  Say Y if you want to enable ASoC-support for STM32
>> +	  Say Y if you want to enable ASoC support for STM32
> 
> This appears to be an unrelated typo fix.
> 

ok

>> diff --git a/sound/soc/stm/Makefile b/sound/soc/stm/Makefile
>> index e466a47..8251931 100644
>> --- a/sound/soc/stm/Makefile
>> +++ b/sound/soc/stm/Makefile
>> @@ -4,3 +4,7 @@ obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai-sub.o
>>   
>>   snd-soc-stm32-sai-objs := stm32_sai.o
>>   obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-sai.o
>> +
>> +# I2S
>> +snd-soc-stm32-i2s-objs := stm32_i2s.o
>> +obj-$(CONFIG_SND_SOC_STM32) += snd-soc-stm32-i2s.o
> 
> Perhaps make this a separate option?  It probably makes sense to rename
> the option for the SAI at the same time.
> 

ok, I will fix it in a new patch.

>> +
>> +	ret = clk_prepare_enable(i2s->pclk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Enable pclk failed: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_prepare_enable(i2s->i2sclk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Enable i2sclk failed: %d\n", ret);
>> +		goto err_pclk_disable;
>> +	}
> 
> It'd be nice to have runtime PM to disable these when the device is idle
> but that's not essential.
> 

Yes, I agree.

BRs
olivier
