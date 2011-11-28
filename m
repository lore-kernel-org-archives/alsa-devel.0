From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 3/7] firmware: Sigma: Fix endianess issues
Date: Mon, 28 Nov 2011 09:44:16 +0100
Message-ID: <1322469860-8210-3-git-send-email-lars@metafoo.de>
References: <1322469860-8210-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id 9A1AC1038AB
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 09:43:32 +0100 (CET)
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
Cc: drivers@analog.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

Currently the SigmaDSP firmware loader only works correctly on little-endian
systems. Fix this by using the proper endianess conversion functions.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Mike Frysinger <vapier@gentoo.org>
Cc: stable@kernel.org
---
 drivers/firmware/sigma.c |    2 +-
 include/linux/sigma.h    |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/sigma.c b/drivers/firmware/sigma.c
index 36265de..1eedb6f 100644
--- a/drivers/firmware/sigma.c
+++ b/drivers/firmware/sigma.c
@@ -133,7 +133,7 @@ int process_sigma_firmware(struct i2c_client *client, const char *name)
 	crc = crc32(0, fw->data + sizeof(*ssfw_head),
 			fw->size - sizeof(*ssfw_head));
 	pr_debug("%s: crc=%x\n", __func__, crc);
-	if (crc != ssfw_head->crc)
+	if (crc != le32_to_cpu(ssfw_head->crc))
 		goto done;
 
 	ssfw.pos = sizeof(*ssfw_head);
diff --git a/include/linux/sigma.h b/include/linux/sigma.h
index 9a138c2..d0de882 100644
--- a/include/linux/sigma.h
+++ b/include/linux/sigma.h
@@ -24,7 +24,7 @@ struct sigma_firmware {
 struct sigma_firmware_header {
 	unsigned char magic[7];
 	u8 version;
-	u32 crc;
+	__le32 crc;
 };
 
 enum {
@@ -40,14 +40,14 @@ enum {
 struct sigma_action {
 	u8 instr;
 	u8 len_hi;
-	u16 len;
-	u16 addr;
+	__le16 len;
+	__be16 addr;
 	unsigned char payload[];
 };
 
 static inline u32 sigma_action_len(struct sigma_action *sa)
 {
-	return (sa->len_hi << 16) | sa->len;
+	return (sa->len_hi << 16) | le16_to_cpu(sa->len);
 }
 
 extern int process_sigma_firmware(struct i2c_client *client, const char *name);
-- 
1.7.7.3
