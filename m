Return-Path: <SRS0=NYZN=LL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18FAC2B9F4
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:42:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528F3610A1
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Jun 2021 14:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528F3610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D70E21732;
	Thu, 17 Jun 2021 16:41:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D70E21732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623940920;
	bh=FxJZemVhv0PT7ZQGokgm80bu9ahUZkSiU/zOZWs87eM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aH25+kv+Szm2zo97K0/QePicEQg77w0EMPcmNsbX5dvH7qaGCNGGenDoh7P0DZacY
	 1Lx/w3YXqnCXMd+veFcffiM98y1TMdjaOm2Xx1OG2uN8ckLoygjbB0lHpXNnTmmJWM
	 naZ0jgakSL7Ix5k71KJcQ/7mQAxZX17lfO3IkDEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F18ACF80539;
	Thu, 17 Jun 2021 16:35:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E3E45F8049E; Thu, 17 Jun 2021 07:48:49 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D84BBF80088
 for <alsa-devel@alsa-project.org>; Thu, 17 Jun 2021 07:48:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D84BBF80088
X-UUID: 46e6c695761741f19e72e456a70f6893-20210617
X-UUID: 46e6c695761741f19e72e456a70f6893-20210617
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 358933624; Thu, 17 Jun 2021 13:48:34 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Jun 2021 13:48:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 17 Jun 2021 13:48:32 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <matthias.bgg@gmail.com>
Subject: [PATCH 1/8] ASoC: mediatek: mt8195: update mediatek common driver
Date: Thu, 17 Jun 2021 13:47:32 +0800
Message-ID: <20210617054740.8081-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210617054740.8081-1-trevor.wu@mediatek.com>
References: <20210617054740.8081-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-Mailman-Approved-At: Thu, 17 Jun 2021 16:34:46 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, bicycle.tsai@mediatek.com, linux-kernel@vger.kernel.org,
 jiaxin.yu@mediatek.com, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, linux-arm-kernel@lists.infradead.org
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

Update mediatek common driver to support MT8195

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 20 ++++++++++++++++++--
 sound/soc/mediatek/common/mtk-base-afe.h   | 10 ++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index 3cb2adf420bb..cdede0172534 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -433,11 +433,20 @@ int mtk_memif_set_addr(struct mtk_base_afe *afe, int id,
 				 phys_buf_addr_upper_32);
 	}
 
-	/* set MSB to 33-bit */
-	if (memif->data->msb_reg >= 0)
+	/*
+	 * set MSB to 33-bit, for memif address
+	 * only for memif base address, if msb_end_reg exists
+	 */
+	if (memif->data->msb_reg)
 		mtk_regmap_update_bits(afe->regmap, memif->data->msb_reg,
 				       1, msb_at_bit33, memif->data->msb_shift);
 
+	/* set MSB to 33-bit, for memif end address */
+	if (memif->data->msb_end_reg)
+		mtk_regmap_update_bits(afe->regmap, memif->data->msb_end_reg,
+				       1, msb_at_bit33,
+				       memif->data->msb_end_shift);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_memif_set_addr);
@@ -464,6 +473,13 @@ int mtk_memif_set_channel(struct mtk_base_afe *afe,
 	else
 		mono = (channel == 1) ? 1 : 0;
 
+	/* for specific configuration of memif mono mode */
+	if (memif->data->int_odd_flag_reg)
+		mtk_regmap_update_bits(afe->regmap,
+				       memif->data->int_odd_flag_reg,
+				       1, mono,
+				       memif->data->int_odd_flag_shift);
+
 	return mtk_regmap_update_bits(afe->regmap, memif->data->mono_reg,
 				      1, mono, memif->data->mono_shift);
 }
diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index a6f68c68581c..ef83e78c22a8 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -29,6 +29,8 @@ struct mtk_base_memif_data {
 	int quad_ch_reg;
 	int quad_ch_mask;
 	int quad_ch_shift;
+	int int_odd_flag_reg;
+	int int_odd_flag_shift;
 	int enable_reg;
 	int enable_shift;
 	int hd_reg;
@@ -37,10 +39,13 @@ struct mtk_base_memif_data {
 	int hd_align_mshift;
 	int msb_reg;
 	int msb_shift;
-	int msb2_reg;
-	int msb2_shift;
+	int msb_end_reg;
+	int msb_end_shift;
 	int agent_disable_reg;
 	int agent_disable_shift;
+	int ch_num_reg;
+	int ch_num_shift;
+	int ch_num_maskbit;
 	/* playback memif only */
 	int pbuf_reg;
 	int pbuf_mask;
@@ -62,6 +67,7 @@ struct mtk_base_irq_data {
 	int irq_en_shift;
 	int irq_clr_reg;
 	int irq_clr_shift;
+	int irq_status_shift;
 };
 
 struct device;
-- 
2.18.0

