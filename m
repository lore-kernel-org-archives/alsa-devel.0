Return-Path: <SRS0=iTaG=EB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97ABC4363A
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:10:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5479B206DD
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nsuf0y/h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fl6Xm/43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5479B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EDA71689;
	Mon, 26 Oct 2020 18:09:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EDA71689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603732249;
	bh=+wgHh24k3f6sHpqfNywOl9XgemGWVfpGEjZG+8lvFYE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nsuf0y/h5Tpwuj99udJohJ5umtJl6v33UJltSmJQss34n4La49gGAfpisrFoDSpdS
	 g2rmwvA33XkY0S1QMwu7peX3AfaddbS8bt4lsHu5Rla6li/RDwiv4N4yDDa+BQZU+P
	 WcbPnvI6kkNYL9a1NY1nXWHKqUGqArfSH3WUJ8Ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 009E9F801D8;
	Mon, 26 Oct 2020 18:09:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1418FF8025E; Mon, 26 Oct 2020 18:09:57 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8CCAF800CC
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 18:09:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8CCAF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Fl6Xm/43"
Received: by mail-wr1-x436.google.com with SMTP id n6so13498761wrm.13
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2020 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vFeyCOZuGu3TAYp3AEJCm2TEdGhGhIny1R6SggmTKY8=;
 b=Fl6Xm/43hXC4xGueHJyhjc4F097rffBBIx+Eq/oU+GjhX++JY5cRmILQZJp6rysLqo
 dJMmTFKSBRh+T7R96gq5W9AP/P7P+lzl5wr/2AMk6EefsApNiPb648JXKNawKuy1Hzzj
 mDUB2cbpuU4pB6KsLVXfaNlmuUdmpa4z6MP/7B+Vfhb7eFR362Y6yO3EM73JXnkUXUcU
 jaDBVRCmMIn527Eo0LUcosY0iP/rAm1ySPHt0eCd5FAMD2G+cEzfmFLRuHphtv7Udo1x
 20n0F4diTbwEbc6iZptgehfXaxG2KPMrjRV4MeVf9rZGSAfvHq9dab935vh0t1rsmg5o
 6E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vFeyCOZuGu3TAYp3AEJCm2TEdGhGhIny1R6SggmTKY8=;
 b=paN8rpPmQbv4C/dVcOMLFM2GrourqdW5M0NMEOXs0H1fxZJpI2eHwuOutEiz2Br4ZE
 GAP8miT0C94BZaHypsIcMk7finQeHIbXKSoRMA+C4PSjuxpBgDwusuPYC0DjJjQ2fhpn
 lOmhLis5mcBZf/rAjPMsLH8s8s3z5p1uAQSjGeYLv4Fj4HyzKCNKk8zb1CMPDAzdgPTh
 u1FcYdPeVNuNrZvtLWh5ziAmbdspCH+66b8dL31GPfiJu71Y7GgK1ziNOyTuvMYGxTin
 gFVgV9fr0pwdyGCZDigiflfVW1BC3EaPifGRPbG2QPmTJ5ND3V6j3AQW+fUY0EzQjMPi
 Gwgw==
X-Gm-Message-State: AOAM530jwMa7V7amrfx5afcrtJmE56mgMjdZuB12YZmZ6PsVVWs/8uVY
 9GifqTUZplDNiuo/BU3pbA3Nsw==
X-Google-Smtp-Source: ABdhPJxSMbYOdUwlA0pB6HpbXDqkJfj/f2c0xOdjab4+4gWwvK7VFgL7/Bwmn3hC0aQtjgXUPy0NLA==
X-Received: by 2002:a5d:4e8d:: with SMTP id e13mr19102405wru.368.1603732191699; 
 Mon, 26 Oct 2020 10:09:51 -0700 (PDT)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id u133sm23136174wmb.6.2020.10.26.10.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:09:51 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH v1 0/2] ASoC: qcom: add support for QRB5165 RB5 machine
Date: Mon, 26 Oct 2020 17:09:45 +0000
Message-Id: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, spapothi@codeaurora.org
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

This patchset adds support to Qualcomm Robotics RB5 Development Kit based on
QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers with onboard
DMIC connected to internal LPASS codec via WSA and VA macros respectively.
    
Srinivas Kandagatla (2):
  ASoC: qcom: dt-bindings: Add SM8250 sound card bindings
  ASoC: qcom: sm8250: add sound card qrb5165-rb5 support

 .../bindings/sound/qcom,sm8250.yaml           | 161 +++++++++++++
 sound/soc/qcom/Kconfig                        |  11 +
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/sm8250.c                       | 228 ++++++++++++++++++
 4 files changed, 402 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
 create mode 100644 sound/soc/qcom/sm8250.c

-- 
2.21.0

