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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C1C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:58:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AED920EDD
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gFm4fLSq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hpu37JgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AED920EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA28516CC;
	Thu, 29 Oct 2020 08:57:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA28516CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603958318;
	bh=qsd7pfkk9HTdd3RIaXjT9P0kIvedgDKnyyES52JNcPA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFm4fLSqQbsUTrspg0+IX1Yl3ilaUDu/yVDyzlwwmHc30rwxbvavRqg1grZZ6Pona
	 CYuK1F9JBuJ3TSATXvrEcunyT/4HS17OmY6iC74KyVE5tXWTJjlwKsAukI7O+enrKI
	 0twRZbM+27vqLwQJQHZ8bzAJwYzopu3+rHley8So=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 37F64F80553;
	Thu, 29 Oct 2020 08:50:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 829E9F80217; Thu, 29 Oct 2020 08:46:14 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95023F80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 08:46:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95023F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Hpu37JgW"
Received: by mail-pg1-x542.google.com with SMTP id r10so1644010pgb.10
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 00:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xjj5xWJ9FV84cpQMmB6KMC3hiQFFHX6QXSYfK7Sl5ao=;
 b=Hpu37JgWrjQxEt663nH8uB2W7ILKGM7z3qWFfZpgnrFEcFeIK3xA0HVQKLh9KN1ZX8
 lHIsLEyPhyxIOJ+MBSD2Z84N7PqRxaK7sNQ8w71VniGjrOWPkMc9kcbKBojWUgS3//eZ
 YbWjZ2J3ssSKoU0kFW3wq8wl3SK+4zQwCVACHu9AqJH3heSnU+AdUSYQ+yv2kLTW/kqS
 2WSd9YZ4ID400GWfQQnmOkabwZWpwu1kzJ9QDZZrkR11bW18dtazy4hOAi/YVSFcCpCv
 9gamosSezd7HxtU8h+Py6VMH50ocQn6P5g5pmaj4s6rvu2Sk2yg8Yt7MSR/GjI6Qewlg
 dvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xjj5xWJ9FV84cpQMmB6KMC3hiQFFHX6QXSYfK7Sl5ao=;
 b=XfEj6RGRiNQ7HIt52rshUPblPjoGl+7XQTLaqZ5Oi5I73MWra8np2exVfcgMPK9Ey4
 ccXAAMTAbiQUZ/VWEz70lqvVcNwBDxq0lhzGXrvhXzSBjzQi3zisUF0EEsK14GAPiWL0
 sWQzTKK9ZqNiT7zcvv4AvC+vQB36YVrPdhrQUE8pRjdmrF1xusWqZ7SsSQQI4yjXWlXp
 k35/RLLJN9QjkVWrFks09IFxGExf7GBN4UP/18JfxrUYopg4Fb/opt7rFDx6IlUjx9yv
 CLbVoEBZBJR8hkhVMKen+IIjs74a0etC/hLGds+2Rzl4BoU5iWpkwgmIjZwNLvVrgf8y
 CcXw==
X-Gm-Message-State: AOAM530u1cQylFlZyCys3eKtqWr1HVGabQFlaMqFZyK0OFFpxD5S1/sP
 RPdI+WUHJHX1lnfGUxsqaFs=
X-Google-Smtp-Source: ABdhPJxi3eINEcdp5sUgDPI05F5UZjtYEVshNYP+69Q0bVkg2BZFWVCs06Kcmm+RLdaDBnWSQPWT4A==
X-Received: by 2002:a65:41c4:: with SMTP id b4mr2195258pgq.223.1603957569666; 
 Thu, 29 Oct 2020 00:46:09 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
 by smtp.gmail.com with ESMTPSA id 38sm1564272pgx.43.2020.10.29.00.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 00:46:09 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 21/25] ASoC: codecs: max98090: remove unnecessary
 CONFIG_PM_SLEEP
Date: Thu, 29 Oct 2020 15:42:57 +0800
Message-Id: <20201029074301.226644-21-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2020 08:49:55 +0100
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
 sound/soc/codecs/max98090.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 945a79e4f3eb..97175d7c99cc 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2636,7 +2636,6 @@ static int max98090_runtime_suspend(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 static int max98090_resume(struct device *dev)
 {
 	struct max98090_priv *max98090 = dev_get_drvdata(dev);
@@ -2653,7 +2652,6 @@ static int max98090_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops max98090_pm = {
 	SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
-- 
2.28.0

