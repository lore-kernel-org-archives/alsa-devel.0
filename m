From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: qcom: qdsp6: remove duplicated include
Date: Wed, 26 Sep 2018 15:33:03 +0800
Message-ID: <20180926073303.25796-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

Remove duplicated includes linux/of_platform.h
and linux/wait.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/qcom/qdsp6/q6asm.c  | 1 -
 sound/soc/qcom/qdsp6/q6core.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 2b2c723..e1cfa84 100644
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
index ca1be73..cdfc8ab 100644
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
2.7.0
