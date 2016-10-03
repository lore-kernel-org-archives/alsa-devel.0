From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/7] ALSA: core: add .update_appl_ptr
 callback for pcm ops
Date: Mon, 3 Oct 2016 09:49:10 -0500
Message-ID: <1dc416c0-e7b5-448f-4a6f-25a25d5ece5e@linux.intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5h8tu934gk.wl-tiwai@suse.de> <20160930172009.GU2467@localhost>
 <s5hintdkzbl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6503E266B93
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 16:49:04 +0200 (CEST)
In-Reply-To: <s5hintdkzbl.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, "Babu, Ramesh" <ramesh.babu@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> When appl_ptr is updated let low-level driver know, e.g.  to let the
>>>> low-level driver/hardware pre-fetch data opportunistically.
>>>>
>>>> The existing .ack callback could be used but it would need to be
>>>> extended with new arguments, resulting in multiple changes in legacy
>>>> code.
>>>
>>> I wouldn't mind changing these callers.  They aren't so many, after
>>> all.
>>
>> Yes this was one of the discussions we had in the past. I don't recall the
>> conclusion so had recommened to keep as is and discuss here.
>>
>> Do you think it's better to do that or use a new one :)
>
> It's OK to change ack callback, and actually it'll be cleaner.
> But then it'll be a problem in the next patch, I suppose :)

The main problem is test/coverage of legacy v. alignment of 
functionality. If we change .ack() then others will have to test for the 
changes and there's a risk of a regression on a specific platform that 
wasn't tested - Murphy's law applies.
