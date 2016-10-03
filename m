From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/7] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Mon, 3 Oct 2016 09:39:41 -0500
Message-ID: <1cfa9993-cdfb-9ef5-907b-845633173965@linux.intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-2-git-send-email-subhransu.s.prusty@intel.com>
 <s5ha8ep34kf.wl-tiwai@suse.de> <20161003044056.GB23816@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BD00266B91
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 16:39:34 +0200 (CEST)
In-Reply-To: <20161003044056.GB23816@subhransu-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


>>> @@ -2438,6 +2440,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>>>  	if (frames == 0)
>>>  		return 0;
>>>
>>> +	if (runtime->no_rewinds)
>>> +		return 0;
>>
>> Better to return an error instead?
>
> As the number of frames rewinded is zero, it looks appropriate. Any reason
> why returning an error code would help?

The return type is also snd_sframes_t, not sure how a error code would 
be returned without additional changes.
