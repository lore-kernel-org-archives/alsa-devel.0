From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 20/21] ASoC: codecs: Enable AB8500 CODEC for Device Tree
Date: Thu, 26 Jul 2012 15:00:17 +0100
Message-ID: <50114D71.9060700@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-21-git-send-email-lee.jones@linaro.org> <20120726115055.GD3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726115055.GD3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 26/07/12 12:50, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 11:28:53AM +0100, Lee Jones wrote:
>
>>   drivers/mfd/ab8500-core.c               |    1 +
>>   include/linux/mfd/abx500/ab8500-codec.h |    6 ++-
>>   sound/soc/codecs/ab8500-codec.c         |   79 +++++++++++++++++++=
++++++++++++
>>   3 files changed, 84 insertions(+), 2 deletions(-)
>
> Yet again no binding documentation....

RFC. ;)

I'll write the documentation when/if the properties are accepted.

>>   	{
>>   		.name =3D "ab8500-codec",
>> +		.of_compatible =3D "stericsson,ab8500-codec",
>>   	},
>
> Why are we doing this?  The MFD cells are a totally Linux specific
> thing, there's no reason to represent them in the device tree unless
> they're in some way reusable and the "ab8500-codec" name suggests tha=
t's
> unlikely.  Just put the properties on the parent node and instantiate
> the MFD cell as normal.
>
>> +	/* Has a non-standard Vamic been requested? */
>> +	if(of_get_property(np, "stericsson,amic1a-bias-vamic2", NULL))
>
> Coding style.

Missing space? Sorry, typo, I'll change.

>> +	if (!of_property_read_u32(np, "stericsson,earpeice-cmv", &value)) =
{
>> +		switch (value) {
>> +		case 950 :
>> +			codec->ear_cmv =3D EAR_CMV_0_95V;
>> +			break;
>> +		case 1100 :
>> +			codec->ear_cmv =3D EAR_CMV_1_10V;
>> +			break;
>> +		case 1270 :
>> +			codec->ear_cmv =3D EAR_CMV_1_27V;
>> +			break;
>> +		case 1580 :
>> +			codec->ear_cmv =3D EAR_CMV_1_58V;
>> +			break;
>> +		default :
>> +			codec->ear_cmv =3D EAR_CMV_UNKNOWN;
>> +			dev_err(dev, "Unsuitable earpiece voltage found in DT\n");
>
> The platform data code picks a default, can't the DT code do the same=
?

No, I don't think that it does? The original code returns -EINVAL unles=
s=20
a value is specified.

The original author is keen to have a clear error message in case users=
=20
try to specify non-exact values. I'd rather we fail-out than use=20
incorrect values which would be a great deal harder for a user to debug=
=2E

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
