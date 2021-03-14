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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B67C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:47:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A54B64E89
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A54B64E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08CAD171F;
	Sun, 14 Mar 2021 16:47:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08CAD171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615736872;
	bh=U5IMjyILfVOzG1qqR8+mgv2ghD2dKifB9XlpewxvE/M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oi6MOu6aVc5Mx2kprdNnvG11uKKQHTzeENJ1ag0J4mAj6GlvGxmH7yiXcRm256wMk
	 upgCClMxHuMd5IQQuI58HWje2qMTQsiFoMhSGMG7fArdmYEup7sZmZpv2yyLSvtRlR
	 n/lEZKKc+XgIHhgmMoN58BZrJcefdH1WJUqspYXc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D63FEF804AA;
	Sun, 14 Mar 2021 16:45:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03885F804A9; Sun, 14 Mar 2021 16:45:36 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 18EA0F8026A
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 16:45:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18EA0F8026A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="R2KJrX5j"
Received: by mail-wr1-x431.google.com with SMTP id b9so4456921wrt.8
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iCLWBBqHBwluoiOOJDI5uMrTVFtzy0ArpO4aAlC/nzc=;
 b=R2KJrX5jiM5ZduJ6elrOV/mm2ZzDVmxC9t9WAmsRmyga5VvtJVcz7HJGwSvAta+XII
 6o96r06jdZIFr1GjOIpus/TyOPmcBH4HkvO5OMzu9klUJ817u3lRezSilzmZL8uamtEE
 pO5PNFObIb9A595AWwP6spAQfX44z+LhnrPHjI4f+XZsGR3mHb86yD4U9Q6RKzaqIHeU
 GeTWbF4lvo5Z8eHueZTtBdjOONkmtODi202CTD+BRhIUJpU2cce+Tk8AeCjZGSpwTNFd
 rCSZy8nPJ7X2FhsOpX/QhgOFNQtiqGjKmrsN/EEAz4/C6XligZMICxE6zJTLfHqhpskf
 BA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iCLWBBqHBwluoiOOJDI5uMrTVFtzy0ArpO4aAlC/nzc=;
 b=GpfsOynTnGyZ0VojkPFABrXZrg+yQ7axce0usgQKwC0vLxBsfrcLCG+cBFgSnujuna
 FxkvKtl+zphWBrQ4diTqhh744jiB6LIsyMPpuFNjLk1fTdIWIOOCz4uJRkwsLWtoBCQ7
 Q27+UuBU5GLmCkwqwmmLg65CAWsnSTuqy2BipdpPpt/i+aONoQmRnVcU/nCV9TZqNPQA
 J8Xz/3qk+s6yAQy0etEgf5L8MTZr54AQpWIa9MR60tFlrYamlHznLXviHOVp1ChTS9Op
 apChh2zirVXuWXpUhZQlcRRZzh6pPKtNVcl1dNUXnfyouK9BkuxmJfbkGFWsdLPV/BGy
 rjnQ==
X-Gm-Message-State: AOAM531aUoY38HCguytb3BWzqQT3hjTjHu8Wp8jgFIgQNyzuDAvAWdlV
 W0gEaRkS4RDPGzQuaBsM9vYz59Ab6+8=
X-Google-Smtp-Source: ABdhPJzrCmAwXQXLkCinKkRoszXsLepF9evCyigdVm6SFGYqK4jTQojMCwnap9KNm9463wv78u6a7g==
X-Received: by 2002:adf:9bce:: with SMTP id e14mr24516002wrc.29.1615736727677; 
 Sun, 14 Mar 2021 08:45:27 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.gmail.com with ESMTPSA id f14sm9673507wmf.7.2021.03.14.08.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Mar 2021 08:45:27 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v5 07/17] ASoC: tegra20: spdif: Remove handing of disabled
 runtime PM
Date: Sun, 14 Mar 2021 18:44:49 +0300
Message-Id: <20210314154459.15375-8-digetx@gmail.com>
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

Runtime PM is always available on Tegra since commit 40b2bb1b132a
("ARM: tegra: enforce PM requirement"), hence there is no need to
handle the case of a disabled RPM by Tegra drivers. Remove handing
of a disabled runtime PM from Tegra20 SPDIF driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index e48d332506a0..7b597ee63cb5 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -294,18 +294,13 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 	spdif->playback_dma_data.slave_id = dmareq->start;
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = tegra20_spdif_runtime_resume(&pdev->dev);
-		if (ret)
-			goto err_pm_disable;
-	}
 
 	ret = snd_soc_register_component(&pdev->dev, &tegra20_spdif_component,
 					 &tegra20_spdif_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
 		ret = -ENOMEM;
-		goto err_suspend;
+		goto err_pm_disable;
 	}
 
 	ret = tegra_pcm_platform_register(&pdev->dev);
@@ -318,9 +313,6 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 
 err_unregister_component:
 	snd_soc_unregister_component(&pdev->dev);
-err_suspend:
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra20_spdif_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 
@@ -333,8 +325,6 @@ static int tegra20_spdif_platform_remove(struct platform_device *pdev)
 	snd_soc_unregister_component(&pdev->dev);
 
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra20_spdif_runtime_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.30.2

