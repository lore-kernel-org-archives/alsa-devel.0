From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v6 01/17] ASoC: fsl_ssi: Redefine RX and TX
	macros
Date: Mon, 12 Feb 2018 14:03:09 -0800
Message-ID: <1518473005-14090-2-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 632232675A4
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 23:02:40 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id g12so29819pgs.0
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 14:02:39 -0800 (PST)
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, timur@tabi.org
Cc: mail@maciej.szmigiero.name, kernel@pengutronix.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The RX and TX macros were defined implicitly and there was
a potential risk if someone changes their values.

Since they were defined to index the array ssi->regvals[2],
this patch moves these two macros to fsl_ssi.c, closer to
its owner ssi->regvals. And it also puts some comments here
to limit their value within [0, 1].

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 4 ++++
 sound/soc/fsl/fsl_ssi.h | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 24fb672..3c8dd60 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -56,6 +56,10 @@
 #include "fsl_ssi.h"
 #include "imx-pcm.h"
 
+/* Define RX and TX to index ssi->regvals array; Can be 0 or 1 only */
+#define RX 0
+#define TX 1
+
 /**
  * FSLSSI_I2S_FORMATS: audio formats supported by the SSI
  *
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index de2fdc5..18f8dd5 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -12,9 +12,6 @@
 #ifndef _MPC8610_I2S_H
 #define _MPC8610_I2S_H
 
-#define RX 0
-#define TX 1
-
 /* -- SSI Register Map -- */
 
 /* SSI Transmit Data Register 0 */
-- 
2.1.4
