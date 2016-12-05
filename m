From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple_card_utils: tidyup file
	comment/define" to the asoc tree
Date: Mon, 05 Dec 2016 12:09:26 +0000
Message-ID: <E1cDs5G-0003lS-13@finisterre>
References: <87lgvyvr4c.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FEBF266C72
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 13:09:37 +0100 (CET)
In-Reply-To: <87lgvyvr4c.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple_card_utils: tidyup file comment/define

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 29a43aa9b4b609eba73e76c5fd92d435fc6e35ce Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 2 Dec 2016 05:27:30 +0000
Subject: [PATCH] ASoC: simple_card_utils: tidyup file comment/define

simple_card_utils was created as simple_card_core in 1st prototype,
and current code still have it. Let's tidyup

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     | 8 ++++----
 sound/soc/generic/simple-card-utils.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index fd6412551145..64e90ca9ad32 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -1,5 +1,5 @@
 /*
- * simple_card_core.h
+ * simple_card_utils.h
  *
  * Copyright (c) 2016 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  *
@@ -7,8 +7,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef __SIMPLE_CARD_CORE_H
-#define __SIMPLE_CARD_CORE_H
+#ifndef __SIMPLE_CARD_UTILS_H
+#define __SIMPLE_CARD_UTILS_H
 
 #include <sound/soc.h>
 
@@ -68,4 +68,4 @@ void asoc_simple_card_canonicalize_cpu(struct snd_soc_dai_link *dai_link,
 
 int asoc_simple_card_clean_reference(struct snd_soc_card *card);
 
-#endif /* __SIMPLE_CARD_CORE_H */
+#endif /* __SIMPLE_CARD_UTILS_H */
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index e5b80f53093a..cf026252cd4a 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -1,5 +1,5 @@
 /*
- * simple-card-core.c
+ * simple-card-utils.c
  *
  * Copyright (c) 2016 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  *
-- 
2.10.2
