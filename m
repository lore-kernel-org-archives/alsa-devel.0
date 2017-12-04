From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: eukrea-tlv320: Remove include line of fsl_ssi.h" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:10 +0000
Message-ID: <E1eLvni-0000OR-Kf@debutante>
References: <1512195805-9023-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512195805-9023-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, bhumirks@gmail.com, tiwai@suse.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: eukrea-tlv320: Remove include line of fsl_ssi.h

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 8f1a1df58e011e54ffcc2acd09249579e9467544 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Fri, 1 Dec 2017 22:32:35 -0800
Subject: [PATCH] ASoC: eukrea-tlv320: Remove include line of fsl_ssi.h

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
any erorr using imx_v6_v7_defconfig, after removing it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 84ef6385736c..191426a6d9ad 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -29,7 +29,6 @@
 
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
-#include "fsl_ssi.h"
 #include "imx-audmux.h"
 
 #define CODEC_CLOCK 12000000
-- 
2.15.0
