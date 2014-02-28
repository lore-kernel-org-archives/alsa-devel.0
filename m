From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: PCM rules for FireWave in speaker.c
Date: Fri, 28 Feb 2014 20:28:33 +0900
Message-ID: <531072E1.6060603@sakamocchi.jp>
References: <530FFF88.1040606@sakamocchi.jp> <53105DA8.1090607@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FBFD261A27
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 12:28:39 +0100 (CET)
In-Reply-To: <53105DA8.1090607@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

Clemens,

> The current rules in speakers.c disallow rates less than 48 kHz if there
> are less than six channels, and disallow two channels if the rate is
> less than 48 kHz.  This means that the allowed parameter combinations
> are 2ch at 48/96 kHz, and 6ch at 32/44.1/48/96 kHz.

Oh, I misunderstood it...

>> Recently, with Jay Fenlason's help, I got some information about its
>> stream format. I'll show them in the end of this message.
>>
>> As a result, I realized FireWave has stream formats below:
>>   - 6ch PCM at 32.0/44.1/48.0/96.0kHz
>>   - 2ch IEC 60958-3 at 32.0/44.1/48.0kHz
>>
>> Although there are no stream formats for 2ch PCM at 48.0/96.0kHz, the
>> driver has it. Do you know the reason? Are there any model quirks?
>
> I don't have any of the AV/C audio specifications; these rules were
> determined experimentally.  In other words, when the sample rate is set
> to 48 or 96 kHz, sending a stream with two PCM channels appears to work.

OK. You confirmed it.

> If you wanted to support these undocumented formats in your driver, you
> would have to add some kind of quirk.

Exactly. For PCM, I need to add hard-coded rule. On the other hand, I 
want to omit IEC 60958-3 mode because I don't know whether ALSA has 
proper interfaces for it. It will not be PCM.

# I wonder why this mailman sometimes don't deliver my mail...


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
