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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43256C2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:51:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FF3520EDD
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 07:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QcZf/ncT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qelMKJ2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF3520EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 597931676;
	Thu, 29 Oct 2020 08:50:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 597931676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603957892;
	bh=mwfeELsdpEZWHfgrlCey+Pdv9B5CeCHD1iXouVtw5WA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QcZf/ncTQdSytW5BhdLX86XIKzerG1UNK00YS4DF2eQurdzGNttLaSgaiBVorlTyO
	 YK57ocGDLYvnlSHzdPogP373nGLIYAN88kClGzJ06JYFSnNI71TtusaZSUae42ePHn
	 VXrlmb7jXPXvjHeX9daNmGxuykg6+FzwVDpB/s4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 31A7BF804BB;
	Thu, 29 Oct 2020 08:49:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E634FF8020D; Thu, 29 Oct 2020 08:43:37 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37194F80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 08:43:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37194F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="qelMKJ2W"
Received: by mail-pf1-x442.google.com with SMTP id w65so1658303pfd.3
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tubacnQpwB3/W2PhhRu24urvA3DZqPuQW1vT0viMV9c=;
 b=qelMKJ2WSeEmQYBOX1ZKDe81Ga6Ri3W0Vyv+XB3IPPvJcxS32qo9MAPakdGNGTBBbq
 zrqOzulmZraX3Q7qsRKvDDYFQk7udvuSECmgQJGPxjaJ6Dr+7I+ILcb+r8U1KjI8UTmf
 qxc5S4bAEM1nkq0i7esFIzTiCzQOfn0OVOaxCogYvzwU4DGlF/Z9ok/mfJXLwovnkcZ0
 3C4yEoqwfNwBYF6tlPYKL63YLgSKl5BnMVy/m82jOBhOcCQ1eL7fINId/h/LLGtWaYUW
 LErPqdvsFq6LiV/7vIWgSrlgaxcgFLkvhhD1mZlYPmchGJHRK7ThN521grVT1fGzcAz4
 kvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tubacnQpwB3/W2PhhRu24urvA3DZqPuQW1vT0viMV9c=;
 b=nONWm6AM1AeWQe8hx26RhhPQVcTRN1Iu/8N2pTw+vpyTuP9/Li5WHpkI6SxH3OhBOs
 eMXBiVrCgj4a/JfFKpSFkKaXGxxwLVNu+4NDF32NEjliEwhGH5iZ8nl9/o+UmguM7As9
 PU1tjBDO7Htxg+Xk6p+BBJaMLNcs18PEiJPLoOiPH7xlNGBJzCIfQNg366PpAwpUF++a
 WZnVUk1Slbz808smfnmRjZi/Sm1byL38ozEBriwGEBpObfiOxJ4l688C8rxVWPZ0rDrp
 AzujST/kX7uBXEZEGd88e6bdYxIfg0NoIB8ANPjbEREBQA4iEoRfqVljkyEaYx9nezPp
 s5yA==
X-Gm-Message-State: AOAM531sUGoKO7Cb7am7cwcBQpTrYbBPENqKbZgPh3xO7zLivz8eVBTr
 RfvIels00uH/w+82e7m4c94=
X-Google-Smtp-Source: ABdhPJwfCpKPCpSPUWy+Lzj+iwnX+ql0BPKlVGcGxkFcgc7JIGCDlh6SjXrSCFSf54pnToB9lwi7Hg==
X-Received: by 2002:a63:7e4f:: with SMTP id o15mr2971579pgn.428.1603957412989; 
 Thu, 29 Oct 2020 00:43:32 -0700 (PDT)
Received: from localhost ([160.16.113.140])
 by smtp.gmail.com with ESMTPSA id v4sm951756pfm.57.2020.10.29.00.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 00:43:32 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 02/25] ASoC: fsl: fsl_ssi: remove unnecessary CONFIG_PM_SLEEP
Date: Thu, 29 Oct 2020 15:42:38 +0800
Message-Id: <20201029074301.226644-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2020 08:49:54 +0100
Cc: "moderated list:FREESCALE SOC SOUND DRIVERS" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:FREESCALE SOC SOUND DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
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
 sound/soc/fsl/fsl_ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 404be27c15fe..065500a4cbc1 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1669,7 +1669,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int fsl_ssi_suspend(struct device *dev)
 {
 	struct fsl_ssi *ssi = dev_get_drvdata(dev);
@@ -1699,7 +1698,6 @@ static int fsl_ssi_resume(struct device *dev)
 
 	return regcache_sync(regs);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops fsl_ssi_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(fsl_ssi_suspend, fsl_ssi_resume)
-- 
2.28.0

