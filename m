From: "Vladimir A. Barinov" <vbarinov@ru.mvista.com>
Subject: Re: [PATCH] ASoC TLV320AIC3X codec driver
Date: Wed, 14 Nov 2007 16:04:31 +0300
Message-ID: <473AF25F.5060305@ru.mvista.com>
References: <20071113194125.GA17302@ru.mvista.com>
	<s5hhcjpfecc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by alsa0.perex.cz (Postfix) with ESMTP id AFBA424737
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 14:04:32 +0100 (CET)
In-Reply-To: <s5hhcjpfecc.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

Thank you for the review.

Takashi Iwai wrote:
> At Tue, 13 Nov 2007 22:41:25 +0300,
> Vladimir Barinov wrote:
>   
>> --- /dev/null
>> +++ linux-2.6.24.rc2.alsa/sound/soc/codecs/tlv320aic3x.c
>>     
> (snip)
>   
>> +
>> +struct snd_soc_codec_device soc_codec_dev_aic3x;
>>     
>
> Do you need this here?  It's defined in the later position.
>   
You are right. Thanks for pointing to this. That is an artefact of the 
driver that I based on.
>   
>> +/*
>> + * All input lines are connected when !0xf and disconnected with 0xf bit field,
>>     
>
> Please keep the line within 80 chars.  Try to run checkpatch.pl in
> linuxkernel/scripts for checking such minor coding-style issues.
>   
But this line is less then 80 chars :)

I've applied checkpatch.pl before sending the patch. The driver really 
has 3 lines with 80 chars warning,
but they are less then 82 char. It's in the codec interconnection map 
for DAPM. If that is a strong demand with
80 chars _warning_ then I'll try to rename the mixers/path/endpoint 
names to match, if not then the code will be
more understandable.
That lines are:
+        {"Right HPCOM Mux", "differential of HPROUT", "Right Line2 
Bypass Mixer"},
+        {"Right HPCOM Mux", "differential of HPLCOM", "Right Line2 
Bypass Mixer"},

If I'll split it with 2 lines each then will it be good to watch in 
accordance with DAPM usage strategy?
Destination Widget  <=== Path Name <=== Source Widget
>   
>> +static const char *aic3x_left_dac_mux[] = { "DAC_L1", "DAC_L3", "DAC_L2" };
>> +static const char *aic3x_right_dac_mux[] = { "DAC_R1", "DAC_R3", "DAC_R2" };
>> +static const char *aic3x_left_hpcom_mux[] =
>> +    { "differential of HPLOUT", "constant VCM", "single-ended" };
>> +static const char *aic3x_right_hpcom_mux[] =
>> +    { "differential of HPROUT", "constant VCM", "single-ended",
>> +      "differential of HPLCOM", "external feedback" };
>> +static const char *aic3x_linein_mode_mux[] = { "single-ended", "differential" };
>>     
>
> Ditto.
>   
Ditto :)
These lines are less then 80 chars.
>   
>> +#define AIC3X_RATES	SNDRV_PCM_RATE_8000_96000
>> +#define AIC3X_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
>> +			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>>     
>
> Are you sure that it's FMTBIT_S24_LE?  It's not packed in 3 bytes but
> uses lower 3 bytes of 4 bytes frame.
>
>   
Aic3x supports 16/20/24/32 bits data word length and in accordance with 
aic33 documentation the
number of clocks per half-frame for each channel are equal to exact 
number of bits of the word.
Unfortunately, now I have no h/w to test 24bits mode.
>   
>> Index: linux-2.6.24.rc2.alsa/sound/soc/codecs/Kconfig
>> ===================================================================
>> --- linux-2.6.24.rc2.alsa.orig/sound/soc/codecs/Kconfig
>> +++ linux-2.6.24.rc2.alsa/sound/soc/codecs/Kconfig
>> @@ -37,3 +37,6 @@ config SND_SOC_CS4270_VD33_ERRATA
>>  	bool
>>  	depends on SND_SOC_CS4270
>>  
>> +config SND_SOC_TLV320AIC3X
>> +	tristate
>> +	depends on SND_SOC
>>     
>
> Currently, there is a known problem with dependency on I2C over soc
> codecs drivers.  If CONFIG_I2C=m and CONFIG_SND_SOC_*=y, you'll get
> unresolved symbols.
>
> I don't know how to resolve this issue right now.  But, the drivers
> that support *only* I2C right now can add "depends on I2C" to its
> Kconfig.  That doesn't work for CS4270 which may work without I2C as
> standalone mode, though.
>   
Ok, will add I2C dependency.

Regards,
Vladimir
