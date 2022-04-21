Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC5EC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 20:38:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 480B0857;
	Thu, 21 Apr 2022 22:37:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 480B0857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650573501;
	bh=vbX/TKpDa/N2SrUr1ksesNzA1slY1N6Q+TmvVJhVrcs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o3FGMv5FUBdL1/yUgm3wQTOuSM7zOj/l9R/pDBHvir1Ol7p+11PBd6namH7QzrpJN
	 Rp6/Z7HmkIpNLGezFfu0UyaDCPCGVBUq/ZwrW3xYlRprma/r4RnbEeFtWao0peCPaM
	 p4nlPSBngLpH/l+hab9hf0uOEXiFy+mVMlP9ZlK8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A89DF804F1;
	Thu, 21 Apr 2022 22:36:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FBAFF804FE; Thu, 21 Apr 2022 22:36:49 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id ACD00F80279
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 22:36:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACD00F80279
X-IronPort-AV: E=Sophos;i="5.90,279,1643641200"; d="scan'208";a="118731532"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 22 Apr 2022 05:36:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id B74A0401998F;
 Fri, 22 Apr 2022 05:36:31 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ASoC: sh: rz-ssi: Add a devres action to release the DMA
 channels
Date: Thu, 21 Apr 2022 21:35:55 +0100
Message-Id: <20220421203555.29011-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org,
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
this issue by adding a devres action to release the DMA channels and
dropping the single rz_ssi_release_dma_channels() call which was placed
in the error path in case devm_snd_soc_register_component() failed.

Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d9a684e71ec3..f04da1bf5680 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -912,6 +912,11 @@ static const struct snd_soc_component_driver rz_ssi_soc_component = {
 	.pcm_construct	= rz_ssi_pcm_new,
 };
 
+static void rz_ssi_release_dma_channels_action(void *data)
+{
+	rz_ssi_release_dma_channels(data);
+}
+
 static int rz_ssi_probe(struct platform_device *pdev)
 {
 	struct rz_ssi_priv *ssi;
@@ -966,6 +971,11 @@ static int rz_ssi_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "DMA enabled");
 		ssi->playback.transfer = rz_ssi_dma_transfer;
 		ssi->capture.transfer = rz_ssi_dma_transfer;
+
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       rz_ssi_release_dma_channels_action, ssi);
+		if (ret)
+			return ret;
 	}
 
 	ssi->playback.priv = ssi;
@@ -1027,8 +1037,6 @@ static int rz_ssi_probe(struct platform_device *pdev)
 					      rz_ssi_soc_dai,
 					      ARRAY_SIZE(rz_ssi_soc_dai));
 	if (ret < 0) {
-		rz_ssi_release_dma_channels(ssi);
-
 		pm_runtime_put(ssi->dev);
 		pm_runtime_disable(ssi->dev);
 		reset_control_assert(ssi->rstc);
-- 
2.17.1

