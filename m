From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/4] ALSA: x86: Don't pass
 SNDRV_PCM_INFO_BATCH flag
Date: Fri, 3 Feb 2017 17:13:49 -0600
Message-ID: <aa88aec1-0703-a683-c19a-9f3b9bd0f233@linux.intel.com>
References: <20170203164400.12983-1-tiwai@suse.de>
 <20170203164400.12983-2-tiwai@suse.de>
 <5a4f2f34-81eb-6f40-2849-0212a1f68e78@linux.intel.com>
 <s5h7f57hw23.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 118EE266BCF
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 00:13:53 +0100 (CET)
In-Reply-To: <s5h7f57hw23.wl-tiwai@suse.de>
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



On 02/03/2017 02:13 PM, Takashi Iwai wrote:
> On Fri, 03 Feb 2017 20:39:49 +0100,
> Pierre-Louis Bossart wrote:
>> On 2/3/17 10:43 AM, Takashi Iwai wrote:
>>> The PCM engine on LPE audio isn't like a batch-style process, but
>>> rather it deals with the standard ring buffer.  Passing the BATCH info
>>> flag is inappropriate.
>> Humm, this is controversial. There are 4 DMA descriptors and getting a
>> precise position in the stream is not straightforward.
> Well, as far as I've tested, it is.  The buffer length register keeps
> the remaining bytes, and you can easily read out and compute the
> current position in fairly exact manner.  Even the old driver has that
> information -- the patch David added does it.
Yes, and I don't think anyone on the Intel side quite understood what 
David did there. The code didn't seem quite right.
>
>> Rewind is also
>> not supported so if you remove the BATCH flag you will push PulseAudio
>> into doing timer-based scheduling and rewinds that probably don't
>> work.
> I don't think there is much difference regarding this.
> Please check the buffer manage description in my previous post
We've never tested the hardware in those configurations so I'd like a 
bit more time to double check how well this might work. None of us has a 
clear view of how much buffering and pre-fetch is done by the DMA engine 
so if you rewind 'too much' you may be out of luck.
>
> In anyway, it'd be appreciated if you can test on your hardware.
> I could test only on a single machine.
I can test more but only in 10 days from now so if we could delay this 
patch a bit it'd be better.
>
>
> thanks,
>
> Takashi
>
>
>>> Similarly, the DOUBLE flag is also superfluous.  Drop both bits.
>>>
>>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>> ---
>>>   sound/x86/intel_hdmi_audio.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
>>> index c83f02c2593e..32a21422e6f5 100644
>>> --- a/sound/x86/intel_hdmi_audio.c
>>> +++ b/sound/x86/intel_hdmi_audio.c
>>> @@ -131,10 +131,8 @@ static const struct channel_map_table map_tables[] = {
>>>   /* hardware capability structure */
>>>   static const struct snd_pcm_hardware snd_intel_hadstream = {
>>>   	.info =	(SNDRV_PCM_INFO_INTERLEAVED |
>>> -		SNDRV_PCM_INFO_DOUBLE |
>>>   		SNDRV_PCM_INFO_MMAP|
>>> -		SNDRV_PCM_INFO_MMAP_VALID |
>>> -		SNDRV_PCM_INFO_BATCH),
>>> +		SNDRV_PCM_INFO_MMAP_VALID),
>>>   	.formats = (SNDRV_PCM_FMTBIT_S24 |
>>>   		SNDRV_PCM_FMTBIT_U24),
>>>   	.rates = SNDRV_PCM_RATE_32000 |
>>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
