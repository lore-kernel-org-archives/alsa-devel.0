Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519EFC433E4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:45:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CE12067D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oQBhvept";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SinIXReR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CE12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64B4615F2;
	Wed, 15 Jul 2020 11:45:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64B4615F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594806357;
	bh=y8YwUf/MRnI092YerIBMDbMWP/i1Q7VltDSfmKvsaiA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oQBhveptzadL1zBr6iXGvIzBtzuEc1YTuz9I+t1ERX2XtgBPfW6Q87IcXhWfpsONA
	 Wk0QSjKJ7+b6EJMDh/f0fhlUsOayBPnicopfprg8YuIze0Kayi9C+YE/HG03IEsuBP
	 S/DixFFhAyboeuQ4j2UqYpdxqx8daPjV8I898aQU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBEF1F80217;
	Wed, 15 Jul 2020 11:45:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAC6DF8021D; Wed, 15 Jul 2020 11:45:04 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6A7DF80113
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 11:44:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6A7DF80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="SinIXReR"
Received: by mail-wr1-x443.google.com with SMTP id j4so1701225wrp.10
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 02:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PqrROLW34HUUtR2h51/zb0sAvx91AU1D+g0vWHL8Q9E=;
 b=SinIXReRv8gqiSN2QfRyGZoxeCSVs1tW6IJ0fPIXqJKyYvSmw8FpS+EVBSF+0RW2Sh
 ZfKeXn9lmtbB+SD4BCJTJtQtDjyF2+P5LA2TO/WhKm/a78apZ8l4h9DB5vNSrDY7ImIu
 27zi1mRvX6cZpJGg/WmAanuUBKuAlFUU9iN8VbKWgpo540NBthUPbNZPqtKKMlWE5juh
 Ut84YQeS4jXHNSmflZPszNc5fOGAmn02ROdfQGAteYwrd9dDC6lrCh/JloCEggU+Wffe
 XRSDKtOVNA3pnZjeWEYAlDKuTayNQ2dWFNwMG7b7jH0R7Za1vatKApj6jDIhtjHreS2w
 RZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PqrROLW34HUUtR2h51/zb0sAvx91AU1D+g0vWHL8Q9E=;
 b=iWwCawyTtDuYKNdIUG1j8Drbs0ybQ+eUgPw9rfo34pLyPbbh93kipSxSrOrIGazdVR
 JuerVHVhUhUK635AY/SoHHChgF2GA0Fm2Ku5GvguszxDsz2ohaU/g2Q6M2TQgxTisGsZ
 I6wiPUXVkLpdr1dgulOtjP/eZpTudevMaldN7I9C/PW2qq5nDObsTmsndnwVk1DYh4D+
 4rPky3ihN6zbqUGK+VsgCTXj5a7YpZVlO0IfG9565+j355AQimmLK+MqRf2sOm76usVX
 0kEFOyhfzg/gbnJTp5bAHwHa761Ak2CG/qqBa5Ud3C/6PaXCR6rjNx05x27aZw1Gnvjm
 2UZQ==
X-Gm-Message-State: AOAM532TZ4elNdK/49JZM77sX45ggaZENzrjEYMQeGUvsqxYc3kfo2DI
 usK2AZgpLNx64GEgzyMtjTvXSw/wpjE=
X-Google-Smtp-Source: ABdhPJz9iEgW39p9NP+x+8HK/WX7+X1jz9XTLGQ3OWUni12lXxbaIHvRiJa1hStnOPuDJMtNRKu1oQ==
X-Received: by 2002:a5d:444e:: with SMTP id x14mr9877312wrr.279.1594806293824; 
 Wed, 15 Jul 2020 02:44:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
 by smtp.gmail.com with ESMTPSA id r10sm2774916wrm.17.2020.07.15.02.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 02:44:53 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org,
	lgirdwood@gmail.com
Subject: [PATCH 1/1] ASoC: fsl: fsl-asoc-card: Trivial: Fix misspelling of
 'exists'
Date: Wed, 15 Jul 2020 10:44:47 +0100
Message-Id: <20200715094447.3170843-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, Lee Jones <lee.jones@linaro.org>,
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

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index faac6ce9a82cb..399c9aad48b1d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -92,8 +92,7 @@ struct fsl_asoc_card_priv {
 };
 
 /*
- * This dapm route map exits for DPCM link only.
+ * This dapm route map exists for DPCM link only.
  * The other routes shall go through Device Tree.
  *
  * Note: keep all ASRC routes in the second half
-- 
2.25.1

