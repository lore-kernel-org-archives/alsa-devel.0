Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD55C48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:51:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA074614A7
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA074614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A4A6166C;
	Tue, 15 Jun 2021 17:50:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A4A6166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623772271;
	bh=9Rc61qOEX4dCvbIso4TMKwr7VWeVpYgY8rXvC9B+Xtc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9loFQrH4OknbHAklvlexCk16vwuYFc0Ma0DaKy+3bnPeBT/huRYvjNQgu5HMxb6D
	 LD/+ki3M+yW7Q9Gh1JW5T9z6XFxp+dOT0adq3DA21OHDFQgISW2yCuAHmgPOBL9dHG
	 t1j/0CnBasMrhZjUNGR9nsxagoFY2+tTjrgxXIl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83EA4F804F2;
	Tue, 15 Jun 2021 17:48:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39529F804EB; Tue, 15 Jun 2021 17:48:52 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEB85F804E0
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 17:48:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEB85F804E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ew0hEf5c"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C2CC61626;
 Tue, 15 Jun 2021 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623772123;
 bh=9Rc61qOEX4dCvbIso4TMKwr7VWeVpYgY8rXvC9B+Xtc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ew0hEf5cK7Jq4mkv2UWeIdiIs2NCHtabM3ALT1mqUld1JY9hg0CF22xOLiggRIJy3
 KdoaBzSlKkY224QeBFys7NbrgnkxjOcWcWQ/KQAgsmVHUZZLzJ0FKHh6Y5+Tu0tL50
 Uj3eX+c6DveIrgD8VlT7A/OfM2hkzI5nbJdaNutEC0vLwjmADMSLuH29XvoG3GFKul
 ZALpG9NGUnBVZA2nKhRy0KyqvhlnkNDy73g2zYt7TkZ5VAOBEWldDgqe16XY3LL1zj
 W7UEtMQk9bukUZJMgBi1v65W1kCYLzpBBAgy+TiC3ECTJsIXYL3R9mMoJDrcFgx6Bm
 ZXAA9Pq7WB/mw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 15/33] ASoC: tas2562: Fix TDM_CFG0_SAMPRATE values
Date: Tue, 15 Jun 2021 11:48:06 -0400
Message-Id: <20210615154824.62044-15-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615154824.62044-1-sashal@kernel.org>
References: <20210615154824.62044-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, Richard Weinberger <richard@nod.at>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 8bef925e37bdc9b6554b85eda16ced9a8e3c135f ]

TAS2562_TDM_CFG0_SAMPRATE_MASK starts at bit 1, not 0.
So all values need to be left shifted by 1.

Signed-off-by: Richard Weinberger <richard@nod.at>
Link: https://lore.kernel.org/r/20210530203446.19022-1-richard@nod.at
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tas2562.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2562.h b/sound/soc/codecs/tas2562.h
index 81866aeb3fbf..55b2a1f52ca3 100644
--- a/sound/soc/codecs/tas2562.h
+++ b/sound/soc/codecs/tas2562.h
@@ -57,13 +57,13 @@
 #define TAS2562_TDM_CFG0_RAMPRATE_MASK		BIT(5)
 #define TAS2562_TDM_CFG0_RAMPRATE_44_1		BIT(5)
 #define TAS2562_TDM_CFG0_SAMPRATE_MASK		GENMASK(3, 1)
-#define TAS2562_TDM_CFG0_SAMPRATE_7305_8KHZ	0x0
-#define TAS2562_TDM_CFG0_SAMPRATE_14_7_16KHZ	0x1
-#define TAS2562_TDM_CFG0_SAMPRATE_22_05_24KHZ	0x2
-#define TAS2562_TDM_CFG0_SAMPRATE_29_4_32KHZ	0x3
-#define TAS2562_TDM_CFG0_SAMPRATE_44_1_48KHZ	0x4
-#define TAS2562_TDM_CFG0_SAMPRATE_88_2_96KHZ	0x5
-#define TAS2562_TDM_CFG0_SAMPRATE_176_4_192KHZ	0x6
+#define TAS2562_TDM_CFG0_SAMPRATE_7305_8KHZ	(0x0 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_14_7_16KHZ	(0x1 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_22_05_24KHZ	(0x2 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_29_4_32KHZ	(0x3 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_44_1_48KHZ	(0x4 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_88_2_96KHZ	(0x5 << 1)
+#define TAS2562_TDM_CFG0_SAMPRATE_176_4_192KHZ	(0x6 << 1)
 
 #define TAS2562_TDM_CFG2_RIGHT_JUSTIFY	BIT(6)
 
-- 
2.30.2

