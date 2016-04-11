From: =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius.trainavicius@gmail.com>
Subject: Too fast playback everywhere, except audacity
Date: Tue, 12 Apr 2016 01:10:41 +0300
Message-ID: <CABpuRUN-DT=Q=R31RTT=mh9SEaAcS3auZecAxfO0iKHnHc_wcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id AE0F12608CF
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 00:10:42 +0200 (CEST)
Received: by mail-ig0-f182.google.com with SMTP id f1so73264959igr.1
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 15:10:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I am developing a driver for a DAC on raspberry pi 3 by mostly making use
of existing PCM5102A, and bcm2708 I2S driver code.

What I've done is just configuring the cpu dai link, and for the sampling
rate changes, I am setting some gpios which configures the clock of an ADC
(PCM1804) which is a master. The main CPU and the DAC are slaves to the ADC
and I have a 24.576MHz oscillator.

The sampling rates I want to support are 48000, 96000 and 192000. I am able
to react just fine to the requested rate in hw_params callback. Trying out
the different rates in audacity works just fine.

However, if I try to playback any wav files using mplayer or aplay or
youtube, all of their playback requests for 48000, but they get played way
too fast.

Also if I request mplayer to use alsa output, it gets a buffer underrun and
gets stuck. If I set audacity to use some other output device than alsa
directly, it plays corrupted audio and hangs on stopping playback.

How does audacity manage to play the audio at the correct speed? Is it
doing software resampling to the 'project rate'?

I've tried getting resampling to work using 'plug', but completely
unsuccessfully - I can't get any sound out of it, it says it failed setting
the requested parameters.

Any pointers to what I should be investigating? I am new to the linux
kernel module development, as well as sound drivers.

Thank you in advance,
Giedrius.
