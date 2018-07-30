From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: memalloc: Fix missing PAGE_SIZE
	definition
Date: Mon, 30 Jul 2018 08:46:40 +0200
Message-ID: <20180730064640.3846-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E8F7F2676E2
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 08:46:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The recent fix moved the inline snd_sgbuf_aligned_pages() outside the
ifdef, and this triggered a build error on some architectures due to
the undefined PAGE_SIZE, as spotted by 0day bot.
Fix it by adding the missing header inclusion.

Fixes: 4cae99d9b530 ("ALSA: memalloc: declare snd_sgbuf_aligned_pages() unconditionally")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index c669900e6cbe..67561b997915 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -24,6 +24,8 @@
 #ifndef __SOUND_MEMALLOC_H
 #define __SOUND_MEMALLOC_H
 
+#include <asm/page.h>
+
 struct device;
 
 /*
-- 
2.18.0
