From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Old firmware version for Dice II ASIC
Date: Thu, 19 Apr 2018 18:21:07 +0200
Message-ID: <b73f31c7-2a47-bc6e-f6bc-9b0636275f06@ladisch.de>
References: <f9e29911-bd79-3441-b240-88a2a838d6a2@sakamocchi.jp>
 <39ab1743-dab9-2812-ba57-4214659858ae@ladisch.de>
 <1d3d65f1-10eb-bdab-7619-5f470d8c9023@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id EABA92675FC
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 18:21:34 +0200 (CEST)
In-Reply-To: <1d3d65f1-10eb-bdab-7619-5f470d8c9023@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Apr 19 2018 17:54, Clemens Ladisch wrote:
>> Takashi Sakamoto wrote:
>>> 183 /* Some old firmware versions do not have the following global registers: */
>>> ...
>>> 188 #define GLOBAL_CLOCK_CAPABILITIES       0x064
>>>
>>> But this is not proper in my case because the maximum offset on global
>>> sub-address space is 0x05c in quadlet unit.
>>
>> IIRC that comment was based on the documentation.  Apparently, there was
>> a misunderstanding of "size 0x60" vs. "up to the register at 0x60".
>
> From my curiosity, do you know which version of DICE firstly supports GLOBAL_VERSION register? Can you read it on the documentation?

I misremembered: I did not find anything about this in the documentation.

This is derived from TCAT's host driver, which unconditionally reads everything
up to the clock capabilities register, and checks for a size larger than 0x64
to detect if the firmware supports clock capabilities.

>> The version register is checked only once (in get_subaddrs()) and does not
>> actually affect the behaviour of the driver, so it would not hurt to simply
>> omit that check on the old firmware.
>
> Hm. The check is applied to the other spaces such as rx/tx, so I'd like to
> leave it as is.

Sorry, "that check" meant the version check for 0x01000000.  Your patch
already implements what I suggested.

> With this patch[1], ALSA dice driver can handle the unit. In this weekend, I'll post it. Your reviewing is very helpful.
>
> [1] https://github.com/takaswie/snd-firewire-improve/commit/1889e06b9593e16da2812010ffd5a8e4b9bc777d

> +	/* Old firmware doesn't support these fields. */
> +	if (dice->clock_caps == 0) {
> +		dice->sync_offset = be32_to_cpu(pointers[6]) * 4;
> +		dice->rsrv_offset = be32_to_cpu(pointers[8]) * 4;
> +	}

Shouldn't this be clock_caps!=0?


Regards,
Clemens
