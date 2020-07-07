Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0A1C433E1
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:31:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A11320708
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j2RCASgC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCYSjXuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A11320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED8451607;
	Tue,  7 Jul 2020 12:30:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED8451607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594117883;
	bh=lfh9aVj1QHY1BY8teu2SpBfyyRekdAW4yjmlTHRQhBw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j2RCASgCV8pT5UToUlEDsVlexyO5bc7eS6kApwf4u4X1OBkAXnZEC8E0B7vgsv9gX
	 7SVEUh5Nv8ymALtyVTQhAQLisHUECRYyMquhWTzeo+zEsY0kQ0Bpe4BlGY7kk3/AWT
	 e9gy7LDn7TdUI+wUmZ6bQ0Z5vYtWniCTaUbT/sCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 886DDF80391;
	Tue,  7 Jul 2020 12:17:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9771CF80343; Tue,  7 Jul 2020 12:17:37 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D391FF80316
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:17:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D391FF80316
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="tCYSjXuU"
Received: by mail-wm1-x343.google.com with SMTP id f18so45915437wml.3
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 03:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d7oRUP6HHmbAXMILeJrpZWaXkV9JssFtTdyZGy/6dhk=;
 b=tCYSjXuURlwgjreX0Ebq0a2Q23GCLXJ9ADPRqI9ys1VeUMctC69cJNaP8QTx38oG4/
 G/CvUacR2s5NWT9H85WTs8wjAHTeI5sYNvDO2tOx2a9ohVWrbgNr/YRR7NbYflcn8iJB
 1nDzhvSjUAeyDQ8WX00jokbXUyChwf4iVxhdJ+fX5iKVekqBwr1tUYhe99XCtpLHkWNt
 j/7sOrH2fBcl0o//lBbkhztFByYhe1pPAp1fvuolQFS3bbFLWD6OQWrOFV3qoOn8EmIJ
 eOenFNQIFMj2OchrK0q//ZaAftRPDArUIUH/zS8ZIdH5x5KzGeqSV0ezQmk0uAnHMHv9
 4Uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d7oRUP6HHmbAXMILeJrpZWaXkV9JssFtTdyZGy/6dhk=;
 b=SF77xuLIgufUEm7y9DLVPKzGOk6Mya+wv0dGie0ZX7s9Wq3ixdkhyB8qgLRwNsp1YC
 Md+8s/81lM426wgc3rFuw6wSpyBTmZyPhRFKREzKY1qSUBSWiD0p71wSUKtusuZJGKcE
 mya3f5bOubQvgnOAOY4K/Jhq7eRWgWaQW7NSXKANoPkSp6hv6G/uM9+//HqlUdtFXDkv
 D0TVUBzw8GrmpoTt92YyTpC5NakaoP1hoBnk8nKb7eyeZsoyLWub1dsgXiKX0MLFgvek
 5ssVOnzprbI8qbuUtjGwO3Bbf6XNl08HBB8VrjcUIEba8AvD2kHumc9huy6GdASdSirM
 2o5g==
X-Gm-Message-State: AOAM530KqVyZM0P+OFreTGrvbMTZL6K1XBlEXJN9ICJvmdVTWs5qD0Wg
 UuuMWw9SnHyuD+0Lu378KvDKIQ==
X-Google-Smtp-Source: ABdhPJx2P1TjQfKulF9kQvC3Rl1oKv0T6tweHznyPHPtYx+jkOMqb0z4kGRg8v3Or+e4ue4AewQEsA==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr3391563wmj.136.1594117031692; 
 Tue, 07 Jul 2020 03:17:11 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:17:10 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH 19/28] ASoC: ux500: ux500_msp_i2s: Remove unused variables
 'reg_val_DR' and 'reg_val_TSTDR'
Date: Tue,  7 Jul 2020 11:16:33 +0100
Message-Id: <20200707101642.1747944-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org,
 Roger Nilsson <roger.xr.nilsson@stericsson.com>,
 Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
 Sandeep Kaushik <sandeep.kaushik@st.com>, zhong jiang <zhongjiang@huawei.com>,
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

Looks like these have been unchecked since the driver's inception in 2012.

Fixes the following W=1 kernel build warning(s):

 sound/soc/ux500/ux500_msp_i2s.c: In function ‘flush_fifo_rx’:
 sound/soc/ux500/ux500_msp_i2s.c:398:6: warning: variable ‘reg_val_DR’ set but not used [-Wunused-but-set-variable]
 sound/soc/ux500/ux500_msp_i2s.c: In function ‘flush_fifo_tx’:
 sound/soc/ux500/ux500_msp_i2s.c:415:6: warning: variable ‘reg_val_TSTDR’ set but not used [-Wunused-but-set-variable]

Cc: zhong jiang <zhongjiang@huawei.com>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: Roger Nilsson <roger.xr.nilsson@stericsson.com>
Cc: Sandeep Kaushik <sandeep.kaushik@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_msp_i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index 394d8b2a4a161..fd0b88bb79212 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -395,7 +395,7 @@ static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
 
 static void flush_fifo_rx(struct ux500_msp *msp)
 {
-	u32 reg_val_DR, reg_val_GCR, reg_val_FLR;
+	u32 reg_val_GCR, reg_val_FLR;
 	u32 limit = 32;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -403,7 +403,7 @@ static void flush_fifo_rx(struct ux500_msp *msp)
 
 	reg_val_FLR = readl(msp->registers + MSP_FLR);
 	while (!(reg_val_FLR & RX_FIFO_EMPTY) && limit--) {
-		reg_val_DR = readl(msp->registers + MSP_DR);
+		readl(msp->registers + MSP_DR);
 		reg_val_FLR = readl(msp->registers + MSP_FLR);
 	}
 
@@ -412,7 +412,7 @@ static void flush_fifo_rx(struct ux500_msp *msp)
 
 static void flush_fifo_tx(struct ux500_msp *msp)
 {
-	u32 reg_val_TSTDR, reg_val_GCR, reg_val_FLR;
+	u32 reg_val_GCR, reg_val_FLR;
 	u32 limit = 32;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
@@ -421,7 +421,7 @@ static void flush_fifo_tx(struct ux500_msp *msp)
 
 	reg_val_FLR = readl(msp->registers + MSP_FLR);
 	while (!(reg_val_FLR & TX_FIFO_EMPTY) && limit--) {
-		reg_val_TSTDR = readl(msp->registers + MSP_TSTDR);
+		readl(msp->registers + MSP_TSTDR);
 		reg_val_FLR = readl(msp->registers + MSP_FLR);
 	}
 	writel(0x0, msp->registers + MSP_ITCR);
-- 
2.25.1

