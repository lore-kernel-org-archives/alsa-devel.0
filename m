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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701D6C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:43:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA282253A
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 12:43:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA282253A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D57D17FE;
	Mon, 18 Jan 2021 13:42:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D57D17FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610973828;
	bh=5+VSSL7E7s8nfraB6MAXlFT043R6DEISbnvI7eVIHvE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NYn1hsIiGxwURcOn+dDWRz0o+32G3cmHOP9RT+AiOF9TgDErczYITT/w5CpqezyDL
	 VP74Q4WVFrlVD6tvOHM3mLuC0M/5kMMamQiHv88Ma3+NVu4HGz3ALt086xDXdWrhXI
	 HX+rWLoP90zWRM4orMFs4QnShUgmOALUYmOtZ5D8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D758F804D8;
	Mon, 18 Jan 2021 13:40:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73EA1F804E3; Mon, 18 Jan 2021 13:40:50 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67114F804D8
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 13:40:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67114F804D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="cGrdPsah"
Received: by mail-qk1-x736.google.com with SMTP id z11so18458127qkj.7
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EVMiEioA7w3i8Gm+/v1dG2o2kJb5f/Py056tr8Ni5fk=;
 b=cGrdPsahLc2fv5+75uubp3CAhB07L/YfIuCmsyN3HbP3r+XBiQ69UrzslLSo9AhPMx
 WTd5G0eazdzqQ62W8ptRC1AYS5muzempZo5opdXrvz+20STlyk2aWX7EGouPsg3Aw+8i
 n/SZNQC3nY4az/GrhPEnvzXfB+xYLnTAMLXfG0juXqIR0PSb2kJddne2me/WCo+/Ng+y
 4pqNDiRWwmB0OqqMXpqQn0U92AIjkBJqBBEA/O6+70nJiAnAq8yu7EltQmD3qyj5mM1R
 6tj021Cz76kGGveElxUT+HHQOarzWYCiX5ZWQ6f2NkoPKLLH11i8SLI3LGMxLmgyaqqw
 kCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EVMiEioA7w3i8Gm+/v1dG2o2kJb5f/Py056tr8Ni5fk=;
 b=c4li/BqK/wNi6N0zaytaJW8OFFH9HamyGcUugOYjspkg5janX12ZvwUTFkzoTvlF4b
 K4h7PKi6ww9poffCzrPyvPM6V88bc1YgXfPlAprHPkoR2k5dpBQgEo40eJeJsa40/Zfa
 9VmLss7OTKv5EAG01U7O/cHEaQqF5xGt3q2xnfMp72oHriCsPEKnpHXBiOmi7w0C4PdV
 fGN1IWEeKWLcg9QDYcYSNoFD2celeD/bA9frOkGXkaFi9rksLmuaXr3tupGykQbplSrH
 iIDYtCjPEBuEWzJEpJaZsyw9OIi+B8xop0/T2fW3WazwOwZRL9ouE1R6VLLC5q28VA7z
 IURg==
X-Gm-Message-State: AOAM532GwxnaXmoEU04OjTEne8vaREhxCeD1O13xTO/Q9WBeL/VprXtt
 Cj4z1jX2IS6MDUeX18lUfqOvlr5CrRQ=
X-Google-Smtp-Source: ABdhPJz3ZqTeH7RGTAPGCH1U/2xF1L+iq843AmnV4xeEQL/kV0t9NAhtgLwbkg0fEeV3982P4c9+Ug==
X-Received: by 2002:a37:57c7:: with SMTP id
 l190mr24329862qkb.487.1610973640429; 
 Mon, 18 Jan 2021 04:40:40 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
 by smtp.gmail.com with ESMTPSA id q92sm10022654qtd.48.2021.01.18.04.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Jan 2021 04:40:39 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Subject: [PATCH 6/6] ASoC: fsl_spdif: Remove of_device_get_match_data() error
 check
Date: Mon, 18 Jan 2021 09:38:15 -0300
Message-Id: <20210118123815.1630882-6-festevam@gmail.com>
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
 sound/soc/fsl/fsl_spdif.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 5fa178f3f497..b4d3b04694bf 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1305,10 +1305,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	spdif_priv->pdev = pdev;
 
 	spdif_priv->soc = of_device_get_match_data(&pdev->dev);
-	if (!spdif_priv->soc) {
-		dev_err(&pdev->dev, "failed to get soc data\n");
-		return -ENODEV;
-	}
 
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
-- 
2.17.1

