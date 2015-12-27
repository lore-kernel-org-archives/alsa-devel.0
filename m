From: Daniel Viksporre <daniel.viksporre@gmail.com>
Subject: Re: Rawmidi
Date: Sun, 27 Dec 2015 16:22:55 +0100
Message-ID: <CAL_NL1Bgv8hoW-wR003jD4Wopc6udG=Xb+DJ8P+W5H5H9dQYnQ@mail.gmail.com>
References: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
 <9511ACE5-064B-40C7-8286-9401991156CD@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id B14FA260541
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2015 16:22:55 +0100 (CET)
Received: by mail-vk0-f46.google.com with SMTP id f2so131753335vkb.3
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2015 07:22:56 -0800 (PST)
In-Reply-To: <9511ACE5-064B-40C7-8286-9401991156CD@ladisch.de>
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

2015-12-27 9:18 GMT+01:00, Clemens Ladisch <clemens@ladisch.de>:
> Daniel Viksporre wrote:
>>test.c:(.text+0x507): undefined reference to `snd_rawmidi_open'
>
> This message comes from the linker.
>
> If the compiler itself does not complain, then you have no
> problem with rawmidi.h.
>
> The linker error is probably caused by not linking with the
> ALSA library; add -lasound to the compiler command.
>
>
> Regards,
> Clemens
>
>

I compiled with...
gcc  -lasound test.c

I have tried with many different code examples that I have found on
the internet, and error messages stays about the same.

// Daniel
