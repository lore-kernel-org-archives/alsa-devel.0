From: Jorge <jorge.sanjuan@codethink.co.uk>
Subject: Re: [PATCH v2 1/4] ALSA: usb-audio: Initial Power Domain support
Date: Mon, 30 Jul 2018 17:05:47 +0100
Message-ID: <dcca62da-db80-5081-4552-2a010b307656@codethink.co.uk>
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-2-jorge.sanjuan@codethink.co.uk>
 <s5hbmaox4dh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbmaox4dh.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 30/07/18 14:03, Takashi Iwai wrote:
> On Mon, 30 Jul 2018 11:23:33 +0200,
> Jorge Sanjuan wrote:
>>
>> diff --git a/include/linux/usb/audio-v3.h b/include/linux/usb/audio-v3.h
>> index 334bfa6dfb47..786e5939d831 100644
>> --- a/include/linux/usb/audio-v3.h
>> +++ b/include/linux/usb/audio-v3.h
>> @@ -447,4 +447,8 @@ struct uac3_interrupt_data_msg {
>>  /* BADD sample rate is always fixed to 48kHz */
>>  #define UAC3_BADD_SAMPLING_RATE				48000
>>  
>> +/* BADD power domains recovery times */
>> +#define UAC3_BADD_PD_RECOVER_D1D0			0x0258
>> +#define UAC3_BADD_PD_RECOVER_D2D0			0x1770
> 
> Please put the unit for these values.  I guess they don't need to be
> hex?
> 

Hi!

The BADD spec defines these inferred values as hex (see section 6.2.2.13
of the spec). Should we keep them as per spec to avoid confusion? I'll
update comment there with the units (50 us increments).

Thanks for the reviews today. I'll update this series soon with the
suggested changes.

Jorge

> 
> Takashi
> 
