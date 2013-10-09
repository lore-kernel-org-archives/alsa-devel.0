From: Mihai Moise <mihai.moise5@gmail.com>
Subject: Bug report Realtek ALC887-VD HDA Intel tone://15000
Date: Wed, 9 Oct 2013 18:53:53 -0400
Message-ID: <CAEha1fQ6sTp6dXfX3_88raLG6YJJX23ECi8skPVmD5mmj3eVsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f195.google.com (mail-ie0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 0803226162A
 for <alsa-devel@alsa-project.org>; Thu, 10 Oct 2013 00:53:54 +0200 (CEST)
Received: by mail-ie0-f195.google.com with SMTP id tp5so572245ieb.6
 for <alsa-devel@alsa-project.org>; Wed, 09 Oct 2013 15:53:54 -0700 (PDT)
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

I am writing to report a bug with ALSA that affects XMMS and Audacious.

I have a Realtek ALC887-VD HDA Intel. I tested with kernel 3.12-rc4
and alsa-libs 1.0.27.2.10.gc1fbd and alsa-oss-1.0.25.2.g39df1 library.
I also compiled and installed alsa-utils-1.0.27.2.6.gf1e99 which made
me realize I had to move the libraries from /usr/lib to /usr/lib64.

Playing tone://15000 in Audacious or XMMS with the ALSA driver without
resampling sounds bad (in XMMS there is no resampling option).

How to reproduce the bug:

Play in XMMS tone://10

In Audacious you would have to lower the volume by 6 dB to get the
same sound volume as in XMMS because it pre-amplifies sounds.

Lower the PC-volume until you stop hearing clicks. To hear the clicks
you need headphones and to raise the real-life amplifier volume all
the way up. For me it is,

Master: 91%
PCM: 100%
Front: 60%

Select the ALSA driver and no resampling in Audacious (I think
Audacious comes with no resampling as the default setting which is why
this is so important).

Play tone://15000

It is supposed to sound like this:

perl -e '$|++;binmode(STDOUT);$_ = 0;while(1){print
pack("v",32767.0*sin(($_&(~1))*3.14159265*15000.0/48000.0));++$_;}' |
aplay -f dat

but it sounds like this:

perl -e '$|++;binmode(STDOUT);$_ = 0;while(1){print
pack("v",32767.0*sin(($_&(~1))*3.14159265*15000.0/44100.0));++$_;}' |
aplay -f cd

This is how it sounds like if the OSS driver is invoked:

perl -e '$|++;binmode(STDOUT);$_ = 0;while(1){print
pack("v",32767.0*sin(($_&(~1))*3.14159265*15000.0/44100.0));++$_;}' |
sox -V4 -b 16 -c 2 -r 44100 -e signed-integer -t raw - -r 44100 -t oss
-d

On my computer, the first and third command lines sound good, the
second command line sounds bad.

When using the OSS driver in XMMS it sounds like the first and third
command lines.

To go into more details: when using the ALSA driver in XMMS, for
frequencies higher than tone://10000 the main frequency gets swamped
by lower harmonics, so the frequency heard seems to drop the higher it
increases. At tone://15000 what is heard is a louder lower harmonic.

My suggestion is: could there be a way to force ALSA to resample the
sound when using an ALC887-VD and/or a Realtek chipset and/or HDA
Intel...
