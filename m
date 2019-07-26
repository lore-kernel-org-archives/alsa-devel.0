From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH] ALSA: i2c: ak4xxx-adda: Fix a possible null pointer
 dereference in build_adc_controls()
Date: Fri, 26 Jul 2019 10:05:42 +0800
Message-ID: <5ef03517-a52f-fe24-30e9-62466d4a1319@gmail.com>
References: <20190725082733.15234-1-baijiaju1990@gmail.com>
 <s5hy30myuvw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy30myuvw.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: tglx@linutronix.de, gregkh@linuxfoundation.org, perex@perex.cz, rfontana@redhat.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 2019/7/25 23:52, Takashi Iwai wrote:
> On Thu, 25 Jul 2019 10:27:33 +0200,
> Jia-Ju Bai wrote:
>> In build_adc_controls(), there is an if statement on line 773 to check
>> whether ak->adc_info is NULL:
>> 	if (! ak->adc_info ||
>> 		! ak->adc_info[mixer_ch].switch_name)
>>
>> When ak->adc_info is NULL, it is used on line 792:
>>      knew.name = ak->adc_info[mixer_ch].selector_name;
>>
>> Thus, a possible null-pointer dereference may occur.
>>
>> To fix this bug, referring to lines 773 and 774, ak->adc_info
>> and ak->adc_info[mixer_ch].selector_name are checked before being used.
>>
>> This bug is found by a static analysis tool STCheck written by us.
>>
>> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>> ---
>>   sound/i2c/other/ak4xxx-adda.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
>> index 5f59316f982a..9a891470e84a 100644
>> --- a/sound/i2c/other/ak4xxx-adda.c
>> +++ b/sound/i2c/other/ak4xxx-adda.c
>> @@ -775,11 +775,13 @@ static int build_adc_controls(struct snd_akm4xxx *ak)
>>   				return err;
>>   
>>   			memset(&knew, 0, sizeof(knew));
>> -			knew.name = ak->adc_info[mixer_ch].selector_name;
>> -			if (!knew.name) {
>> +			if (! ak->adc_info ||
>> +				! ak->adc_info[mixer_ch].selector_name) {
>>   				knew.name = "Capture Channel";
>>   				knew.index = mixer_ch + ak->idx_offset * 2;
>>   			}
>> +			else
>> +				knew.name = ak->adc_info[mixer_ch].selector_name;
>>   
>>   			knew.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
>>   			knew.info = ak4xxx_capture_source_info;
> The code change itself looks good, but please follow the standard
> coding style.  In short: please run checkpatch.pl, fix errors (some
> warnings may be ignored) and resubmit.

Okay, thanks for the advice.
I will send a v2 patch.


Best wishes,
Jia-Ju Bai
