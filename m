From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/8] ASoC: SigmaDSP: Move private structs and functions to c file
Date: Thu, 24 Nov 2011 13:48:26 +0100
Message-ID: <1322138908-32127-7-git-send-email-lars@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322138908-32127-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Move the structs and functions only used by SigmaDSP firmware loader itself
from the header to the c file.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sigmadsp.c |   35 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sigmadsp.h |   39 ---------------------------------------
 2 files changed, 35 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index e13501a..c6964f4 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -15,6 +15,41 @@
 
 #include "sigmadsp.h"
 
+#define SIGMA_MAGIC "ADISIGM"
+
+struct sigma_firmware_header {
+	unsigned char magic[7];
+	u8 version;
+	__le32 crc;
+} __packed;
+
+enum {
+	SIGMA_ACTION_WRITEXBYTES = 0,
+	SIGMA_ACTION_WRITESINGLE,
+	SIGMA_ACTION_WRITESAFELOAD,
+	SIGMA_ACTION_DELAY,
+	SIGMA_ACTION_PLLWAIT,
+	SIGMA_ACTION_NOOP,
+	SIGMA_ACTION_END,
+};
+
+struct sigma_action {
+	u8 instr;
+	u8 len_hi;
+	__le16 len;
+	__be16 addr;
+	unsigned char payload[];
+} __packed;
+
+struct sigma_firmware {
+	const struct firmware *fw;
+	size_t pos;
+};
+
+static inline u32 sigma_action_len(struct sigma_action *sa)
+{
+	return (sa->len_hi << 16) | le16_to_cpu(sa->len);
+}
 static size_t sigma_action_size(struct sigma_action *sa)
 {
 	size_t payload = 0;
diff --git a/sound/soc/codecs/sigmadsp.h b/sound/soc/codecs/sigmadsp.h
index 745f1bd..99a6091 100644
--- a/sound/soc/codecs/sigmadsp.h
+++ b/sound/soc/codecs/sigmadsp.h
@@ -9,47 +9,8 @@
 #ifndef __SIGMA_FIRMWARE_H__
 #define __SIGMA_FIRMWARE_H__
 
-#include <linux/firmware.h>
-#include <linux/types.h>
-
 struct i2c_client;
 
-#define SIGMA_MAGIC "ADISIGM"
-
-struct sigma_firmware {
-	const struct firmware *fw;
-	size_t pos;
-};
-
-struct sigma_firmware_header {
-	unsigned char magic[7];
-	u8 version;
-	__le32 crc;
-} __packed;
-
-enum {
-	SIGMA_ACTION_WRITEXBYTES = 0,
-	SIGMA_ACTION_WRITESINGLE,
-	SIGMA_ACTION_WRITESAFELOAD,
-	SIGMA_ACTION_DELAY,
-	SIGMA_ACTION_PLLWAIT,
-	SIGMA_ACTION_NOOP,
-	SIGMA_ACTION_END,
-};
-
-struct sigma_action {
-	u8 instr;
-	u8 len_hi;
-	__le16 len;
-	__be16 addr;
-	unsigned char payload[];
-} __packed;
-
-static inline u32 sigma_action_len(struct sigma_action *sa)
-{
-	return (sa->len_hi << 16) | le16_to_cpu(sa->len);
-}
-
 extern int process_sigma_firmware(struct i2c_client *client, const char *name);
 
 #endif
-- 
1.7.7.1
