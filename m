From: Akshay Mishra <akshaymishra@gmail.com>
Subject: Re: Overrun Errors - SAM9G
Date: Thu, 17 Jul 2014 21:39:03 +0530
Message-ID: <CABSY_ZuvvjsgGPJ90PU39zZ7nBYiWZOWWGSjenUWf9qoH5q34A@mail.gmail.com>
References: <CABSY_ZsjSaZQA+KadBWnzR-9=YQby-Fnb9ZpBGZpXHtVsZZXMw@mail.gmail.com>
 <CABSY_Zsh44D19KtDYkc6ozSsxKpTk+cQJiy4rEGKqWgbv_a=tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F3D826559B
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 18:09:24 +0200 (CEST)
Received: by mail-oi0-f47.google.com with SMTP id x69so1282701oia.34
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 09:09:23 -0700 (PDT)
In-Reply-To: <CABSY_Zsh44D19KtDYkc6ozSsxKpTk+cQJiy4rEGKqWgbv_a=tQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 17 July 2014 18:24, Akshay Mishra <akshaymishra@gmail.com> wrote:

> Hello,
>     I am trying a simple alsa capture on the Atmel ARM9 (SAM9G45). While
> only capture runs fine, putting any os call on the same thread gives XRUNs.
>
> Even a innocent usleep(1) seems to lead to regular XRUNs. Eventually I
> want to dump this capture on the serial port and I am not able to get past
> this.
>
>
running pulseaudio gives me the following. I am not sure if this is related.

 snd_pcm_avail() returned a value that is exceptionally large: 414168 bytes
(2347 ms).
E: [alsa-sink] alsa-util.c: Most likely this is a bug in the ALSA driver
'(null)'. Please report this issue to the ALSA developers.
E: [alsa-sink] alsa-util.c: snd_pcm_dump():
E: [alsa-sink] alsa-util.c: Hardware PCM card 0 'Atmel AC97C' device 0
subdevice 0
E: [alsa-sink] alsa-util.c: Its setup is:
E: [alsa-sink] alsa-util.c:   stream       : PLAYBACK
E: [alsa-sink] alsa-util.c:   access       : MMAP_INTERLEAVED
E: [alsa-sink] alsa-util.c:   format       : S16_LE
E: [alsa-sink] alsa-util.c:   subformat    : STD
E: [alsa-sink] alsa-util.c:   channels     : 2
E: [alsa-sink] alsa-util.c:   rate         : 44100
E: [alsa-sink] alsa-util.c:   exact rate   : 44100 (44100/1)
E: [alsa-sink] alsa-util.c:   msbits       : 16
E: [alsa-sink] alsa-util.c:   buffer_size  : 8640
E: [alsa-sink] alsa-util.c:   period_size  : 1440
E: [alsa-sink] alsa-util.c:   period_time  : 32653
E: [alsa-sink] alsa-util.c:   tstamp_mode  : ENABLE
E: [alsa-sink] alsa-util.c:   period_step  : 1
E: [alsa-sink] alsa-util.c:   avail_min    : 7759
E: [alsa-sink] alsa-util.c:   period_event : 0
E: [alsa-sink] alsa-util.c:   start_threshold  : -1
E: [alsa-sink] alsa-util.c:   stop_threshold   : 1132462080
E: [alsa-sink] alsa-util.c:   silence_threshold: 0
E: [alsa-sink] alsa-util.c:   silence_size : 0
E: [alsa-sink] alsa-util.c:   boundary     : 1132462080
E: [alsa-sink] alsa-util.c:   appl_ptr     : 396378
E: [alsa-sink] alsa-util.c:   hw_ptr       : 491280






> I have tried on AT91 linux as well as on kernel 3.10.10-rt7 with no
> success.
>
> Please advice,
> Akshay
>
>
