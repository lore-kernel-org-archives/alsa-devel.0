From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] ASoC: fsl_spdif: Remove unused includes of linux/clk-private.h
Date: Fri,  3 Oct 2014 17:54:13 +0200
Message-ID: <1412351653-29592-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 sound/soc/fsl/fsl_spdif.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 70acfe4..5bda323 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -15,7 +15,6 @@
 
 #include <linux/bitrev.h>
 #include <linux/clk.h>
-#include <linux/clk-private.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
-- 
1.9.3
