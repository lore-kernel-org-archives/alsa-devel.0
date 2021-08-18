Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A63C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 10:16:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B9860F35
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 10:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69B9860F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23256166E;
	Wed, 18 Aug 2021 12:15:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23256166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629281764;
	bh=0M+yI1SdLihuaQ5BCtUcLSjJP76Le/uhgikfvFZZ+s4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m6kzy4JQFLCYsOTNpsxTXxR4a7FBc8UV6WLIKgMj1/hw20gKHQOFSlxtMSbECODSJ
	 3YssiE4HjF2XUTZac3pSiS/RzTkphNUz/37MW76ylPTysy4xfhcJlTUIgTOTF3sm8F
	 LnKpp4NI67eqoruQTeShxckDCA8jEASeg9Fxb0m0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD406F80169;
	Wed, 18 Aug 2021 12:15:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED761F80249; Wed, 18 Aug 2021 12:15:11 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 01CFCF80169
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 12:15:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01CFCF80169
X-IronPort-AV: E=Sophos;i="5.84,330,1620658800"; d="scan'208";a="91022020"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 18 Aug 2021 19:14:56 +0900
Received: from localhost.localdomain (unknown [10.226.93.61])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3B5D1400F783;
 Wed, 18 Aug 2021 19:14:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v3] ASoC: sh: rz-ssi: Improve error handling in
 rz_ssi_dma_request function
Date: Wed, 18 Aug 2021 11:14:50 +0100
Message-Id: <20210818101450.15948-1-biju.das.jz@bp.renesas.com>
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

dma_request_chan() returns error pointer in case of failures, but
the rz_ssi_dma_request() checked for NULL pointer instead.

This patch fixes the issue by checking for ERR_PTR() instead of
NULL and sets the DMA pointers to NULL in error case so that ssi
can fallback to PIO mode.

Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
 * Added Fixes tag
 * For SSI with with full-duplex transmission and reception, 
   Add support for fallback to PIO mode, if both channels are
   not available.

v1->v2:
 * Replaced IS_ERR_OR_NULL with IS_ERR for error pointer check, as the
   dma_request_chan function never returns NULL pointer for error case.
---
 sound/soc/sh/rz-ssi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index f097c773d413..fa0cc08f70ec 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -185,7 +185,7 @@ rz_ssi_stream_get(struct rz_ssi_priv *ssi, struct snd_pcm_substream *substream)
 
 static inline bool rz_ssi_is_dma_enabled(struct rz_ssi_priv *ssi)
 {
-	return (ssi->playback.dma_ch || ssi->capture.dma_ch);
+	return (ssi->playback.dma_ch && (ssi->dma_rt || ssi->capture.dma_ch));
 }
 
 static int rz_ssi_stream_is_valid(struct rz_ssi_priv *ssi,
@@ -676,15 +676,26 @@ static void rz_ssi_release_dma_channels(struct rz_ssi_priv *ssi)
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
 
+	if (!rz_ssi_is_dma_enabled(ssi))
+		goto no_dma;
+
 	if (ssi->playback.dma_ch &&
 	    (rz_ssi_dma_slave_config(ssi, ssi->playback.dma_ch, true) < 0))
 		goto no_dma;
-- 
2.17.1

