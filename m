Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA12C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:42:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800BB227C3
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800BB227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B057B17E3;
	Mon, 18 Jan 2021 13:41:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B057B17E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610973742;
	bh=Z+5VCyGoDHyvsSOb37JRuPCcVY5rqQXMOeVO3QsO97c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eJdAD16gNV+CXQKTTvW7p3FTfRobwlD4PhvES060/B3yEkRcohG5ySsWvg8kPJK4G
	 Wx03YggPEKUQGPG58aCMVU0Gm0M9Q0lp/Tbzf0/frwl2TPJ2621S5r18FflH6TVzsI
	 iEwmKtR56lxWMEkMcl4sdk1BDMY8+L83DzkGwA+8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85CE1F804C2;
	Mon, 18 Jan 2021 13:40:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5566BF804C2; Mon, 18 Jan 2021 13:40:40 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A398AF804BD
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 13:40:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A398AF804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="DyO3/KlA"
Received: by mail-qk1-x72a.google.com with SMTP id d14so18418177qkc.13
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 04:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rJGQe5DLUCujhheGlYdjnKqoPtjInXeGbwGR6AhkBpc=;
 b=DyO3/KlA72FQJVvSGPoTkWxVcPqPgx+JP29jShdtRSWuu/m05ZslSwa/ZOQD0Uqhow
 XrMNWPpJQOetceWLdFJitUD4wm38FCQnTMvDchVt6XmLBsyFUeTD1gKRXZD2UAGpAdb5
 tJl3sIne9fBIH8nDTARYcZL6XxHL16pNr+Wwm4E5h06MEmHI2H4mqAXC1K26zfOW/nOj
 CV7JgYDysNV0zIq0EwxdRV1yIUP0AM5BgsHwt6x1ik5rfEQc7jeE/xEgpX6yZ+6FDQUv
 S2v9sH9qu5jDDIFEiXN/nfsOM49LoFLJNumjY12wahyHAV+kt5vpRL6c7pv0ZDuxdgp8
 kDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rJGQe5DLUCujhheGlYdjnKqoPtjInXeGbwGR6AhkBpc=;
 b=uoIzeCqlSsJqbweYH/81aUk7B/dVJBBjU+r5eDrWTHzB043Yc+SJcxzF1dJVHKlHmx
 Kxc01+giMUJnI6EUfneGir5v+VPrT74X5vFYXGUJFR3lwPM0beP92kKR5KZ/2x+lCHll
 yCKeja6VlbBUC9kExNfdMGHwe15XH6Gw78yjGk6cCs7ZxS7WNY8Lt+nKfzuwSU4TLsaI
 hIBRphxNf7i7eqTq/7CTTnFgR9zknxz4MI54DRreRmZJ9dXD7Knr1kgns+VTKWPRHqBs
 U+0xdkkzY8MhNO9yI3bvHLIcCH2xfB4aZoy6/gZL2hCtSag41a927FiZ9C31xCxsNyjl
 MhdA==
X-Gm-Message-State: AOAM531a4yx9lKahsWrai8kXHWT4KvgwX3rn6qmBREOWEC59PGedL1T/
 EpN4Ka6o0l3ECm9Dn+QIDHo=
X-Google-Smtp-Source: ABdhPJxv3vOdtq+qd+sfmcMcusl9eGeyuVlFf+I2b6pMJt9n+nQN6DgnS1hd+kQqJIr3bkFHui5Sdg==
X-Received: by 2002:ae9:c013:: with SMTP id u19mr23823029qkk.59.1610973631191; 
 Mon, 18 Jan 2021 04:40:31 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
 by smtp.gmail.com with ESMTPSA id q92sm10022654qtd.48.2021.01.18.04.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 04:40:30 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 3/6] ASoC: fsl_xcvr: Remove unused of_id variable
Date: Mon, 18 Jan 2021 09:38:12 -0300
Message-Id: <20210118123815.1630882-3-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118123815.1630882-1-festevam@gmail.com>
References: <20210118123815.1630882-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 Fabio Estevam <festevam@gmail.com>, shengjiu.wang@nxp.com, timur@kernel.org
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

The of_id variable is not used, so just remove it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 sound/soc/fsl/fsl_xcvr.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 3d58c88ea603..dd228b421e2c 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1130,16 +1130,11 @@ MODULE_DEVICE_TABLE(of, fsl_xcvr_dt_ids);
 static int fsl_xcvr_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	struct fsl_xcvr *xcvr;
 	struct resource *ram_res, *regs_res, *rx_res, *tx_res;
 	void __iomem *regs;
 	int ret, irq;
 
-	of_id = of_match_device(fsl_xcvr_dt_ids, dev);
-	if (!of_id)
-		return -EINVAL;
-
 	xcvr = devm_kzalloc(dev, sizeof(*xcvr), GFP_KERNEL);
 	if (!xcvr)
 		return -ENOMEM;
-- 
2.17.1

