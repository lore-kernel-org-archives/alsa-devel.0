From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH v4 00/12] Line6 POD X3/X3Live suport
Date: Sun, 18 Sep 2016 20:59:20 +0200
Message-ID: <1474225172-32081-1-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 662B4260A59
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 21:00:43 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id 133so11707850wmq.2
 for <alsa-devel@alsa-project.org>; Sun, 18 Sep 2016 12:00:43 -0700 (PDT)
In-Reply-To: <1470942147-19848-1-git-send-email-dev@andree.sk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com, perex@perex.cz, stefanha@gmail.com, grabner@icg.tugraz.at, alsa-devel@alsa-project.org
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Hello all,


attached are the yet again reworked patches. Basically the diff is only some
formatting. In addition, some of the previously big patches were split to
multiple smaller ones. Compared to v3, there is a small bisectability/patch
sanity fix.

I have checked that after each one, the compilation works, but not that the
result doesn't segfault or even work - I don't have the hardware previously
supported by the driver and the most interesting changes are only useful as
a whole for POD X3.

Greetings!


Andrej Krutak (12):
  ALSA: line6: Enable different number of URBs for frame transfers
  ALSA: line6: Add high-speed USB support
  ALSA: line6: Support assymetrical in/out configurations
  ALSA: line6: Allow different channel numbers for in/out
  ALSA: line6: Add LINE6_CAP_IN_NEEDS_OUT, a void playback stream during
    capture
  ALSA: line6: Distinguish device init (ctrl EP) and MIDI data transfer
    (int EP)
  ALSA: line6: Allow processing of raw incoming messages
  ALSA: line6: Add support for POD X3
  ALSA: line6: Add support for POD X3 Live (only USB ID differs from POD
    X3)
  ALSA: line6: Only determine control port properties if needed
  ALSA: line6: Cleanup podhd initialization
  ALSA: line6: Add hwdep interface to access the POD control messages

 include/uapi/sound/asound.h |   3 +-
 sound/usb/line6/Kconfig     |   4 +-
 sound/usb/line6/capture.c   |  50 +++++---
 sound/usb/line6/driver.c    | 269 +++++++++++++++++++++++++++++++++------
 sound/usb/line6/driver.h    |  58 +++++++--
 sound/usb/line6/midi.c      |   2 +-
 sound/usb/line6/pcm.c       |  83 ++++++++----
 sound/usb/line6/pcm.h       |  19 +--
 sound/usb/line6/playback.c  |  37 ++++--
 sound/usb/line6/pod.c       |  12 +-
 sound/usb/line6/podhd.c     | 300 ++++++++++++++++++++++++++++++++++++++++----
 sound/usb/line6/toneport.c  |   6 +-
 sound/usb/line6/variax.c    |   6 +-
 13 files changed, 703 insertions(+), 146 deletions(-)

-- 
1.9.1
