From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: Fix typo in a field define" to the asoc tree
Date: Wed, 29 Nov 2017 10:57:32 +0000
Message-ID: <E1eK03Y-0005z9-7c@debutante>
References: <1510862118-16104-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510862118-16104-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Laurent Charpentier <laurent.charpentier@nxp.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, fabio.estevam@nxp.com, alsa-devel@alsa-project.orglaurent.charpentier@nxp.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: Fix typo in a field define

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

>From b89b6925bb9d48926d7ba713d3f13b14fc35c544 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 16 Nov 2017 11:55:18 -0800
Subject: [PATCH] ASoC: fsl_asrc: Fix typo in a field define

ASRFSTi_IAEi has an 11-bit offset as its _SHIFT macro defines.

So this patch just fixes that.

Reported-by: Laurent Charpentier <laurent.charpentier@nxp.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 0f163abe4ba3..52c27a358933 100644
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
2.15.0
