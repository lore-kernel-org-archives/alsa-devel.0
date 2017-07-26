From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2 01/11] ASoC: samsung: s3c2412: Handle
 return value of clk_prepare_enable.
Date: Wed, 26 Jul 2017 17:35:32 +0530
Message-ID: <b042a76a-4b18-faad-3d79-0d3132441250@gmail.com>
References: <84c0014d4dbd466f52c45d8efbd2c1080d8174fb.1501047400.git.arvind.yadav.cs@gmail.com>
 <20170726112817.sdcfz25nhiitkhd2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D0A7926740A
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 14:06:20 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id k190so1469475pgk.4
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 05:06:20 -0700 (PDT)
In-Reply-To: <20170726112817.sdcfz25nhiitkhd2@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, krzk@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

Hi,


On Wednesday 26 July 2017 04:58 PM, Mark Brown wrote:
> On Wed, Jul 26, 2017 at 11:15:25AM +0530, Arvind Yadav wrote:
>
>> --- a/sound/soc/samsung/s3c2412-i2s.c
>> +++ b/sound/soc/samsung/s3c2412-i2s.c
>> @@ -65,13 +65,16 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>>   	s3c2412_i2s.iis_cclk = devm_clk_get(dai->dev, "i2sclk");
>>   	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
>>   		pr_err("failed to get i2sclk clock\n");
>> -		return PTR_ERR(s3c2412_i2s.iis_cclk);
>> +		ret = PTR_ERR(s3c2412_i2s.iis_cclk);
>> +		goto err;
>>   	}
>>   
> Why are we making this unrelated change?  None of the error handling we
> jump to is relevant if this fails...
3c_i2sv2_probe is enabling "iis" clock. If devm_clk_get(, "i2sclk") fails.
we need to disable and free the clock "iis" .
>
>>   	/* Set MPLL as the source for IIS CLK */
>>   
>>   	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
>> -	clk_prepare_enable(s3c2412_i2s.iis_cclk);
>> +	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
>> +	if (ret)
>> +		goto err;
>>   
>>   	s3c2412_i2s.iis_cclk = s3c2412_i2s.iis_pclk;
>>   
>> @@ -80,6 +83,11 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>>   			      S3C_GPIO_PULL_NONE);
>>   
>>   	return 0;
>> +
>> +err:
>> +	clk_disable(s3c2412_i2s.iis_pclk);
> This will disable the clock if we failed to enable it which is clearly
> not correct.  It's also matching a clk_prepare_enable() with a
> clk_disable() which is going to leave an unbalanced prepare.
s3c_i2sv2_probe is enabling "iis" clock. And s3c2412_i2s_probe is enabling
"i2sclk"  and "mpll"clock. If, "mpll" clk_prepare_enable fails. We need 
to disable and
free the clock "iis".  and devm will handle other clock "i2sclk". In 
this code we have used
"s3c2412_i2s.iis_cclk" for all the clock which is more confusing for me.
Please correct me if i am wrong.

~arvind
