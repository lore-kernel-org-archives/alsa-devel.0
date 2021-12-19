Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5017CC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Dec 2021 18:12:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53CF41845;
	Sun, 19 Dec 2021 19:11:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53CF41845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639937565;
	bh=Cpo4U8J97FvvpBiqo1UGLR2gVcAmHv42fYBXpbg9oT4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U9H9VSKCJH8i+Il7mTDTmtf3L6jasj3DGqHX89PNaa4Fk1rsCmQyAKRN/E5/8Rn0T
	 9kT25HozIfbkFRq4IS4G4QCcX0JHQUH2wv1F4tWc57UlTyqkJbok6bjqvB5sgxCBsx
	 WCh9IxSXWlKNJO4ZO5Wr/wKN3ivDusEbZE9UEU+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E796F804E4;
	Sun, 19 Dec 2021 19:11:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 087A1F802BE; Sun, 19 Dec 2021 19:11:08 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id D8F6EF80279
 for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2021 19:11:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8F6EF80279
X-IronPort-AV: E=Sophos;i="5.88,218,1635174000"; d="scan'208";a="104455502"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 03:10:56 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 477DB40CB08A;
 Mon, 20 Dec 2021 03:10:54 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 2/2] ASoC: bcm: Use platform_get_irq() to get the interrupt
Date: Sun, 19 Dec 2021 18:10:39 +0000
Message-Id: <20211219181039.24812-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211219181039.24812-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: alsa-devel@alsa-project.org, Prabhakar <prabhakar.csengg@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
allocation of IRQ resources in DT core code, this causes an issue
when using hierarchical interrupt domains using "interrupts" property
in the node as this bypasses the hierarchical setup and messes up the
irq chaining.

In preparation for removal of static setup of IRQ resource from DT core
code use platform_get_irq().

While at it also drop "r_irq" member from struct bcm_i2s_priv as there
are no users of it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/bcm/bcm63xx-i2s.h          |  1 -
 sound/soc/bcm/bcm63xx-pcm-whistler.c | 12 +++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/bcm/bcm63xx-i2s.h b/sound/soc/bcm/bcm63xx-i2s.h
index edc328ba53d3..f30556bec89e 100644
--- a/sound/soc/bcm/bcm63xx-i2s.h
+++ b/sound/soc/bcm/bcm63xx-i2s.h
@@ -74,7 +74,6 @@
 
 struct bcm_i2s_priv {
 	struct device *dev;
-	struct resource *r_irq;
 	struct regmap *regmap_i2s;
 	struct clk *i2s_clk;
 	struct snd_pcm_substream	*play_substream;
diff --git a/sound/soc/bcm/bcm63xx-pcm-whistler.c b/sound/soc/bcm/bcm63xx-pcm-whistler.c
index b5096f64c576..41f80d564020 100644
--- a/sound/soc/bcm/bcm63xx-pcm-whistler.c
+++ b/sound/soc/bcm/bcm63xx-pcm-whistler.c
@@ -387,14 +387,12 @@ int bcm63xx_soc_platform_probe(struct platform_device *pdev,
 {
 	int ret;
 
-	i2s_priv->r_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!i2s_priv->r_irq) {
-		dev_err(&pdev->dev, "Unable to get register irq resource.\n");
-		return -ENODEV;
-	}
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
 
-	ret = devm_request_irq(&pdev->dev, i2s_priv->r_irq->start, i2s_dma_isr,
-			i2s_priv->r_irq->flags, "i2s_dma", (void *)i2s_priv);
+	ret = devm_request_irq(&pdev->dev, ret, i2s_dma_isr,
+			       irq_get_trigger_type(ret), "i2s_dma", (void *)i2s_priv);
 	if (ret) {
 		dev_err(&pdev->dev,
 			"i2s_init: failed to request interrupt.ret=%d\n", ret);
-- 
2.17.1

