From: Raphael Poggi <poggi.raph@gmail.com>
Subject: [PATCH 2/4] sound: codecs: pcm1792a: add define for register
Date: Fri, 20 Nov 2015 11:09:15 +0100
Message-ID: <1448014157-36526-3-git-send-email-raphael.poggi@avalun.com>
References: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448014157-36526-1-git-send-email-raphael.poggi@avalun.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Raphael Poggi <poggi.raph@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Raphael Poggi <poggi.raph@gmail.com>

Use define for register instead of number, when it is possible.
Doing this, make easier to read and use in the code.

Signed-off-by: Raphael Poggi <poggi.raph@gmail.com>
---
 sound/soc/codecs/pcm1792a.c | 47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
index cf42b24..febaa48 100644
--- a/sound/soc/codecs/pcm1792a.c
+++ b/sound/soc/codecs/pcm1792a.c
@@ -33,27 +33,36 @@
 
 #include "pcm1792a.h"
 
-#define PCM1792A_DAC_VOL_LEFT	0x10
-#define PCM1792A_DAC_VOL_RIGHT	0x11
-#define PCM1792A_FMT_CONTROL	0x12
-#define PCM1792A_MODE_CONTROL	0x13
-#define PCM1792A_SOFT_MUTE	PCM1792A_FMT_CONTROL
-
-#define PCM1792A_FMT_MASK	0x70
-#define PCM1792A_FMT_SHIFT	4
-#define PCM1792A_MUTE_MASK	0x01
-#define PCM1792A_MUTE_SHIFT	0
-#define PCM1792A_ATLD_ENABLE	(1 << 7)
+#define PCM1792A_DAC_VOL_LEFT		0x10
+#define PCM1792A_DAC_VOL_RIGHT		0x11
+#define PCM1792A_FMT_CONTROL		0x12
+#define PCM1792A_MODE_CONTROL		0x13
+#define PCM1792A_ZERO_OUTPUT		0x15
+#define PCM1792A_SOFT_MUTE		PCM1792A_FMT_CONTROL
+#define PCM1792A_ZERO_FLAG		0x16
+#define PCM1792A_DEVICE_ID		0x17
+
+#define PCM1792A_CHANNEL		0x14
+#define PCM1792A_CHANNEL_MONO_MASK	0x8
+#define PCM1792A_CHANNEL_MONO_SHIFT	0x8
+#define PCM1792A_CHANNEL_MONO_LEFT	(0x0 << PCM1792A_CHANNEL_MONO_SHIFT)
+#define PCM1792A_CHANNEL_MONO_RIGHT	(0x1 << PCM1792A_CHANNEL_MONO_SHIFT)
+
+#define PCM1792A_FMT_MASK		0x70
+#define PCM1792A_FMT_SHIFT		4
+#define PCM1792A_MUTE_MASK		0x01
+#define PCM1792A_MUTE_SHIFT		0
+#define PCM1792A_ATLD_ENABLE		(1 << 7)
 
 static const struct reg_default pcm1792a_reg_defaults[] = {
-	{ 0x10, 0xff },
-	{ 0x11, 0xff },
-	{ 0x12, 0x50 },
-	{ 0x13, 0x00 },
-	{ 0x14, 0x00 },
-	{ 0x15, 0x01 },
-	{ 0x16, 0x00 },
-	{ 0x17, 0x00 },
+	{ PCM1792A_DAC_VOL_LEFT, 0xff },
+	{ PCM1792A_DAC_VOL_RIGHT, 0xff },
+	{ PCM1792A_FMT_CONTROL, 0x50 },
+	{ PCM1792A_MODE_CONTROL, 0x00 },
+	{ PCM1792A_CHANNEL, 0x00 },
+	{ PCM1792A_ZERO_OUTPUT, 0x01 },
+	{ PCM1792A_ZERO_FLAG, 0x00 },
+	{ PCM1792A_DEVICE_ID, 0x00 },
 };
 
 static bool pcm1792a_accessible_reg(struct device *dev, unsigned int reg)
-- 
2.1.0
