From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH] ALSA: hda/realtek - change the location for one of two
 front microphones
Date: Fri, 7 Jul 2017 15:29:25 +0800
Message-ID: <2dc66444-b93c-5e9d-ecdc-111e85585bad@canonical.com>
References: <1499400509-23919-1-git-send-email-hui.wang@canonical.com>
 <s5hinj4ai91.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <s5hinj4ai91.wl-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/07/2017 02:11 PM, Takashi Iwai wrote:
> On Fri, 07 Jul 2017 06:08:29 +0200,
> Hui Wang wrote:
>> On this Lenovo machine, there are two front mics, and both of them are
>> assigned the same name "Mic", but pulseaudio can't support two mics
>> with the same name, as a workaround, we change the location for one of
>> them, then the driver will assign "Front Mic" and "Mic" for them.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index cebf59e..a6c3ce0 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -5179,6 +5179,7 @@ enum {
>>   	ALC233_FIXUP_ASUS_MIC_NO_PRESENCE,
>>   	ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE,
>>   	ALC233_FIXUP_LENOVO_MULTI_CODECS,
>> +	ALC294_FIXUP_LENOVO_MIC_LOCATION,
>>   };
>>   
>>   static const struct hda_fixup alc269_fixups[] = {
>> @@ -5962,6 +5963,18 @@ enum {
>>   		.type = HDA_FIXUP_FUNC,
>>   		.v.func = alc233_alc662_fixup_lenovo_dual_codecs,
>>   	},
>> +	[ALC294_FIXUP_LENOVO_MIC_LOCATION] = {
>> +		.type = HDA_FIXUP_PINS,
>> +		.v.pins = (const struct hda_pintbl[]) {
>> +			/* Change the mic location from front to right, otherwise there are
>> +			   two front mics with the same name, pulseaudio can't handle them.
>> +			   This is just a temporary workaround, after applying this fixup,
>> +			   there will be one "Front Mic" and one "Mic" in this machine.
>> +			 */
>> +			{ 0x1a, 0x04a19040 },
>> +			{ }
>> +		},
>> +	},
> Doesn't this Lenovo device need other quirks like hotkey?
> Just to be sure.
So far, we don't meet hotkey issues on this machine.  And this machine 
is not a laptop, here is the picture of this machine: 
http://www3.lenovo.com/us/en/workstations-thinkstation-p-series/thinkstation-p-series-tiny-/ThinkStation-P320-Tiny/p/33TS3TP320T


Cheers,
Hui.
> thanks,
>
> Takashi
>
