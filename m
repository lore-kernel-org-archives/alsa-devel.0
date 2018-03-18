From: Daniel Loranger <dloranger08@gmail.com>
Subject: unstable channel assignments for 8 channel codec
Date: Sat, 17 Mar 2018 17:25:36 -0700
Message-ID: <CAGs4Mr96EFs-fj2UGp-oZOX-3yHEJZFkz=pE3_eZ=fpBDv-P6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f169.google.com (mail-yw0-f169.google.com
 [209.85.161.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CB40266F68
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 01:25:39 +0100 (CET)
Received: by mail-yw0-f169.google.com with SMTP id y64so9387195ywa.3
 for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2018 17:25:39 -0700 (PDT)
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

Hello all,

I don't know if anyone can help me, or if this is even the right place to
track down an issue I am facing.  I have tried the developer, and filed a
bug in github against the c code, but not getting any responses.

I am using an audio injector octo sound board on a raspberry pi 3.  this
sound board has 6 inputs and 8 outputs.

The issue I am facing is the audio channels appear to be randomly assigned
each time speaker-test utility is ran.

My best guess at this point is there is a missing configuration in either
the C driver or in the alsa configuration.  I am hoping the latter hence my
reaching out here.

My research has lead me to think that the missing information is related to
the channel assignments are missing from the config, but I am out of my
league in understanding the right way to go about this.

here is the driver if that is relevant at all
https://github.com/raspberrypi/linux/blob/rpi-4.9.y/sound/soc/bcm/audioinjector-octo-soundcard.c

I have configured per the device manufacturers instructions as follow

here is the asoundrc contents
pcm.!default { # type hw # card 0 type plug slave.pcm "anyChannelCount" }
ctl.!default { type hw card 0 }
Here is the asound.conf contents
pcm.!default { # type hw # card 0 type plug slave.pcm "anyChannelCount" }
ctl.!default { type hw card 0 } pcm.anyChannelCount { type route slave.pcm
"hw:0" slave.channels 8; ttable { 0.0 1 1.1 1 2.2 1 3.3 1 4.4 1 5.5 1 6.6 1
7.7 1 } } ctl.anyChannelCount { type hw; card 0; }

-- 
Daniel Loranger
