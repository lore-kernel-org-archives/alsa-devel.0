From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: s3c2412: cleanups / fixes for preparation
 of clocks.
Date: Thu, 27 Jul 2017 10:32:17 +0530
Message-ID: <481b8fe6-22d1-f59a-2ed9-6b8c473d5276@gmail.com>
References: <ea012cdeda63560e99e83d2fc25ce584031fb519.1501095307.git.arvind.yadav.cs@gmail.com>
 <20170726191223.dmwacvhmwh7j3trz@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726191223.dmwacvhmwh7j3trz@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,


On Thursday 27 July 2017 12:42 AM, Krzysztof Kozlowski wrote:
> On Thu, Jul 27, 2017 at 12:28:52AM +0530, Arvind Yadav wrote:
>> -Use devm_clk_get() to make cleanup paths more simple.
>> -clk_prepare_enable() can fail here and we must check its return value.
>> -Add s3c_i2sv2_remove cleanup function of s3c_i2sv2_probe.
>> -No need to iounmap. Here, mapping done by devm_ioremap_resource.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Since I did not hear from you, I just sent fixes for these. We missed
> each other by two minutes. :)
>
> Anyway it is good to do one fix at a time, not everything in one commit.
> You are changing here a lot so this should be split.
>
> BTW, do you have the s3c24xx hardware? Can you test if issues spotted
> here and in my patchset really happen?
>
> Best regards,
> Krzysztof
Please drop this patch. Sorry, I don't have s3c24xx hardware.
This is not available. :(

Thanks,
~arvind
>> ---
>>   sound/soc/samsung/s3c-i2s-v2.c  | 19 ++++++++++++++++---
>>   sound/soc/samsung/s3c-i2s-v2.h  |  3 +++
>>   sound/soc/samsung/s3c2412-i2s.c | 10 ++++++++--
>>   3 files changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/sound/soc/samsung/s3c-i2s-v2.c b/sound/soc/samsung/s3c-i2s-v2.c
>> index 8f42dea..ab4899f 100644
>> --- a/sound/soc/samsung/s3c-i2s-v2.c
>> +++ b/sound/soc/samsung/s3c-i2s-v2.c
>> @@ -625,20 +625,24 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
>>   {
>>   	struct device *dev = dai->dev;
>>   	unsigned int iismod;
>> +	int ret;
>>   
>>   	i2s->dev = dev;
>>   
>>   	/* record our i2s structure for later use in the callbacks */
>>   	snd_soc_dai_set_drvdata(dai, i2s);
>>   
>> -	i2s->iis_pclk = clk_get(dev, "iis");
>> +	i2s->iis_pclk = devm_clk_get(dev, "iis");
>>   	if (IS_ERR(i2s->iis_pclk)) {
>>   		dev_err(dev, "failed to get iis_clock\n");
>> -		iounmap(i2s->regs);
>>   		return -ENOENT;
>>   	}
>>   
>> -	clk_enable(i2s->iis_pclk);
>> +	ret = clk_prepare_enable(i2s->iis_pclk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to prepare iis_clock\n");
>> +		return ret;
>> +	}
>>   
>>   	/* Mark ourselves as in TXRX mode so we can run through our cleanup
>>   	 * process without warnings. */
>> @@ -652,6 +656,15 @@ int s3c_i2sv2_probe(struct snd_soc_dai *dai,
>>   }
>>   EXPORT_SYMBOL_GPL(s3c_i2sv2_probe);
>>   
>> +int s3c_i2sv2_remove(struct snd_soc_dai *dai)
>> +{
>> +	struct s3c_i2sv2_info *i2s = to_info(dai);
>> +
>> +	clk_disable_unprepare(i2s->iis_pclk);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(s3c_i2sv2_remove);
>> +
>>   #ifdef CONFIG_PM
>>   static int s3c2412_i2s_suspend(struct snd_soc_dai *dai)
>>   {
>> diff --git a/sound/soc/samsung/s3c-i2s-v2.h b/sound/soc/samsung/s3c-i2s-v2.h
>> index 182d805..d6844b9 100644
>> --- a/sound/soc/samsung/s3c-i2s-v2.h
>> +++ b/sound/soc/samsung/s3c-i2s-v2.h
>> @@ -91,6 +91,9 @@ extern int s3c_i2sv2_probe(struct snd_soc_dai *dai,
>>   			   struct s3c_i2sv2_info *i2s,
>>   			   unsigned long base);
>>   
>> +
>> +extern int s3c_i2sv2_remove(struct snd_soc_dai *dai);
>> +
>>   /**
>>    * s3c_i2sv2_register_component - register component and dai with soc core
>>    * @dev: DAI device
>> diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
>> index 0a47182..adfbd52d 100644
>> --- a/sound/soc/samsung/s3c2412-i2s.c
>> +++ b/sound/soc/samsung/s3c2412-i2s.c
>> @@ -65,13 +65,18 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>>   	s3c2412_i2s.iis_cclk = devm_clk_get(dai->dev, "i2sclk");
>>   	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
>>   		pr_err("failed to get i2sclk clock\n");
>> +		s3c_i2sv2_remove(dai);
>>   		return PTR_ERR(s3c2412_i2s.iis_cclk);
>>   	}
>>   
>>   	/* Set MPLL as the source for IIS CLK */
>>   
>> -	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
>> -	clk_prepare_enable(s3c2412_i2s.iis_cclk);
>> +	clk_set_parent(s3c2412_i2s.iis_cclk, devm_clk_get(dai->dev, "mpll"));
>> +	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
>> +	if (ret) {
>> +		s3c_i2sv2_remove(dai);
>> +		return ret;
>> +	}
>>   
>>   	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
>>   
>> @@ -85,6 +90,7 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>>   static int s3c2412_i2s_remove(struct snd_soc_dai *dai)
>>   {
>>   	clk_disable_unprepare(s3c2412_i2s.iis_cclk);
>> +	s3c_i2sv2_remove(dai);
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.7.4
>>
