From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 9/9] ASoC: eukrea-tlv320: Remove include line of fsl_ssi.h
Date: Fri,  1 Dec 2017 22:23:25 -0800
Message-ID: <1512195805-9023-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

The machine driver links both imx-ssi (legacy non-DT driver) and
fsl_ssi (up-to-date DT based driver). So It also includes both
imx-ssi.h and fsl_ssi.h header files. This creates a limitation
for two header files -- they can't define anything with identical
names.

Since the eukrea-tlv320 machine driver now does not really need
anything being defined in the fsl_ssi header file, and it's also
going to take some time to clean up two SSI drivers, this patch
takes a quick way to remove the #include fsl_ssi.h line for now.
It can be added back once the header files are done refactoring.

The eukrea-tlv320 driver is still compiled successfully without
any erorr using imx_v6_v6_defconfig, after removing it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/eukrea-tlv320.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 84ef638..191426a 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -29,7 +29,6 @@
 
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
-#include "fsl_ssi.h"
 #include "imx-audmux.h"
 
 #define CODEC_CLOCK 12000000
-- 
2.7.4
