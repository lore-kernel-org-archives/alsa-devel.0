From: Trevor Page <trevg60@gmail.com>
Subject: Problems with i.MX233 driver in 3.12rc2
Date: Tue, 1 Oct 2013 07:43:43 +0100
Message-ID: <CAG8Y82pXO3ZFGG75fY4ggSTpNQ4wF2j=mmVuw3XmWxKSdT2Y=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id C0C932651DC
 for <Alsa-devel@alsa-project.org>; Tue,  1 Oct 2013 08:43:43 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id mz13so2413555bkb.16
 for <Alsa-devel@alsa-project.org>; Mon, 30 Sep 2013 23:43:43 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

First post to this list - I hope this is the appropriate place to ask for
this assistance.

I'm using the Olinuxino Maxi board with the i.MX233 processor. I'm using
the 3.12rc2 kernel at the moment because this has recently introduced the
drivers for this processor's audio. I understand that the drivers for this
chip's audio are:

 sound/soc/codecs/mxs-builtin-codec.c
sound/soc/mxs/mxs-builtin-audio.c
 sound/soc/mxs/mxs-builtin-dai.c
sound/soc/mxs/mxs-builtin-pcm.c

My application for the board is a simple C program that uses the Linphone
library to make VOIP calls. The problem I am having is that audio usually
works (playback and capture) perfectly fine from boot, but at some point it
may suddenly go 'dead'. At this point, there is no longer any audio from
the headphone socket. I have not yet pinpointed exactly what it takes to
trigger the fault, but I have seen it happen once when the call was put on
hold while a Linphone call was in progress.

Once the audio output is dead, these are some further observations:
- When a Linphone call is received, I still hear a click from the headphone
output when the call ends.
- I have confirmed that the DAC / HP channels are turned up and unmuted.
- If I run speaker-test when the audio is working, speaker-test
periodically prints time duration information (presumably on each pass of
its internal loop), like "0 - Front Left", "Time per period ...". When the
audio is dead, speaker-test just freezes on "0 - Front Left" forever, as if
some call is either blocking or returning to say it is busy. This might
hopefully therefore be a useful point to start debugging.
- I have only ever managed to restore audio using a reboot.

I would like to have a go at debugging this. My problem though is that
although I'm experienced with C and microprocessor programming, compiling
and debugging embedded Linux is new ground for me. I'd be grateful for any
pointers on things I could try in order to gain an insight into what's
going wrong, and tips on how I could debug the drivers.

So far my plan for today is to build the kernel again with the i.MX233
audio drivers as external modules so that I can hopefully play with them a
bit and compile them separately. (I assume the development and debug
process for audio drivers like this is to compile them as .ko modules and
modprobe them in). However without having any prior knowledge of Linux
drivers or the ALSA / ASoC framework I'm not sure if I'm going to get very
far.

Regards,

Trevor.
