From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] ALSA: core: add .notify callback
 for pcm ops
Date: Thu, 09 Jul 2015 09:35:07 +0200
Message-ID: <559E242B.7030003@linux.intel.com>
References: <1436350236-17509-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1436350236-17509-3-git-send-email-pierre-louis.bossart@linux.intel.com>
 <s5hlheqhghu.wl-tiwai@suse.de>
 <CAN8cciYNQNXNzLgfFt=eXy4BVvYJaYfPPdwaCPUOJmuZO38LkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C3B260504
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 09:35:08 +0200 (CEST)
In-Reply-To: <CAN8cciYNQNXNzLgfFt=eXy4BVvYJaYfPPdwaCPUOJmuZO38LkQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/9/15 9:25 AM, Raymond Yau wrote:
>>>
>>> When appl_ptr is updated let low-level driver know.
>>>
>>> This is only enabled when the NO_REWIND hardware flag is used,
>>> so that the low-level driver/hardware to opportunistically pre-fetch
>>> data.
>>>
>>> FIXME: should we rely on .ack for this?
>>> Signed-off-by: Pierre-Louis Bossart <
> pierre-louis.bossart@linux.intel.com>
>>
>> Hmm, OK, so the forward is allowed but with workarounds...
>> But then why rewind won't work in a similar way?  DSP might be able to
>> cancel some of inflight data.
>>
>> In other words, I see no reason to strict notify callback only for
>> no_rewinds.  This is an optional ops in anyway.
>>
>> Also, I find the name "notify" a bit too ambiguous.  In this case,
>> it's notifying the applptr change.  So, a name related with the
>> function would be more understandable.
>>
>>
>
> If driver specify no rewind flag, should alsa lib
>
> 1) return error when application call snd_pcm_rewind() and
> snd_pcm_forward() ?

no, it would return 0 on rewind and the number of frames on forward. In 
other words the value returned is consistent with the function prototype 
which has no scope for errors.

> 2) return zero when call snd_pcm_rewindable() and snd_pcm_forwardable()

again zero for rewind and the actual number for forward.

> How can the application recover when hw_ptr is behind appl_ptr when stop
> threshold is set to boundary ?

Don't understand the question, there is no change here.

> Do you mean compressed audio stream don't support rewind and forward ?

You can't rewind in a compressed bitstream in general without losing 
sync or missing state information when there are dependencies between 
frames (linear prediction or filter with history). Forward is the same.
Some encoders allow for skips to well identified markers but random 
access is not possible or desired in general.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
