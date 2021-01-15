Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F918C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 16:57:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F9220738
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 16:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F9220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B884D182F;
	Fri, 15 Jan 2021 17:56:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B884D182F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610729850;
	bh=QpBQddm8uxBszssbJdZ84soxqw9Tu9qDUll/PQ4yAx4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2n35msqI81Wc5BZE9u8KY1szTTrWO0VcTpVExZnZrGnNDP6w4BSuUWpt2LDjPvla
	 mrkntMCL60yihWbGXmMdsuBikoqBqBqpyQbLdCG46Wl5zhZ8rpfZEQ/9phLo7twmjw
	 IUUhpw/FK05IQWHDrsiAxlPYGMKbQLsF+uYa0598=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A65AF8026B;
	Fri, 15 Jan 2021 17:55:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC9C9F8026B; Fri, 15 Jan 2021 17:55:44 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30B10F80134
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 17:55:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 30B10F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="JyOzx4Fv"
Received: by mail-wr1-x432.google.com with SMTP id q18so9983830wrn.1
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 08:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qpoU5fqNwBrgG+uQnSKsFtoenWMjs1fcRQ3GYXtUAfw=;
 b=JyOzx4Fv8jpmSqjzz6uWttvy15gDpPwhLvBE47Jl3j6+4seX77+kh+s4z7qdkB9XZv
 1m5mBd6QIBVByhFMCsF4auzJ5pFw0xD2bg+jljTwtbDE8dBxE2ak4Z249fFIHrQKqJJq
 fckoWR4/PauSu9ShyA+gryhbfUNV7Nd3M1Po56yCIHeP9DiRjbWkELJP7mt88CNxMi5L
 JJKeO5A/skGVOdJ9K44j1OEM2uSW+hCw5xZMgjt/16rThqkag4TM3TZArH1mV7+GWF5G
 CAEaMR5JUQK9H+FVGM4ggZjFKevYm4RgYBlp7wzKspfqfFNfB2Bc+Ep//R26wR2p+33+
 3MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qpoU5fqNwBrgG+uQnSKsFtoenWMjs1fcRQ3GYXtUAfw=;
 b=DzisxpofrZUux+VEP1opfzcGFBKd6GHtVCqDGbYxqMAuImd3h8Oc/l6BgGUQpyLq4E
 OJyzf20i86eeY4i+CIp0D7xCvPfQ6VQM1Ke9smqBJ4iUw0xp7ChPFRwbnHxN/ElouI55
 ODdAnqKUQOMzdM1KJxAuyoGjICL10oHPB++LKJcc/Wy89zavCeIAil+dJ7swKLHLGJDy
 fhhENPN1VqbKg2QVl4yhuPn0qvldPas3MGrVrbLynxMm+K2iSBlRNO7QbhDCndfZpZCB
 9ZwlOGo4fw6/uXrNEMuua3RYEMxlhhbViVc6SwembahexMOBj8dwu4BoAO5q6BPIiRJ4
 vUGw==
X-Gm-Message-State: AOAM531iSmA8jGiTZtvkPhE1DDmseVn1TOacl9YUB12nvre1tnpoG5F9
 vkIAvJyKoibeHwLTv8x4HURErg==
X-Google-Smtp-Source: ABdhPJyLPxRwkrI+zHOIgoHA0e737MQMy5mIKOsHajXwgWnZq2enQJ0S7G1aMQrecyoNBQzsgdsyAQ==
X-Received: by 2002:adf:bc92:: with SMTP id g18mr13731534wrh.160.1610729733129; 
 Fri, 15 Jan 2021 08:55:33 -0800 (PST)
Received: from srini-hackbox.lan
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.gmail.com with ESMTPSA id b7sm14655045wru.33.2021.01.15.08.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 08:55:32 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: linux-kernel@vger.kernel.org,
	broonie@kernel.org
Subject: [PATCH 2/2] MAINTAINERS: update qcom ASoC drivers list
Date: Fri, 15 Jan 2021 16:55:20 +0000
Message-Id: <20210115165520.6023-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210115165520.6023-1-srinivas.kandagatla@linaro.org>
References: <20210115165520.6023-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: plai@codeaurora.org, bgoswami@codeaurora.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 alsa-devel@alsa-project.org
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

Add full list of ASoC drivers that are maintained!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1545817c899..7699d9d94a49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14516,6 +14516,14 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	sound/soc/codecs/lpass-va-macro.c
+F:	sound/soc/codecs/lpass-wsa-macro.*
+F:	sound/soc/codecs/msm8916-wcd-analog.c
+F:	sound/soc/codecs/msm8916-wcd-digital.c
+F:	sound/soc/codecs/wcd9335.*
+F:	sound/soc/codecs/wcd934x.c
+F:	sound/soc/codecs/wcd-clsh-v2.*
+F:	sound/soc/codecs/wsa881x.c
 F:	sound/soc/qcom/
 
 QCOM IPA DRIVER
-- 
2.21.0

