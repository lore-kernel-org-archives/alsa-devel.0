From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: sprd: Fix modular build
Date: Wed,  3 Apr 2019 11:56:54 +0700
Message-ID: <20190403045654.26957-1-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1061F8071D
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 06:57:12 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Baolin Wang <baolin.wang@linaro.org>
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
