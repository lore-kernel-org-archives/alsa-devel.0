From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: qdsp6: remove duplicated include
	from q6adm.c" to the asoc tree
Date: Fri, 21 Sep 2018 17:24:04 +0100 (BST)
Message-ID: <20180921162404.9AF74440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B6C9F2676A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 18:24:08 +0200 (CEST)
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
To: zhong jiang <zhongjiang@huawei.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: qdsp6: remove duplicated include from q6adm.c

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

>From c78d42c7fbd6f2a27a665bcd1ab60c9df617f7c9 Mon Sep 17 00:00:00 2001
From: zhong jiang <zhongjiang@huawei.com>
Date: Fri, 21 Sep 2018 18:24:58 +0800
Subject: [PATCH] ASoC: qcom: qdsp6: remove duplicated include from q6adm.c

We include wait.h twice in q6adm.c. it is unnecessary. hence remove
it.  Further, order the include files as alphabet.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 932c3ebfd252..da242515e146 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -2,25 +2,24 @@
 // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
-#include <linux/slab.h>
-#include <linux/wait.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/kref.h>
-#include <linux/wait.h>
-#include <linux/soc/qcom/apr.h>
 #include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/wait.h>
 #include <sound/asound.h>
 #include "q6adm.h"
 #include "q6afe.h"
 #include "q6core.h"
-#include "q6dsp-errno.h"
 #include "q6dsp-common.h"
+#include "q6dsp-errno.h"
 
 #define ADM_CMD_DEVICE_OPEN_V5		0x00010326
 #define ADM_CMDRSP_DEVICE_OPEN_V5	0x00010329
-- 
2.19.0
