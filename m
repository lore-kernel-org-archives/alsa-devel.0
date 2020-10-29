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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA98BC2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:58:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27E720EDD
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LnLtSQHZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwqb1spm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27E720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FAD216C8;
	Thu, 29 Oct 2020 08:57:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FAD216C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603958293;
	bh=pMlbAqa42LVACxmlliCo297WZrrSwNyGxDdqP0AIGsQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnLtSQHZ6ZrYJLRr6qUhE8JHo0rWYCrUT3cBBlGRAhIWtdFMxDPGMlp3IIQf4PZkQ
	 LTrkt04ZoTTDQScpInPva5DAL7mfkxnt5ikye7Go3DUdRt09C10Ja1elUEl9uGzvUC
	 JSNCS7dyVkrg1ArUiHNv8EdSEMQEwtzaidgqNfKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 161F7F80544;
	Thu, 29 Oct 2020 08:50:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 344C3F8020D; Thu, 29 Oct 2020 08:46:10 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3F9AF80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 08:46:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3F9AF80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="fwqb1spm"
Received: by mail-pg1-x543.google.com with SMTP id o7so1659864pgv.6
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+fK2OKGG4p6bBRTtmFHio3t91tYIgqc0DsdsIh3WcuQ=;
 b=fwqb1spmwvHpmlB/d75reyt5h4z8ocPuPqiM5mdXJ4T+5K5P3vH0oGF9ARZygflH/n
 U59mds2tnw0KPqvD29hNFDxSwvdfFFSzpCI4IGontMbmIKSaxNNPCF4tw5aoKCQUILjf
 N11tN+SfI+XP8CxhR62N6F6+XoeJUE3do3F09QQSOuiFikVLq24Wwp3noTJuy38yAECR
 IgVSb8K4cMuuvyYHHNiJ6exSrBlwaRDuAjY331AnzGIoxHudk34o+2Ox6ukP6llzNVRs
 URWyEEeBofEw8Yte+xw7m/TpGD6vxdNPm1tNJRbdBV+5Jb9Gj/ApIa8FsuMTAppW7g5+
 d9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+fK2OKGG4p6bBRTtmFHio3t91tYIgqc0DsdsIh3WcuQ=;
 b=NdJJ2sYV1EOhUuDMiA6Z6ZLI4ikU5NaD3fP62lEfm50A66SabshdsdsDH2ShoMGNT5
 xR5NmVHmHnpijPBVaWFOgJ0qsgErMwyjItSlJIN8Q5WMZaLZi5TOXInsrm1/bqHFRimo
 mORL5c/PstDq65u32x27s+CJ6hiW6jltMOLlsW/6gZNyZOb+OQfQ+RMhjWmLbEaF9tdv
 0Z6IygcM90dhOT3YTtY1Z+QHmaf6flmUPDNqCx6vLJcrdXlh/bxRpV7jc0stmhGSAxMT
 9J0i0Dh+w7nUQcf9cHGIMpQB+Og//bCEHgCiGSsCRBu9reMeqzR4shjq81EwGKBzdmJI
 WZHA==
X-Gm-Message-State: AOAM531kQYMRb9aXiEhYLWq3ONb1oLa9/OcTwggMYiyff5wzcIfsj8kO
 bVKyqMslKmTE9d3DtOqexvw=
X-Google-Smtp-Source: ABdhPJxAard+MstQQ74IvRjEm3mHbgNxVhSDNfaQyzhEUf/VKrm9IqsMsBxCjyNF9MRXU+CSHRKg5w==
X-Received: by 2002:a17:90a:348e:: with SMTP id
 p14mr3047577pjb.75.1603957564962; 
 Thu, 29 Oct 2020 00:46:04 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
 by smtp.gmail.com with ESMTPSA id e5sm1945312pfl.216.2020.10.29.00.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 00:46:04 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 20/25] ASoC: max98390: remove unnecessary CONFIG_PM_SLEEP
Date: Thu, 29 Oct 2020 15:42:56 +0800
Message-Id: <20201029074301.226644-20-coiby.xu@gmail.com>
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
 sound/soc/codecs/max98390.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index ff5cc9bbec29..50b37e39bb6d 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -889,7 +889,6 @@ static int max98390_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max98390_suspend(struct device *dev)
 {
 	struct max98390_priv *max98390 = dev_get_drvdata(dev);
@@ -913,7 +912,6 @@ static int max98390_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops max98390_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(max98390_suspend, max98390_resume)
-- 
2.28.0

