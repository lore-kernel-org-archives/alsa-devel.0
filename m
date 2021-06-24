Return-Path: <SRS0=UF41=LS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62261C48BDF
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 09:23:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD39B613F1
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Jun 2021 09:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD39B613F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80DA51614;
	Thu, 24 Jun 2021 11:22:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80DA51614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624526576;
	bh=GJqzYTtJzMlvm9r9tpqjowmD4OlOf8DpTk/qijTvmqA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jv6XvdIiWHKEYYMBXBYSVbzHM5utUw9PIR22KtCh9T7rYOTGfRKoiOja86QcarwpY
	 54t6CoRjH4x1P4eIwIFf42O6a3klCrLpKmrm505IfU3z4qfMn3/dn7eOnfQQjbspCz
	 yEbuobQKhF4b3HfK/Xa4YV64ywDfponUtaka/wIY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22B38F801F7;
	Thu, 24 Jun 2021 11:22:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D9CFCF8025F; Thu, 24 Jun 2021 11:22:04 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81B8FF800E1
 for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2021 11:21:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 81B8FF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="uhjdive/"
Received: by mail-wr1-x429.google.com with SMTP id a13so5816152wrf.10
 for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2021 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eil13llqRA8gYhUtxKkI3REM+ezUGVLrIHE4Cv2dVF8=;
 b=uhjdive/O7I2WAuxOtK/E1s2j/zgeRvQzfihlEW8X/mI6MelZSIx1sNhvw83vrwVS3
 8Nd+BLc0014wUTXeUJ4A7kgZHjUUuqF6+lO7crQJs+StROQx///ECIVDXxq75RLqkqQv
 /0NUlGqw5GahfYINcQAmor72L2Jwodfhcg0Fx5szchgiP8SjcpMehH/ME8mGH9kOTb78
 OiM5Nt6fe90IR9LKc4lOSnE6kYMAjlIBqLh4eGFqb+Rt2ZPGJ5CS1T/7Njt7KYKOCf8t
 ne5KgG8W6X8pjnoIysVJUC9abq8vmjkvWwA8SBS28kT5giu0J55ePt3PQlrmDFAuj+fe
 12DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eil13llqRA8gYhUtxKkI3REM+ezUGVLrIHE4Cv2dVF8=;
 b=N4H8fbVZ207rVOAmEDsf0bosiTkBSebUCWTju360ygTobGqRvirJtzFxZPepvRERHc
 98YSH2zr1VdvNyyhbhzMzJPCYSj4BAhCKx0jcpqSdIAWBOciSa/MaYe3607YFadtQuxZ
 VL54v5Y9Kz5hQ1LakI3KRunGGbkN9N9h+ZPSFBCbCjjRxJMyjZFcUfZ7S0Ai575O7Ms2
 MwVmhMt+zAzdMFOJ46jjF1n9dnEJXipkpJq6SxSQfEgWOy2UMAfg3mgmn4upPiGfqOcc
 SUyaz8y5RtQr1Kr/SyVBPujM+mVWCGGHs85I1G6+FybgYEn/J7ojyfW51IuudHA6nIMr
 fCrQ==
X-Gm-Message-State: AOAM533Sdhq1CAF3Oh8ZItOTTLaHqwztq9B6jVt4gZRBc0rPAKm10gac
 uIBWgyRTKvPD9GUqrdZKhjL65A==
X-Google-Smtp-Source: ABdhPJztlTt5zmiHbLHkei3r2qRcSGTuDwQiJ31CFKymrlQ3Ku1mjf4fKdAVOaYllWr2BwpDAXBP0A==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18mr3260555wru.86.1624526518958; 
 Thu, 24 Jun 2021 02:21:58 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id u18sm2235066wmj.15.2021.06.24.02.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 02:21:58 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH] ASoC: qcom: lpass-cpu: mark IRQ_CLEAR register as volatile
 and readable
Date: Thu, 24 Jun 2021 10:21:53 +0100
Message-Id: <20210624092153.5771-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 Marek Szyprowski <m.szyprowski@samsung.com>
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

Currently IRQ_CLEAR register is marked as write-only, however using
regmap_update_bits on this register will have some side effects.
so mark IRQ_CLEAR register appropriately as readable and volatile.

Fixes: da0363f7bfd3 ("ASoC: qcom: Fix for DMA interrupt clear reg overwriting")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-cpu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 0b9cbf2ce505..8998697cd1e1 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -525,6 +525,8 @@ static bool lpass_cpu_regmap_readable(struct device *dev, unsigned int reg)
 			return true;
 
 	for (i = 0; i < v->irq_ports; ++i) {
+		if (reg == LPAIF_IRQCLEAR_REG(v, i))
+			return true;
 		if (reg == LPAIF_IRQEN_REG(v, i))
 			return true;
 		if (reg == LPAIF_IRQSTAT_REG(v, i))
@@ -566,9 +568,12 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
 	struct lpass_variant *v = drvdata->variant;
 	int i;
 
-	for (i = 0; i < v->irq_ports; ++i)
+	for (i = 0; i < v->irq_ports; ++i) {
+		if (reg == LPAIF_IRQCLEAR_REG(v, i))
+			return true;
 		if (reg == LPAIF_IRQSTAT_REG(v, i))
 			return true;
+	}
 
 	for (i = 0; i < v->rdma_channels; ++i)
 		if (reg == LPAIF_RDMACURR_REG(v, i))
-- 
2.21.0

