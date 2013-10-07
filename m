From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] ASoC: twl4030: Use virtual DAPM mixer
 controls
Date: Mon, 7 Oct 2013 12:09:18 +0300
Message-ID: <52527A3E.6030209@ti.com>
References: <1381059831-16074-1-git-send-email-lars@metafoo.de>
 <1381059831-16074-2-git-send-email-lars@metafoo.de> <525279CA.50608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id C92842625F7
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 11:09:09 +0200 (CEST)
In-Reply-To: <525279CA.50608@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/07/2013 12:07 PM, Peter Ujfalusi wrote:
> On 10/06/2013 02:43 PM, Lars-Peter Clausen wrote:
>> By using the new virtual DAPM mixer controls it is possible to remove the
>> twl4030 specific implementation of virtual controls.
> =

> Acked-by: Peter Ujfalusi <peter.ujflausi@ti.com>

Argh, typo in my e-mail address:

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  sound/soc/codecs/twl4030.c | 80 +++++++++++++++++++++------------------=
-------
>>  1 file changed, 36 insertions(+), 44 deletions(-)
>>
>> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
>> index 1e3884d..dfc51bb 100644
>> --- a/sound/soc/codecs/twl4030.c
>> +++ b/sound/soc/codecs/twl4030.c
>> @@ -46,13 +46,7 @@
>>  /* TWL4030 PMBR1 Register GPIO6 mux bits */
>>  #define TWL4030_GPIO6_PWM0_MUTE(value)	((value & 0x03) << 2)
>>  =

>> -/* Shadow register used by the audio driver */
>> -#define TWL4030_REG_SW_SHADOW		0x4A
>> -#define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)
>> -
>> -/* TWL4030_REG_SW_SHADOW (0x4A) Fields */
>> -#define TWL4030_HFL_EN			0x01
>> -#define TWL4030_HFR_EN			0x02
>> +#define TWL4030_CACHEREGNUM	(TWL4030_REG_MISC_SET_2 + 1)
>>  =

>>  /*
>>   * twl4030 register cache & default register settings
>> @@ -132,7 +126,6 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] =3D=
 {
>>  	0x00, /* REG_VIBRA_PWM_SET	(0x47)	*/
>>  	0x00, /* REG_ANAMIC_GAIN	(0x48)	*/
>>  	0x00, /* REG_MISC_SET_2		(0x49)	*/
>> -	0x00, /* REG_SW_SHADOW		(0x4A)	- Shadow, non HW register */
>>  };
>>  =

>>  /* codec private data */
>> @@ -198,42 +191,41 @@ static int twl4030_write(struct snd_soc_codec *cod=
ec,
>>  	int write_to_reg =3D 0;
>>  =

>>  	twl4030_write_reg_cache(codec, reg, value);
>> -	if (likely(reg < TWL4030_REG_SW_SHADOW)) {
>> -		/* Decide if the given register can be written */
>> -		switch (reg) {
>> -		case TWL4030_REG_EAR_CTL:
>> -			if (twl4030->earpiece_enabled)
>> -				write_to_reg =3D 1;
>> -			break;
>> -		case TWL4030_REG_PREDL_CTL:
>> -			if (twl4030->predrivel_enabled)
>> -				write_to_reg =3D 1;
>> -			break;
>> -		case TWL4030_REG_PREDR_CTL:
>> -			if (twl4030->predriver_enabled)
>> -				write_to_reg =3D 1;
>> -			break;
>> -		case TWL4030_REG_PRECKL_CTL:
>> -			if (twl4030->carkitl_enabled)
>> -				write_to_reg =3D 1;
>> -			break;
>> -		case TWL4030_REG_PRECKR_CTL:
>> -			if (twl4030->carkitr_enabled)
>> -				write_to_reg =3D 1;
>> -			break;
>> -		case TWL4030_REG_HS_GAIN_SET:
>> -			if (twl4030->hsl_enabled || twl4030->hsr_enabled)
>> -				write_to_reg =3D 1;
>> -			break;
>> -		default:
>> -			/* All other register can be written */
>> +	/* Decide if the given register can be written */
>> +	switch (reg) {
>> +	case TWL4030_REG_EAR_CTL:
>> +		if (twl4030->earpiece_enabled)
>>  			write_to_reg =3D 1;
>> -			break;
>> -		}
>> -		if (write_to_reg)
>> -			return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
>> -						    value, reg);
>> +		break;
>> +	case TWL4030_REG_PREDL_CTL:
>> +		if (twl4030->predrivel_enabled)
>> +			write_to_reg =3D 1;
>> +		break;
>> +	case TWL4030_REG_PREDR_CTL:
>> +		if (twl4030->predriver_enabled)
>> +			write_to_reg =3D 1;
>> +		break;
>> +	case TWL4030_REG_PRECKL_CTL:
>> +		if (twl4030->carkitl_enabled)
>> +			write_to_reg =3D 1;
>> +		break;
>> +	case TWL4030_REG_PRECKR_CTL:
>> +		if (twl4030->carkitr_enabled)
>> +			write_to_reg =3D 1;
>> +		break;
>> +	case TWL4030_REG_HS_GAIN_SET:
>> +		if (twl4030->hsl_enabled || twl4030->hsr_enabled)
>> +			write_to_reg =3D 1;
>> +		break;
>> +	default:
>> +		/* All other register can be written */
>> +		write_to_reg =3D 1;
>> +		break;
>>  	}
>> +	if (write_to_reg)
>> +		return twl_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE,
>> +					    value, reg);
>> +
>>  	return 0;
>>  }
>>  =

>> @@ -532,7 +524,7 @@ SOC_DAPM_ENUM("Route", twl4030_handsfreel_enum);
>>  =

>>  /* Handsfree Left virtual mute */
>>  static const struct snd_kcontrol_new twl4030_dapm_handsfreelmute_contro=
l =3D
>> -	SOC_DAPM_SINGLE("Switch", TWL4030_REG_SW_SHADOW, 0, 1, 0);
>> +	SOC_DAPM_SINGLE_VIRT("Switch", 1);
>>  =

>>  /* Handsfree Right */
>>  static const char *twl4030_handsfreer_texts[] =3D
>> @@ -548,7 +540,7 @@ SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
>>  =

>>  /* Handsfree Right virtual mute */
>>  static const struct snd_kcontrol_new twl4030_dapm_handsfreermute_contro=
l =3D
>> -	SOC_DAPM_SINGLE("Switch", TWL4030_REG_SW_SHADOW, 1, 1, 0);
>> +	SOC_DAPM_SINGLE_VIRT("Switch", 1);
>>  =

>>  /* Vibra */
>>  /* Vibra audio path selection */
>>
> =

> =



-- =

P=E9ter
