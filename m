Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F23C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 02:28:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E26E64F90
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 02:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E26E64F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93D35828;
	Fri, 12 Mar 2021 03:27:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93D35828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615516076;
	bh=N4JrrhiwF3cSklCJGNHf293DtIuJXxBbsDskYn0Cwr4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IqN9hXu7KYFN6NZDKbzGFnpm6kN1dDsKxWGudiardXo+VSgE7yZGeC0aCpSQ2/HFe
	 uI37DbnmLpdWStFIhumjyNKpIGRZ92nsgbNTJE+joHkhEzj+fz43i7ox6curxXGW98
	 XNfF35At9VmUSD+09tg0ZIIhM41yZW+tn5LtV0xM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 091F2F8012A;
	Fri, 12 Mar 2021 03:27:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF104F801D8; Fri, 12 Mar 2021 03:27:01 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa1.perex.cz (Postfix) with ESMTP id B1678F8012A
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 03:26:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1678F8012A
X-UUID: 3b2e1080fb164915960c585295b6b8a1-20210312
X-UUID: 3b2e1080fb164915960c585295b6b8a1-20210312
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw01.mediatek.com (envelope-from <jiaxin.yu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 921633192; Fri, 12 Mar 2021 10:26:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Mar 2021 10:26:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Mar 2021 10:26:47 +0800
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
To: <tzungbi@google.com>, <broonie@kernel.org>, <matthias.bgg@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: mediatek: mt8192: fix tdm out data is valid on rising
 edge
Date: Fri, 12 Mar 2021 10:26:45 +0800
Message-ID: <1615516005-781-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: shane.chien@mediatek.com, Trevor.Wu@mediatek.com,
 Jiaxin Yu <jiaxin.yu@mediatek.com>
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

This patch correct tdm out bck inverse register to AUDIO_TOP_CON3[3].

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c | 4 +++-
 sound/soc/mediatek/mt8192/mt8192-reg.h     | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
index f5de1d769679..f3bebed2428a 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
@@ -555,7 +555,9 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 
 	/* set tdm */
 	if (tdm_priv->bck_invert)
-		tdm_con |= 1 << BCK_INVERSE_SFT;
+		regmap_update_bits(afe->regmap, AUDIO_TOP_CON3,
+				   BCK_INVERSE_MASK_SFT,
+				   0x1 << BCK_INVERSE_SFT);
 
 	if (tdm_priv->lck_invert)
 		tdm_con |= 1 << LRCK_INVERSE_SFT;
diff --git a/sound/soc/mediatek/mt8192/mt8192-reg.h b/sound/soc/mediatek/mt8192/mt8192-reg.h
index 562f25c79c34..b9fb80d4afec 100644
--- a/sound/soc/mediatek/mt8192/mt8192-reg.h
+++ b/sound/soc/mediatek/mt8192/mt8192-reg.h
@@ -21,6 +21,11 @@ enum {
 /*****************************************************************************
  *                  R E G I S T E R       D E F I N I T I O N
  *****************************************************************************/
+/* AUDIO_TOP_CON3 */
+#define BCK_INVERSE_SFT                              3
+#define BCK_INVERSE_MASK                             0x1
+#define BCK_INVERSE_MASK_SFT                         (0x1 << 3)
+
 /* AFE_DAC_CON0 */
 #define VUL12_ON_SFT                                   31
 #define VUL12_ON_MASK                                  0x1
@@ -2079,9 +2084,6 @@ enum {
 #define TDM_EN_SFT                                     0
 #define TDM_EN_MASK                                    0x1
 #define TDM_EN_MASK_SFT                                (0x1 << 0)
-#define BCK_INVERSE_SFT                                1
-#define BCK_INVERSE_MASK                               0x1
-#define BCK_INVERSE_MASK_SFT                           (0x1 << 1)
 #define LRCK_INVERSE_SFT                               2
 #define LRCK_INVERSE_MASK                              0x1
 #define LRCK_INVERSE_MASK_SFT                          (0x1 << 2)
-- 
2.18.0

