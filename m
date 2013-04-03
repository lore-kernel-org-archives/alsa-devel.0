From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 00/10] UAC2: Automatic clock switching
Date: Wed,  3 Apr 2013 23:18:48 +0200
Message-ID: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AB46260320
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:05 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jc3so1110296bkc.15
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

This is version 2 of the automatic clock switching.
v1: http://mailman.alsa-project.org/pipermail/alsa-devel/2013-March/060734.html

No patches added or removed.
Rebased patches with "ALSA: usb: Work around CM6631 sample rate change bug",
commit 690a863ff03d9a29ace2b752b8f802fba78a842f .

Clemens, Takashi and Torstein, thank you very much for reviewing and providing
comments!

Changes:
* Fixed formatting
* (#5) Fixed type cast: u32 -> __l32
* (#6) Added rational to commit message
* (#7) Fixed assignment of int to unsigned char, return error code if encountered
* (#8) Fixed the parameter name, annotated the default value
* (#10) Avoid second read of frequency for read-only clocks

Tested with Takashi's for-next.
Applies against Takashi's for-next HEAD efc33ce197e4b6aaddf1eb2ba6293f51daf3c283 .

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
 sound/usb/clock.c    | 153 ++++++++++++++++++++++++++++++++++++++-------------
 sound/usb/clock.h    |   3 +-
 sound/usb/endpoint.c |  18 +++---
 sound/usb/endpoint.h |   2 +-
 sound/usb/format.c   |   2 +-
 sound/usb/midi.c     |  12 ++--
 sound/usb/pcm.c      |  32 ++++-------
 sound/usb/proc.c     |   7 +--
 sound/usb/stream.c   |  12 ++--
 sound/usb/usbaudio.h |   1 +
 11 files changed, 157 insertions(+), 96 deletions(-)

-- 
1.8.1.5
