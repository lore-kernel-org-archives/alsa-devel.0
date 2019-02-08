From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: msm8916-wcd-analog: add missing license
	information" to the asoc tree
Date: Fri,  8 Feb 2019 17:34:58 +0000 (GMT)
Message-ID: <20190208173458.EC3B41127F2F@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 377A8267A41
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 18:35:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johan Hovold <johan@kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: msm8916-wcd-analog: add missing license information

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

>From 3f22e31da833e576fcfecce1f4e7ed958477d1ec Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 8 Feb 2019 16:16:55 +0100
Subject: [PATCH] ASoC: msm8916-wcd-analog: add missing license information

Add the missing license and copyright information which never made it
into the analog driver when the original driver was split in two as part
of the review process.

Link: https://lkml.kernel.org/r/1465582725-30183-3-git-send-email-srinivas.kandagatla@linaro.org
Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index b7cf7cce95fe..368b6c09474b 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1,3 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2016, The Linux Foundation. All rights reserved.
+
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-- 
2.20.1
