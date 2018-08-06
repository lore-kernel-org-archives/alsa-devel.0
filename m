From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sdm845: remove unused header files" to
	the asoc tree
Date: Mon,  6 Aug 2018 12:50:43 +0100 (BST)
Message-ID: <20180806115043.1C2AB1124240@debutante.sirena.org.uk>
References: <20180806101209.15167-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA413267857
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:50:43 +0200 (CEST)
In-Reply-To: <20180806101209.15167-4-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org, broonie@kernel.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sdm845: remove unused header files

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

>From 846b2c96808cc7cdf4e0619d00604b3edd15b35a Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Mon, 6 Aug 2018 11:12:07 +0100
Subject: [PATCH] ASoC: sdm845: remove unused header files

This patch removes unused header files from the driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index c1adb77230eb..2a781d87ee65 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -5,11 +5,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/atomic.h>
 #include <linux/of_device.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include <linux/soc/qcom/apr.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
-- 
2.18.0
