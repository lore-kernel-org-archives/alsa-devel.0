From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH RFC 2/9] ALSA: core: allow for
 trigger_tstamp snapshot in .trigger
Date: Wed, 10 Dec 2014 12:43:38 -0600
Message-ID: <5488945A.8010208@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1418077426-8309-3-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5htx13mpoy.wl-tiwai@suse.de> <5488814B.5030406@linux.intel.com>
 <s5hfvcnmmq5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4936D2605A3
 for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2014 19:43:43 +0100 (CET)
In-Reply-To: <s5hfvcnmmq5.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>>>> +	int trigger_tstamp_pending_update; /* trigger timestamp being updated from initial estimate */
>>>
>>> This isn't used at all in this patch.  I found it being used in the
>>> later usb-audio patch.  If it's the only place, can't it be rather put
>>> locally to usb-audio object instead of the common pcm runtime?
>>
>> It's not limited to USB. We have upcoming hardware where the
>> trigger_tstamp will only be determined with a delay due to IPC. USB is
>> just an example of a common pattern where the trigger_tstamp will be
>> known for sure after a couple of ms.
>
> Well, the question is whether this *must* be put in the common place.
> In other words, will this field be referred in the common PCM code?
> If not, it should be recorded rather locally.

well i wasn't sure of what to do here:
1. we can leave the low-lever driver update the trigger_tstamp on its 
own, and then this field is not needed at the core level, but the core 
or the application will not be notified that an update is pending
2. or we use this field to let the core know, and possibly let userspace 
know that the trigger will be updated shortly. However, I didn't find an 
existing mechanism to notify userspace that the new trigger_tstamp is 
dirty and has changed so the use of this field is indeed incomplete for now.

I could go either way.

			
>>>
>>> IMO, it's better to clear the flat at the beginning of PCM trigger
>>> commonly.  Looking at the later patch, you clear in each driver's
>>> callback.  This should be moved into the common place.
>>
>> I must admit I don't really understand the logic of all the _pre and
>> _post operations. Did you mean clearing this field in snd_pcm_do_start()?
>
> Yes, either snd_pcm_do_start() and snd_pcm_pre_start().  There aren't
> much difference in this case.

ok, will cleanup.
