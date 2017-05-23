From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: Extend PCM buffer-copy helpers
Date: Tue, 23 May 2017 08:11:51 +0200
Message-ID: <20170523061155.1582-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C5F266EB9
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 08:12:00 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id EF4B5AD25
 for <alsa-devel@alsa-project.org>; Tue, 23 May 2017 06:11:59 +0000 (UTC)
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

Hop, step... before jump.

This is a patch series based on the previous one ("[PATCH 00/16] ALSA:
Convert to new copy_silence PCM ops"), as the second step for killing
set_fs().  It extends the PCM buffer-copy helper functions to allow
in-kernel buffer copy via the new PCM ops, as well as some code
refactoring.

Once when these are implemented, the set_fs() can be eliminated by
simply replacing with these new helpers.

The latest patches are found in topic/kill-set_fs branch in sound git
tree.


Takashi

===

Takashi Iwai (4):
  ALSA: pcm: Shuffle code
  ALSA: pcm: Call directly the common read/write helpers
  ALSA: pcm: Provide read/write helpers for in-kernel buffer transfer
  ALSA: pcm: Split PCM transfer codes

 include/sound/pcm.h  |  81 ++++++++--
 sound/core/pcm_lib.c | 410 ++++++++++++++++++++++++++-------------------------
 2 files changed, 282 insertions(+), 209 deletions(-)

-- 
2.13.0
