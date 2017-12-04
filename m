From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 01/10] ASoC: fsl_ssi: Remove unused struct device
Date: Mon,  4 Dec 2017 12:46:34 -0800
Message-ID: <1512420403-10164-2-git-send-email-nicoleotsuka@gmail.com>
References: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, fabio.estevam@nxp.com, timur@tabi.org, mail@maciej.szmigiero.name, caleb@crome.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

struct device is defined in system level header files any way.
As long as fsl_ssi.h is included after those header files, it
should be safe to remove this line.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 5065105..5cf56d2 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -206,8 +206,6 @@
 #define CCSR_SSI_SACNT_AC97EN		0x00000001
 
 
-struct device;
-
 #if IS_ENABLED(CONFIG_DEBUG_FS)
 
 struct fsl_ssi_dbg {
-- 
2.7.4
