From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] Yet another line6 cleanups
Date: Wed, 28 Jan 2015 17:41:22 +0100
Message-ID: <1422463289-19135-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 152C2264ED4
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:41:37 +0100 (CET)
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

OK, I did enough for this month.

The only real fix is the first patch for big-endianess.  The rest are
rather cleanups and beautifying the code.

As usual, the latest code is found in test/line6 branch.


thanks,

Takashi

===

Takashi Iwai (7):
  ALSA: line6: Fix volume calculation for big-endian
  ALSA: line6: Tidy up and typo fixes in comments
  ALSA: line6: Remove revision.h
  ALSA: line6: Move the contents of usbdefs.h into driver.h
  ALSA: line6: Remove struct usb_line6_podhd
  ALSA: line6: Remove invalid capability bits for PODxt Live Variax
  ALSA: line6: Remove snd_line6_ prefix of pcm property fields

 sound/usb/line6/capture.c  |  5 ++-
 sound/usb/line6/driver.c   |  4 +--
 sound/usb/line6/driver.h   | 89 ++++++++++++++++++++--------------------------
 sound/usb/line6/midi.c     |  1 -
 sound/usb/line6/midi.h     | 32 +++++------------
 sound/usb/line6/pcm.h      | 57 +++++++++--------------------
 sound/usb/line6/playback.c | 24 +++++++------
 sound/usb/line6/pod.c      | 39 ++++++--------------
 sound/usb/line6/podhd.c    | 16 +++------
 sound/usb/line6/revision.h |  4 ---
 sound/usb/line6/toneport.c | 31 +++++-----------
 sound/usb/line6/usbdefs.h  | 27 --------------
 sound/usb/line6/variax.c   | 25 ++++---------
 13 files changed, 109 insertions(+), 245 deletions(-)
 delete mode 100644 sound/usb/line6/revision.h
 delete mode 100644 sound/usb/line6/usbdefs.h

-- 
2.2.2
