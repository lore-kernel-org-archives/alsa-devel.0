From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] Reduce races in line6 drivers
Date: Tue, 27 Jan 2015 17:13:12 +0100
Message-ID: <1422375197-17293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D98F2608EC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 17:13:19 +0100 (CET)
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

another day, another patchset.
This time it mostly covers the races in PCM stream handling.  This
should work for most cases, but there are slightly uncovered
conditions that is fairly difficult to fix.  Maybe moving to the
non-atomic PCM ops is one way, but it's too far ahead, ther are
much more things to clean up before that.


Takashi

===

Takashi Iwai (5):
  ALSA: line6: Fix racy loopback handling
  ALSA: line6: Clear prev_fbuf and prev_fsize properly
  ALSA: line6: Reorganize PCM stream handling
  ALSA: line6: Make common PCM pointer callback
  ALSA: line6: Handle error from line6_pcm_acquire()

 sound/usb/line6/capture.c  | 113 +++------------
 sound/usb/line6/capture.h  |   1 -
 sound/usb/line6/pcm.c      | 351 ++++++++++++++++++++++++++-------------------
 sound/usb/line6/pcm.h      | 145 ++++++-------------
 sound/usb/line6/playback.c | 139 ++++--------------
 sound/usb/line6/playback.h |   1 -
 sound/usb/line6/toneport.c |  17 ++-
 7 files changed, 302 insertions(+), 465 deletions(-)

-- 
2.2.2
