From: Anders Alex <alibobar@gmail.com>
Subject: twl4030 and Puredata/jack
Date: Fri, 8 Mar 2013 16:31:40 +0100
Message-ID: <CAAuz6aqqixPxBZQQ5GJinPDfseSVKcnBCvMnLt-6Uad4fP9uPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 831D2261731
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 16:31:41 +0100 (CET)
Received: by mail-pa0-f49.google.com with SMTP id kp6so1363001pab.8
 for <alsa-devel@alsa-project.org>; Fri, 08 Mar 2013 07:31:40 -0800 (PST)
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

Ok,

Let me start off that I know very little about audio and drivers.

Recently I started looking in to running Puredata and possibly jack on the
Pandora handheld.
However I ran in to a number of problems getting these to interface with
alsa.
I should note that on the pandora we don't have too up to date versions of
alsa and kernel so perhaps these are already resolved.
In SL4P (slackware for pandora) I have:

ALSA: 1.0.24
Kernel: 3.2.30

I will paste a couple of use-cases and their corresponding dmesg output:

When I run ~$ pd -alsa I get:

snd_pcm_hw_params (input): Invalid argument
snd_pcm_hw_params (output): Invalid argument

and:
[201429.385345] omap_mcbsp_dai_hw_params: not enough bandwidth for desired
rate and channels
[201429.385375] asoc: interface omap-mcbsp-dai.1 hw params failed

With 'jackd -d alsa -S'  (need s16_le):

loading driver ..
creating alsa driver ... hw:0|hw:0|1024|2|48000|0|0|nomon|swmeter|-|16bit
control device hw:0
configuring for 48000Hz, period = 1024 frames (21.3 ms), buffer = 2 periods
ALSA: final selected sample format for capture: 16bit little-endian
ALSA: use 2 periods for capture
ALSA: cannot set hardware parameters for capture
ALSA: cannot configure capture channel


cannot load driver module alsa

and:
[201746.759857] asoc: can't set codec twl4030-hifi hw params

The pandora kernel-dev explained that the hardware can only handle stereo
streams. However someone in #jack explains it as the following:
"This typically means that the ALSA driver is incomplete or buggy when used
the way JACK does (poll+mmap) vs. the way aplay does (blocking read+write).
So things that do stuff the "aplay way" will work; things that do stuff the
JACK way will not work."

I hope someone can shed some light on this and perhaps give some ideas to
how to get this working.

cheers,
alexander
