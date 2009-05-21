From: Cristian Morales Vega <cmorve69@yahoo.es>
Subject: Program blocks with alsa pulse plugin
Date: Thu, 21 May 2009 22:34:28 +0200
Message-ID: <8235e6f40905211334o44beb4d1x5325202b4c6ae8f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id E62FC24531
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 22:34:30 +0200 (CEST)
Received: by ewy23 with SMTP id 23so1547700ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 21 May 2009 13:34:29 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm not sure where exactly the problem is, probably in the alsa pulse
plugin? And not sure where alsa pulse plugin should be reported, ALSA
or PA?
Using http://byuu.org/bsnes/ through the ALSA API with PulseAudio at
some point provokes the game to block with 100% CPU usage. Stopping it
I get this backtrace:

Program received signal SIGTSTP, Stopped (user).
0x00007ffff2b8a386 in poll () from /lib64/libc.so.6
(gdb) bt
#0  0x00007ffff2b8a386 in poll () from /lib64/libc.so.6
#1  0x00007ffff72ac94c in snd1_pcm_wait_nocheck () from
/usr/lib64/libasound.so.2
#2  0x00007ffff72accb7 in snd1_pcm_write_areas () from /usr/lib64/libasound.so.2
#3  0x00007ffff72ebf3a in snd_pcm_ioplug_writei () from
/usr/lib64/libasound.so.2
#4  0x000000000043e1b8 in ruby::AudioALSA::sample (this=<value
optimized out>, left=<value optimized out>, right=<value optimized
out>)
    at lib/ruby/audio/alsa.cpp:101
#5  0x000000000043ed8b in ruby::AudioInterface::sample (this=0x74c520,
left=<value optimized out>, right=<value optimized out>)
    at lib/ruby/ruby_audio.cpp:110
#6  0x00000000004a5b82 in SNES::sDSP::enter (this=0x8528c0) at
dsp/sdsp/sdsp.cpp:199
#7  0x00000000004a309a in SNES::sSMP::op_read (this=0x851860,
addr=4532) at smp/ssmp/timing/timing.cpp:8
#8  0x00000000004a2652 in SNES::sSMP::enter (this=0x851860) at
smp/core/memory.hpp:2
#9  0x000000000043bec0 in ?? () at lib/libco/x86-64.c:31
#10 0x0000000000000000 in ?? ()

There are lots of snd_pcm_writei() (lib/ruby/audio/alsa.cpp:101) calls
before bsnes blocks, and the only errors are some underruns that are
"fixed" with snd_pcm_recover(). Just that at some point (easier to
trigger with 150% or 200% emu speed) blocks. It's using the "safe
ALSA" everywhere, so...


This is with openSUSE 11.1. But also with openSUSE 11.1 + PA from
multimedia:libs (0.9.14) and a recent GIT snapshot of ALSA from
multimedia:audio:snapshot and multimedia:audio:KMP.
There is a package for Fedora in rpmfusion, and they have a readme
that states the problem also happens there.

To avoid this bsnes dev created a native PA backend. I inform just in
case this is triggering a bug, perhaps affecting other software, you
are interested in fix...


PS. ...obviously bsnes never blocks when using ALSA directly.
