From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ALSA: seq: Some minor cleanups
Date: Wed,  1 Aug 2018 18:11:55 +0200
Message-ID: <20180801161200.3930-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 980D52677AA
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 18:12:02 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 01868AA71
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 16:12:02 +0000 (UTC)
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

while debugging the recent virmidi bug, I've found a few ugly
appearance in the sequencer code, so spent a bit time for cleaning it
up.

Most of changes are cosmetic, non-functional changes.


Takashi

===

Takashi Iwai (5):
  ALSA: seq: Minor cleanup of MIDI event parser helpers
  ALSA: seq: Remove dead codes
  ALSA: seq: Fix leftovers at probe error path
  ALSA: seq: Use no intrruptible mutex_lock
  ALSA: seq: Drop unused 64bit division macros

 include/sound/seq_midi_event.h    |  6 +--
 sound/core/seq/oss/seq_oss_midi.c |  2 +-
 sound/core/seq/seq.c              | 33 ++++++------
 sound/core/seq/seq_clientmgr.c    | 28 +++-------
 sound/core/seq/seq_info.c         | 10 +---
 sound/core/seq/seq_info.h         |  6 +--
 sound/core/seq/seq_memory.c       | 12 -----
 sound/core/seq/seq_memory.h       |  6 ---
 sound/core/seq/seq_midi.c         | 24 ++++-----
 sound/core/seq/seq_midi_emul.c    | 12 -----
 sound/core/seq/seq_midi_event.c   | 87 +++----------------------------
 sound/core/seq/seq_queue.c        | 12 +----
 sound/core/seq/seq_queue.h        | 27 ----------
 sound/core/seq/seq_virmidi.c      | 37 +------------
 14 files changed, 52 insertions(+), 250 deletions(-)

-- 
2.18.0
