Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759FC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:27:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0A520656
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 10:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PfCC4lpH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BucFTP/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0A520656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28C6783D;
	Tue, 11 Aug 2020 12:26:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28C6783D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597141619;
	bh=vepUT1+B2Z/uut/fn1FupwnKwr3iSEWfDAHYndRh0z8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PfCC4lpHLrDcXxt2vk6Y4PgH8wpEthVyIkcAP0yJfyh56lj9GPS738HKOKxlOcg9e
	 qwJUM2ECYaRmX4kzbee2fhW3PIDOA5EnOvWrpsrE9vCGaUxzWA8vrSY5pqw1fpaI87
	 y0X+xxGV1zcQk4mKApppsvRkcIFK79KZZMwgMW4E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B60BFF8014C;
	Tue, 11 Aug 2020 12:26:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE0CDF80161; Tue, 11 Aug 2020 12:26:07 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22369F800BC
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 12:26:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22369F800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="BucFTP/U"
Received: by mail-ed1-x542.google.com with SMTP id q4so8636569edv.13
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 03:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PaWjjpu7k8J9RHaNkW//mkekRofZuSKHvdYD85FjRL0=;
 b=BucFTP/U0ooSwDRC3ml0RS3YG5nZYJfI2RHb6DVQUW7bjkswI+6cSdb9nLwTSRU95W
 LFYeyr7pH6ftcNWyO+90HHFn0/cmOpmU5WX3p4joKIHk4vwDBlxo9dm311EPTfK8tDDx
 irLzHLg26oLDsUNhsjtj/wwPlQkvpkj7EhaLmL5hzKx8yz/bAXVP7Viy480MmNAmu8nY
 RDX4z3uyWN46vkhj0oSt6kXEuUcBnZ24fS26JKj2rep0kHMTViTtIgl2kI9VRQDmaKzJ
 xxPaVVKDGo0Ql8AYnjrmY+AG0OeVjhP7OMxIk8A3BNzbwDauKBzKh3HsCvYqNWZc73JB
 l7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PaWjjpu7k8J9RHaNkW//mkekRofZuSKHvdYD85FjRL0=;
 b=rdiRhNcrvfOaGUWqIkbu7cKUjgaunc4Eahr1M6d/nQbA2HtuQNpTRnrJDHyaH4YKDQ
 Be4tCWAZNp9Yi/pl8XuQOY+DdSHXVDu1a2KGTmmdld2MmuNU8bXEk9SNzpeMuZKkPtL4
 ViMVaplK6t2Bgfw7HgpImqj1FOMvC+YOHQ27rPavDDVLqZGCQF9qNQVn+JBDvIieq2zF
 NyFnceapZTjMpAUlC7wG+zwcA55iHtIuaikzH1pZTE1/6CXh/2ZqHc17+ri5FQPvlBQC
 1zReqnYWYc90eZ9t49f0z7YIXb1M2WFxaXstEkzF3uInjbbEfo1EaC4qWedgPv/GrKG6
 Kqjg==
X-Gm-Message-State: AOAM530dRR92gEfZ89e+LpO6ijk3R4G58KXOuwqnPAZWXZnjAVgSx4qa
 7U3GPehdLFvAohzN3pFT7MnBRQ==
X-Google-Smtp-Source: ABdhPJw7lgKWYL2W+g2daDCtxbUyMIzYG9IWIZ1uZANjQlfF+D0YKGkMjX9+XiPw5+vJHZ8Idi9Y3g==
X-Received: by 2002:aa7:d516:: with SMTP id y22mr25187240edq.221.1597141558972; 
 Tue, 11 Aug 2020 03:25:58 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id v14sm14864196ejb.63.2020.08.11.03.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 03:25:58 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 2/2] ASoC: q6routing: add dummy register read function
Date: Tue, 11 Aug 2020 11:25:52 +0100
Message-Id: <20200811102552.26975-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
References: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 lgirdwood@gmail.com, tiwai@suse.com,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, john.stultz@linaro.org
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

Most of the DAPM widgets for DSP ASoC components reuse reg field
of the widgets for its internal calculations, however these are not
real registers. So read/writes to these numbers are not really
valid. However ASoC core will read these registers to get default
state during startup.

With recent changes to ASoC core, every register read/write
failures are reported very verbosely. Prior to this fails to reads
are totally ignored, so we never saw any error messages.

To fix this add dummy read function to return default value.

Reported-by: John Stultz <john.stultz@linaro.org>
Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index eaa95b5a7b66..fb7c4b266d19 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -973,6 +973,13 @@ static int msm_routing_probe(struct snd_soc_component *c)
 	return 0;
 }
 
+static unsigned int q6routing_reg_read(struct snd_soc_component *component,
+				       unsigned int reg)
+{
+	/* default value */
+	return 0;
+}
+
 static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.probe = msm_routing_probe,
 	.name = DRV_NAME,
@@ -981,6 +988,7 @@ static const struct snd_soc_component_driver msm_soc_routing_component = {
 	.num_dapm_widgets = ARRAY_SIZE(msm_qdsp6_widgets),
 	.dapm_routes = intercon,
 	.num_dapm_routes = ARRAY_SIZE(intercon),
+	.read = q6routing_reg_read,
 };
 
 static int q6pcm_routing_probe(struct platform_device *pdev)
-- 
2.21.0

