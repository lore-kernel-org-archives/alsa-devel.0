From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V3 1/2] ASoC: max98357a: Add missing header files
Date: Tue, 17 Feb 2015 00:53:11 -0800
Message-ID: <1424163192-665-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add missing header files to avoid implicit
declarations and indirect inclusions.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
for fix/max98357a branch

changes from v2:
 - split patch into logical changes
 - rebased to new branch

changes from v1:
 - matched subject line to subsystem style

 sound/soc/codecs/max98357a.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index f493fb6fd4ea764d617b3d7dd5f3b1ebe1e0fe20..e9e6efbc21dd527299fb459ec01903fa8c24dae2 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -12,10 +12,19 @@
  * max98357a.c -- MAX98357A ALSA SoC Codec driver
  */
 
-#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
 #include <sound/soc.h>
+#include <sound/soc-dai.h>
+#include <sound/soc-dapm.h>
 
 #define DRV_NAME "max98357a"
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
