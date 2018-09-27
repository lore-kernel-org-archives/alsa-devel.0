From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: qdsp6: remove duplicated include"
	to the asoc tree
Date: Thu, 27 Sep 2018 23:39:11 +0100 (BST)
Message-ID: <20180927223911.6AD74440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DAAF22678C3
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2018 00:39:14 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: qdsp6: remove duplicated include

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

>From 06da26e5ce157bf2af09ef4a9f5dc30af4599fa0 Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 26 Sep 2018 15:33:03 +0800
Subject: [PATCH] ASoC: qcom: qdsp6: remove duplicated include

Remove duplicated includes linux/of_platform.h
and linux/wait.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c  | 1 -
 sound/soc/qcom/qdsp6/q6core.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 2b2c7233bb5f..e1cfa846a1dc 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -11,7 +11,6 @@
 #include <linux/spinlock.h>
 #include <linux/kref.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <uapi/sound/asound.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
diff --git a/sound/soc/qcom/qdsp6/q6core.c b/sound/soc/qcom/qdsp6/q6core.c
index ca1be7305524..cdfc8ab6cfc0 100644
--- a/sound/soc/qcom/qdsp6/q6core.c
+++ b/sound/soc/qcom/qdsp6/q6core.c
@@ -10,7 +10,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/jiffies.h>
-#include <linux/wait.h>
 #include <linux/soc/qcom/apr.h>
 #include "q6core.h"
 #include "q6dsp-errno.h"
-- 
2.19.0
