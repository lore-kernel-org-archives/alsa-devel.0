From: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Subject: [alsa-devel][PATCH v1] ASoC: TSCS42xx: Add missing headers
Date: Thu, 8 Mar 2018 21:13:40 -0600
Message-ID: <20180309031332.GA27764@t7-ThinkPad-E560>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add missing headers

Signed-off-by: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
---
 sound/soc/codecs/tscs42xx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index e915261fa1cb..cfc71b5411ee 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -3,14 +3,19 @@
 // Copyright 2017 Tempo Semiconductor, Inc.
 // Author: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
 
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
 #include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/string.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/mutex.h>
-#include <linux/regmap.h>
+#include <sound/tlv.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
-#include <sound/tlv.h>
 
 #include "tscs42xx.h"
 
-- 
2.15.1
