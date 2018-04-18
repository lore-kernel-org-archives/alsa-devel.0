From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Old firmware version for Dice II ASIC
Date: Wed, 18 Apr 2018 19:24:18 +0900
Message-ID: <f9e29911-bd79-3441-b240-88a2a838d6a2@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 3231D267608
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 12:24:28 +0200 (CEST)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

Recently I get Alesis Multimix 12 FireWire and work for ALSA dice driver
to support it. This unit uses ASIC of 'WaveFront DICE II STD' and TCAT
extended application protocol is not supported.

Unfortunately, the driver in v4.17-rc1 can't handle this unit, due to
validation of address sections for global space.

$ dmesg
snd_dice fw1.0: Sound card registration failed: -19

(sound/firewire/dice/dice-transaction.c)
265 static int get_subaddrs(struct snd_dice *dice)
266 {
267     static const int min_values[10] = {
268             10, 0x64 / 4,
269             10, 0x18 / 4,
270             10, 0x18 / 4,
271             0, 0,
272             0, 0,
273     };
         ...
290     err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
291                      DICE_PRIVATE_SPACE, pointers,
292                      sizeof(__be32) * ARRAY_SIZE(min_values), 0);
293     if (err < 0)
294         goto end;
295
296     for (i = 0; i < ARRAY_SIZE(min_values); ++i) {
297         data = be32_to_cpu(pointers[i]);
298         if (data < min_values[i] || data >= 0x40000) {
299             err = -ENODEV;
300             goto end;
301         }
302     }

The condition 'data < min_values[i]' is evaluated as true at a second
iteration (i = 1). A quadlet of 0xffffe0000004-7 has 0x000018 and this
is less than 0x19 (= 0x64 / 4) in fact.

$ ./firewire-request /dev/fw1 read 0xffffe0000000 28
result: 000: 00 00 00 0a 00 00 00 18 00 00 00 22 00 00 00 8a
result: 010: 00 00 00 ac 00 00 01 12 00 00 00 00 00 00 00 00
result: 020: 00 00 00 00 00 00 00 00

In line 183 of 'sound/firewire/dice/dice-interface.h', I can see below
comments:

(sound/firewire/dice/dice-interface.h)
175 #define GLOBAL_SAMPLE_RATE              0x05c
...
181 #define GLOBAL_VERSION                  0x060
182
183 /* Some old firmware versions do not have the following global 
registers: */
...
188 #define GLOBAL_CLOCK_CAPABILITIES       0x064

But this is not proper in my case because the maximum offset on global
sub-address space is 0x05c in quadlet unit.

Well, this unit supports 44.1/48.0 kHz and use internal/Rx1 as its
sampling clock source according to user manual. This is what in
'check_clock_caps()'.

(sound/firewire/dice/dice.c)
  96 static int check_clock_caps(struct snd_dice *dice)
  97 {
101     /* some very old firmwares don't tell about their clock support */
102     if (dice->clock_caps > 0) {
         ...
109     } else {
110         /* this should be supported by any device */
111         dice->clock_caps = CLOCK_CAP_RATE_44100 |
112                            CLOCK_CAP_RATE_48000 |
113                            CLOCK_CAP_SOURCE_ARX1 |
114                            CLOCK_CAP_SOURCE_INTERNAL;
115     }

In my opinion, GLOBAL_VERSION offset belongs to global address space for
newer firmware version. Would I request any comment to you for this
idea?


Regards

Takashi Sakamoto
