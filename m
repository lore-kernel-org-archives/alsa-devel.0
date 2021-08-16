Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200F9C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 13:22:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DCE6113D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 13:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1DCE6113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E90A16B4;
	Mon, 16 Aug 2021 15:21:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E90A16B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629120121;
	bh=mBEHG3eZGiOamtIKqhF93rbq7DRVy3bF04vcJaDz8pY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jWqNYobeovXThv4m11CbOCB4gX11P9XDTQ5etAkIQrg3510KfKOVHmGpUs8ZBxpak
	 MnM3d2KZwoY9eVZ2GuY4EEwYLWA0JHm3ugTNOG7wYwMQdnIKB4XcripPbH4H1i7P0f
	 HBP1L85V3FFdNIFEf7Lyg0BsGWaKevO6CceNQ8zc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03120F80134;
	Mon, 16 Aug 2021 15:21:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70315F80249; Mon, 16 Aug 2021 15:21:07 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 126D9F80134
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 15:20:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 126D9F80134
X-IronPort-AV: E=Sophos;i="5.84,324,1620658800"; d="scan'208";a="90799322"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2021 22:20:55 +0900
Received: from localhost.localdomain (unknown [10.226.93.25])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id C55F243028A9;
 Mon, 16 Aug 2021 22:20:52 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: sh: rz-ssi: Fix dereference of noderef expression
 warning
Date: Mon, 16 Aug 2021 14:20:49 +0100
Message-Id: <20210816132049.28128-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Biju Das <biju.das@bp.renesas.com>
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

Fix following sparse warning:
sound/soc/sh/rz-ssi.c:156:15: sparse: warning: dereference of
noderef expression

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 2f9345415a15..7fa3737b90bf 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -148,7 +148,7 @@ static u32 rz_ssi_reg_readl(struct rz_ssi_priv *priv, uint reg)
 	return readl(priv->base + reg);
 }
 
-static void rz_ssi_reg_mask_setl(struct rz_ssi_priv __iomem *priv, uint reg,
+static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *priv, uint reg,
 				 u32 bclr, u32 bset)
 {
 	u32 val;
-- 
2.17.1

