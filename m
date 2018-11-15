From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8822: convert to SPDX identifiers"
	to the asoc tree
Date: Thu, 15 Nov 2018 19:46:53 +0000 (GMT)
Message-ID: <20181115194653.8D8D4440078@finisterre.ee.mobilebroadband>
References: <20181115094912.656-1-CTLIN0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33932267B23
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 20:47:00 +0100 (CET)
In-Reply-To: <20181115094912.656-1-CTLIN0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Lin <CTLIN0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, wtli@nuvoton.com, kchsu0@nuvoton.com, lgirdwood@gmail.com, yhchuang@nuvoton.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8822: convert to SPDX identifiers

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

>From 0c8224c34aa82901037e6c5921b692ea1b78fd24 Mon Sep 17 00:00:00 2001
From: David Lin <CTLIN0@nuvoton.com>
Date: Thu, 15 Nov 2018 17:49:13 +0800
Subject: [PATCH] ASoC: nau8822: convert to SPDX identifiers

This patch fixes typo in the comment.

Signed-off-by: David Lin <CTLIN0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8822.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8822.h b/sound/soc/codecs/nau8822.h
index d15afd782815..9c552983a293 100644
--- a/sound/soc/codecs/nau8822.h
+++ b/sound/soc/codecs/nau8822.h
@@ -5,7 +5,7 @@
  * Copyright 2017 Nuvoton Technology Crop.
  *
  * Author: David Lin <ctlin0@nuvoton.com>
- * Co-author: John Hsu <kchsu@nuvoton.com>
+ * Co-author: John Hsu <kchsu0@nuvoton.com>
  * Co-author: Seven Li <wtli@nuvoton.com>
  */
 
-- 
2.19.1
