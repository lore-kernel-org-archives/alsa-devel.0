Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B72C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 03:45:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F9221D95
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 03:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F9221D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1650516E0;
	Fri, 15 Jan 2021 04:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1650516E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610682343;
	bh=HPChyODOycgwQjwu3iaw34rKduy1AHV/7ZgFD8r0bMY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRlbeh7aSj6pmqdSVRLO19pMlpyA/GYtVAtaBGlsKBwaE+CZdt5/3b8HhkgOMfiZW
	 qFGDinsQaNMnYOyo4/dehC4JjcuL902OnR/rkBiZlEg400bttq3YBB4M4TaepjR/6+
	 /E3b97MFQ83cr5rfnLlfW1QdOA48qGURMIi9ue+c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56850F804B4;
	Fri, 15 Jan 2021 04:43:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81202F804B4; Fri, 15 Jan 2021 04:43:48 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E1CBF8016D
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 04:43:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E1CBF8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="GJ5Qhb9s"
Received: by mail-pj1-x1033.google.com with SMTP id my11so4860129pjb.1
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2021 19:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=C6He9tPGs+/ws70kmAFtHlq88pmaEAaoR8SLKcK4SNg=;
 b=GJ5Qhb9slRBrvf9Om96+ZSgwwXop709x4reSxdwYFvhArCZ3JxK8K7CppeVFX1E93P
 iR9hC/FsprYlbJQiI4OXZmTUdzuVCPNGkW4/EPu7ozcWyhUoB1s3D5RlZmEgqz0CzEb3
 FIeIrmAMceMKjNeUuMEJhBRyPr8WrCBDqZkoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=C6He9tPGs+/ws70kmAFtHlq88pmaEAaoR8SLKcK4SNg=;
 b=olxfONYO9F9ea1ZYCmM+uildCYYJjuGEtdpQmA7JxLOcHLbKPmhmRKMEIuhUxgO+95
 MYzLRRKnrj1wWPOxCdJVwHsTRfStTp6z24CLvTU3TDasAZ/iElNmkCDPmHlT1aMuPSyq
 /I/NaMPg++0YuZiVTeUfxZbPQfdp5/IfoCvExDpE3o5ovf0khNknnEtoA49QX+zDV4Hu
 S+ugpXne+tvCwzSgQFio3Q9zW/ovTqregXSZqvQ2c4CMCRl0MV8lnv8QIttIJIaeC+eq
 xBYz3tbOxevRdSSTJ407Pd1hUxucWYHrn1bBr/S6r6cxwBP/7e4MKulIy/H93RgtgSWl
 xWQA==
X-Gm-Message-State: AOAM533i7Kl1HUi9mfGJ0f0d/UbgpfIjrmO0LzBz6El7XwDChLBD8l43
 84K+15GvTmcg7em+fkjJo5fzlw==
X-Google-Smtp-Source: ABdhPJyBWMQFKo0YFElvC/23fia/mMyG6g/vnSyuo284t516we9EDHsMfA3/PLuEvFZ8ZcHDB4FoPg==
X-Received: by 2002:a17:90a:68ce:: with SMTP id
 q14mr8096304pjj.223.1610682210864; 
 Thu, 14 Jan 2021 19:43:30 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
 by smtp.gmail.com with ESMTPSA id u12sm6499062pfh.98.2021.01.14.19.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 19:43:30 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ASoC: qcom: Remove useless debug print
Date: Thu, 14 Jan 2021 19:43:24 -0800
Message-Id: <20210115034327.617223-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210115034327.617223-1-swboyd@chromium.org>
References: <20210115034327.617223-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao <srivasam@codeaurora.org>,
 V Sujith Kumar Reddy <vsujithk@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

This looks like a left over debug print that tells us that HDMI is
enabled. Let's remove it as that's definitely not an error to have HDMI
enabled.

Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Cc: Srinivasa Rao <srivasam@codeaurora.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Fixes: 7cb37b7bd0d3 ("ASoC: qcom: Add support for lpass hdmi driver")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 sound/soc/qcom/lpass-cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index af684fd19ab9..8437ba31a306 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -742,7 +742,6 @@ static void of_lpass_cpu_parse_dai_data(struct device *dev,
 		}
 		if (id == LPASS_DP_RX) {
 			data->hdmi_port_enable = 1;
-			dev_err(dev, "HDMI Port is enabled: %d\n", id);
 		} else {
 			data->mi2s_playback_sd_mode[id] =
 				of_lpass_cpu_parse_sd_lines(dev, node,
-- 
https://chromeos.dev

