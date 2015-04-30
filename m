From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 02/14] ASoC: qcom: remove unnecessary header files
Date: Thu, 30 Apr 2015 18:16:44 +0100
Message-ID: <1430414204-10955-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch removes unnecessary header files in lpass cpu and platform
code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c      | 6 +-----
 sound/soc/qcom/lpass-platform.c | 6 ------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 1e284c6..4084295 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -14,12 +14,7 @@
  */
 
 #include <linux/clk.h>
-#include <linux/compiler.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/ioport.h>
 #include <linux/kernel.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -28,6 +23,7 @@
 #include <linux/regmap.h>
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
+
 #include "lpass-lpaif-ipq806x.h"
 #include "lpass.h"
 
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 2fa6280..ffc0928 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -13,17 +13,11 @@
  * lpass-platform.c -- ALSA SoC platform driver for QTi LPASS
  */
 
-#include <linux/compiler.h>
-#include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/err.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/io.h>
 #include <linux/platform_device.h>
-#include <sound/memalloc.h>
-#include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <linux/regmap.h>
 #include <sound/soc.h>
-- 
1.9.1
