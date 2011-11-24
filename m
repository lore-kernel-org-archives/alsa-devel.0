From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/8] firmware: Sigma: Mark firmware strutcs
	packed
Date: Thu, 24 Nov 2011 13:48:23 +0100
Message-ID: <1322138908-32127-4-git-send-email-lars@metafoo.de>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 166111037FC
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 13:47:48 +0100 (CET)
In-Reply-To: <1322138908-32127-1-git-send-email-lars@metafoo.de>
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

Mark structs which are embedded into the firmware as packed to avoid alignment
issues.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@kernel.org
---
 include/linux/sigma.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sigma.h b/include/linux/sigma.h
index d0de882..745f1bd 100644
--- a/include/linux/sigma.h
+++ b/include/linux/sigma.h
@@ -25,7 +25,7 @@ struct sigma_firmware_header {
 	unsigned char magic[7];
 	u8 version;
 	__le32 crc;
-};
+} __packed;
 
 enum {
 	SIGMA_ACTION_WRITEXBYTES = 0,
@@ -43,7 +43,7 @@ struct sigma_action {
 	__le16 len;
 	__be16 addr;
 	unsigned char payload[];
-};
+} __packed;
 
 static inline u32 sigma_action_len(struct sigma_action *sa)
 {
-- 
1.7.7.1
