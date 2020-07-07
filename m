Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535DBC433E1
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:25:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37C2206B6
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SwEJCb0F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhs6mPQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37C2206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FFFA74C;
	Tue,  7 Jul 2020 12:24:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FFFA74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594117515;
	bh=OpuTpsPUqQgNdRyulOppnnJDfOYVl4J8PGfggRev+qk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SwEJCb0F7dRfPmjni6ZVI45aqf/CGxXUvMDGgN7L1hIRMDkpTLX/WUhldEBHnk3X7
	 Hu6Bi909LEzKuJrCdc0zMFfneR9oGf2FiSbTSw3fDl0uczIoIUTCTf9yBREh9hpQnW
	 6UVkAV964vxaMs2IqN88sM1MCbdmG4lAHFD/ZJiw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3F5FF8031A;
	Tue,  7 Jul 2020 12:17:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0600EF8031A; Tue,  7 Jul 2020 12:17:20 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 285F7F80264
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:17:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 285F7F80264
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="yhs6mPQq"
Received: by mail-wr1-x442.google.com with SMTP id s10so44501283wrw.12
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=joYuVrqjbvze3xQNhXb1qygj1A0MIp/q6w6MCrvUZ8U=;
 b=yhs6mPQq4PZeAt1M2EZMuLygavzZyEDV/c7Afv2xVs9/TugaazgwktDEldd7ZHl6jo
 5TSLozA1cPtC0mMfjSR+eEDDFqNoqdaIRYlcRwQyis654xVVugVaJ5/09fjtvF53qr3G
 AM71mfQpQPhABe8ZE/CSuJ/7yjxUd4EfLvizTrmuoLtXflMfxnEsww5Abej9dATeKPzk
 DCcxKFJ2krNUxMnnknHCRIUQMbynguHM9yiVaGT4YbXmFZxoaTGinJsTS2pn6w9dxE35
 wWajVTMatx/MEmzV/VNOHjxcWEmbTRuoAH82DfsBaLUVz/gI1cNQy4aav0LgjVDi2bPO
 +umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=joYuVrqjbvze3xQNhXb1qygj1A0MIp/q6w6MCrvUZ8U=;
 b=WNQAb+TYFFQDLc6lauNbFJV4f3nTlEfpkvDifTYlpcCEWiy/VPIps+Ux/YgoNXMC17
 MwjAcqF74vVQ7v7CVZkIpwpimLRBvAfdLLL7IuoEKqNqEq/K6tjjqtVZYxorizGlKJli
 lBvVr/ymrhpJxo8I8m5kPCRU0HDaVD257x1OAS0CSdY0JSlEdyc4aiLvSb8RAsJdAyC2
 /8cZHKa4ktlcXiaW33mHtE1kw5E18kiiswu/Hr4lJHIDzfA6/BM2mBiIXwfELc/vFXEr
 GIdJLOka68ggZ6pysL9+pRVTYpw7bHOJ/d5pg2LJ2JSoMYpb+aZSCeKZ7BWghEMN/vZM
 EHGQ==
X-Gm-Message-State: AOAM533+l1yUcpwC0i9aFtOY496Usaswn9pFKJ5zOImU8n7HjB4EU3oE
 l61yWrQgHenchqah1uTMUI2Y2w==
X-Google-Smtp-Source: ABdhPJxG99p5QaqaNYLPvj7Abir3MWTHXEmvxOPLyB5aXcDmjbSSvCDpahka5msO5NNg5NwWh6HBEg==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr50993892wrs.320.1594117025590; 
 Tue, 07 Jul 2020 03:17:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:17:05 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH 14/28] ASoC: samsung: pcm: Demote half-documented kerneldoc
 header
Date: Tue,  7 Jul 2020 11:16:28 +0100
Message-Id: <20200707101642.1747944-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>,
 Jaswinder Singh <jassisinghbrar@gmail.com>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee.jones@linaro.org>,
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

Ideally the author or someone 'in the know' should come back and
provide the remainder of the documentation.  Until the kerneldoc
checkers have been satisfied, let's just demote the header to a
standard comment block.

Fixes the following W=1 kernel build warning(s):

 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'lock' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'sclk_per_fs' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'idleclk' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'pclk' not described in 's3c_pcm_info'
 sound/soc/samsung/pcm.c:127: warning: Function parameter or member 'cclk' not described in 's3c_pcm_info'

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Jaswinder Singh <jassisinghbrar@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/samsung/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index a5b1a12b34966..3116be4239f59 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -102,7 +102,7 @@
 #define S3C_PCM_FIFOSTAT_RXFIFOFULL		(0x1 << 1)
 #define S3C_PCM_FIFOSTAT_RXFIFOALMSTFULL	(0x1 << 0)
 
-/**
+/*
  * struct s3c_pcm_info - S3C PCM Controller information
  * @dev: The parent device passed to use from the probe.
  * @regs: The pointer to the device register block.
-- 
2.25.1

