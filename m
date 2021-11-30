Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E81C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 05:41:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9536A1F0C;
	Tue, 30 Nov 2021 06:40:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9536A1F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638250874;
	bh=WbKXPNuoNJVdOKQwcjqcgGKKgsTr+qtobCDhZ9ew6r0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g4I8ds3Ni3BiqvDEv1r/SDAOlrMEyRhZ4IxfCjCsU/P6T6EKm40AIVlxLuxscplDA
	 HWz1ZG7Gef8qrUgNJ2uBWslBsHS1F7QkS9P5x3bQR4BsiqE3GrpxXJ0HYWgIjiJH6d
	 IZmGmV2b9uQyYkUh2NBtTaAFUz6WIYMK+ASsdfYg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 012B1F8028D;
	Tue, 30 Nov 2021 06:40:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EDF16F80301; Tue, 30 Nov 2021 06:40:17 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0397F80113
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 06:39:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0397F80113
X-UUID: 7fcca7d58fa54c37b40bdb1e4fce2cb6-20211130
X-UUID: 7fcca7d58fa54c37b40bdb1e4fce2cb6-20211130
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1883285016; Tue, 30 Nov 2021 13:39:09 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 30 Nov 2021 13:39:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Tue, 30 Nov 2021 13:39:07 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH 1/2] ASoC: mediatek: mt8195: support reserved memory assignment
Date: Tue, 30 Nov 2021 13:39:04 +0800
Message-ID: <20211130053905.28470-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211130053905.28470-1-trevor.wu@mediatek.com>
References: <20211130053905.28470-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, yc.hung@mediatek.com,
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

For security purpose, restrict the memory assess region of AFE memif.
The specified memory region should be assigned from DTS.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
index 2bb05a828e8d..8a6db24116e3 100644
--- a/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-afe-pcm.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/pm_runtime.h>
 #include "mt8195-afe-common.h"
 #include "mt8195-afe-clk.h"
@@ -3061,6 +3062,12 @@ static int mt8195_afe_pcm_dev_probe(struct platform_device *pdev)
 	int i, irq_id, ret;
 	struct snd_soc_component *component;
 
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_err(dev, "failed to assign memory region: %d\n", ret);
+		return ret;
+	}
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(33));
 	if (ret)
 		return ret;
-- 
2.18.0

