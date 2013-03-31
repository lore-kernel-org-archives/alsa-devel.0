From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCH 00/10] UAC2: Automatic clock switching
Date: Sun, 31 Mar 2013 17:52:22 +0200
Message-ID: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FDFE261718
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 17:52:52 +0200 (CEST)
Received: by mail-bk0-f45.google.com with SMTP id j10so658944bkw.4
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 08:52:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This patch series is intended for-next.

It provides automatic clock switching for UAC2 devices (patches #6-#8).
If the current selected clock is not valid, other clocks will be checked
and the first (indexwise) valid clock will be used.

Patch #8 provides a module flag to turn this logic off, since
in some use cases (e.g., studio work) it might not be desired.
But I think most users want their audio devices to "just work",
so the default is on.

To make the change more obvious, I first moved the validity check
around without changing any logic (#6).

Patch #10 adds support for clocks with read-only sample frequency
control.

All other patches included are trivial clean up patches.

I'd appreciate a review and/or testing this patch series.
This applies to all UAC2 devices, so please let me know if anyone
sees any issue.

Tested with mainline.
Applies against mainline (3.9-rc4), HEAD at 46a1f21a679abaaeae6db9969963dc998c9f1c1c
Applies against Takashi's for-next, HEAD at 4abdbd1c2c1832e7270e546307ffb3e56b286db2

Cheers,

Eldad Zack (10):
  ALSA: usb-audio: convert list_for_each to entry variant
  ALSA: usb-audio: neaten MODULE_DEVICE_TABLE placement
  ALSA: usb-audio: neaten EXPORT_SYMBOLS placement
  ALSA: usb-audio: spelling correction
  ALSA: usb-audio: use endianness macros
  ALSA: usb-audio: UAC2: do clock validity check earlier
  ALSA: usb-audio: UAC2: try to find and switch to valid clock
  ALSA: usb-audio: UAC2: auto clock selection module param
  ALSA: usb-audio: show err in set_sample_rate_v2 debug
  ALSA: usb-audio: UAC2: support read-only freq control

 sound/usb/card.c     |  11 ++--
 sound/usb/clock.c    | 150 ++++++++++++++++++++++++++++++++++++++-------------
 sound/usb/clock.h    |   3 +-
 sound/usb/endpoint.c |  18 +++----
 sound/usb/endpoint.h |   2 +-
 sound/usb/format.c   |   2 +-
 sound/usb/midi.c     |  12 ++---
 sound/usb/pcm.c      |  32 ++++-------
 sound/usb/proc.c     |   7 ++-
 sound/usb/stream.c   |  12 ++---
 sound/usb/usbaudio.h |   1 +
 11 files changed, 155 insertions(+), 95 deletions(-)

-- 
1.8.1.5
