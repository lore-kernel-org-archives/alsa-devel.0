Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2614BC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FB02065F
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YiduxaqW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrsas+PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FB02065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2ACD182A;
	Tue,  7 Jul 2020 12:20:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2ACD182A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594117309;
	bh=UeaKl4pv+RuJz2Ecee5sA+b4IurRmuXeBKL/YsV1/2E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YiduxaqWdPLdL1euZDfongc55WBDIFwah9QroLeNPu4xjv7X72eEB+9VO/6J6wGzN
	 em9+8r9P6eukay3JUdP7aFrrk+o/OyPbn40TtSRSKov3pxBF2UHtoU5vZP2OKuvIZT
	 vLuJvVWxPZvZIL83tL1fPKB3AKFaN21PsNkN/KKc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D833F80307;
	Tue,  7 Jul 2020 12:17:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92431F802E8; Tue,  7 Jul 2020 12:17:07 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4215CF801F9
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:16:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4215CF801F9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="qrsas+PZ"
Received: by mail-wr1-x444.google.com with SMTP id s10so44500833wrw.12
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HXwAK5e9O3NfsiXPR7kk8AeqU5Nw2ls4PmOWf/vu7lg=;
 b=qrsas+PZEhVKEED/gwuG+M3fvZFc9iTyVZ9kC/kfAQJtySYFhAXFVpKKKmyVPzJsef
 fCJFw/7CBzrR/D0H4Ibl8ook5vPEI7nkN6UMPeetQWBt4M+Kx0Tquh3FeHQKe+00wO+m
 GqDseXgUs910Lbr6v6S1qDkgnl8n1Y7UIIuytj30iKNt1AOZABZ9LymxXsaWj6zDFYGe
 XI8qHYoQ/wOSdxtGcESFe8ZYMktICg66e53gTSweXye36XFgFl6kw5awQcpN8EpYSN23
 8sMm+Tp30g9gUcdoX30JFTNJlS2oJp3wB6d8NA/Z4UGG+OpYufSxlq2WEns0mrZb6qvR
 vMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HXwAK5e9O3NfsiXPR7kk8AeqU5Nw2ls4PmOWf/vu7lg=;
 b=q6TZpgBB6M2q4bMjqSyrwpvE8ISwgVYvLaZoDWcjAWPLxh9rUpAlAseEBi0lcDqpAC
 kIErewEDvODmjcIUIYr8K1YCmFeq3Ed6IisLVZcRdcEO8Sto9jvsmJ18stfbb87CipXj
 NVE7iq+/Y8CYtdVXoaD1CqJO/xv1qU8c9b9ktLYZa+zlKjRpDiKfgeQzx+Th3F2vN1vc
 p/hU5bC/SC/HtcYdD1jJCMmvdkXptoyCVVQObbBpKUjLLbuj50AMwDsIlKxpV8Yyvqqp
 ycFYcVYk3ehPhV0WCHOG/xRUvkKfMDAGLiQMn/Y4Et42L1K85GoCPvKLXkHY1DQpaT/G
 XTRg==
X-Gm-Message-State: AOAM531ugrJu45q+rs5iZ81oPR7/oB/3oOBERbAJcIDGF3nMaLKdIhYu
 C3WVX/7iRZ46lCoYesGW4GAEeQ==
X-Google-Smtp-Source: ABdhPJw+rbiTfjvaZjvfOEvXP2PwVD2bXCDT7mTpQWEQuNXSkRYtQLVPb8Dx6k7fktqcFGcvxY+9RA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr51092373wru.88.1594117018607; 
 Tue, 07 Jul 2020 03:16:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:16:58 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH 08/28] ASoC: fsl: fsl_spdif: Update 'struct fsl_spdif_priv's
 descriptions
Date: Tue,  7 Jul 2020 11:16:22 +0100
Message-Id: <20200707101642.1747944-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
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

Two descriptions for 'soc' and 'regcache_srpc' were missing.  Add them.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_spdif.c:125: warning: Function parameter or member 'soc' not described in 'fsl_spdif_priv'
 sound/soc/fsl/fsl_spdif.c:125: warning: Function parameter or member 'regcache_srpc' not described in 'fsl_spdif_priv'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 7aa3bdec5b6b5..f0b2375a9246f 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -83,6 +83,7 @@ struct spdif_mixer_control {
 /**
  * struct fsl_spdif_priv - Freescale SPDIF private data
  *
+ * @soc: SoC specific data
  * @fsl_spdif_control: SPDIF control data
  * @cpu_dai_drv: cpu dai driver
  * @pdev: platform device pointer
@@ -100,6 +101,7 @@ struct spdif_mixer_control {
  * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @dma_params_tx: DMA parameters for transmit channel
  * @dma_params_rx: DMA parameters for receive channel
+ * @regcache_srpc: regcache for SRPC
  */
 struct fsl_spdif_priv {
 	const struct fsl_spdif_soc_data *soc;
@@ -120,7 +122,6 @@ struct fsl_spdif_priv {
 	struct clk *spbaclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	/* regcache for SRPC */
 	u32 regcache_srpc;
 };
 
-- 
2.25.1

