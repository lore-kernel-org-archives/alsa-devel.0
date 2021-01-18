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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04749C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:43:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C85D2253A
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C85D2253A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5BA01827;
	Mon, 18 Jan 2021 13:42:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5BA01827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610973793;
	bh=HRAQunMgu/h1mJX5ZUHMI+tQCqYcLBGGel7sOgstwsY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qApgumMcBC2TSsVRJmKz9q4jAfT1NrWauxG8nKfhJbCdEOxm6GM+JvZckTHhmou1B
	 v2GWCOa5LjuydPm1iuC3PWJRE4n7AGhiax93KkAmPDultDmCuCk2noflf2h79y0txz
	 KRWH1fd263hm6Hz3A5Hzw/inZdVRwHOWdifgYl24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 784A0F804DF;
	Mon, 18 Jan 2021 13:40:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9061CF804DF; Mon, 18 Jan 2021 13:40:45 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22E62F8026B
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 13:40:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22E62F8026B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hR6f8o1+"
Received: by mail-qv1-xf2c.google.com with SMTP id az16so7390693qvb.5
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 04:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s9kZrXrP1ftv/2VBylHEr0nu+FeRKJe/CjWJntpZsFQ=;
 b=hR6f8o1+pjF9o91tgZE3uunTsyOV/4JH4qynXQO1KxwfpEoFc5pQyVaAgB0aRHXbyj
 cnsiy1YvLnc27humvTCcgy1FxqrutjRgsfXc7eD0GjPGAzpuw80id0AjgkzbYvLdIWVJ
 /nHYDlSeAlMcEOZq/b0UkX2zqEsjLXhXW8gdnbAyOHtmw3jEPix40sKqCQ1sPZ2p5yiC
 sbN8gHI1rsbnfUEDDBXJ2SDmyVNOBdaQ0tyOkgU2dD26vAVe+DgqchQ7Xz3/GpdEraYy
 1nqffEeHQHSeyvfyZedjO/8/8DnCTBLx6Neeza716+uMA47Tx8fgjqeITv40YHlL+qlN
 C9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s9kZrXrP1ftv/2VBylHEr0nu+FeRKJe/CjWJntpZsFQ=;
 b=fhDf1uSiaChLIbiHBtVmQ8amVzuYC2zJjXOPaTMVPU8TtOM2oDR9wCgMM8vriKsGM5
 KS1hMeRX6YN7NCTCqZIkYdnvVqN/JEg86Fs44qN49OLJP0itA/wLHLhSpzxfFqoxkQ7G
 tAsDx73loCt28Y0kDjjdzVKmau36N2nx3H4FLVA/D8bspEONbvZ5Y8pkqjU3FwtLVdlh
 ox8lL5OW8WlBQQJNpOdlP7dCBl2ycL4PI3tYjbEr38yZi2ih39Qc4dHmtZRDd+CIc9uW
 9YcVpB58rtc/lRyAb02dU4R8WfYdTUO1aLWomVX836ogu63c2/dN3M80Vz2aRwTweMLn
 P/bg==
X-Gm-Message-State: AOAM5300jX2nm3J/VtzXgA8YDZySN9eS+ICyrpf6/zpt1xu/COPzF8Ul
 +DusBMPLjiCF0rcCFM94tyU=
X-Google-Smtp-Source: ABdhPJyKtdasELqPTC7gbDd+bfs7q8RNBiRhQWNHQltb6zWzcftNvNCVuaNakiDQvOHsYwgQh8rYeg==
X-Received: by 2002:a0c:a525:: with SMTP id y34mr23586624qvy.37.1610973637465; 
 Mon, 18 Jan 2021 04:40:37 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
 by smtp.gmail.com with ESMTPSA id q92sm10022654qtd.48.2021.01.18.04.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 04:40:36 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 5/6] ASoC: fsl_esai: Remove of_device_get_match_data() error
 check
Date: Mon, 18 Jan 2021 09:38:14 -0300
Message-Id: <20210118123815.1630882-5-festevam@gmail.com>
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

The only way this driver can be probed is via devicetree, which always
provides driver data.

Remove the unneeded of_device_get_match_data() error check, as it
can never fail.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 sound/soc/fsl/fsl_esai.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 39637ca78cdb..614e22a95f53 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -967,10 +967,6 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	snprintf(esai_priv->name, sizeof(esai_priv->name), "%pOFn", np);
 
 	esai_priv->soc = of_device_get_match_data(&pdev->dev);
-	if (!esai_priv->soc) {
-		dev_err(&pdev->dev, "failed to get soc data\n");
-		return -ENODEV;
-	}
 
 	/* Get the addresses and IRQ */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.17.1

