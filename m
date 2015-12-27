From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Rawmidi
Date: Mon, 28 Dec 2015 00:49:41 +0900
Message-ID: <56800895.5070008@sakamocchi.jp>
References: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
 <9511ACE5-064B-40C7-8286-9401991156CD@ladisch.de>
 <CAL_NL1Bgv8hoW-wR003jD4Wopc6udG=Xb+DJ8P+W5H5H9dQYnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CF38262626
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2015 16:49:46 +0100 (CET)
In-Reply-To: <CAL_NL1Bgv8hoW-wR003jD4Wopc6udG=Xb+DJ8P+W5H5H9dQYnQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Viksporre <daniel.viksporre@gmail.com>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 28 2015 00:22, Daniel Viksporre wrote:
> 2015-12-27 9:18 GMT+01:00, Clemens Ladisch <clemens@ladisch.de>:
>> Daniel Viksporre wrote:
>>> test.c:(.text+0x507): undefined reference to `snd_rawmidi_open'
>>
>> This message comes from the linker.
>>
>> If the compiler itself does not complain, then you have no
>> problem with rawmidi.h.
>>
>> The linker error is probably caused by not linking with the
>> ALSA library; add -lasound to the compiler command.
>>
>>
>> Regards,
>> Clemens
>>
>>
> 
> I compiled with...
> gcc  -lasound test.c
> 
> I have tried with many different code examples that I have found on
> the internet, and error messages stays about the same.

I think cause is the position of linker option. Let's try:
$ gcc test.c -lasound


Regards

Takashi Sakamoto
