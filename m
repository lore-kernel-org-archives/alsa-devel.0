From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: Add the explicit appl_ptr sync
	support
Date: Fri, 23 Jun 2017 17:27:06 +0900
Message-ID: <e5e8e0b3-8d5e-c29f-cd29-67efd812c6d7@sakamocchi.jp>
References: <20170620153352.27775-1-tiwai@suse.de>
 <32c68d13-d522-209a-9965-37440d096b48@sakamocchi.jp>
 <s5hzid1scys.wl-tiwai@suse.de>
 <f1878604-3fb8-593f-ee12-2a1a2c226e4d@sakamocchi.jp>
 <s5hwp84qumh.wl-tiwai@suse.de>
 <bca6a38c-7c60-a5b5-e77a-3d93b8ff7438@sakamocchi.jp>
 <s5hh8z8ovlt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 9B607266D46
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 10:27:08 +0200 (CEST)
In-Reply-To: <s5hh8z8ovlt.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 23 2017 01:06, Takashi Iwai wrote:
> On Thu, 22 Jun 2017 17:35:34 +0200,
> Takashi Sakamoto wrote:
>>
>> Hi,
>>
>> On Jun 22 2017 17:44, Takashi Iwai wrote:
>>>>> Currently alsa-lib issues sync_ptr() also for obtaining the PCM state
>>>>> from the kernel, and this also triggers ack unless SYNC_APPL_PTR flag
>>>>> is set.  The commit f8ff2f28ba49 tried to reduce the ack calls  by
>>>>> filtering in pcm_lib_apply_appl_ptr() side, but it has a side-effect
>>>>> as you noticed.
>>>>>
>>>>> There can be a few options to cover this for the newer alsa-lib, for
>>>>> example:
>>>>>
>>>>> A. Add a new bit flag to sync_ptr() allowing only the state update
>>>>>       and/or the explicit applptr update.
>>>>>
>>>>> B. Introduce a completely new ioctl for the appl_ptr sync.
>>>>>
>>>>> C. Keep disabling control mmap while allowing state mmap.
>>>>>
>>>>> D. Track the last appl_ptr individually from runtime->control->appl_ptr
>>>>>       and compare/update with this value in pcm_lib_apply_appl_ptr().
>>>>>
>>>>> E. Remove the filtering from pcm_lib_apply_appl_ptr(), let each driver
>>>>>       optimize if needed.
>>>>>
>>>>> Currently I'm thinking of (A), but open for all and other possible
>>>>> options.  All these may need the check of user_pversion so that the
>>>>> old code still works as is.
>>>>
>>>> I prefer C) and I'm working for it, because protocol validation of
>>>> userland is not needed in kernel land, as long as I understand. But if
>>>> allowed to add more changes to protocol/interface, A) and B) could be
>>>> within my candidates.
>>>
>>> (C) was my original idea, too, so it doesn't sound bad to me, too :)
>>> But, we're bumping the protocol version, so more intensive changes
>>> should be OK.  Let's see.
>>
>> I posted patchset for alsa-lib for your C) idea. In this patchset,
>> mapping for status/control data is processed independently,
>>
>> [alsa-devel] [alsa-lib][RFC][PATCH 0/9] pcm: handle status/control
>> mapping independently
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122130.html
> 
> The patchset looks good through a quick glance.
> I'd need to test it more intensively later, but I'm basically fine to
> go in that direction.  In general, this change wouldn't conflict with
> other improvements.

Thanks for your positive comment. I'm preparing for new patchset with my 
further self-check.

>> Additionally, some helper functions to call ioctl(2) with
>> SNDRV_PCM_IOCTL_SYNC_PTR for several purposes. I think to get help
>> from it for our arrangement to A) and B).
>>
>> I agree with the idea in A) to add a flag to update state only. For
>> the other probabilities, I need time to consider about it.
> 
> Yeah, let's take some time.
> 
> Meanwhile, I'd like to merge the basic part in order to make
> maintenance easier.  Let's sort out which ones to be applied right
> now.
> 
> At least, the following one should be OK:
> 
>    [PATCH v2 1/3] ALSA: pcm: Add the explicit appl_ptr sync support
> 
> May I re-apply your reviewed-by tag for this?

I did it just now. Let's merge it.

> For alsa-lib side, a few of yours and my patches are merely cleanups,
> so we should apply them beforehand, too.
> 
>    [PATCH alsa-lib 3/4] pcm: hw: Remove superfluous call of snd_pcm_set_appl_ptr()
>    [alsa-lib][RFC][PATCH 1/9] pcm: obsolete 'mmap_emulation' parameter of snd_pcm_hw_open_fd()
>    [alsa-lib][RFC][PATCH 2/9] pcm: minor code refactoring for ioctl call

I'm OK to apply the cleanups. I already reviewed the first patch so 
let's merge it. I'll post the rest of two without RFC rebasing to 
current master a few hours later.


Thanks

Takashi Sakamoto
