From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/16] Yet more cleanups of line6 drivers
Date: Fri, 23 Jan 2015 18:13:07 +0100
Message-ID: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D82B2654C6
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:40 +0100 (CET)
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

Hi,

here is a series of cleanup patches for line6 stuff.  They are applied
on top of my previous patches.  The latest patchset is found in
test/line6 branch of sound.git tree.


Takashi


Takashi Iwai (16):
  ALSA: line6: Minor refactoring
  ALSA: line6: Fix memory leak at probe error path
  ALSA: line6: Remove unused line6_nop_read()
  ALSA: line6: Reduce superfluous spinlock in midi.c
  ALSA: line6: Fix missing error handling in line6_pcm_acquire()
  ALSA: line6: Use logical OR
  ALSA: line6: Fix the error recovery in line6_pcm_acquire()
  ALSA: line6: Drop superfluous spinlock for trigger
  ALSA: line6: Use incremental loop
  ALSA: line6: Drop voodoo workarounds
  ALSA: line6: Rearrange PCM structure
  ALSA: line6: Consolidate URB unlink and sync helpers
  ALSA: line6: Use dev_err()
  ALSA: line6: Consolidate PCM stream buffer allocation and free
  ALSA: line6: Do clipping in volume / monitor manipulations
  ALSA: line6: Skip volume manipulation during silence copying

 sound/usb/line6/capture.c  | 122 ++++++--------------------
 sound/usb/line6/capture.h  |   5 --
 sound/usb/line6/driver.c   | 157 ++++++++++++++++-----------------
 sound/usb/line6/driver.h   |   2 -
 sound/usb/line6/midi.c     |  18 ++--
 sound/usb/line6/midi.h     |   7 +-
 sound/usb/line6/pcm.c      | 210 +++++++++++++++++++++++++++------------------
 sound/usb/line6/pcm.h      | 163 ++++++++++-------------------------
 sound/usb/line6/playback.c | 159 ++++++++++------------------------
 sound/usb/line6/playback.h |   5 --
 10 files changed, 329 insertions(+), 519 deletions(-)

-- 
2.2.2
