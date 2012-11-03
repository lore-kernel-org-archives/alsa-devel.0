From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400,RFC 0/6] M-Audio Fast Track C400
Date: Sat,  3 Nov 2012 14:40:05 +0100
Message-ID: <1351950011-8915-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5908E261701
 for <alsa-devel@alsa-project.org>; Sat,  3 Nov 2012 14:40:19 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so1459057bku.38
 for <alsa-devel@alsa-project.org>; Sat, 03 Nov 2012 06:40:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Chris Cavey <chris-alsa@rauros.net>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The following patches adds support for the M-Audio Fast Track C400.
I recently bought this device and I was able to get this work thanks to
the discussion on the alsa-devel list.[1]
Thanks everyone!

This series applies against the latest mainline tree, 3.7-rc3
(HEAD 0f89a5733a8d28174c7adeb1fdc20ac11439e766 )

* First of all, everything works: mixer controls, effects control,
playback and capture (with the correct sampling frequency set).
Note that the device doesn't really have a master control or left/right
pan. It's just "emulated" in the software.
Audio in/out works good (but not good enough yet, see below).
Playback and capture at 48KHz as well as 96KHz works fine (if you don't
mind an xrun every 2-5 minutes). I've captured with the C400 and played
it back on my on-board device and vice versa to make sure it gets the
sample rate correctly.

* The clock sources are still named "Unit 129" (0x81, internal) and
"Unit 130" (0x82, SPDIF). I'll fix this later. I also plan to fix the
channel names (i.e., instead of "AIn3", use "SPDIF In L").

* I've touched one FTU mixer creation function. I'd appreciate if someone
can test this with the FTU to make sure I didn't break something.

* The last two patches are not ready to go in. Patch #5 employs a crude
hack and misuses cmask. Patch #6 follows suit. I'd appreciate some
hints on how to do this properly.
(It's theoretically possible to use cmask properly, but cmasks must be
a 64 bits type, because we have 10 input * 6 output = 60 paths).

* Somewhat unrelated: I encounter latency issues. I'm not sure if it's
just my particular hardware/drivers. I'm getting jack xruns even with
very large buffers and low sampling frequency. Jackd is running alone,
with almost no system activity (no X).
With the USB 2.0 interface (ehci) I have also experienced hard lock-ups
after a while (or almost immediately with 96KHz @ 64 bytes * 2 periods).
Luckily I have a USB 3.0 interfaces as well (Intel xhci), which doesn't
lock-up, but I still get xruns once every 2-5 minutes. (1000HZ kernel,
with PREEMPT).
Also, xruns are much less frequent when using only capture or only playback.

Chris, do you mind testing this and see if (1) it works for you and (2)
you see the same latency issues? Thanks for the USB captures, it really
saved a lot of work to get this done!

Cheers,
Eldad

Cc: Chris Cavey <chris-alsa@rauros.net>
Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

--

Eldad Zack (6):
  usb-audio: skip UAC2 EFFECT_UNIT
  usb-audio: parameterize FTU effect unit control
  usb-audio: M-Audio Fast Track C400 quirks table
  usb-audio: Fast Track C400 mixer ranges
  usb-audio: Fast Track C400 mixer quirks
  usb-audio: add remaining C400 controls

 sound/usb/mixer.c        |   55 +++++++++++++-
 sound/usb/mixer_quirks.c |  196 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/usb/quirks-table.h |   71 +++++++++++++++++
 3 files changed, 313 insertions(+), 9 deletions(-)

-- 
1.7.8.6
