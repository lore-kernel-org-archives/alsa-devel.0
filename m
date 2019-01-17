From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 05/14] ALSA: pci: Remove superfluous
 snd_pcm_suspend*() calls
Date: Wed, 16 Jan 2019 20:21:57 -0600
Message-ID: <a329b6ed-39aa-0730-cb90-b950eda7edf8@linux.intel.com>
References: <20190115162155.6308-1-tiwai@suse.de>
 <20190115162155.6308-6-tiwai@suse.de>
 <f675ffaa-9966-a05b-7915-a4a16eefbfcb@linux.intel.com>
 <s5hpnsx26tc.wl-tiwai@suse.de> <s5hh8e9fyam.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 264402667E7
 for <alsa-devel@alsa-project.org>; Thu, 17 Jan 2019 03:22:01 +0100 (CET)
In-Reply-To: <s5hh8e9fyam.wl-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

> BTW, while checking these things, I noticed that there are three
> exceptional drivers: sound/soc/intel/atom/sst-mfld-platform-pcm.c,
> sound/soc/intel/haswell/sst-haswell-pcm.c, and
> sound/soc/samsung/tm2_wm5110.c.  (You can simply grep the external
> snd_soc_suspend call, and only these match.)
>
> The former two drivers look really weird: they do handle the PM only
> with PM prepare and complete callbacks, while snd_soc_suspend() and co
> are called internally from there.  The prepare and complete callbacks
> aren't designed for the complete suspend/resume tasks, so I'd say it's
> a quite abuse.

For the Atom/SST driver, I remember there was a need to set/restore the 
DSP state with a specific command that wasn't handled with regular 
controls - largely a work-around due to the firmware design.

For the Haswell driver, there was also a need to preserve/restore state 
and pause/stop pipelines (a recurring issue with the "Made for Windows" 
firmware).

These drivers are quite old now and it's not clear to me if they are 
broken or if we are talking of an improvement. Could you clarify what 
you view as "abuse"?

a) is this the fact that there are prepare/complete callback for those 
drivers, instead of others such as freeze, thaw, etc.

b) the fact they they call snd_soc_suspend/resume directly?

c) the fact that they suspend the PCM streams?

d) all of the above (which is entirely possible).

Thanks

-Pierre
