From: Eldad Zack <eldad@fogrefinery.com>
Subject: [FT C400,v2,RFC 0/8] M-Audio Fast Track C400
Date: Tue,  6 Nov 2012 01:30:31 +0100
Message-ID: <1352161839-1455-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E42B8261671
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 01:33:10 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id e19so2096111bku.38
 for <alsa-devel@alsa-project.org>; Mon, 05 Nov 2012 16:33:10 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Grant Diffey <gdiffey@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Eldad Zack <eldad@fogrefinery.com>, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

The following patches adds support for the M-Audio Fast Track C400.
I recently bought this device and I was able to get this work thanks to
the discussion on the alsa-devel list.[1]
Thanks everyone!

This series applies against the latest mainline tree, 3.7-rc4
(HEAD 3d70f8c617a436c7146ecb81df2265b4626dfe89 )

This is v2 of the series. It adds patches #3 and #8.

* First of all, everything works: mixer controls, effects control,
playback and capture (with the correct sampling frequency set).
Note that the device doesn't really have a master control or left/right
pan. It's just "emulated" in the software.

* Audio in/out seems to work good in v2, mainly because the
playback is an implicit feedback endpoint, and it is now configured
with the capture endpoint as its sync-buddy (patch #8).

* Also needed to correct the calculation for implicit feedback, because
of the different channel numbers between the two endpoints on the C400
(6 playback - implicit feedback, 4 capture) (patch #3).

* The clock sources are still named "Unit 129" (0x81, internal) and
"Unit 130" (0x82, SPDIF). I'll fix this later. I also plan to fix the
channel names (i.e., instead of "AIn3", use "SPDIF In L").

* I've touched one FTU mixer creation function. I'd appreciate if someone
can test this with the FTU to make sure I didn't break something.

* Patches #6 and #7 are not ready to go in. Patch #6 employs a crude
hack and misuses cmask. Patch #7 follows suit. I'd appreciate some
hints on how to do this properly.
(It's theoretically possible to use cmask properly, but cmasks must be
a 64 bits type, because we have 10 input * 6 output = 60 paths).

Grant, I mentioned just now that I get distorted playback. This was caused
by me using an lower bandwidth altsetting (2), which I tried since it
gives only 2 playback channels, figuring it might help latency somehow.
I now reverted back to the original alsetting (1) and I seem to get a
stable latency and I can't hear anything unusual (yet?). jack_delay seems
to be happy as well.

Cheers,
Eldad

Cc: Grant Diffey <gdiffey@gmail.com>
Cc: Chris Cavey <chris-alsa@rauros.net>
Signed-off-by: Eldad Zack <eldad@fogrefinery.com>


Eldad Zack (8):
  usb-audio: skip UAC2 EFFECT_UNIT
  usb-audio: parameterize FTU effect unit control
  usb-audio: use sender stride for implicit feedback
  usb-audio: M-Audio Fast Track C400 quirks table
  usb-audio: Fast Track C400 mixer ranges
  usb-audio: Fast Track C400 mixer quirks
  usb-audio: add remaining C400 controls
  usb-audio: FT C400 sync playback EP to capture EP

 sound/usb/endpoint.c     |    9 ++-
 sound/usb/mixer.c        |   55 +++++++++++++-
 sound/usb/mixer_quirks.c |  196 ++++++++++++++++++++++++++++++++++++++++++++--
 sound/usb/pcm.c          |   13 +++
 sound/usb/quirks-table.h |   71 +++++++++++++++++
 5 files changed, 332 insertions(+), 12 deletions(-)

-- 
1.7.8.6
