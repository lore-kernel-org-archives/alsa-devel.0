From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
 when pause release after resume
Date: Thu, 9 May 2019 23:23:57 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D19528396E1@SHSMSX103.ccr.corp.intel.com>
References: <1557282761-26146-1-git-send-email-libin.yang@intel.com>
 <aa0c6eea81a721f340dd1362801e49049a6620dd.camel@linux.intel.com>
 <s5htve4mymn.wl-tiwai@suse.de>
 <ac99b2fefe05833787e473cbd2327a35c02de68b.camel@linux.intel.com>
 <s5hd0krmsyy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A679F89674
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2019 01:24:03 +0200 (CEST)
In-Reply-To: <s5hd0krmsyy.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "Wang, Rander" <rander.wang@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Friday, May 10, 2019 1:35 AM
>To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>Cc: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>Sridharan, Ranjani <ranjani.sridharan@intel.com>; pierre-
>louis.bossart@linux.intel.com; Wang, Rander <rander.wang@intel.com>;
>broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
>when pause release after resume
>
>On Thu, 09 May 2019 18:56:12 +0200,
>Ranjani Sridharan wrote:
>>
>> > Hm, it's a good question.  Currently the PCM core doesn't care about
>> > the paused stream wrt PM by the assumption that the paused / stopped
>> > stream doesn't need a special resume treatment.  But, generally
>> > speaking, the pause-release won't work for a hardware that doesn't
>> > support the full resume, either.  For example, the legacy HD-audio
>> > may restart from some wrong position if resumed from the pause.
>> >
>> > Maybe this problem hasn't been seen just because the pause function
>> > is rarely used.
>> >
>> > So, the safe behavior would be to let the stream being SUSPENDED
>> > state at snd_pcm_stream_suspend() when it's in the PAUSED and has no
>> > INFO_RESUME capability.  Then the application does re-prepare the
>> > stream like the running one.
>> >
>> > But the question is what's expected at next.  Should the application
>> > re-start?  But it was paused.  Should PCM core automatically move to
>> > pause?  But most hardware can't move the pointer to any random
>> > position.
>> >
>> > My gut feeling is just to treat like a normal error-restart, i.e.
>> > re-prepare / re-start.  But I'm open and would like to hear more
>> > opinions.
>>
>> Hi Takashi,
>>
>> So in the current scenario what we see is that after resuming from S3,
>> a pause-release action from the user results in a FE prepare()
>> followed by the START trigger (and not a PAUSE-RELEASE trigger).
>>
>> Libin's patch proposes to do a prepare() for the BE even in the case
>> of a regular pause-release. But this might not be ideal since other
>> drivers might have logic in the prepare() ioctl that might end up with
>> errors.
>
>Right.
>
>> So I am thinking maybe we can have some internal logic in the SOF
>> prepare() callback that will also call the BE prepare() when the
>> be->dpcm[stream].state is SND_SOC_DPCM_STATE_PAUSED? Would that
>make
>> sense?
>
>Yes, that would work, I guess.  Eventually this might be needed to be
>addressed in ALSA core side, too, but it's good to have some fix beforehand in
>DPCM.

Ranjani, with "regular pause-release", do you mean pause-release
without S3? The prepare() is called from alsa core (pcm_native.c) in S3 case.
Prepare() being called in pause-release after S3 is because of S3, not because
of pause-release. Actually, if you pause-release without S3 (not sure in
pm-runtime case), ASoC's prepare() will not be called. So 
dpcm_be_dai_prepare() will not be called. So you assumption of
"regular pause-release" calling prepare() is wrong.

Please let me describe the flow below:
1. Pause-release after S3 without RESUME_INFO
Prepare() -> trigger start
2. pause-release without S3 without/with RESUME_INFO
Trigger pause-release
3. Pause-release after S3 with RESUME_INFO
Trigger resume

So you will see prepare() is only called in case 1. This is because S3
happens before pause-release. I believe all drivers need prepare()
in such case, not only for SOF driver.

Regards,
Libin

>
>
>thanks,
>
>Takashi
