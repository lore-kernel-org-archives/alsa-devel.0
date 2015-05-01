From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/5] ASoC: dapm: Add support for
	autodisable mux	controls
Date: Fri, 1 May 2015 11:24:51 +0100
Message-ID: <20150501102451.GS3480@opensource.wolfsonmicro.com>
References: <1430411912-6599-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430411912-6599-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <55426AD9.7080302@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D6E22606AC
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 12:24:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55426AD9.7080302@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 30, 2015 at 07:48:09PM +0200, Lars-Peter Clausen wrote:
> On 04/30/2015 06:38 PM, Charles Keepax wrote:
> [...]
>> @@ -354,6 +355,34 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
>>   			}
>>   		}
>>   		break;
>> +	case snd_soc_dapm_mux:
>> +		e = (struct soc_enum *)kcontrol->private_value;
>> +
>> +		if (e->autodisable) {
>> +			struct snd_soc_dapm_widget template;
>> +
>> +			memset(&template, 0, sizeof(template));
>> +			template.reg = e->reg;
>> +			template.mask = e->mask << e->shift_l;
>> +			template.shift = e->shift_l;
>> +			template.off_val = e->values[0];
>
> I think we should handle the case where e->values is NULL. In which case  
> off_val should just be 0.

Ooops yeah sorry got a bit over keen there.

>
>> +			template.on_val = template.off_val;
>> +			template.id = snd_soc_dapm_kcontrol;
>> +			template.name = name;
>> +
> [...]
>
>> @@ -3002,10 +3034,10 @@ int snd_soc_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
>>
>>   	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
>>
>> +	change = dapm_kcontrol_set_value(kcontrol, val);
>> +
>>   	if (e->reg != SND_SOC_NOPM)
>>   		change = soc_dapm_test_bits(dapm, e->reg, mask, val);
>> -	else
>> -		change = dapm_kcontrol_set_value(kcontrol, val);
>>
>
> This probably needs the same logic as in snd_soc_dapm_put_volsw() to  
> correctly handle the case where the hardware state and the software state 
> might be out of sync.

Yeah makes sense.

>
>>   	if (change) {
>>   		if (e->reg != SND_SOC_NOPM) {
>>
> /

I will send out a new spin shortly.

Thanks,
Charles
