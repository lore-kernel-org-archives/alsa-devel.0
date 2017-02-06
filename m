From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] Yet another patchset for LPE audio
	refactoring
Date: Mon, 6 Feb 2017 17:56:54 -0600
Message-ID: <149fad5a-898d-ea49-625c-6be1bba350bf@linux.intel.com>
References: <20170203164400.12983-1-tiwai@suse.de>
 <s5hshnrf88i.wl-tiwai@suse.de>
 <4b313a18-f7a0-83f6-3f97-2daadec6ebf9@linux.intel.com>
 <s5ho9yff0xx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C607226686E
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 00:56:57 +0100 (CET)
In-Reply-To: <s5ho9yff0xx.wl-tiwai@suse.de>
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

On 2/6/17 3:45 PM, Takashi Iwai wrote:
> On Mon, 06 Feb 2017 22:16:22 +0100,
> Pierre-Louis Bossart wrote:
>>
>> On 2/6/17 1:07 PM, Takashi Iwai wrote:
>>> On Fri, 03 Feb 2017 17:43:56 +0100,
>>> Takashi Iwai wrote:
>>>>
>>>> Hi,
>>>>
>>>> this is the final part of my cleanup / refactoring patchsets for Intel
>>>> LPE audio.  Now the PCM stream engine has been rewritten.  It supports
>>>> more flexible configuration, not only fixed 4 periods, for example,
>>>> yet with a lot of code reduction.
>>>>
>>>> As usual, the patches are found in topic/intel-lpe-audio-cleanup
>>>> branch.
>>>
>>> So far, from my side, now most of changes have been submitted /
>>> merged.  But I still have some unclear things in the code.
>>>
>>> - The PCM format: the code contains the handling of S16_LE, but it
>>>   doesn't seem work when I enabled the info bit.  What's missing?
>>>   Also U24_LE format is ever supported...?  How?
>>
>> In the initial version the samples were assumed to be using the 24 lsb
>> of a 32-bit word. 16-bit data can be supported as long as it was
>> left-shifted before being written to the ring buffer.
>>
>> For stereo the channels are assumed to be interleaved in Layout 0
>> (left, right). For more than 2ch, all channels for the same sample are
>> inserted consecutively (ie. no blocks of channels). In the initial
>> version the number of channels is assumed to be even and one bogus
>> channel had to be inserted for odd number of channels.
>>
>> in more recent versions the samples could also be represented as using
>> the 24 msb and the requirement for the bogus channel was removed but I
>> never worked on this personally and the documentation is far from
>> clear.
>
> OK, that's interesting.  So we may support even  S32_LE format, too.

well, yes but the 8 LSBs would be ignored, you can only transmit 24 bits 
with HDMI (it's 28 bits total per sample with 4 status bits).

>
> The odd channel restriction isn't seen in the current code, indeed.
> It's worth to try 3 channels tomorrow :)
>
>> At any rate, here's what I see in the description of the
>> STREAM_X_LPE_AUD_CONFIG registers for CHT:
>>
>> Bit 15:
>> 1: DP mode
>> 0: HDMI (default)
>>
>> Bit14:
>> 1: no bogus sample for odd channels
>> 0: bogus sample for off channels (default)
>>
>> Bit13:
>> 1: MSB is bit 31 of 32-bit container
>> 0: MSB is bit 23 of 32-bit container (default)
>>
>> Bit 12:
>> 1: 16-bit container
>> 0: 32-bit container (default)
>>
>> Bit 11:
>> 1: send silence stream
>> 0: send null packets (default)
>
> So this corresponds to the hw_silence stuff you mentioned?

yes. I am still trying to figure out how it's supposed to be used (you 
need a valid configuration first).

>
>
>> I see no evidence that unsigned data is supported.
>
> Yeah, and I really doubt whether unsigned format is supported at all.
> Better to drop it.

Agree.

>
>> I would really take all these configurations with caution, it's not
>> clear to me if the documentation reflects the actual implementation.
>
> Sure, it's just for fun for now.
>
>> Note that the hardware can swap channels, I don't remember if this is
>> currently enabled.
>
> We have the following code:
>
> #define SWAP_LFE_CENTER		0x00fac4c8
>
> 	/*
> 	 * Program channel mapping in following order:
> 	 * FL, FR, C, LFE, RL, RR
> 	 */
>
> 	had_write_register(intelhaddata, AUD_BUF_CH_SWAP, SWAP_LFE_CENTER);
>
> 0x00fac4c8 is octal 74543210, so it's jus a plain order.

Yes, the 24 LBSs (23:0) in this register are split in 8 3-bit subfields, 
e.g if you program 7 (111b) in bits 2:0 and 0 in bits 23:21 you would 
swap first and last channels.
This only works for multichannel (layout 1), no support for l/r swap.

>
> But this reminds me that I didn't check the correctness of chmap order
> in the current driver.  Another thing to try tomorrow.
>
>>
>>>
>>> - The behavior in had_process_buffer_underrun() isn't clear enough.
>>>   Or, more exactly, the behavior of AUD_HDMI_STATUS reg and AUD_CONFIG
>>>   reg look complex, and need a bit more description for readers
>>>   (including me).
>>>
>>> Can you guys enlighten a bit?
>>
>> For the LPE_AUDIO_Buffer_config register (65020h), there is one
>> important field
>> 10:8: DMA Fifo watermark. The audio unit has 8x64 bytes, this register
>> define when to fetch data. Bottom line it'd be wise to avoid rewinding
>> below that FIFO size...
>
> Right, this may be needed to be exposed.
>
>
>> There are two possible interrupt sources in the
>> STREAM_X_LPE_AUD_HDMI_STATUS (65064h)
>> Bit 31: sample buffer underrun. HDMI audio unit did not have enough
>> samples to insert in video frame (cleared by writing a one)
>> Bit 29: buffer done status, write 1 to clear
>> Bit 15: sample buffer underrun interrupt enable
>
> OK, then the current code seems naming the function wrongly.
> It names had_enable_audio_int() but actually this should be named as
> had_clear_interrupts() or such.

I think enable and clear are two separate steps, you only clear what 
you've enabled, no?

>
>>
>> Hope this helps
>
> Very appreciated, thank you for prompt answer!
>
>
> Takashi
>
