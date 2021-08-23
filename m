Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40382C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 10:57:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BDD61186
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 10:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57BDD61186
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CFE2F1677;
	Mon, 23 Aug 2021 12:56:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CFE2F1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629716250;
	bh=YRTd6krr8RQ+NyDwXHRRo0tJId+rbFXN2ybOtyD9aHA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iTp8gZhuytJc6Sf36OdEZHY/LdEE0UzpyQU4zon78KwmYZ5JocVXt1q44orUb9gHO
	 GlJSrqsz/Uie/2uhK3Cz+jP2F1KWmxpr1/wm8IzMw3SGwThBSQBVcxt11IR1gymCSN
	 2/tvcp1MZBCKMMzN8kynk/TNyor/vKTOQ6JqwfwI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E53CF80517;
	Mon, 23 Aug 2021 12:55:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69A52F80424; Mon, 23 Aug 2021 12:54:55 +0200 (CEST)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.132])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6839BF80240
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 12:54:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6839BF80240
Received: from localhost (unknown [192.168.167.225])
 by lucky1.263xmail.com (Postfix) with ESMTP id 1E70EFB689;
 Mon, 23 Aug 2021 18:54:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P10596T140297356953344S1629716077595046_; 
 Mon, 23 Aug 2021 18:54:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7521e69a4dbeb53b84cf502e8c7b8d39>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 6
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: Sugar Zhang <sugar.zhang@rock-chips.com>
To: broonie@kernel.org,
	heiko@sntech.de
Subject: [PATCH 13/15] ASoC: rockchip: i2s: Add support for frame inversion
Date: Mon, 23 Aug 2021 18:54:34 +0800
Message-Id: <1629716076-21465-4-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>,
 linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org
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

This patch adds support for frame inversion.

Change-Id: Ic77122501224cec45200ae64416745a82fb67d76
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 20 +++++++++++++++++---
 sound/soc/rockchip/rockchip_i2s.h | 10 ++++++----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index a0f2778..6ccb62e 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -233,13 +233,27 @@ static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 
 	regmap_update_bits(i2s->regmap, I2S_CKR, mask, val);
 
-	mask = I2S_CKR_CKP_MASK;
+	mask = I2S_CKR_CKP_MASK | I2S_CKR_TLP_MASK | I2S_CKR_RLP_MASK;
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
-		val = I2S_CKR_CKP_NEG;
+		val = I2S_CKR_CKP_NORMAL |
+		      I2S_CKR_TLP_NORMAL |
+		      I2S_CKR_RLP_NORMAL;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		val = I2S_CKR_CKP_NORMAL |
+		      I2S_CKR_TLP_INVERTED |
+		      I2S_CKR_RLP_INVERTED;
 		break;
 	case SND_SOC_DAIFMT_IB_NF:
-		val = I2S_CKR_CKP_POS;
+		val = I2S_CKR_CKP_INVERTED |
+		      I2S_CKR_TLP_NORMAL |
+		      I2S_CKR_RLP_NORMAL;
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		val = I2S_CKR_CKP_INVERTED |
+		      I2S_CKR_TLP_INVERTED |
+		      I2S_CKR_RLP_INVERTED;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/sound/soc/rockchip/rockchip_i2s.h b/sound/soc/rockchip/rockchip_i2s.h
index fcaae24..251851b 100644
--- a/sound/soc/rockchip/rockchip_i2s.h
+++ b/sound/soc/rockchip/rockchip_i2s.h
@@ -88,15 +88,17 @@
 #define I2S_CKR_MSS_SLAVE	(1 << I2S_CKR_MSS_SHIFT)
 #define I2S_CKR_MSS_MASK	(1 << I2S_CKR_MSS_SHIFT)
 #define I2S_CKR_CKP_SHIFT	26
-#define I2S_CKR_CKP_NEG		(0 << I2S_CKR_CKP_SHIFT)
-#define I2S_CKR_CKP_POS		(1 << I2S_CKR_CKP_SHIFT)
+#define I2S_CKR_CKP_NORMAL	(0 << I2S_CKR_CKP_SHIFT)
+#define I2S_CKR_CKP_INVERTED	(1 << I2S_CKR_CKP_SHIFT)
 #define I2S_CKR_CKP_MASK	(1 << I2S_CKR_CKP_SHIFT)
 #define I2S_CKR_RLP_SHIFT	25
 #define I2S_CKR_RLP_NORMAL	(0 << I2S_CKR_RLP_SHIFT)
-#define I2S_CKR_RLP_OPPSITE	(1 << I2S_CKR_RLP_SHIFT)
+#define I2S_CKR_RLP_INVERTED	(1 << I2S_CKR_RLP_SHIFT)
+#define I2S_CKR_RLP_MASK	(1 << I2S_CKR_RLP_SHIFT)
 #define I2S_CKR_TLP_SHIFT	24
 #define I2S_CKR_TLP_NORMAL	(0 << I2S_CKR_TLP_SHIFT)
-#define I2S_CKR_TLP_OPPSITE	(1 << I2S_CKR_TLP_SHIFT)
+#define I2S_CKR_TLP_INVERTED	(1 << I2S_CKR_TLP_SHIFT)
+#define I2S_CKR_TLP_MASK	(1 << I2S_CKR_TLP_SHIFT)
 #define I2S_CKR_MDIV_SHIFT	16
 #define I2S_CKR_MDIV(x)		((x - 1) << I2S_CKR_MDIV_SHIFT)
 #define I2S_CKR_MDIV_MASK	(0xff << I2S_CKR_MDIV_SHIFT)
-- 
2.7.4



