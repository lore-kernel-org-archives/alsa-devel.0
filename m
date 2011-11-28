From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 6/7] ASoC: SigmaDSP: Move private structs
	and functions to C file
Date: Mon, 28 Nov 2011 09:44:19 +0100
Message-ID: <1322469860-8210-6-git-send-email-lars@metafoo.de>
References: <1322469860-8210-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A922103893
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 09:43:31 +0100 (CET)
In-Reply-To: <1322469860-8210-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

Move the structs and functions only used by SigmaDSP firmware loader itself
from the header to the C file.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/sigmadsp.c |   36 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/sigmadsp.h |   39 ---------------------------------------
 2 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
index c0ad885..aa223c5 100644
--- a/sound/soc/codecs/sigmadsp.c
+++ b/sound/soc/codecs/sigmadsp.c
@@ -15,6 +15,42 @@
 
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
+
 static size_t sigma_action_size(struct sigma_action *sa)
 {
 	size_t payload = 0;
diff --git a/sound/soc/codecs/sigmadsp.h b/sound/soc/codecs/sigmadsp.h
index d0de882..99a6091 100644
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
-};
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
-};
-
-static inline u32 sigma_action_len(struct sigma_action *sa)
-{
-	return (sa->len_hi << 16) | le16_to_cpu(sa->len);
-}
-
 extern int process_sigma_firmware(struct i2c_client *client, const char *name);
 
 #endif
-- 
1.7.7.3
