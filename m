From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/5] ASoC: qcom: remove unused header files from common.h
Date: Mon,  6 Aug 2018 11:12:08 +0100
Message-ID: <20180806101209.15167-5-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org
Cc: perex@perex.cz, tiwai@suse.com, vkoul@kernel.org, linux-kernel@vger.kernel.org, rohitkr@codeaurora.org, bgoswami@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch removes unused header files from common.h.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index ad5d2cf27459..f05c05b12bd7 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -4,7 +4,6 @@
 #ifndef __QCOM_SND_COMMON_H__
 #define __QCOM_SND_COMMON_H__
 
-#include <linux/component.h>
 #include <sound/soc.h>
 
 int qcom_snd_parse_of(struct snd_soc_card *card);
-- 
2.16.2
