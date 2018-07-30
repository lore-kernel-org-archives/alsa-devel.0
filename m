From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: memalloc: Fix missing PAGE_SIZE
	definition" to the asoc tree
Date: Mon, 30 Jul 2018 12:04:25 +0100 (BST)
Message-ID: <20180730110425.6AD481124216@debutante.sirena.org.uk>
References: <20180730064640.3846-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B8B792677A5
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 13:04:29 +0200 (CEST)
In-Reply-To: <20180730064640.3846-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild test robot <lkp@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: memalloc: Fix missing PAGE_SIZE definition

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 345a9ca37aa69bb3133c1a8390a71f993abcef0c Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 30 Jul 2018 08:46:40 +0200
Subject: [PATCH] ALSA: memalloc: Fix missing PAGE_SIZE definition

The recent fix moved the inline snd_sgbuf_aligned_pages() outside the
ifdef, and this triggered a build error on some architectures due to
the undefined PAGE_SIZE, as spotted by 0day bot.
Fix it by adding the missing header inclusion.

Fixes: 4cae99d9b530 ("ALSA: memalloc: declare snd_sgbuf_aligned_pages() unconditionally")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
