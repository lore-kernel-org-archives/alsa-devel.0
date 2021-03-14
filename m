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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C11C433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:52:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866C564E51
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866C564E51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 131F917D8;
	Sun, 14 Mar 2021 16:51:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 131F917D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615737169;
	bh=ZfEjQD6vml11tT8+GwfnTrPvotB2NMus3N7hexGM88E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oKWT/AMzKYR6wkfRLwzuBLP2niYTSy0qRkSEEr3u36TjW0Li4H2+YUWlSvrxHwp+H
	 8rBKQvCxeWKP7VexLx11x5vcqnL0WxS8zKBlxWv4tguYiLJsKhld41o4SLg1HiNiMG
	 MsC3JFGMPtcfXrV8BIAET6gQXk/4d83cEZE1AUZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAE1BF80528;
	Sun, 14 Mar 2021 16:46:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09DDEF804AE; Sun, 14 Mar 2021 16:45:54 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 377B7F80430
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 16:45:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 377B7F80430
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bRLNLTAB"
Received: by mail-wr1-x42a.google.com with SMTP id k8so4445373wrc.3
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QpHXgChknEzhzYi4Q8rqZSYE4y3Oym7aFx47bTQjCRA=;
 b=bRLNLTABvbDYFY599i2T//8iHkJMDYKj6tzFPHL5SRb7AcALZZ0tKjQ5HdxlWBKjWt
 SyQ8A7RJU2hkiRLLJtJhOPzsDbpsLT/2dkHYZfviDM5OBmhMUumILoFGotrAY8soWdmY
 iKzKwqaZgmgpZsx5W23qofLLZaie4fRDfIg01+S70kAdvLXNbGAfhkNN4dnyZehpkVYV
 nF8qR7+vHHQikU6mecPKMNDN5E/JQVnRhgn2B8c8Njs9BsUUJIR9PewiDzSTy3aUCMn2
 1hmnjgAZXcjogfiAAxxCg4d3gfteOrRJuowIVdRkdmpzvi3bDsxpD9bUkaEDeAgVzEbc
 CMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QpHXgChknEzhzYi4Q8rqZSYE4y3Oym7aFx47bTQjCRA=;
 b=RwH0eI4ZeKdjfPB5RxLTSRwEr32cp00OsgZbhQfiFuiSwxFyYXz6LpmgPdIps7yFAm
 ZlELEcplLBO17FCckdGZM+WlqStK8WFDk2T63HMlOXxKercFPWLnOyxdIhRmuUeqONCQ
 J+vEUISne3/08L7nMrkam0CRd2LE/jFbu9j4CjaDVYb17+clOBJEDdBCKL0aDvC/FgeM
 VvOm0RvFzchmek69DBrpysHVH3Ur0S6R3IM7BUdMVi2Ukc/L8xP5g/NDfZ2DkZ0L91bT
 yEy/nxGiiqRqgjgDnULTDVaLADonIZT4/8Ilx3JZDPAvpgG+FPF+OgCtptca/F1AjZwT
 S8wA==
X-Gm-Message-State: AOAM530Hk8EBHESyIbTdglJRvIjMz38TELWCGo3qlT7TX6C8C7L5TnUj
 3fo9BMwbTFVZsr6yuSdnkcI=
X-Google-Smtp-Source: ABdhPJyd0+Gt/PLPpYiHZG8ky3XiLj8yZZzNOhE6OO/1QCc4KEUkdkf0+qyy74cpcV5yufuKG140NA==
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr22810754wrs.34.1615736731999; 
 Sun, 14 Mar 2021 08:45:31 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.gmail.com with ESMTPSA id f14sm9673507wmf.7.2021.03.14.08.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Mar 2021 08:45:31 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v5 11/17] ASoC: tegra20: i2s: Remove handing of disabled
 runtime PM
Date: Sun, 14 Mar 2021 18:44:53 +0300
Message-Id: <20210314154459.15375-12-digetx@gmail.com>
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
of a disabled runtime PM from Tegra20 I2S driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_i2s.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index fe569198b17a..1b27f81c10fe 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -401,18 +401,13 @@ static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 	i2s->playback_dma_data.maxburst = 4;
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = tegra20_i2s_runtime_resume(&pdev->dev);
-		if (ret)
-			goto err_pm_disable;
-	}
 
 	ret = snd_soc_register_component(&pdev->dev, &tegra20_i2s_component,
 					 &i2s->dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register DAI: %d\n", ret);
 		ret = -ENOMEM;
-		goto err_suspend;
+		goto err_pm_disable;
 	}
 
 	ret = tegra_pcm_platform_register(&pdev->dev);
@@ -425,9 +420,6 @@ static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 
 err_unregister_component:
 	snd_soc_unregister_component(&pdev->dev);
-err_suspend:
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra20_i2s_runtime_suspend(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 err:
@@ -438,10 +430,7 @@ static int tegra20_i2s_platform_remove(struct platform_device *pdev)
 {
 	tegra_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra20_i2s_runtime_suspend(&pdev->dev);
 
 	return 0;
 }
-- 
2.30.2

