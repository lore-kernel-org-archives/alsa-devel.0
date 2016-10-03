From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 7/7] ALSA: usb: take startup delay into
 account
Date: Mon, 3 Oct 2016 10:04:23 -0500
Message-ID: <efce9dd9-b3f3-b7cf-86df-c6be4e0014cd@linux.intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-8-git-send-email-subhransu.s.prusty@intel.com>
 <s5h4m4x33jo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A9277266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 17:04:16 +0200 (CEST)
In-Reply-To: <s5h4m4x33jo.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


>> For playback usages, the endpoints are started before the prepare
>> step, and valid audio data will be rendered with a delay that
>> cannot be recovered.
>> Worst-case the initial delay due to buffering of empty URBS can
>> be up to 12ms

> This is really a fix unlike other patches in the series.
> Please split it from others, so that we can apply it easily.

There was also additional discussions on this topic since I put this 
together, not sure it makes sense to merge this patch at the moment.
In the Windows driver, the URBs can be submitted at a specific time, 
which allows for synchronous starts of all endpoints (limited to the 1ms 
frame resolution). In Linux we can't since the start time is owned by 
the xhci driver and can't be modified by the class driver. I talked with 
Mathias Nyman and Baolu Lu on this before the summer and of course I 
became busy with other things. The short story is that there is a wider 
problem with USB start and linking endpoints that should be addressed as 
a single step. Maybe something to talk about at the miniconference?
