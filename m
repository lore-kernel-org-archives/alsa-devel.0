From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: semantics of SNDRV_PCM_INFO_BATCH (was: Re: safe
	support for rewind in ALSA)
Date: Tue, 23 Feb 2010 15:02:35 +0800
Message-ID: <4f3252891002222302i6c65b672l40ff7a781ef824b8@mail.gmail.com>
References: <alpine.DEB.1.10.1002012328440.3125@ecabase.localdomain>
	<4f3252891002100519h132fddb8t1f2bc56e97bf5c40@mail.gmail.com>
	<4B72B665.3060903@ladisch.de>
	<4f3252891002102252vb6d7a94l76fb78e33da37775@mail.gmail.com>
	<4B73AFD5.4080205@ladisch.de>
	<alpine.LNX.2.00.1002110822480.19278@eeebox2.perex-int.cz>
	<4f3252891002141903q34144f58n60978e28e65640b4@mail.gmail.com>
	<alpine.DEB.1.10.1002211208120.3327@ecabase.localdomain>
	<20100221203500.GH31800@tango.0pointer.de>
	<alpine.DEB.1.10.1002221958390.3327@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9360B24347
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 08:02:37 +0100 (CET)
Received: by pwi9 with SMTP id 9so3083194pwi.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 23:02:36 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1002221958390.3327@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/23 Kai Vehmanen <kvehmanen@eca.cx>

> Hi,
>
> On Sun, 21 Feb 2010, Lennart Poettering wrote:
>
>  But you can query the SNDRV_PCM_INFO_BATCH flag (it's set by e.g. the USB
>>> driver) and adjust your hrtimer-based application's logic based on that
>>>
>>
It is not easy to calculate the correct wake up time if the function is a
stepping function since you must keep track of the elasped time instead of
relying on the hw ptr positon


>  [...]
>
>> This mean that the wake up time cannot be calculated using as number of
>>>> sample/rate since the fuction is not linear especially when using max
>>>> buffer
>>>> size , min period --> max period size is much greater than the watermark
>>>>
>>>
>>> Yep, that's what SNDRV_PCM_INFO_BATCH flag warns you about.
>>>
>>
>> Hmm, could you elaborate a little about SNDRV_PCM_INFO_BATCH? What
>> exactly does that mean in general and especially for the timer based
>> audio scheduling?
>>
>> I am currently not making use of this, but should I?
>>
>
> I'm also looking at this topic from an application developer perspective,
> so I can only provide you my interpretation of reading current ALSA code,
> but here goes.
>
> I'll also add Eliot (who asked about the same thing, in
> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-February/025262.html) to the cc, and also Takashi, who git-annotate reveals has made most recent
> PCM_INFO_BATCH related changes to linux/sound/core/pcm_lib.c. ;)
>
> Anyway, SNDRV_PCM_INFO_BATCH is set by following drivers:
>  - isa/msnd
>  - pcii/bt87x
>  - pci/korg1212
>  - pcmcia/pdaudiocf
>  - soc/au1x
>  - soc/fsl (mpc52xx/8610)
>  - sparc/dbri
>  - usbaudio
>

How about cs46xx ?


>
> Common to all these drivers is that audio samples are moved to/from the
> ALSA ringbuffer, in bursts, to an intermediary block of memory, and from
> there to/from the codec. And most importantly, pointer callback is based on
> last ack'ed burst. IOW, hw_ptr jumps in bursts with these drivers and
> granularity of hw_ptr is more coarse (affecting snd_pcm_avail(),
> snd_pcm_delay() and so forth).
>
> Now the existing documentation for the flag (and user-space
> snd_pcm_hw_params_is_batch() API) is rather brief as you've noted, and AFAIK
> very few apps use these, so I'm not sure, how much we as app developers
> should rely on these semantics (and to the fact that future drivers will use
> the BATCH flag in a similar way).
>
> But anyways, the fact remains that snd_pcm_hw_params_is_batch() exists, and
> based on a review of current (2.6.33-rc) drivers, majority/all of the
> drivers use the flag in the same way.
>
> So for apps like PA, snd_pcm_hw_params_is_batch() is a hint that app should
> not rewind closer to hw_ptr than period-size. It also hints that hw_ptr
> granularity is more coarse, which might be useful in setting sane defaults
> for buffer watermarks and such.
>
> PS Eliot: I didn't respond to your original mail, as I don't really
>   have even good reading-the-code interpretations for the others.
>   SNDRV_PCM_INFO_BLOCK_TRANSFER/snd_pcm_hw_params_is_block_transfer()
>   is set by many, many drivers, but I'm not sure what the
>   semantics really are (why cs4281 does not set the flag, while
>   ens1370 sets it for instance). Then again SNDRV_PCM_INFO_BLOCK_DOUBLE
>   seems very close to BATCH flag, but drivers setting DOUBLE (basicly
>   just rme9652), _do_ support accurate pointer/hw_ptr reporting, so
>   there is a difference.
>
