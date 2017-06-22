From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: Add the explicit appl_ptr sync
	support
Date: Fri, 23 Jun 2017 00:35:34 +0900
Message-ID: <bca6a38c-7c60-a5b5-e77a-3d93b8ff7438@sakamocchi.jp>
References: <20170620153352.27775-1-tiwai@suse.de>
 <32c68d13-d522-209a-9965-37440d096b48@sakamocchi.jp>
 <s5hzid1scys.wl-tiwai@suse.de>
 <f1878604-3fb8-593f-ee12-2a1a2c226e4d@sakamocchi.jp>
 <s5hwp84qumh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 5EFD0266D83
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 17:35:41 +0200 (CEST)
In-Reply-To: <s5hwp84qumh.wl-tiwai@suse.de>
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

On Jun 22 2017 17:44, Takashi Iwai wrote:
>>> Currently alsa-lib issues sync_ptr() also for obtaining the PCM state
>>> from the kernel, and this also triggers ack unless SYNC_APPL_PTR flag
>>> is set.  The commit f8ff2f28ba49 tried to reduce the ack calls  by
>>> filtering in pcm_lib_apply_appl_ptr() side, but it has a side-effect
>>> as you noticed.
>>>
>>> There can be a few options to cover this for the newer alsa-lib, for
>>> example:
>>>
>>> A. Add a new bit flag to sync_ptr() allowing only the state update
>>>      and/or the explicit applptr update.
>>>
>>> B. Introduce a completely new ioctl for the appl_ptr sync.
>>>
>>> C. Keep disabling control mmap while allowing state mmap.
>>>
>>> D. Track the last appl_ptr individually from runtime->control->appl_ptr
>>>      and compare/update with this value in pcm_lib_apply_appl_ptr().
>>>
>>> E. Remove the filtering from pcm_lib_apply_appl_ptr(), let each driver
>>>      optimize if needed.
>>>
>>> Currently I'm thinking of (A), but open for all and other possible
>>> options.  All these may need the check of user_pversion so that the
>>> old code still works as is.
>>
>> I prefer C) and I'm working for it, because protocol validation of
>> userland is not needed in kernel land, as long as I understand. But if
>> allowed to add more changes to protocol/interface, A) and B) could be
>> within my candidates.
> 
> (C) was my original idea, too, so it doesn't sound bad to me, too :)
> But, we're bumping the protocol version, so more intensive changes
> should be OK.  Let's see.

I posted patchset for alsa-lib for your C) idea. In this patchset, 
mapping for status/control data is processed independently,

[alsa-devel] [alsa-lib][RFC][PATCH 0/9] pcm: handle status/control 
mapping independently
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122130.html

Additionally, some helper functions to call ioctl(2) with 
SNDRV_PCM_IOCTL_SYNC_PTR for several purposes. I think to get help from 
it for our arrangement to A) and B).

I agree with the idea in A) to add a flag to update state only. For the 
other probabilities, I need time to consider about it.

>>> ... and, while testing the patchset today, I noticed a bug in the
>>> user_pversion check.  Namely, the user_pversion check must not be done
>>> against a substream.  A substream may be shared among multiple
>>> processes (typically by dmix), and changing from one process may hit
>>> others when it's set in the substream object.  For identifying the
>>> setup for each stream (from the user-space POV), the flag has to be
>>> stored in snd_pcm_file instead, just like no_compat_mmap flag.
>>
>> Oh, I overlooked a case of open(2) with O_APPEND, as well. I also
>> think it reasonable to utilize the private data of file descriptor for
>> this purpose, good.
>>
>>> That said, I have to respin a new patch in anyway, at least for the
>>> patches 2 & 3 :) I'll leave your reviewed-by tag from these, please
>>> review the new patchset again.  Sorry for doubly works.
>>
>> No worry.
> 
> So, at this point, I think it's safe to apply the first patch.
> 
> The second one is introducing USER_PVERSION ioctl, but it makes little
> sense without the actual usage.  And the last one is obviously not
> working well as is, and we may have a better optimization.


Regards

Takashi Sakamoto
