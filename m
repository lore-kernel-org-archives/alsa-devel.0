From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: twl6040: Use virtual DAPM mixer
 controls
Date: Mon, 7 Oct 2013 12:11:31 +0300
Message-ID: <52527AC3.2020103@ti.com>
References: <1381059831-16074-1-git-send-email-lars@metafoo.de>
 <1381059831-16074-3-git-send-email-lars@metafoo.de> <525279DA.4070502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id F136A264F41
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2013 11:11:22 +0200 (CEST)
In-Reply-To: <525279DA.4070502@ti.com>
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
>> twl6040 specific implementation of virtual controls.
> =

> Acked-by: Peter Ujfalusi <peter.ujflausi@ti.com>

Same typo as with the twl4030 patch:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  sound/soc/codecs/twl6040.c | 22 +++++-----------------
>>  1 file changed, 5 insertions(+), 17 deletions(-)
>>
>> diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
>> index 35059a2..f2f4bcb 100644
>> --- a/sound/soc/codecs/twl6040.c
>> +++ b/sound/soc/codecs/twl6040.c
>> @@ -54,12 +54,7 @@ enum twl6040_dai_id {
>>  #define TWL6040_OUTHF_0dB 0x03
>>  #define TWL6040_OUTHF_M52dB 0x1D
>>  =

>> -/* Shadow register used by the driver */
>> -#define TWL6040_REG_SW_SHADOW	0x2F
>> -#define TWL6040_CACHEREGNUM	(TWL6040_REG_SW_SHADOW + 1)
>> -
>> -/* TWL6040_REG_SW_SHADOW (0x2F) fields */
>> -#define TWL6040_EAR_PATH_ENABLE	0x01
>> +#define TWL6040_CACHEREGNUM	(TWL6040_REG_STATUS + 1)
>>  =

>>  struct twl6040_jack_data {
>>  	struct snd_soc_jack *jack;
>> @@ -135,8 +130,6 @@ static const u8 twl6040_reg[TWL6040_CACHEREGNUM] =3D=
 {
>>  	0x00, /* REG_HFOTRIM	0x2C	*/
>>  	0x09, /* REG_ACCCTL	0x2D	*/
>>  	0x00, /* REG_STATUS	0x2E (ro) */
>> -
>> -	0x00, /* REG_SW_SHADOW	0x2F - Shadow, non HW register */
>>  };
>>  =

>>  /* List of registers to be restored after power up */
>> @@ -220,12 +213,8 @@ static int twl6040_read_reg_volatile(struct snd_soc=
_codec *codec,
>>  	if (reg >=3D TWL6040_CACHEREGNUM)
>>  		return -EIO;
>>  =

>> -	if (likely(reg < TWL6040_REG_SW_SHADOW)) {
>> -		value =3D twl6040_reg_read(twl6040, reg);
>> -		twl6040_write_reg_cache(codec, reg, value);
>> -	} else {
>> -		value =3D twl6040_read_reg_cache(codec, reg);
>> -	}
>> +	value =3D twl6040_reg_read(twl6040, reg);
>> +	twl6040_write_reg_cache(codec, reg, value);
>>  =

>>  	return value;
>>  }
>> @@ -261,8 +250,7 @@ static int twl6040_write(struct snd_soc_codec *codec,
>>  		return -EIO;
>>  =

>>  	twl6040_write_reg_cache(codec, reg, value);
>> -	if (likely(reg < TWL6040_REG_SW_SHADOW) &&
>> -	    twl6040_is_path_unmuted(codec, reg))
>> +	if (twl6040_is_path_unmuted(codec, reg))
>>  		return twl6040_reg_write(twl6040, reg, value);
>>  	else
>>  		return 0;
>> @@ -555,7 +543,7 @@ static const struct snd_kcontrol_new hfr_mux_control=
s =3D
>>  	SOC_DAPM_ENUM("Route", twl6040_hf_enum[1]);
>>  =

>>  static const struct snd_kcontrol_new ep_path_enable_control =3D
>> -	SOC_DAPM_SINGLE("Switch", TWL6040_REG_SW_SHADOW, 0, 1, 0);
>> +	SOC_DAPM_SINGLE_VIRT("Switch", 1);
>>  =

>>  static const struct snd_kcontrol_new auxl_switch_control =3D
>>  	SOC_DAPM_SINGLE("Switch", TWL6040_REG_HFLCTL, 6, 1, 0);
>>
> =

> =



-- =

P=E9ter
