Return-Path: <SRS0=5I5Q=XH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDF3C5ACAE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:57:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674AF206A5
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ki6PCYP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674AF206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C0D61730;
	Thu, 12 Sep 2019 11:56:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C0D61730
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568282269;
	bh=PF0tgVqXRw5MbQjc2iueLo21KoxmaBzAzWzSBOUdcZg=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ki6PCYP8MGEMCT9qmPBv7qEYSUUPGYN4HL0z/OX3wv84P6d6SyTJdw7UayZMpXxgV
	 Comuag8IIf3GEL2SIAlsb46cDvuGprMLTQr7dkcaHrFCnWkQWk4R7jGTc+WK7vnSta
	 vLXR+Uz940jC9gO1FH3vSzV6dSePG1lKFjr9YebM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C610F805A0;
	Thu, 12 Sep 2019 11:55:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2447AF80444; Thu, 12 Sep 2019 11:55:18 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa1.perex.cz (Postfix) with ESMTP id AB137F80368
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2019 11:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB137F80368
X-UUID: 6653e603bf49491a8d405c8204bee09d-20190912
X-UUID: 6653e603bf49491a8d405c8204bee09d-20190912
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1463196714; Thu, 12 Sep 2019 17:55:05 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Sep 2019 17:55:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Sep 2019 17:55:03 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <broonie@kernel.org>, <robh+dt@kernel.org>
Date: Thu, 12 Sep 2019 17:54:56 +0800
Message-ID: <1568282096-13821-3-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1568282096-13821-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1568282096-13821-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jiaxin.yu@mediatek.com,
 tzungbi@google.com, linux-mediatek@lists.infradead.org, eason.yen@mediatek.com
Subject: [alsa-devel] [PATCH 2/2] ASoC: mt8183: fix audio playback slowly
	after playback during bootup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Before regmap_reinit_cache we must reset audio reg as default value.
So we use reset controller unit(toprgu) to reset audio hw.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/common/mtk-base-afe.h   |  1 +
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 21 +++++++++++++++++++++
 sound/soc/mediatek/mt8183/mt8183-reg.h     |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index 60cb609a9790..bccc079ee660 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -60,6 +60,7 @@ struct mtk_base_afe {
 	void __iomem *base_addr;
 	struct device *dev;
 	struct regmap *regmap;
+	struct regmap *toprgu_regmap;
 	struct mutex irq_alloc_lock; /* dynamic alloc irq lock */
 
 	unsigned int const *reg_back_up_list;
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 4a31106d3471..0e5634b3a8e3 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1089,6 +1089,7 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	struct mtk_base_afe *afe;
 	struct mt8183_afe_private *afe_priv;
 	struct device *dev;
+	unsigned int reg_value;
 	int i, irq_id, ret;
 
 	afe = devm_kzalloc(&pdev->dev, sizeof(*afe), GFP_KERNEL);
@@ -1126,6 +1127,26 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* toprgu_regmap init */
+	afe->toprgu_regmap = syscon_regmap_lookup_by_phandle(dev->of_node,
+							     "mediatek,toprgu");
+	if (IS_ERR(afe->toprgu_regmap)) {
+		dev_err(dev, "could not get toprgu_regmap from dev\n");
+		return PTR_ERR(afe->toprgu_regmap);
+	}
+
+	/* read TOPRGUWDT_SWSYSRST, the high 8bits must be zero */
+	regmap_read(afe->toprgu_regmap, TOPRGUWDT_SWSYSRST, &reg_value);
+
+	/* write TOPRGUWDT_SWSYSRST, we need set high 8bits as 0x88 first */
+	reg_value |= 0x88000000;
+
+	/* reset audio domain registers */
+	reg_value |= 1 << AUDIO_RST_SFT;
+	regmap_write(afe->toprgu_regmap, TOPRGUWDT_SWSYSRST, reg_value);
+	reg_value &= ~(1 << AUDIO_RST_SFT);
+	regmap_write(afe->toprgu_regmap, TOPRGUWDT_SWSYSRST, reg_value);
+
 	/* enable clock for regcache get default value from hw */
 	afe_priv->pm_runtime_bypass_reg_ctl = true;
 	pm_runtime_get_sync(&pdev->dev);
diff --git a/sound/soc/mediatek/mt8183/mt8183-reg.h b/sound/soc/mediatek/mt8183/mt8183-reg.h
index e544a09e1913..8579ac4052ff 100644
--- a/sound/soc/mediatek/mt8183/mt8183-reg.h
+++ b/sound/soc/mediatek/mt8183/mt8183-reg.h
@@ -413,6 +413,12 @@
 #define AFE_MAX_REGISTER AFE_GENERAL2_ASRC_2CH_CON13
 #define AFE_IRQ_STATUS_BITS 0x1fff
 
+/* TOPRGUWDT_SWSYSRST */
+#define TOPRGUWDT_SWSYSRST 0x18
+#define AUDIO_RST_SFT                                17
+#define AUDIO_RST_MASK                               0x1
+#define AUDIO_RST_MASK_SFT                           (0x1 << 17)
+
 /* AUDIO_TOP_CON3 */
 #define BCK_INVERSE_SFT                              3
 #define BCK_INVERSE_MASK                             0x1
-- 
2.18.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
