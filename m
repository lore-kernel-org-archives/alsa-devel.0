From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Old firmware version for Dice II ASIC
Date: Thu, 19 Apr 2018 21:49:50 +0900
Message-ID: <1d3d65f1-10eb-bdab-7619-5f470d8c9023@sakamocchi.jp>
References: <f9e29911-bd79-3441-b240-88a2a838d6a2@sakamocchi.jp>
 <39ab1743-dab9-2812-ba57-4214659858ae@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id CCB57266E30
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 14:49:55 +0200 (CEST)
In-Reply-To: <39ab1743-dab9-2812-ba57-4214659858ae@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Thanks for your comment.

On Apr 19 2018 17:54, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Recently I get Alesis Multimix 12 FireWire and work for ALSA dice driver
>> to support it. This unit uses ASIC of 'WaveFront DICE II STD' and TCAT
>> extended application protocol is not supported.
>>
>> Unfortunately, the driver in v4.17-rc1 can't handle this unit, due to
>> validation of address sections for global space.
>> [...]
>> (sound/firewire/dice/dice-interface.h)
>> 175 #define GLOBAL_SAMPLE_RATE              0x05c
>> ...
>> 181 #define GLOBAL_VERSION                  0x060
>> 182
>> 183 /* Some old firmware versions do not have the following global registers: */
>> ...
>> 188 #define GLOBAL_CLOCK_CAPABILITIES       0x064
>>
>> But this is not proper in my case because the maximum offset on global
>> sub-address space is 0x05c in quadlet unit.
> 
> IIRC that comment was based on the documentation.  Apparently, there was
> a misunderstanding of "size 0x60" vs. "up to the register at 0x60".

Aha. I'm OK.

 From my curiosity, do you know which version of DICE firstly supports 
GLOBAL_VERSION register? Can you read it on the documentation?

>> In my opinion, GLOBAL_VERSION offset belongs to global address space for
>> newer firmware version.
> 
> I agree; if this is how the hardware behaves, then this is what the driver
> should support.
>
> The version register is checked only once (in get_subaddrs()) and does not
> actually affect the behaviour of the driver, so it would not hurt to simply
> omit that check on the old firmware.  (And the "quadlets >= 90" check in
> dice_proc_read() needs to be adjusted.)

Hm. The check is applied to the other spaces such as rx/tx, so I'd like 
to leave it as is. With this patch[1], ALSA dice driver can handle the 
unit. In this weekend, I'll post it. Your reviewing is very helpful.

[1] 
https://github.com/takaswie/snd-firewire-improve/commit/1889e06b9593e16da2812010ffd5a8e4b9bc777d


Thanks

Takashi Sakamoto
