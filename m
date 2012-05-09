From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Fast Track Ultra latency and new streaming logic.
Date: Wed, 9 May 2012 20:13:25 +0200
Message-ID: <CAFz=ag6oLMKKX7Azte8b0VLpTa2KN=HVTJfT+x1U+PnL_zq7rA@mail.gmail.com>
References: <CACckToWK=Si8-8rPKgo-ZWA+ncTVb7zW8jHZvf7VbKT1sMM32Q@mail.gmail.com>
	<CAFz=ag5d8PFYoA2KsWKMZ+yX=1gLQmGWx7wFn1cTVf4CW_jDiA@mail.gmail.com>
	<CAFz=ag6d+zcHrNhxKwaTHQYb04GJEKDXjowz4NhXtERAV-zjag@mail.gmail.com>
	<CAFz=ag4j2OZTZqzeo+h210AaVgToA93hTs5QPL1UPHCCCLJkZg@mail.gmail.com>
	<s5hehqtzefd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9669710B98E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 20:13:26 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so596469yhn.38
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2012 11:13:26 -0700 (PDT)
In-Reply-To: <s5hehqtzefd.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

(stupid me.. again for the list...)

Hi,

2012/5/9 Takashi Iwai <tiwai@suse.de>:
> Or a full-duplex issue?  You can test the latency via
> alsa-lib/test/latency program.

OK, I don't know if I'm using it the right way (see below ) but here
are some observations:

1. With the old streaming logic I can successfully go down to a
reported latency of 384 frames @96kHz without an xrun.

2. With the new streaming logic 'latency' will not start.

It fails with:
Unable to set hw params for capture: Device or resource busy
Unable to set sw parameters for playback stream: Device or resource busy

As a first guess this could be related to the fact that the PCM
streams of the FTU are never reported as "Running" with the new
streaming logic. (Daniel?)

3. 'latency' never returns cleanly.

On Ubuntu I'm getting
*** glibc detected ***
/home/fex/workspace/Audio/Latency/alsa-lib/test/.libs/lt-latency:
invalid fastbin entry (free): 0x00000000013c0570 ***

On Fedora (kernel with old streaming logic) I get:

*** glibc detected ***
/home/fex/workspace/Audio/Latency/alsa-lib/test/.libs/lt-latency:
munmap_chunk(): invalid pointer: 0x00000000018a5f90 ***
*** glibc detected ***
/home/fex/workspace/Audio/Latency/alsa-lib/test/.libs/lt-latency:
malloc(): memory corruption (fast): 0x00000000018a5a90 ***

On Fedora 'latency' hangs after this message.

>
> (Yes, the usage is quite undocumented.  Anyone contributing the howto
>  would be great...)

Yes, I don't even know how to use it or if I've used it correctly...

It doesn't seem to be neccessary to connect an output to an input. Is
this correct? At least results don't change without a connection...

Regards,

Felix
