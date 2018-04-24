From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/8] ALSA: Hardening for potential Spectre v1
Date: Tue, 24 Apr 2018 09:56:11 +0200
Message-ID: <20180424075619.29602-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E50E526768E
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 09:56:42 +0200 (CEST)
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
Cc: Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset to cover the potential issues wrt Spectre v1 that
were spotted out recently by Smatch:
  https://marc.info/?l=linux-kernel&m=152411496503418&w=2

Although all reports for sound/* seem like no serious issues, it's
better to cover potential usages than a too late sorry.

The first patch is basically irrelevant for Spectre but a preliminary
fix for the following fix.  Most of the rest patches are
straightforward, but the second one, the fix for OSS emulation, became
a fair amount of code refactoring in the end.

An open question is whether we should put Cc-to-stable to these
fixes.  Maybe yes, although we've never proven that the problem would
actually exist, the issue is still "hot", so people may want to see
them more-or-less covered...


thanks,

Takashi

===

Takashi Iwai (8):
  ALSA: seq: oss: Fix unbalanced use lock for synth MIDI device
  ALSA: seq: oss: Hardening for potential Spectre v1
  ALSA: control: Hardening for potential Spectre v1
  ALSA: hda: Hardening for potential Spectre v1
  ALSA: opl3: Hardening for potential Spectre v1
  ALSA: asihpi: Hardening for potential Spectre v1
  ALSA: hdspm: Hardening for potential Spectre v1
  ALSA: rme9652: Hardening for potential Spectre v1

 include/sound/control.h            |  7 +++-
 sound/core/seq/oss/seq_oss_event.c | 15 ++++---
 sound/core/seq/oss/seq_oss_midi.c  |  2 +
 sound/core/seq/oss/seq_oss_synth.c | 85 ++++++++++++++++++++++----------------
 sound/core/seq/oss/seq_oss_synth.h |  3 +-
 sound/drivers/opl3/opl3_synth.c    |  7 +++-
 sound/pci/asihpi/hpimsginit.c      | 13 ++++--
 sound/pci/asihpi/hpioctl.c         |  4 +-
 sound/pci/hda/hda_hwdep.c          | 12 +++++-
 sound/pci/rme9652/hdspm.c          | 24 ++++++-----
 sound/pci/rme9652/rme9652.c        |  6 ++-
 11 files changed, 113 insertions(+), 65 deletions(-)

-- 
2.16.3
