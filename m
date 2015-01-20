From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 0/3] Minor line6 cleanup
Date: Tue, 20 Jan 2015 02:20:47 -0600
Message-ID: <1421742050-13299-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f173.google.com (mail-ig0-f173.google.com
 [209.85.213.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 479812604BB
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 09:21:04 +0100 (CET)
Received: by mail-ig0-f173.google.com with SMTP id a13so16211240igq.0
 for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2015 00:21:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

These apply on top of test/line6.

Chris Rorvick (3):
  ALSA: line6: Remove superfluous NULL checks
  ALSA: line6: Refer to manufacturer as "Line 6"
  ALSA: line6: Remove driver version from header comment

 sound/usb/line6/Kconfig    |  4 ++--
 sound/usb/line6/capture.c  |  2 +-
 sound/usb/line6/capture.h  |  2 +-
 sound/usb/line6/driver.c   | 36 +++++++++++++-----------------------
 sound/usb/line6/driver.h   | 14 +++++++-------
 sound/usb/line6/midi.c     |  6 +++---
 sound/usb/line6/midi.h     |  4 ++--
 sound/usb/line6/midibuf.c  |  4 ++--
 sound/usb/line6/midibuf.h  |  2 +-
 sound/usb/line6/pcm.c      |  2 +-
 sound/usb/line6/pcm.h      | 10 +++++-----
 sound/usb/line6/playback.c |  2 +-
 sound/usb/line6/playback.h |  2 +-
 sound/usb/line6/pod.c      |  6 +++---
 sound/usb/line6/podhd.c    |  6 +++---
 sound/usb/line6/toneport.c |  4 ++--
 sound/usb/line6/usbdefs.h  |  2 +-
 sound/usb/line6/variax.c   |  4 ++--
 18 files changed, 51 insertions(+), 61 deletions(-)

-- 
2.1.0
