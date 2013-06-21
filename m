From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: codecs: adau1701: add support
	for pin muxing
Date: Fri, 21 Jun 2013 09:28:13 +0200
Message-ID: <51C4008D.6080303@gmail.com>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-4-git-send-email-zonque@gmail.com>
 <51C3FFB5.9010101@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f181.google.com (mail-ea0-f181.google.com
 [209.85.215.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 832BB2654C7
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 09:27:41 +0200 (CEST)
Received: by mail-ea0-f181.google.com with SMTP id a15so4473493eae.40
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 00:27:41 -0700 (PDT)
In-Reply-To: <51C3FFB5.9010101@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 21.06.2013 09:24, Lars-Peter Clausen wrote:
> On 06/20/2013 07:29 PM, Daniel Mack wrote:
>> [...]
>>  static int adau1701_probe(struct snd_soc_codec *codec)
>>  {
>> -	int ret;
>> +	int ret, i;
>> +	unsigned int val;
>>  	struct i2c_client *client = to_i2c_client(codec->dev);
>>  	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>>  
>> @@ -576,6 +584,19 @@ static int adau1701_probe(struct snd_soc_codec *codec)
>>  	regmap_write(adau1701->regmap, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
>>  	regmap_write(adau1701->regmap, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
>>  
>> +	/* set up pin config */
>> +	val = 0;
>> +	for (i = 0; i < 6; i++)
>> +		val |= adau1701->pin_config[i] << (i * 4);
>> +
>> +	regmap_write(adau1701->regmap, ADAU1701_PINCONF_0, val);
>> +
>> +	val = 0;
>> +	for (i = 0; i < 6; i++)
>> +		val |= adau1701->pin_config[i + 6] << (i * 4);
>> +
>> +	regmap_write(adau1701->regmap, ADAU1701_PINCONF_1, val);
> 
> Will the config survive a reset?
> 

That will be synced back via regcache_sync(), no?
