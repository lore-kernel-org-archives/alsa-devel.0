From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] MFD: twl6040: Update register bit
	definitions
Date: Mon, 24 Jun 2013 15:42:04 +0200
Message-ID: <1372081326-6917-3-git-send-email-peter.ujfalusi@ti.com>
References: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A279265066
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 15:42:14 +0200 (CEST)
In-Reply-To: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

Add define for: HSDRV, HFDAC, HFPGA and HFDRV enable bits

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
CC: Samuel Ortiz <sameo@linux.intel.com>
---
 include/linux/mfd/twl6040.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mfd/twl6040.h b/include/linux/mfd/twl6040.h
index 94ac944..7e7fbce 100644
--- a/include/linux/mfd/twl6040.h
+++ b/include/linux/mfd/twl6040.h
@@ -125,8 +125,15 @@
 
 #define TWL6040_HSDACENA		(1 << 0)
 #define TWL6040_HSDACMODE		(1 << 1)
+#define TWL6040_HSDRVENA		(1 << 2)
 #define TWL6040_HSDRVMODE		(1 << 3)
 
+/* HFLCTL/R (0x14/0x16) fields */
+
+#define TWL6040_HFDACENA		(1 << 0)
+#define TWL6040_HFPGAENA		(1 << 1)
+#define TWL6040_HFDRVENA		(1 << 4)
+
 /* VIBCTLL/R (0x18/0x1A) fields */
 
 #define TWL6040_VIBENA			(1 << 0)
-- 
1.8.2.1
