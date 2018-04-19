From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Old firmware version for Dice II ASIC
Date: Thu, 19 Apr 2018 10:54:12 +0200
Message-ID: <39ab1743-dab9-2812-ba57-4214659858ae@ladisch.de>
References: <f9e29911-bd79-3441-b240-88a2a838d6a2@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A049266E30
 for <alsa-devel@alsa-project.org>; Thu, 19 Apr 2018 10:54:15 +0200 (CEST)
In-Reply-To: <f9e29911-bd79-3441-b240-88a2a838d6a2@sakamocchi.jp>
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
> Recently I get Alesis Multimix 12 FireWire and work for ALSA dice driver
> to support it. This unit uses ASIC of 'WaveFront DICE II STD' and TCAT
> extended application protocol is not supported.
>
> Unfortunately, the driver in v4.17-rc1 can't handle this unit, due to
> validation of address sections for global space.
> [...]
> (sound/firewire/dice/dice-interface.h)
> 175 #define GLOBAL_SAMPLE_RATE              0x05c
> ...
> 181 #define GLOBAL_VERSION                  0x060
> 182
> 183 /* Some old firmware versions do not have the following global registers: */
> ...
> 188 #define GLOBAL_CLOCK_CAPABILITIES       0x064
>
> But this is not proper in my case because the maximum offset on global
> sub-address space is 0x05c in quadlet unit.

IIRC that comment was based on the documentation.  Apparently, there was
a misunderstanding of "size 0x60" vs. "up to the register at 0x60".

> In my opinion, GLOBAL_VERSION offset belongs to global address space for
> newer firmware version.

I agree; if this is how the hardware behaves, then this is what the driver
should support.

The version register is checked only once (in get_subaddrs()) and does not
actually affect the behaviour of the driver, so it would not hurt to simply
omit that check on the old firmware.  (And the "quadlets >= 90" check in
dice_proc_read() needs to be adjusted.)


Regards,
Clemens
