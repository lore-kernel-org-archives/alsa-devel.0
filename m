From: Alexandra Yates <alexandra.yates@linux.intel.com>
Subject: Re: [PATCH V2] Intel device IDs Audio
Date: Thu, 5 Nov 2015 11:51:52 -0800
Message-ID: <563BB358.6060604@linux.intel.com>
References: <s5h37wk3fjs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h37wk3fjs.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, perex@perex.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi,

On 11/05/2015 02:29 AM, Takashi Iwai wrote:
> On Thu, 05 Nov 2015 00:56:09 +0100,
> Alexandra Yates wrote:
>>
>> Adding Intel codename Lewisburg platform device IDs for audio.
>>
>> Signed-off-by: Alexandra Yates <alexandra.yates@linux.intel.com>
>
> Thanks.  Though, I still believe the position after Wellsburg is best
> (which is the similar chip that has the same driver type and driver
>   caps bits), so I rearranged it.  Also the subject was aligned.
> And last but not least, Cc to stable was added.
>

Thank you for your review and making the additional changes. I'll keep 
your methodology for future reference.

Is this mean that the patch was accepted upstream?

>
> Takashi
>
>> ---
>>   sound/pci/hda/hda_intel.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
>> index c38c68f..e8d1151 100644
>> --- a/sound/pci/hda/hda_intel.c
>> +++ b/sound/pci/hda/hda_intel.c
>> @@ -2168,6 +2168,11 @@ static const struct pci_device_id azx_ids[] = {
>>   	/* ICH10 */
>>   	{ PCI_DEVICE(0x8086, 0x3a6e),
>>   	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_INTEL_ICH },
>> +	/* Lewisburg */
>> +	{ PCI_DEVICE(0x8086, 0xa1f0),
>> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>> +	{ PCI_DEVICE(0x8086, 0xa270),
>> +	  .driver_data = AZX_DRIVER_PCH | AZX_DCAPS_INTEL_PCH },
>>   	/* Generic Intel */
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_ANY_ID),
>>   	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
>> --
>> 1.9.1
>>
>>

-- 
Thank you,
<Alexandra>
