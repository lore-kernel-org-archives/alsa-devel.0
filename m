From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [RFC PATCH] ALSA: hda - add support for runtime
	power management
Date: Sun, 19 Aug 2012 10:46:42 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F818C27C@SHSMSX101.ccr.corp.intel.com>
References: <1345195814-2287-1-git-send-email-mengdong.lin@intel.com>
 <s5hsjblvo9s.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F818B4E4@SHSMSX101.ccr.corp.intel.com>
 <s5hd32psbqb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 68C672652A6
 for <alsa-devel@alsa-project.org>; Sun, 19 Aug 2012 12:17:01 +0200 (CEST)
In-Reply-To: <s5hd32psbqb.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Looking at your original patch, just a few points I'd like to clarify:
> 
> - Don't use snd_printd().  It's a debug print most of distros turn
>   ON, thus it'd be annoying.  If any, use snd_printdd().

Okay. I'll remove snd_printd(). Thanks for pointing out this.


> - The IRQ reassignment is required for runtime PM?

I'm not sure if the IRQ reassignment can be removed and I'll double check this. 
 
> - Why you call snd_pcm_suspend_all() in azx_runtime_suspend()?
>   In which situation would a PCM stream be pending?

snd_pcm_suspend_all() should not be called in azx_runtime_suspend(), since there is no active PCM streams when ready for runtime suspend. I'll remove it. 


> - Are snd_power_change_state() calls needed for runtime PM?
I think this is needed. It's because HW is actually in D3 when it's runtime suspended and need a delay for transition back to D0. And there are operations that need HW in D0, such as snd_pcm_prepare().

Thanks again!
Mengdong
