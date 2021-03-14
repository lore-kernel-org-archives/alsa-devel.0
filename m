Return-Path: <SRS0=8nxE=IM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858EBC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:49:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A820F64E76
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A820F64E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 411E417A3;
	Sun, 14 Mar 2021 16:48:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 411E417A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615736977;
	bh=kPUUSenYzptj8r+Zf7M6AevhdBe4uyS7b1cOVopMf2M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IjmgILNAMrKaCVR860TY7awvDM1cUWSzJPG809HTr9KtYLhROHufbElBTc3QbpBwy
	 nrOLicaW2c4yuYp+C6Uyjq+jOHmxn++bxJtY99AvnuPjoEssHqtz11ltKovhaO9EY2
	 CjLuE1on+tyn038zPFpeEa21lPN9i2EpOk6ctgIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29F33F804E3;
	Sun, 14 Mar 2021 16:45:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 131BDF804B2; Sun, 14 Mar 2021 16:45:42 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF9BAF8032D
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 16:45:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF9BAF8032D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZYxiTzHu"
Received: by mail-wr1-x42e.google.com with SMTP id e10so7428427wro.12
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f6C5LnJcPjvrSoy/lW5/dsmp2Az/VjPBdQ0RoCAGgfc=;
 b=ZYxiTzHuyZcBK0UmcnUMMH2wRhTl8IC9KjHzV4UiQHTwXYXCQ4DuHAFmssHWQQe5Ep
 JKNxFfS+xnNMvxIlbXBKxXN4PO60R0jQOzt5KWqrk57csAkbqxsEF1I6Hg+Oxy8/Wrk5
 mvaVKDn8I8nTuNJ+242qcfWHFmfwgJt0GRl8p3qqQjeIZY6/PaNzlzx8e3v7eIcVUGyn
 Ds0f1y3RimkVFewBa+h8AKsauiu2qsw4zlCV9AnORuNZS6VFp/XQ2EzbvngAhdH71MlV
 0pXNKNDyZbZsrkQWMmybLEgakqVBJR2xGxQ6Hnq5nJg7y/eWQea0bnIoyky9kZfN+Z/N
 Nbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f6C5LnJcPjvrSoy/lW5/dsmp2Az/VjPBdQ0RoCAGgfc=;
 b=hyRQU2FX/EpaT+OnOkNEv3AZa6C/oJtp0eIgUNCrrwAi+0vRzNqFrWiL8WPUomG+W6
 MbFqOw+VDhtLhVW+u3R6gHw1jqReFQUnlJ2dfG72wJkIBnnJ5l4asB/uNHAlycXF2Qv+
 WmICObZmUx6+zdEUBZY29VwIfUE71R71oTCYYBljATyYQ0P+SiTXBBev/+KpAjvVmB7p
 Set4fCxCuCCRLU4yzulGOCp4KLLAVlI5IKGpQGscKHLG2ZiYcfCJGApo6+xrMkJOHKXA
 +0gIPgPDniqHhdsHy11Lm71ZbSuW83Yns0A8xE3ibEMmqgxXSGyrzGFj4lfO/vmwELEc
 Zluw==
X-Gm-Message-State: AOAM530uJIVslIlpttbDbdDTdpOKPNtYaT3jYNAMwUnWiYrm/30cn/fg
 s63Od24tWmsoHnNunhrUi5s=
X-Google-Smtp-Source: ABdhPJxXAO+1FBI64G8zBdvT7vnz3Vqw9PUJEJpwZD9Nk01gBQn6RH3itOOLxfyExn9w7NOHrnJzhg==
X-Received: by 2002:adf:a2c2:: with SMTP id t2mr23194274wra.47.1615736729659; 
 Sun, 14 Mar 2021 08:45:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.gmail.com with ESMTPSA id f14sm9673507wmf.7.2021.03.14.08.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Mar 2021 08:45:29 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v5 09/17] ASoC: tegra20: i2s: Correct driver removal order
Date: Sun, 14 Mar 2021 18:44:51 +0300
Message-Id: <20210314154459.15375-10-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314154459.15375-1-digetx@gmail.com>
References: <20210314154459.15375-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Tegra20 I2S driver has a wrong driver removal order, which should be
opposite to the registration order, but it's not. In particular the
runtime PM is disabled in a wrong order. Fix the order.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index 267517446d27..0f2bdc2e8598 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -440,13 +440,13 @@ static int tegra20_i2s_platform_remove(struct platform_device *pdev)
 {
 	struct tegra20_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
+	tegra_pcm_platform_unregister(&pdev->dev);
+	snd_soc_unregister_component(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		tegra20_i2s_runtime_suspend(&pdev->dev);
 
-	tegra_pcm_platform_unregister(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-
 	clk_put(i2s->clk_i2s);
 
 	return 0;
-- 
2.30.2

