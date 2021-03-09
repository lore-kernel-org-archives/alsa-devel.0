Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1795C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 10:17:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F8B6525D
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 10:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F8B6525D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C57F617C6;
	Tue,  9 Mar 2021 11:16:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C57F617C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615285031;
	bh=BRVhD52pmWHL1HNcZmIYnvtdZYl372NJ8VdvNqRYleM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DxgVMRheOupppXdKYn15uLa4vEzm47oAwqjo3JfoVVcA6rPWTUTMMOboWIHMQLgNQ
	 ybgj1FNMvik86oikLL7iZPwx4i/NRpEEWH5Czu2+f29qV0RZcoWkMMyaRjBOjzRGvR
	 1c4tbU1LINpl9AAO74dfWM8RZJPRRtZMViCj8FpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2477AF80256;
	Tue,  9 Mar 2021 11:16:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5ED6F8025A; Tue,  9 Mar 2021 11:16:19 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0C66F8014E
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 11:16:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0C66F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="wx8qqAH5"
Received: by mail-wm1-x333.google.com with SMTP id
 r15-20020a05600c35cfb029010e639ca09eso5574371wmq.1
 for <alsa-devel@alsa-project.org>; Tue, 09 Mar 2021 02:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h7PtkbsEWdkuJd/mmYpJAYKJMOfm44GbXmX9GIVF+Uo=;
 b=wx8qqAH5D94zcPZhTci5hev6TaMVBRkTx/B9T8R2RCHadUoOcTgCEgY2J/0ylwWSqh
 qFsWCkng5osHQRgET9sguzMMOYiBxrpzSK6F3JiwxBy7Ij+i9n8XSo5sBk8CKhZftY6Z
 a9rwcCh27dXbLnjJflxEBNFjQ816PbAc32fcGC3FNnLaObGcbos7cwL6UtqZ2QB6q1C0
 jUcqcTDRpuZEjg427XPr1YVSq7qDdEB/DE4HXvQkWeiAeuc2YXQc1a27QoaRrTYhB+Wh
 eGbXyW1RkvDfDr4BJODy3d5yiJW1HLuTTcIFYnOIQdHsnQ7p99AbAiUiwUipxZ3sMmM3
 QIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=h7PtkbsEWdkuJd/mmYpJAYKJMOfm44GbXmX9GIVF+Uo=;
 b=YVdlzdsRFdnsfaTzwxQrtTNd/Rnx5nb8AKOgJMc5FihSoAe+su6qtvyClY4yLc4Fuq
 nJRyph1tah1WLwoOzHTlZw9huBHkVsFK8E1ZabnfnP1vK0Izc3YeC719C9vg6qy+9iu3
 TGwWvX+OYJXKDiZGuMT9Tix7CNWsQVknaIrgP3omjvk5uU7EvVwbKpucHu4YXE4Dzhi2
 PFxHyBCQhOtqesrBPX9uPQSMXerkKIZpkGK3fWel+btzd983RKI6HDtEO0epl6RHr3xV
 4sGZutKEj1qC8wqa+gD7/3Am0XxONqeBixnYZZi4gRk25hKkzvAT+qfKWZ2cNZtaSS0q
 xnIg==
X-Gm-Message-State: AOAM531cWLNNAvl8FAl/uy6dYAV/yJbQ6QBQwK/eW+2NjVLYtVZklat0
 uEs4JQiFYL9Fdb7t71fyDAG+nA==
X-Google-Smtp-Source: ABdhPJwyT3j3Xfd3tolLUlZDCHTHVfr30U9H40Y0ozNmW0iEDfz/gVEPVyODJb3UTTeAt6ehMHGJeQ==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr3240872wmj.122.1615284975651; 
 Tue, 09 Mar 2021 02:16:15 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id r2sm22552248wrt.8.2021.03.09.02.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 02:16:15 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: broonie@kernel.org
Subject: [PATCH 0/3] ASoC: sdm845: array out of bound issues
Date: Tue,  9 Mar 2021 10:16:10 +0000
Message-Id: <20210309101613.25995-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: amit.pundir@linaro.org, alsa-devel@alsa-project.org,
 bjorn.andersson@linaro.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 john.stultz@linaro.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

During testing John Stultz and Amit reported few array our bound issues
after enabling bound sanitizer

This patch series attempts to fix those!

Srinivas Kandagatla (3):
  ASoC: qcom: sdm845: Fix array out of bounds access
  ASoC: qcom: sdm845: Fix array out of range on rx slim channels
  ASoC: codecs: wcd934x: add a sanity check in set channel map

 sound/soc/codecs/wcd934x.c | 6 ++++++
 sound/soc/qcom/sdm845.c    | 6 +++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.21.0

