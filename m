Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DE4C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 01:37:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9487D61262
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 01:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9487D61262
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5240416A0;
	Tue, 28 Sep 2021 03:36:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5240416A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632793038;
	bh=qBZyUkep2XOKCiQqvkSqwL1GWV67BBTeGPY03yeUjQ0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C32GCOc+Em7zpWwBDZPskS/9xyp0CO310X9c2Dfknh/O5s8Ua9tjRkHq58WDuqPGI
	 dlC/GsKnPNckFp8HgAWGlqfqZO0HCYuPYrGEU4FR4YnOYKKuD/iZt+AIzHIkaGAqvE
	 OD05LHBYqRiLNLKsoWOyRdCDX8sV16PnET72PLGQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CADCBF8032C;
	Tue, 28 Sep 2021 03:36:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67A3DF804AD; Tue, 28 Sep 2021 03:36:24 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.132])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8D40F80105
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 03:36:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8D40F80105
Received: from localhost (unknown [192.168.167.16])
 by lucky1.263xmail.com (Postfix) with ESMTP id 617E7FB618;
 Tue, 28 Sep 2021 09:36:08 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P13671T140479825954560S1632792967296273_; 
 Tue, 28 Sep 2021 09:36:08 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 10
X-LOCAL-RCPT-COUNT: 1
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <449a6737cf21524e2fbe3c53d057ed92>
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH] Revert "ASoC: rockchip: add config for rockchip dmaengine pcm
 register"
Date: Tue, 28 Sep 2021 09:35:57 +0800
Message-Id: <1632792957-80428-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Sugar Zhang <sugar.zhang@rock-chips.com>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This reverts commit 75b31192fe6ad20b42276b20ee3bdf1493216d63.

The original purpose of customized pcm was to config prealloc buffer size
flexibly. but, we can do the same thing by soc-generic-dmaengine-pcm.

And the generic one can generated the better config by querying DMA
capabilities from dmaengine driver rather than the Hard-Coded one.

e.g.

the customized one:

  static const struct snd_pcm_hardware snd_rockchip_hardware = {
         .info                   = SNDRV_PCM_INFO_MMAP |
                                   SNDRV_PCM_INFO_MMAP_VALID |
                                   SNDRV_PCM_INFO_PAUSE |
                                   SNDRV_PCM_INFO_RESUME |
                                   SNDRV_PCM_INFO_INTERLEAVED,
  ...

the generic one:

  ret = dma_get_slave_caps(chan, &dma_caps);
  if (ret == 0) {
          if (dma_caps.cmd_pause && dma_caps.cmd_resume)
                  hw.info |= SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME;
          if (dma_caps.residue_granularity <= DMA_RESIDUE_GRANULARITY_SEGMENT)
                  hw.info |= SNDRV_PCM_INFO_BATCH;
  ...

So, let's revert back to use the generic dmaengine pcm.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/Makefile       |  3 +--
 sound/soc/rockchip/rockchip_i2s.c |  3 +--
 sound/soc/rockchip/rockchip_pcm.c | 44 ---------------------------------------
 sound/soc/rockchip/rockchip_pcm.h | 11 ----------
 4 files changed, 2 insertions(+), 59 deletions(-)
 delete mode 100644 sound/soc/rockchip/rockchip_pcm.c
 delete mode 100644 sound/soc/rockchip/rockchip_pcm.h

diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 65e814d..05b078e 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # ROCKCHIP Platform Support
 snd-soc-rockchip-i2s-objs := rockchip_i2s.o
-snd-soc-rockchip-pcm-objs := rockchip_pcm.o
 snd-soc-rockchip-pdm-objs := rockchip_pdm.o
 snd-soc-rockchip-spdif-objs := rockchip_spdif.o
 
-obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o snd-soc-rockchip-pcm.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_PDM) += snd-soc-rockchip-pdm.o
 obj-$(CONFIG_SND_SOC_ROCKCHIP_SPDIF) += snd-soc-rockchip-spdif.o
 
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 7e89f5b..a6d7656 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -20,7 +20,6 @@
 #include <sound/dmaengine_pcm.h>
 
 #include "rockchip_i2s.h"
-#include "rockchip_pcm.h"
 
 #define DRV_NAME "rockchip-i2s"
 
@@ -756,7 +755,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 		goto err_suspend;
 	}
 
-	ret = rockchip_pcm_platform_register(&pdev->dev);
+	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
 		goto err_suspend;
diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
deleted file mode 100644
index 02254e4..0000000
--- a/sound/soc/rockchip/rockchip_pcm.c
+++ /dev/null
@@ -1,44 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
- */
-
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/module.h>
-
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/dmaengine_pcm.h>
-
-#include "rockchip_pcm.h"
-
-static const struct snd_pcm_hardware snd_rockchip_hardware = {
-	.info			= SNDRV_PCM_INFO_MMAP |
-				  SNDRV_PCM_INFO_MMAP_VALID |
-				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME |
-				  SNDRV_PCM_INFO_INTERLEAVED,
-	.period_bytes_min	= 32,
-	.period_bytes_max	= 8192,
-	.periods_min		= 1,
-	.periods_max		= 52,
-	.buffer_bytes_max	= 64 * 1024,
-	.fifo_size		= 32,
-};
-
-static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config = {
-	.pcm_hardware = &snd_rockchip_hardware,
-	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
-	.prealloc_buffer_size = 32 * 1024,
-};
-
-int rockchip_pcm_platform_register(struct device *dev)
-{
-	return devm_snd_dmaengine_pcm_register(dev, &rk_dmaengine_pcm_config,
-		SND_DMAENGINE_PCM_FLAG_COMPAT);
-}
-EXPORT_SYMBOL_GPL(rockchip_pcm_platform_register);
-
-MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/rockchip/rockchip_pcm.h b/sound/soc/rockchip/rockchip_pcm.h
deleted file mode 100644
index 7f00e2c..0000000
--- a/sound/soc/rockchip/rockchip_pcm.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2018 Rockchip Electronics Co. Ltd.
- */
-
-#ifndef _ROCKCHIP_PCM_H
-#define _ROCKCHIP_PCM_H
-
-int rockchip_pcm_platform_register(struct device *dev);
-
-#endif
-- 
2.7.4



