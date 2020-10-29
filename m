Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33359C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:53:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566CE20782
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fWvVcYyp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6yk89vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566CE20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3952166D;
	Thu, 29 Oct 2020 08:53:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3952166D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603958033;
	bh=ySHldnunD7enUs04BlkeCA5RbYH6rX3c0OJ03BNbGJ4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fWvVcYypTr8W0QsuraMj4oYB5n8ejKMrdgMl2MgI7fw7tVeD+4CUNPbEZDZ4DtZp+
	 4Wu7UpVQHSzepuhZ4QRlDEKsHaqc0aHl9+yyMYU07P2C+5mT5/bL1Pp5mcYEAwhwKU
	 1MGAseVK6yKIXvvN0bAsTwSP95z/WztO7v4Bgw14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B0943F804EC;
	Thu, 29 Oct 2020 08:50:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 01AC8F800FF; Thu, 29 Oct 2020 08:44:10 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2262FF801D8
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 08:44:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2262FF801D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="f6yk89vg"
Received: by mail-pl1-x644.google.com with SMTP id p17so880945pli.13
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 00:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TpBMm8g68pTx9DqIx3h+hx1vGqrNoMOX/Q5L49wwIlo=;
 b=f6yk89vg+qNSCOZtGKP6o4XSw44ktFR5O/1XFznnntptHHnL0+qBgyXM4wq7ghfeyo
 I3JupIjev6TG41pCUKUEOvPuEywsgWMReZZ7NlzrqcAPpjMh6Pxlj/WGA4SkEjbP0qwC
 vjv495mn1+cr0bglnS2V4hf4SCXBwYTrSJQZst+MQDNfWnb4sZB40YXw6u66l8FXjNY+
 w0E4lPqr7m/ENjVS/PeGpCEc85t1xSQ1/hznWT9to1SyQBNi3sj5JOVagFg2IhtRunmf
 nJUSVpTKk6c842awUDRUOdSHzH+SgP2oOEz8o5iIXjf5qrm+/+4hD5RgzvbR8AotFXS6
 ec6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TpBMm8g68pTx9DqIx3h+hx1vGqrNoMOX/Q5L49wwIlo=;
 b=JTExPUta0Gg+eQBRue6uxTVoQCybFPzDdFEBUgId5v4kEvICyi4xtDqJ1w1nkJyQxH
 KC8G0S6W5kslpXEDnL0jZGPnsUJrlCkMn5rLmRwC4UHPjbhB5ZuFTYtci9raTeAbemG6
 veArjIIGia+Ez58qm4xEl5q7ziETcbbDTxMovkHMrjYJBlnbf6gT6QhufujWFvoKKcrj
 7SqFthGwzdyQvLaaQLsGfxaAp5BQ0PXnn1QRTstd1x6H7Z0qY5Ph2+gLFqGSRj9eD1RC
 An0Y+l3JxxKej5ek9hJUCnGjl3B1i0DP7M22qk+sAJ73NYysVMI/SAMT9Jr7vmqGz09Q
 KVrA==
X-Gm-Message-State: AOAM533+Y/TuwuhOoGH7C2FUvMSDlIpsUZhote5MZEQzhSxgiTvpyIx1
 Oybv7XgHH+U317kDtyCpDB/H3GIEwGRkzRlV
X-Google-Smtp-Source: ABdhPJyJYs8Hm3RbNRVfredcnwtafkPurb0Ozj/n6XbH3XxzaDaN5PEg476VGV/RBDSEyV7o9cImKg==
X-Received: by 2002:a17:902:8647:b029:d3:d448:98a8 with SMTP id
 y7-20020a1709028647b02900d3d44898a8mr2865766plt.29.1603957445560; 
 Thu, 29 Oct 2020 00:44:05 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
 by smtp.gmail.com with ESMTPSA id n6sm1562177pjj.34.2020.10.29.00.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 00:44:05 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 08/25] ASoC: img-i2s-out: remove unnecessary CONFIG_PM_SLEEP
Date: Thu, 29 Oct 2020 15:42:44 +0800
Message-Id: <20201029074301.226644-8-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2020 08:49:54 +0100
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>
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

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/img/img-i2s-out.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index b56a18e7f3ac..7693b7fdf299 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -551,7 +551,6 @@ static int img_i2s_out_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int img_i2s_out_suspend(struct device *dev)
 {
 	struct img_i2s_out *i2s = dev_get_drvdata(dev);
@@ -598,7 +597,6 @@ static int img_i2s_out_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct of_device_id img_i2s_out_of_match[] = {
 	{ .compatible = "img,i2s-out" },
-- 
2.28.0

