Return-Path: <SRS0=RBkB=NF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542BC4338F
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Aug 2021 13:42:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8D660F4B
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Aug 2021 13:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B8D660F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F05EF1783;
	Sat, 14 Aug 2021 15:41:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F05EF1783
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628948544;
	bh=5EWHMqVQV4YfFSIJKaCPbxb6mCMse21Ru3AIML8AIAQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Lg6ky9TnwBCSUolSp4Hn64lxVKeCBTQt+idSp6YtqaFCDzerK1UAq9v4R++V8cev9
	 1T4vyuyQ/16im0teFawKqwtf8JsJFoYSqauTmT8HcZO8lK2hV2U8GiizEnZ8MhFgwv
	 eAdYjOs3orw7HUwmxnf4XN2GUrfpmygDpwYuOYZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 694E4F80245;
	Sat, 14 Aug 2021 15:41:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42708F8025D; Sat, 14 Aug 2021 15:41:27 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 2C711F80127
 for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2021 15:41:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C711F80127
X-IronPort-AV: E=Sophos;i="5.84,321,1620658800"; d="scan'208";a="90626665"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 14 Aug 2021 22:41:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.7])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7C01A4270487;
 Sat, 14 Aug 2021 22:41:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_dma_request function
Date: Sat, 14 Aug 2021 14:41:06 +0100
Message-Id: <20210814134106.14275-1-biju.das.jz@bp.renesas.com>
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

The rz_ssi_dma_request function only checks the NULL condition for
the value returned by the dma_request_chan function, but this function
can also return an error. If it happens, the subsequent function call to
rz_ssi_dma_slave_config can lead to a kernel crash.

This patch fixes the issue by checking both error and NULL condition
returned by dma_request_chan.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index ea8d33ede5d2..3867e2efd3e0 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -676,11 +676,19 @@ static void rz_ssi_release_dma_channels(struct rz_ssi_priv *ssi)
 static int rz_ssi_dma_request(struct rz_ssi_priv *ssi, struct device *dev)
 {
 	ssi->playback.dma_ch = dma_request_chan(dev, "tx");
+	if (IS_ERR_OR_NULL(ssi->playback.dma_ch))
+		ssi->playback.dma_ch = NULL;
+
 	ssi->capture.dma_ch = dma_request_chan(dev, "rx");
+	if (IS_ERR_OR_NULL(ssi->capture.dma_ch))
+		ssi->capture.dma_ch = NULL;
+
 	if (!ssi->playback.dma_ch && !ssi->capture.dma_ch) {
 		ssi->playback.dma_ch = dma_request_chan(dev, "rt");
-		if (!ssi->playback.dma_ch)
+		if (IS_ERR_OR_NULL(ssi->playback.dma_ch)) {
+			ssi->playback.dma_ch = NULL;
 			goto no_dma;
+		}
 
 		ssi->dma_rt = true;
 	}
-- 
2.17.1

