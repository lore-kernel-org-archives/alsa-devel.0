From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
 when pause release after resume
Date: Thu, 9 May 2019 02:30:39 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1952838E47@SHSMSX103.ccr.corp.intel.com>
References: <1557282761-26146-1-git-send-email-libin.yang@intel.com>
 <aa0c6eea81a721f340dd1362801e49049a6620dd.camel@linux.intel.com>
 <s5htve4mymn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 916B4F8073C
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 04:30:44 +0200 (CEST)
In-Reply-To: <s5htve4mymn.wl-tiwai@suse.de>
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
>Sent: Thursday, May 9, 2019 5:21 AM
>To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
>Cc: Yang, Libin <libin.yang@intel.com>; alsa-devel@alsa-project.org;
>Sridharan, Ranjani <ranjani.sridharan@intel.com>; pierre-
>louis.bossart@linux.intel.com; Wang, Rander <rander.wang@intel.com>;
>broonie@kernel.org
>Subject: Re: [alsa-devel] [PATCH V2] ASoC: soc-pcm: BE dai needs prepare
>when pause release after resume
>
>On Wed, 08 May 2019 18:30:08 +0200,
>Ranjani Sridharan wrote:
>>
>> On Wed, 2019-05-08 at 10:32 +0800, libin.yang@intel.com wrote:
>> > From: Libin Yang <libin.yang@intel.com>
>> >
>> > If playback/capture is paused and system enters S3, after system
>> > returns from suspend, BE dai needs to call prepare() callback when
>> > playback/capture is released from pause if RESUME_INFO flag is not
>> > set.
>> Hi Takashi,
>>
>> This is a question for you. We've run into the problem of not being
>> able to do a pause-release after the system resumes from S3 after we
>> removed INFO_RESUME from the SOF driver.
>>
>> Apparently, with this flag removed, when the user does a pause release
>> after resuming from S3, the prepare() callback gets invoked for the FE
>> but doesnt happen for the the BE. Could you please guide us on whether
>> this is the right approach and if not, suggest an alternative?

I think this may be a ASoC FE-BE defect.
In this case, ASoC will call FE dai prepare(), but it will not call 
BE dai prepare() because of the judgement. This is why I made the patch.

>
>Hm, it's a good question.  Currently the PCM core doesn't care about the
>paused stream wrt PM by the assumption that the paused / stopped stream
>doesn't need a special resume treatment.  But, generally speaking, the pause-
>release won't work for a hardware that doesn't support the full resume,
>either.  For example, the legacy HD-audio may restart from some wrong
>position if resumed from the pause.
>
>Maybe this problem hasn't been seen just because the pause function is rarely
>used.
>
>So, the safe behavior would be to let the stream being SUSPENDED state at
>snd_pcm_stream_suspend() when it's in the PAUSED and has no
>INFO_RESUME capability.  Then the application does re-prepare the stream
>like the running one.
>
>But the question is what's expected at next.  Should the application re-start?
>But it was paused.  Should PCM core automatically move to pause?  But most
>hardware can't move the pointer to any random position.

I think our current solution is reasonable. we should remove INFO_RESUME
for Intel platform. The only side effect is that we will restart the PCM.
My understanding is that INFO_RESUME is used for those platforms which 
can support suspend/resume by hardware. And obviously, on intel platforms, 
we need do a lot of recovery for resume in driver. 

Regards,
Libin

>
>My gut feeling is just to treat like a normal error-restart, i.e. re-prepare / re-
>start.  But I'm open and would like to hear more opinions.
>
>
>thanks,
>
>Takashi
>
>
