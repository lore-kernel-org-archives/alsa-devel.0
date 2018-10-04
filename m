From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] ALSA: Fix fall-through annotations
Date: Thu,  4 Oct 2018 20:12:29 +0200
Message-ID: <20181004181234.21152-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 894122678AB
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 20:12:36 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E2B98B038
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2018 18:12:35 +0000 (UTC)
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

here is some trivial patches to add / fix the fall-through
annotations.  The patchset for ASoC will follow later.


Takashi

===

Takashi Iwai (5):
  ALSA: memalloc: Add fall-through annotation
  ALSA: caiaq: Add fall-through annotation
  ALSA: seq: oss: Use the standard fall-through annotation
  ALSA: opti92xx-ad1848: Use the standard fall-through annotation
  ALSA: au88xx: Add fall-through annotations

 sound/core/memalloc.c              | 1 +
 sound/core/seq/oss/seq_oss_timer.c | 2 +-
 sound/isa/opti9xx/opti92x-ad1848.c | 6 ++++--
 sound/pci/au88x0/au88x0_core.c     | 6 ++++++
 sound/usb/caiaq/device.c           | 1 +
 5 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.18.0
