From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] Yet another patchset for LPE audio
 refactoring
Date: Mon, 6 Feb 2017 19:22:17 -0600
Message-ID: <9a49639a-5322-ad84-2dc1-73b3451a032e@linux.intel.com>
References: <20170203164400.12983-1-tiwai@suse.de>
 <s5hshnrf88i.wl-tiwai@suse.de>
 <4b313a18-f7a0-83f6-3f97-2daadec6ebf9@linux.intel.com>
 <s5ho9yff0xx.wl-tiwai@suse.de>
 <149fad5a-898d-ea49-625c-6be1bba350bf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FE5726686E
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 02:22:21 +0100 (CET)
In-Reply-To: <149fad5a-898d-ea49-625c-6be1bba350bf@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> - The behavior in had_process_buffer_underrun() isn't clear enough.
>>>>   Or, more exactly, the behavior of AUD_HDMI_STATUS reg and AUD_CONFIG
>>>>   reg look complex, and need a bit more description for readers
>>>>   (including me).
>>>>
>>>> Can you guys enlighten a bit?
>>>
>>> For the LPE_AUDIO_Buffer_config register (65020h), there is one
>>> important field
>>> 10:8: DMA Fifo watermark. The audio unit has 8x64 bytes, this register
>>> define when to fetch data. Bottom line it'd be wise to avoid rewinding
>>> below that FIFO size...
>>
>> Right, this may be needed to be exposed.
>>
>>
>>> There are two possible interrupt sources in the
>>> STREAM_X_LPE_AUD_HDMI_STATUS (65064h)
>>> Bit 31: sample buffer underrun. HDMI audio unit did not have enough
>>> samples to insert in video frame (cleared by writing a one)
>>> Bit 29: buffer done status, write 1 to clear
>>> Bit 15: sample buffer underrun interrupt enable
>>
>> OK, then the current code seems naming the function wrongly.
>> It names had_enable_audio_int() but actually this should be named as
>> had_clear_interrupts() or such.
>
> I think enable and clear are two separate steps, you only clear what
> you've enabled, no?

To be crystal-clear, there are two interrupts we care about
1. buffer interrupt. This is enabled in bit1 of 
STREAM_X_LPE_AUD_BUFFER_M_ADDR, the hardware will generate an interrupt 
when the hardware is done reading the data from memory. Bit0 is set 
after a new address is programmed (or just to reactivate the same address).
2. underrun interrupt. This is enabled once in the 
STREAM_X_LPE_AUD_HDMI_STATUS register, you don't need to re-enable it 
for each buffer.
