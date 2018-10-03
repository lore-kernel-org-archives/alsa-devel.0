From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] ALSA: intel8x0: Fix fall-through annotations
Date: Wed, 3 Oct 2018 20:40:18 +0200
Message-ID: <0a1e79ff-b033-2e2d-86a3-a5db54b2094c@embeddedor.com>
References: <20181003103836.GA21649@embeddedor.com>
 <s5hftxnovx4.wl-tiwai@suse.de> <s5hbm8boven.wl-tiwai@suse.de>
 <787e9aeb-34e0-3075-d816-7963cca61020@embeddedor.com>
 <s5hy3beop4m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hy3beop4m.wl-tiwai@suse.de>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 10/3/18 8:34 PM, Takashi Iwai wrote:
>>
>> You are correct. It does not trigger a warning.
>>
>> There are about 50 similar instances in the whole codebase. And, as they
>> are just a few, what I'm trying to do is to replace them with the most
>> commonly used form: "fall through"
> 
> Hm, then I'm not sure whether it's worth for further similar
> replacements.  A term "fallthru" is also very commonly used, and the
> compiler knows it, too, so why bother to rewrite?
> 

Not that common actually. There are more than 2000 instances of "fall through"
and just ~50 of "fallthru" and ~40 of "fall thru"

> I don't mean to revert the already applied changes, but maybe better
> to concentrate on fixing other real bugs (and/or real warnings).
> 

Yeah. Sure thing. It's just that I sort of ran into those cases a few days ago.

Thanks
--
Gustavo
