From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH 1/1] ASoC: ad193x: add support to ad1934
Date: Tue, 29 Sep 2015 14:00:52 +0200
Message-ID: <560A7D74.2090901@atmel.com>
References: <273ce440257bbe7c450132bd8dffb25cbaac117e.1443515024.git.cyrille.pitchen@atmel.com>
 <560A4EF7.9030506@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <560A4EF7.9030506@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi!

I'll fix it in v2. Thanks for your review!

Cyrille

Le 29/09/2015 10:42, Lars-Peter Clausen a =E9crit :
> On 09/29/2015 10:36 AM, Cyrille Pitchen wrote:
>> The AD1934 codec has no DAC feature. Hence it register mapping is sl=
ightly
>> different from the register mapping of other members of the AD193x f=
amily.
>>
>> Some ASoC controls and widgets are related to the DAC feature so are=
 not
>> relevant in the case of an AD1934 codec.
>=20
> Looks mostly good, thanks.
>=20
>> diff --git a/sound/soc/codecs/ad193x-i2c.c b/sound/soc/codecs/ad193x=
-i2c.c
>> index df3a1a415825..8aa50d35662f 100644
>> --- a/sound/soc/codecs/ad193x-i2c.c
>> +++ b/sound/soc/codecs/ad193x-i2c.c
>> @@ -15,8 +15,8 @@
>>  #include "ad193x.h"
>> =20
>>  static const struct i2c_device_id ad193x_id[] =3D {
>> -	{ "ad1936", 0 },
>> -	{ "ad1937", 0 },
>> +	{ "ad1936", AD193x },
>> +	{ "ad1937", AD193x },
>=20
> Should be a upper case X.
>=20
>>  	{ }
>>  };
> [...]
> [...]
>> @@ -91,18 +97,33 @@ static const struct snd_soc_dapm_route audio_pat=
hs[] =3D {
>>  	{ "DAC", NULL, "SYSCLK" },
>>  	{ "DAC Output", NULL, "DAC" },
>>  	{ "DAC Output", NULL, "VMID" },
>> -	{ "ADC", NULL, "SYSCLK" },
>> -	{ "DAC", NULL, "ADC_PWR" },
>> -	{ "ADC", NULL, "ADC_PWR" },
>>  	{ "DAC1OUT", NULL, "DAC Output" },
>>  	{ "DAC2OUT", NULL, "DAC Output" },
>>  	{ "DAC3OUT", NULL, "DAC Output" },
>>  	{ "DAC4OUT", NULL, "DAC Output" },
>> +	{ "SYSCLK", NULL, "PLL_PWR" },
>> +};
>> +
>> +static const struct snd_soc_dapm_route adc_audio_paths[] =3D {
>=20
> this should have the ad193x_ prefix as well.
>=20
>> +	{ "ADC", NULL, "SYSCLK" },
>> +	{ "ADC", NULL, "ADC_PWR" },
>>  	{ "ADC", NULL, "ADC1IN" },
>>  	{ "ADC", NULL, "ADC2IN" },
>> -	{ "SYSCLK", NULL, "PLL_PWR" },
>>  };
>=20
