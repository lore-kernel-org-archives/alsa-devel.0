From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 11/11] sound/oxygen_io: take msecs_to_jiffies_min into
 use
Date: Mon, 13 May 2013 16:30:18 +0200
Message-ID: <5190F8FA.9050201@ladisch.de>
References: <1368188011-23661-1-git-send-email-imre.deak@intel.com> <1368188011-23661-11-git-send-email-imre.deak@intel.com> <s5hr4hbq8sd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr4hbq8sd.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Imre Deak <imre.deak@intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Imre Deak wrote:
>> Use msecs_to_jiffies_min instead of open-coding the same.
>>
>> +++ b/sound/pci/oxygen/oxygen_io.c
>> @@ -108,7 +108,7 @@ static int oxygen_ac97_wait(struct oxygen *chip, unsigned int mask)
>>  	wait_event_timeout(chip->ac97_waitqueue,
>>  			   ({ status |= oxygen_read8(chip, OXYGEN_AC97_INTERRUPT_STATUS);
>>  			      status & mask; }),
>> -			   msecs_to_jiffies(1) + 1);
>> +			   msecs_to_jiffies_min(1));
>
> This would change the behavior, I guess.

No, that's exactly how msecs_to_jiffies_min would be implemented.

> (Though, I'm not sure whether the original code was intentional.)

When I wrote this, I was not able to prove that msecs_to_jiffies always
rounds up.  (And I guess it doesn't; otherwise the _min variant would
not be needed.)


Regards,
Clemens
