From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] ALSA: Add the explicit appl_ptr sync
	support
Date: Thu, 22 Jun 2017 05:08:40 +0900
Message-ID: <f1878604-3fb8-593f-ee12-2a1a2c226e4d@sakamocchi.jp>
References: <20170620153352.27775-1-tiwai@suse.de>
 <32c68d13-d522-209a-9965-37440d096b48@sakamocchi.jp>
 <s5hzid1scys.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 22A2A2664EB
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 22:08:46 +0200 (CEST)
In-Reply-To: <s5hzid1scys.wl-tiwai@suse.de>
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

On Jun 21 2017 22:10, Takashi Iwai wrote:
>> However, when running with patched alsa-lib[1], due to a commit
>> f8ff2f28ba49 ("ALSA: pcm: Skip ack callback without actual appl_ptr
>> update")[2], callback functions in driver side for .ack are not called
>> from ioctl handler in ALSA PCM core. When page frames for control data
>> of PCM substream is mapped to VMA of the application, the application
>> updates the value of pointer in the frame, then transfer the value via
>> ioctl. Comparing these two values should be the same and ALSA PCM core
>> skip the callback.
> 
> Oh, that's a damn good point.
> 
> Currently alsa-lib issues sync_ptr() also for obtaining the PCM state
> from the kernel, and this also triggers ack unless SYNC_APPL_PTR flag
> is set.  The commit f8ff2f28ba49 tried to reduce the ack calls  by
> filtering in pcm_lib_apply_appl_ptr() side, but it has a side-effect
> as you noticed.
> 
> There can be a few options to cover this for the newer alsa-lib, for
> example:
> 
> A. Add a new bit flag to sync_ptr() allowing only the state update
>     and/or the explicit applptr update.
> 
> B. Introduce a completely new ioctl for the appl_ptr sync.
> 
> C. Keep disabling control mmap while allowing state mmap.
> 
> D. Track the last appl_ptr individually from runtime->control->appl_ptr
>     and compare/update with this value in pcm_lib_apply_appl_ptr().
> 
> E. Remove the filtering from pcm_lib_apply_appl_ptr(), let each driver
>     optimize if needed.
> 
> Currently I'm thinking of (A), but open for all and other possible
> options.  All these may need the check of user_pversion so that the
> old code still works as is.

I prefer C) and I'm working for it, because protocol validation of 
userland is not needed in kernel land, as long as I understand. But if 
allowed to add more changes to protocol/interface, A) and B) could be 
within my candidates.

> ... and, while testing the patchset today, I noticed a bug in the
> user_pversion check.  Namely, the user_pversion check must not be done
> against a substream.  A substream may be shared among multiple
> processes (typically by dmix), and changing from one process may hit
> others when it's set in the substream object.  For identifying the
> setup for each stream (from the user-space POV), the flag has to be
> stored in snd_pcm_file instead, just like no_compat_mmap flag.

Oh, I overlooked a case of open(2) with O_APPEND, as well. I also think 
it reasonable to utilize the private data of file descriptor for this 
purpose, good.

> That said, I have to respin a new patch in anyway, at least for the
> patches 2 & 3 :) I'll leave your reviewed-by tag from these, please
> review the new patchset again.  Sorry for doubly works.

No worry.


Thanks

Takashi Sakamoto
