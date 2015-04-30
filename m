From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH lib 0/5] alsa-lib namehint fixes
Date: Thu, 30 Apr 2015 15:06:13 +0200
Message-ID: <1430399178-15173-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FE5F261738
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 15:06:21 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 38695ABEB
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 13:06:19 +0000 (UTC)
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

Hi,

here is a series of fixes for alsa-lib namehint stuff.
Currently snd_device_name_hint() doesn't return proper lists except
for PCM.  Also it may do bogus free() or segfault for wrong
operations.  This patchset addresses such issues and also adds the
missing hint descriptions to ctl, seq, hwdep, etc.


Takashi

===

Takashi Iwai (5):
  namehint: Fix invalid list access in snd_device_name_hint()
  namehint: Fix the listing without device number
  namehint: Fix bad free with invalid iface name
  Allow hint for ctl, hwdep, timer and seq
  conf: Add hint descriptions to ctl, hwdep, seq and timer devices

 include/local.h             |  2 ++
 src/conf/alsa.conf          | 15 ++++++++++++++-
 src/confmisc.c              | 13 +++++++++++++
 src/control/control_hw.c    |  4 +---
 src/control/control_shm.c   |  7 ++-----
 src/control/namehint.c      | 26 ++++++++++++--------------
 src/hwdep/hwdep_hw.c        |  4 +---
 src/pcm/pcm.c               | 12 ------------
 src/pcm/pcm_local.h         |  5 ++---
 src/rawmidi/rawmidi.c       | 18 ------------------
 src/rawmidi/rawmidi_local.h |  2 +-
 src/seq/seq_hw.c            |  4 +---
 src/timer/timer_hw.c        |  4 +---
 src/timer/timer_query_hw.c  |  4 +---
 14 files changed, 51 insertions(+), 69 deletions(-)

-- 
2.3.6
