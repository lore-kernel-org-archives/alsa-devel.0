Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A692C4320A
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 08:44:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F8261154
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 08:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7F8261154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B78241679;
	Thu, 19 Aug 2021 10:43:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B78241679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629362657;
	bh=hnTi7qhS57uBrMK/moyB44/v/nBepvUWKt3Yc00n6tc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aq7LHmanrYXWQin/PKuo9Ia01M8TwZfl4b9KgaDJj0idGFK+VDfa2Yhv32wad2JBy
	 POF8DosV362hxfZjSFjlVyIOFV1DIJqeX0VSHB5XHsToO5f14l/qGEUyqRqaSIr51W
	 CjGoUXY9Q/9+KWKBRfM+qcK0mDEcXcg1osn+Esok=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2973BF804E3;
	Thu, 19 Aug 2021 10:43:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34275F804E3; Thu, 19 Aug 2021 10:43:25 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A0E0F800EC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 10:43:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A0E0F800EC
X-UUID: 761f0b9674654e2a9eec287ecd7e479e-20210819
X-UUID: 761f0b9674654e2a9eec287ecd7e479e-20210819
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 251282711; Thu, 19 Aug 2021 16:43:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Aug 2021 16:43:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 19 Aug 2021 16:43:08 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
 <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
Subject: [PATCH v5 01/11] ASoC: mediatek: mt8195: update mediatek common driver
Date: Thu, 19 Aug 2021 16:41:34 +0800
Message-ID: <20210819084144.18483-2-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210819084144.18483-1-trevor.wu@mediatek.com>
References: <20210819084144.18483-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 cychiang@google.com, bicycle.tsai@mediatek.com, linux-kernel@vger.kernel.org,
 jiaxin.yu@mediatek.com, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, wenst@chromium.org, aaronyu@google.com,
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

Update mediatek common driver to support MT8195

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 22 +++++++++++++++++++---
 sound/soc/mediatek/common/mtk-base-afe.h   | 10 ++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index 3cb2adf420bb..baaa5881b1d4 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -139,7 +139,7 @@ int mtk_afe_fe_hw_params(struct snd_pcm_substream *substream,
 		substream->runtime->dma_area,
 		substream->runtime->dma_bytes);
 
-	memset_io(substream->runtime->dma_area, 0,
+	memset_io((void __force __iomem *)substream->runtime->dma_area, 0,
 		  substream->runtime->dma_bytes);
 
 	/* set addr */
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

