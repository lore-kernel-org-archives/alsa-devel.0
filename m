From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH RESEND] ASoC: fsl_asrc: protect macro argument
Date: Wed,  6 Dec 2017 16:17:27 +0100
Message-ID: <20171206151727.2111-1-stefan@agner.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, timur@tabi.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, fabio.estevam@nxp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, stefan@agner.ch
List-Id: alsa-devel@alsa-project.org

Protect macro argument with parentheses to avoid ambiguity.
This fixes a warning seen with clang:
  warning: logical not is only applied to the left hand side of this comparison

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 0f163abe4ba3..ec33dab4b909 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -57,7 +57,7 @@
 #define REG_ASRDOC			0x74
 #define REG_ASRDI(i)			(REG_ASRDIA + (i << 3))
 #define REG_ASRDO(i)			(REG_ASRDOA + (i << 3))
-#define REG_ASRDx(x, i)			(x == IN ? REG_ASRDI(i) : REG_ASRDO(i))
+#define REG_ASRDx(x, i)			((x) == IN ? REG_ASRDI(i) : REG_ASRDO(i))
 
 #define REG_ASRIDRHA			0x80
 #define REG_ASRIDRLA			0x84
-- 
2.13.3
