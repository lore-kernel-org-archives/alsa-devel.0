From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/5] ASoC: sdm845: remove unused header files
Date: Mon,  6 Aug 2018 11:12:07 +0100
Message-ID: <20180806101209.15167-4-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch removes unused header files from the driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sdm845.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index be0cb1122036..c9884e380549 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -5,11 +5,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/atomic.h>
 #include <linux/of_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <linux/soc/qcom/apr.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
-- 
2.16.2
