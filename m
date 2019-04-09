From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ALSA: seq: More cleanups and fixes
Date: Tue,  9 Apr 2019 19:00:15 +0200
Message-ID: <20190409170020.20685-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 47E0DF8963E
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:00:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6970BAD7B
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:00:23 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset for ALSA sequencer to clean up / minor improvement
of some code as well as the fixes for remaining issues caught
(spontaneously) by syzkaller.


Takashi

===

Takashi Iwai (5):
  ALSA: seq: Use kvmalloc() for cell pools
  ALSA: seq: Align temporary re-locking with irqsave version
  ALSA: seq: Remove superfluous irqsave flags
  ALSA: seq: Protect in-kernel ioctl calls with mutex
  ALSA: seq: Fix race of get-subscription call vs port-delete ioctls

 sound/core/seq/seq_clientmgr.c | 38 +++++++++++++++++---------------------
 sound/core/seq/seq_fifo.c      | 14 ++++++--------
 sound/core/seq/seq_memory.c    | 30 ++++++++++++++----------------
 sound/core/seq/seq_ports.c     | 28 ++++++++++++++--------------
 sound/core/seq/seq_ports.h     |  5 +++--
 5 files changed, 54 insertions(+), 61 deletions(-)

-- 
2.16.4
