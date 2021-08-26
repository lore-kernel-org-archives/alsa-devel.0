Return-Path: <SRS0=0cRQ=NR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746E5C432BE
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 11:27:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711B8610C7
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 11:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 711B8610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDEC11698;
	Thu, 26 Aug 2021 13:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDEC11698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629977248;
	bh=Tuyi4wryxOlEBGyFKeELeB4lyOe+7sJSwiGZGNr6X7M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TQ1gYcRaYG/+NBwVKoVfktGsweWDlBBGZtuKH0CSi0yXX1A3M40Iys1zCzwTfxAh0
	 rs9+ryi5kKmn+bOci13KKBF7V0NC/HzETpze0U7HQwDn/fScFGQYc4o50uie42A+k5
	 Rar4Dv2cu7TAiolEopLREIVUhMZuoa8Huxw2GybY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6EFCAF80054;
	Thu, 26 Aug 2021 13:26:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F19D8F8013F; Thu, 26 Aug 2021 13:26:37 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8A184F8013F
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 13:26:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A184F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="Y3YjSEgv"
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D9AA03F044; 
 Thu, 26 Aug 2021 11:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1629977171;
 bh=BOfv1mWZucvdeO+2RiG1GUgsxmx8e5VDjoBIMqK5l0s=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=Y3YjSEgvmcKuAagE7kzuOI8dH/Zix7iP2PU0sh6qgONNmsEdBJY0lJmJo8iNaY527
 nJJ4FHc0piCHPZBSJLbOkBLg4/AkeOwHhvH/wULTDCxudSlTPZGx2OyeZKjp3pmSP9
 bwjmTfXDCZZfz0+rxshp0Ek9M6P9LiDJXq9TtFjb4BKvvMrmi51PDGtzVYTMwpgkww
 q5FMPrpFVndd79wZl9bX/Yq+oJNNV5YfxAl+7A7yoBzFqc+pjcmKKyKb/OP1CILvDT
 wSow8pCjCiDmZRNBOdweVr63wcw+JPri8f25906su2+9l71kBVNbQJJskxWBWxSd1F
 2XNXn4B36Qd9g==
From: Colin King <colin.king@canonical.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, alsa-devel@alsa-project.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH][next] ASoC: mediatek: mt8195: Fix spelling mistake "bitwiedh"
 -> "bitwidth"
Date: Thu, 26 Aug 2021 12:26:11 +0100
Message-Id: <20210826112611.10356-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_dbg message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/mediatek/mt8195/mt8195-dai-etdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
index bd9876cf02c8..7378e42f2766 100644
--- a/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
+++ b/sound/soc/mediatek/mt8195/mt8195-dai-etdm.c
@@ -1909,7 +1909,7 @@ static int mtk_dai_etdm_configure(struct mtk_base_afe *afe,
 		__func__, etdm_data->format, etdm_data->data_mode,
 		etdm_data->lrck_inv, etdm_data->lrck_width, etdm_data->bck_inv,
 		etdm_data->clock_mode, etdm_data->slave_mode);
-	dev_dbg(afe->dev, "%s rate %u channels %u bitwiedh %u, id %d\n",
+	dev_dbg(afe->dev, "%s rate %u channels %u bitwidth %u, id %d\n",
 		__func__, rate, channels, bit_width, dai_id);
 
 	etdm_channels = (etdm_data->data_mode == MTK_DAI_ETDM_DATA_ONE_PIN) ?
-- 
2.32.0

