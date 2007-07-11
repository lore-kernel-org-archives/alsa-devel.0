From: Steve Longerbeam <stevel@embeddedalley.com>
Subject: Re: non-interleaved mode
Date: Wed, 11 Jul 2007 09:23:12 -0700
Message-ID: <469503F0.80706@embeddedalley.com>
References: <4693CB01.5060804@embeddedalley.com>
	<s5hbqejjphf.wl%tiwai@suse.de>	<20070711091324.43424685.alsauser@pragmasoft.com>
	<s5hps2zhxlb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp105.biz.mail.mud.yahoo.com (smtp105.biz.mail.mud.yahoo.com
	[68.142.200.253])
	by alsa0.perex.cz (Postfix) with SMTP id 284A3103918
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 18:23:16 +0200 (CEST)
In-Reply-To: <s5hps2zhxlb.wl%tiwai@suse.de>
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
Cc: "J. Scott Merritt" <alsauser@pragmasoft.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Wed, 11 Jul 2007 09:13:24 -0400,
> J. Scott Merritt wrote:
>   
>> On Wed, 11 Jul 2007 10:47:56 +0200
>> Takashi Iwai <tiwai@suse.de> wrote:
>>
>>     
>>> At Tue, 10 Jul 2007 11:08:01 -0700,
>>> Steve Longerbeam wrote:
>>>       
>>>> Hi,
>>>>
>>>> The driver for the sound engine I'm working on requires NONINTERLEAVED. 
>>>> Will ALSA core give my driver a full period of left-only samples, 
>>>> followed by a full period of right-only samples? Or are left/right 
>>>> samples split within a single period (ie. first half of period is left 
>>>> samples, second half is right samples)?
>>>>         
>>> The former case.  The standard non-interleaved buffer consists of
>>> (the same buffer-size of) full-length of mono-streams.
>>>
>>>
>>> Takashi
>>>       
>> Doesn't this depend upon the driver implementation ?  IIRC, I tried to
>> request NON-INTERLEAVED on the PXA270 AC97 driver and it told me that
>> wasn't a permitted operation (one of the reasons that I needed to use
>> mmap access in SALSA-Lib).
>>     
>
> The latter case, "multi-streams in each period" style, cannot be
> represented in ALSA API, more specifically, snd_pcm_channel_info
> struct.  Thus, it has to be remapped virtually to the normal
> non-interleaved streams (each with full periods), or to avoid mmap and
> copy the data inside the driver.
>
> There is another COMPLEX_MMAP access type, but it's also for linear
> frames with constant increments, where each channel can be represented
> with snd_pcm_channel_info record.  The "multi-streams in each period"
> is non-linear.
>
>
>   

Last night I ran an experiment.  I created a 16-bit stereo .wav file 
with all left samples = 0x5555, and all right samples = 0xAAAA. I then 
played the .wav using aplay, and just before trigger start in my driver 
I searched the DMA buffer for the first occurrence of 0xAAAA. The right 
samples didn't start until exactly half-way through the entire DMA buffer!

So now I'm confused, you say there should be one full period of left, 
followed by one full period of right, but I'm observing that the whole 
buffer is split in half, with the first half left, the second half 
right. How did this happen? Is there any way for a driver to query ALSA 
core about the non-interleaved layout of samples in memory?

I'm running 2.6.21.1 which is alsa-driver 1.0.14rc3, and I'm using 
alsa-lib 1.0.14rc3 and alsa-utils 1.0.14rc2.

Steve
