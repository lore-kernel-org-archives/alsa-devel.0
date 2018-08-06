From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/5] ASoC: apq8096: remove unused header files
Date: Mon,  6 Aug 2018 11:12:06 +0100
Message-ID: <20180806101209.15167-3-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/apq8096.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 6ee7e66cbaaa..1543e85629f8 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -1,9 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018, Linaro Limited
 
-#include <linux/soc/qcom/apr.h>
 #include <linux/module.h>
-#include <linux/component.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <sound/soc.h>
-- 
2.16.2
