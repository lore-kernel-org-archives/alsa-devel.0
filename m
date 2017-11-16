From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_asrc: Fix typo in a field define
Date: Thu, 16 Nov 2017 11:55:18 -0800
Message-ID: <1510862118-16104-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, fabio.estevam@nxp.com, laurent.charpentier@nxp.com
List-Id: alsa-devel@alsa-project.org

ASRFSTi_IAEi has an 11-bit offset as its _SHIFT macro defines.

So this patch just fixes that.

Reported-by: Laurent Charpentier <laurent.charpentier@nxp.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 0f163ab..52c27a35 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -260,8 +260,8 @@
 #define ASRFSTi_OUTPUT_FIFO_SHIFT	12
 #define ASRFSTi_OUTPUT_FIFO_MASK	(((1 << ASRFSTi_OUTPUT_FIFO_WIDTH) - 1) << ASRFSTi_OUTPUT_FIFO_SHIFT)
 #define ASRFSTi_IAEi_SHIFT		11
-#define ASRFSTi_IAEi_MASK		(1 << ASRFSTi_OAFi_SHIFT)
-#define ASRFSTi_IAEi			(1 << ASRFSTi_OAFi_SHIFT)
+#define ASRFSTi_IAEi_MASK		(1 << ASRFSTi_IAEi_SHIFT)
+#define ASRFSTi_IAEi			(1 << ASRFSTi_IAEi_SHIFT)
 #define ASRFSTi_INPUT_FIFO_WIDTH	7
 #define ASRFSTi_INPUT_FIFO_SHIFT	0
 #define ASRFSTi_INPUT_FIFO_MASK		((1 << ASRFSTi_INPUT_FIFO_WIDTH) - 1)
-- 
2.1.4
