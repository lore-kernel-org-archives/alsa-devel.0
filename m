Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF27C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Apr 2022 07:51:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9EE4618AA;
	Tue, 26 Apr 2022 09:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9EE4618AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650959507;
	bh=x0Ev83o1WbeM8LBW4kcL75a0OYYQjFjdZZwKL2+4QG0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cIfZlT2g90Vuvb6PXMd8mf78BztAPJTm0a/99LS6gSOg93FeD4b8/R92pA3uvbSHw
	 nOMTpVk+Y9B9S9RfaqYA4mGf+V+bNQwBEJ51t9xdTo5lh8WclBgWC/BjQtHffwMsNL
	 /6MYMISIOYAjQnJnovj5OkUofcTedn5i84wU1PAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAA6BF8051A;
	Tue, 26 Apr 2022 09:50:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54288F80526; Tue, 26 Apr 2022 09:50:12 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id C105DF8014B
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2022 09:50:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C105DF8014B
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; d="scan'208";a="118016712"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 26 Apr 2022 16:50:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id E19074248B19;
 Tue, 26 Apr 2022 16:49:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH v2 3/3] ASoC: sh: rz-ssi: Release the DMA channels in
 rz_ssi_probe() error path
Date: Tue, 26 Apr 2022 08:49:22 +0100
Message-Id: <20220426074922.13319-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@denx.de>,
 linux-kernel@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
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

DMA channels requested by rz_ssi_dma_request() in rz_ssi_probe() were
never released in the error path apart from one place. This patch fixes
this issue by calling rz_ssi_release_dma_channels() in the error path.

Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Dropped devers action and instead called rz_ssi_release_dma_channels()
  in the error path.
---
 sound/soc/sh/rz-ssi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d9a684e71ec3..e392de7a262e 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -976,14 +976,18 @@ static int rz_ssi_probe(struct platform_device *pdev)
 
 	/* Error Interrupt */
 	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
-	if (ssi->irq_int < 0)
+	if (ssi->irq_int < 0) {
+		rz_ssi_release_dma_channels(ssi);
 		return ssi->irq_int;
+	}
 
 	ret = devm_request_irq(&pdev->dev, ssi->irq_int, &rz_ssi_interrupt,
 			       0, dev_name(&pdev->dev), ssi);
-	if (ret < 0)
+	if (ret < 0) {
+		rz_ssi_release_dma_channels(ssi);
 		return dev_err_probe(&pdev->dev, ret,
 				     "irq request error (int_req)\n");
+	}
 
 	if (!rz_ssi_is_dma_enabled(ssi)) {
 		/* Tx and Rx interrupts (pio only) */
@@ -1011,13 +1015,16 @@ static int rz_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(ssi->rstc))
+	if (IS_ERR(ssi->rstc)) {
+		rz_ssi_release_dma_channels(ssi);
 		return PTR_ERR(ssi->rstc);
+	}
 
 	reset_control_deassert(ssi->rstc);
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
+		rz_ssi_release_dma_channels(ssi);
 		pm_runtime_disable(ssi->dev);
 		reset_control_assert(ssi->rstc);
 		return dev_err_probe(ssi->dev, ret, "pm_runtime_resume_and_get failed\n");
-- 
2.25.1

