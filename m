From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Add defaults for SND_SST_
 options and machine drivers
Date: Thu, 16 Nov 2017 17:01:06 -0600
Message-ID: <cec24178-4cb4-bf7c-9a21-5994820be9b5@linux.intel.com>
References: <20171116221643.30128-1-pierre-louis.bossart@linux.intel.com>
 <CA+55aFzxL6-Xp=-mnBwMisZsuKhRZ6zRDJoAmH8W5LDHU2oJuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 70A4F266F1D
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 00:01:10 +0100 (CET)
In-Reply-To: <CA+55aFzxL6-Xp=-mnBwMisZsuKhRZ6zRDJoAmH8W5LDHU2oJuw@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 11/16/2017 04:24 PM, Linus Torvalds wrote:
> On Thu, Nov 16, 2017 at 2:16 PM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> Add 'default m' when sensible
> No.
>
> This is not sensible, and is not at all what I suggested.
>
> Actual new code should *never* be default 'm' or 'y'.
>
> You may think it's supremely important because you maintain it, but so
> does EVERY other developer for their code, and no, we don'[t want to
> just default everything on.
>
> So the only thing that should be on by default is stuff that either
>
>   (a) is a new option for something that used to not have an option at
> all and was always enabled
>
>       IOW, this is a "it used to always be there, we default it on now
> that we've made it optional".
>
>   (b) stuff that doesn't actually generate any code, but is there as a choice.
>
>       So this is stuff like "show me the config options for vendor XYZ".
>
>   (c) stuff that really is so common that it is the majority of users.
>
>       This is stuff like USB, or block devices, or "enable networking".
>
> But some individual driver for some hardware that nobody has? No.
>
> So things like this is pure garbage:
>
>       config SND_SST_ATOM_HIFI2_PLATFORM
>              tristate "Intel ASoC SST driver for HiFi2 platforms
> (*field, *trail)"
>              default m
>
> because clearly "Intel ASoC SST driver for HiFi2 platforms" should not
> at all default to being on for everybody.
It's only on for people who select X86 and ASoC (which isn't on by 
default). With make defconfig, none of this is selected and I *thought* 
making those suboptions default to m would help distros who don't 
necessarily know the status of each driver, plus what was selected is 
known to be conflict-free. I guess I will follow the network example and 
state 'this is recommended'.

This is also not *new* code, what I tried here is to reverse the 
selection since the existing Kconfigs selected a target and inferred 
what SOC options are needed, and it needs to be the other way around to 
share machine drivers between SST and SOF drivers. Not to mention that 
there is no reason for machine driver configurations to be dependent on 
SOC-level configs like LPSS, this should be handled elsewhere.

I will move the TOPLEVEL config to follow what you suggested with the 
network example, this config does not have any impact on the code. will 
send a v2 tomorrow. If you want to send me your config i'll be happy to 
check the changes are ok. Thanks.

>
> So NAK NAK NAK on stuff like this.
>
>                      Linus
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
