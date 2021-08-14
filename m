Return-Path: <SRS0=RBkB=NF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC9C4338F
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Aug 2021 18:02:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41DA60F92
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Aug 2021 18:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D41DA60F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88BD01701;
	Sat, 14 Aug 2021 20:01:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88BD01701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628964158;
	bh=o4fcEsbeCIya5o7SaDd8oHuEu/jH+sIt8NkonDBklWk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ocTEEcjLjlrra6Pa/76h0XTe1OZmvKNBsuJpz0iG4WlapBfnH/2aAs/pFJ41jJLXO
	 PzlFANX3zYwbIBDDpDATpfDdsA7vrro4WQAuZGClew39d3AZsgwCfzNnLt2CZkiTST
	 EDKZER6r8xbkNhLtw3dhFLQCMrvn1/I5Kg5G7D7I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 216DCF80245;
	Sat, 14 Aug 2021 20:01:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C950F8025D; Sat, 14 Aug 2021 20:01:44 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 8A405F800AF
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 20:01:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A405F800AF
X-IronPort-AV: E=Sophos;i="5.84,322,1620658800"; d="scan'208";a="90637177"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 15 Aug 2021 03:01:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.6])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id B7A3040BF759;
 Sun, 15 Aug 2021 03:01:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_dma_request function
Date: Sat, 14 Aug 2021 19:01:20 +0100
Message-Id: <20210814180120.18082-1-biju.das.jz@bp.renesas.com>
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

The pointer returned by the dma_request_chan function is an error pointer
for the error cases. But on the rz_ssi_dma_request function, it checks for
NULL pointer instead.

This patch fixes the issue by checking the error pointer instead of NULL
pointer.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Replaced IS_ERR_OR_NULL with IS_ERR for error pointer check, as the
   dma_request_chan function never returns NULL pointer for error case.
---
 sound/soc/sh/rz-ssi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index ea8d33ede5d2..2f9345415a15 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -676,11 +676,19 @@ static void rz_ssi_release_dma_channels(struct rz_ssi_priv *ssi)
 static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 {
 	ssi->playback.dma_ch = dma_request_chan(dev, "tx");
+	if (IS_ERR(ssi->playback.dma_ch))
+		ssi->playback.dma_ch = NULL;
+
 	ssi->capture.dma_ch = dma_request_chan(dev, "rx");
+	if (IS_ERR(ssi->capture.dma_ch))
+		ssi->capture.dma_ch = NULL;
+
 	if (!ssi->playback.dma_ch && !ssi->capture.dma_ch) {
 		ssi->playback.dma_ch = dma_request_chan(dev, "rt");
-		if (!ssi->playback.dma_ch)
+		if (IS_ERR(ssi->playback.dma_ch)) {
+			ssi->playback.dma_ch = NULL;
 			goto no_dma;
+		}
 
 		ssi->dma_rt = true;
 	}
-- 
2.17.1

