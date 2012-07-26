From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
Date: Thu, 26 Jul 2012 12:38:17 +0100
Message-ID: <50112C29.6020606@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-8-git-send-email-lee.jones@linaro.org> <20120726113204.GY3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726113204.GY3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 26/07/12 12:32, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 11:28:40AM +0100, Lee Jones wrote:
>
>> @@ -52,10 +52,13 @@ static unsigned int hw_read(struct snd_soc_codec=
 *codec, unsigned int reg)
>>   		if (codec->cache_only)
>>   			return -1;
>>
>> -		ret =3D regmap_read(codec->control_data, reg, &val);
>> -		if (ret =3D=3D 0)
>> -			return val;
>> -		else
>> +		if (codec->using_regmap) {
>> +			ret =3D regmap_read(codec->control_data, reg, &val);
>> +			if (ret =3D=3D 0)
>> +				return val;
>> +			else
>> +				return -1;
>> +		} else
>
> No, this makes no sense.  There is no non-regmap I/O support in soc-i=
o,
> anything using the soc-io hw_read() function must be using regmap.
>
>>   	case SND_SOC_REGMAP:
>>   		/* Device has made its own regmap arrangements */
>> -		codec->using_regmap =3D true;
>
> Again, this makes no sense.  If we're explicitly being asked to use
> regmap then we should be using regmap or just failing to set up I/O
> (which is obviously a catastrophic failure).

How much work is there involved in regmap:ing a device, so that=20
dev_get_regmap() doesn't fail?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
