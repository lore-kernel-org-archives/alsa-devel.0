From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: usb-audio: ignore delay
 calculation for capture stream
Date: Mon, 26 Nov 2012 15:05:45 -0600
Message-ID: <50B3D9A9.1000702@linux.intel.com>
References: <1353684108-16669-1-git-send-email-tiwai@suse.de>
 <1353684108-16669-2-git-send-email-tiwai@suse.de>
 <50B37B90.7020403@linux.intel.com> <s5hr4ngh1u1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id C1BEE2651C2
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2012 22:05:47 +0100 (CET)
In-Reply-To: <s5hr4ngh1u1.wl%tiwai@suse.de>
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


>>> It doesn't make sense to calculate the delay for capture streams in
>>> the current implementation.  It's always zero, so we should skip the
>>> computation in snd_usb_pcm_pointer() in the case of capture.
>>
>> Shouldn't we add support for delay on the capture path instead? We could
>> use the same frame counter to report the delay and resync when the urb
>> is retired.
>
> Sure, it must be possible like that way.
> Wouldn't you like to volunteer? ;)

Sounds like a good skunkworks for the end of the year...If we have both 
HDA and USB behaving correctly on delays, this would raise the bar for 
everyone.
