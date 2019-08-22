From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ALSA: usb-audio: Fix the mixer control range limiting
 issue
Date: Thu, 22 Aug 2019 12:39:29 +0100
Message-ID: <292a1950-3f2a-0099-eb37-bad202c47c23@linaro.org>
References: <20190821100225.9254-1-srinivas.kandagatla@linaro.org>
 <s5h7e7678le.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h7e7678le.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Deepa Madiregama <dmadireg@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Meng Wang <mwang@codeaurora.org>
List-Id: alsa-devel@alsa-project.org



On 21/08/2019 18:05, Takashi Iwai wrote:
> On Wed, 21 Aug 2019 12:02:25 +0200,
> Srinivas Kandagatla wrote:
>>
>> From: Deepa Madiregama <dmadireg@codeaurora.org>
>>
>> - mixer_ctl_set() function is limiting the volume level
>>    to particular range. This results in incorrect initial
>>    volume setting for that device.
>> - In USB mixer while calculating the dBmin/dBmax values
>>    resolution factor is hardcoded to 256 which results in
>>    populating the wrong values for dBmin/dBmax.
>> - Fix is to use appropriate resolution factor while
>>    calculating the dBmin/dBmax values.
> 
> This change doesn't sound right.  Basically the values returned from
> USB-audio FEATURE UNIT or MIXER UNIT are always in 1/256 dB unit, per
> definition.  And we pass dB min/max to user-space as TLV_DB_MINMAX(),
> i.e. TLV points just both min and max, no matter what scale is.  I
> believe that the current code is correct in this regard.
> 
> So, it's either a firmware bug that gives the wrong values back, or
> the case we still don't cover, e.g. multiple RANGE values for
> UAC2/UAC3.
> 
> Please check what exactly doesn't work as expected.  Which value is
> returned from the USB-audio device and what is wrongly interpreted.
> 

Thanks for the detailed review.

I see https://www.usb.org/sites/default/files/audio10.pdf clearly 
specifies Mixer unit is always 1/256dB units.

This patch has been carried in Qcom downstream kernels for past many 
years to fix very low Initial volume setting on some USB headsets like 
Logitech S-150 USB Speakers and Nokia HS-82 USB headset.

Its highly likely that its a firmware bug!, but I will try to get it 
retested on latest kernel and collect some logs!

Thanks,
srini


> 
> thanks,
> 
> Takashi
> 
> 
>> Signed-off-by: Deepa Madiregama <dmadireg@codeaurora.org>
>> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
>> Signed-off-by: Meng Wang <mwang@codeaurora.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/usb/mixer.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 5070a6a76ab3..a67448327d07 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -1248,8 +1248,10 @@ static int get_min_max_with_quirks(struct usb_mixer_elem_info *cval,
>>   	/* USB descriptions contain the dB scale in 1/256 dB unit
>>   	 * while ALSA TLV contains in 1/100 dB unit
>>   	 */
>> -	cval->dBmin = (convert_signed_value(cval, cval->min) * 100) / 256;
>> -	cval->dBmax = (convert_signed_value(cval, cval->max) * 100) / 256;
>> +	cval->dBmin =
>> +		(convert_signed_value(cval, cval->min) * 100) / (cval->res);
>> +	cval->dBmax =
>> +		(convert_signed_value(cval, cval->max) * 100) / (cval->res);
>>   	if (cval->dBmin > cval->dBmax) {
>>   		/* something is wrong; assume it's either from/to 0dB */
>>   		if (cval->dBmin < 0)
>> -- 
>> 2.21.0
>>
