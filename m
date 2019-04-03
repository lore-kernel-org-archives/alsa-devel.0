From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sprd: Fix modular build" to the asoc
	tree
Date: Wed,  3 Apr 2019 06:52:35 +0100 (BST)
Message-ID: <20190403055235.C4E15440082@finisterre.ee.mobilebroadband>
References: <20190403045654.26957-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45FA5F80714
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 07:52:41 +0200 (CEST)
In-Reply-To: <20190403045654.26957-1-broonie@kernel.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Baolin Wang <baolin.wang@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sprd: Fix modular build

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

>From 0f9e47b3fd92c809a8c68719cd60ba863c4c48e0 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 3 Apr 2019 11:55:40 +0700
Subject: [PATCH] ASoC: sprd: Fix modular build

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sprd/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sprd/Makefile b/sound/soc/sprd/Makefile
index fa1d5476b8da..e6c2606da8e2 100644
--- a/sound/soc/sprd/Makefile
+++ b/sound/soc/sprd/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Spreadtrum Audio Support
 
-obj-$(CONFIG_SND_SOC_SPRD)	+= sprd-pcm-dma.o sprd-pcm-compress.o
+snd-soc-sprd-platform-objs := sprd-pcm-dma.o sprd-pcm-compress.o
+
+obj-$(CONFIG_SND_SOC_SPRD) += snd-soc-sprd-platform.o
-- 
2.20.1
