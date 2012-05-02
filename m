From: Daniel Mack <zonque@gmail.com>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Wed, 02 May 2012 10:41:39 +0200
Message-ID: <4FA0F343.3060702@gmail.com>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A9A81043DC
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 10:41:49 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so240883bkc.38
	for <alsa-devel@alsa-project.org>; Wed, 02 May 2012 01:41:49 -0700 (PDT)
In-Reply-To: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On 01.05.2012 02:18, Grant Diffey wrote:
> In continuing my personal habit of looking gift horses in the mouth...

Testing is much appreciated :)

> I can't seem to get below 512frames in flight (2 256sample frames or 4
> 128 or 8 64's) without consistant overruns.
> 
> I have a feeling that the pcm <-> urb layer is buffering until a urb is
> max urbsize from a quick look at the code does this seem like the right
> track?

No, it doesn't. The implicit feedback streaming model waits for capture
urbs to arrive and then sends back an urb with the same amount of data
for playback. Hence, the number of bytes per playback urb is defined by
the device and the stream it sends to the host.

> This leads to rather high latencies (22ms+) or is this conclusion bogus?

The urb length can't possibly lead to such latencies. With a sample
frequency of 44100 Hz and a stereo stream @16bit, we're dealing with a
data rate of 176400 bytes/s. Even with max urbsizes of 512 bytes, an urb
can only hold ~2,9ms of audio data. With more streams, higher sample
rates or deeper samples, this number is declining. So this can't be the
reason.

Also, I doubt that the rewrite of the streaming code is to blame for
what you're seeing, as it just changed the logical view on internal
structures. The streaming behaviour itself should remain the same.

What you could do, though, is disabling the FTU quirk in
sound/usb/pcm.c:set_format(). That should in theory restore the old
streaming logic. Does that change anything?


Daniel
