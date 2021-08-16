Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06059C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 21:17:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA6A61052
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 21:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BA6A61052
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A749A1664;
	Mon, 16 Aug 2021 23:16:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A749A1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629148624;
	bh=kU1dHfBGIiB+lL6u/dWeJXq07GEDV0GGo5cTgY7VwJg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ue57Jrrkb2B/Gf5GQZ3cqIiKfoktE5KbHiQClTKLFo5e3nad54lJmIvsPddRqToMM
	 iJes+EDECnX9ioFXEKUjaobP/wAw0JTcHR5vz5y4rhmmZSU5yAtC6Tg8hnxTQjDvzK
	 RgKKByKPArucIGe35cdU5IJN6dZeClDH5QLq/3Zs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC8A7F804E5;
	Mon, 16 Aug 2021 23:15:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 139FCF804E5; Mon, 16 Aug 2021 23:15:24 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F05EF8028D
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 23:15:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F05EF8028D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="t4xoxQNZ"
Received: by mail-pj1-x102b.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so1036173pjr.1
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 14:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g1dC/n65USYYjusFSHlK9vgvBZI+Oht+fJhBix7TCeM=;
 b=t4xoxQNZT+ddH/5CyxnTOTAsIOrlFK0h8YIrmhdRIIzq6YqwuYzLmD42x5ufOdt2Kh
 Qjz+yojzhOH+R2Cqvujce8uwq4FQ4yKFuZZ4tWTqbh+Mzm6oOzk485L6ViKdzQRJrK8k
 vrcOIX6Vi10mJirmOboPGb1aJLkvwNJyPUjquLbdSyOy3w3e/0Sr/kIFfXhu6GFwBqGk
 B5knjVopEOwgh63nDkMMLz1TrLO+TgsXvnhcM9ZkxQtB7o4pM+A0Q04hKsvcNTLXD6Tr
 GKVEitBx67K+T66SO1CNCAm61aLGbE6ZsnI2HmOc8bhSzI26WuyNC6Dp/meCt06I+Wfn
 +FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g1dC/n65USYYjusFSHlK9vgvBZI+Oht+fJhBix7TCeM=;
 b=r3l8ivzD3JnKW+tU7Q4p8YAug/4E/1XAHcPbaMhCa1yrxBHJF2mhIOfxud/xGEALYA
 EvNFzodFAH34pcoaAambFmGs89bOHifGl1j6OcHsTb9XmXMj8ht0Eei6Szwxh2CKZsGg
 DaOeN1oybL829/Aw4H90Wl0Joy8NnV5u5rExh/AqnBYDS5ceGGEcQveflH3oYF+Lqk0E
 3LmdatU3bH7AR1AV9zjLoCKm2fRocDudWr4IEmXJ8gw1feAXQdmJ4b3PY7ebRFFpPGpI
 rDjcjBNAwzjZgisnAiAwTv0ha9JQkCZCAtuhvufJCAON5fkLA3YxBGuMUhkDtTP7OD2o
 5SwQ==
X-Gm-Message-State: AOAM533CHk1KvmA/jO4++Gb6KUQMJ1ke7AT5W+j2+h94oliX3ywigk3D
 Nff2U6RMhgUEp/xunP39jVs=
X-Google-Smtp-Source: ABdhPJxjLEm08f2XZOAIRQkKqH3kneBQs/5LROljNjO6HNA+l0EUm6jIrU0DDbEv3pH+REERz2pRUQ==
X-Received: by 2002:a17:90a:ee91:: with SMTP id
 i17mr605327pjz.67.1629148512230; 
 Mon, 16 Aug 2021 14:15:12 -0700 (PDT)
Received: from xps.yggdrasil ([49.207.137.16])
 by smtp.gmail.com with ESMTPSA id b12sm103154pff.63.2021.08.16.14.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 14:15:11 -0700 (PDT)
From: Aakash Hemadri <aakashhemadri123@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 2/2] ASoC: tegra30: i2s: Fix incorrect usage of
 of_device_get_match_data
Date: Tue, 17 Aug 2021 02:44:52 +0530
Message-Id: <4805c7fcd35c8deada63d41cb34d40de80f85a13.1629148177.git.aakashhemadri123@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629148177.git.aakashhemadri123@gmail.com>
References: <cover.1629148177.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Helgaas <bjorn@helgaas.com>, Thierry Reding <thierry.reding@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-tegra@vger.kernel.org
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

const struct of_device_id incorrectly assigned "match->data" using
    of_device_get_match_data()

Instead assign `const struct tegra30_i2s_soc_data *soc_data` with
const void *of_device_get_match_data(...)

Fixes: 356b94a32a75 ("ASoC: tegra30: i2s: Use of_device_get_match_data")

Signed-off-by: Aakash Hemadri <aakashhemadri123@gmail.com>
---
 sound/soc/tegra/tegra30_i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
index d4c5594efaf1..084a533bf4f2 100644
--- a/sound/soc/tegra/tegra30_i2s.c
+++ b/sound/soc/tegra/tegra30_i2s.c
@@ -406,7 +406,7 @@ static const struct of_device_id tegra30_i2s_of_match[] = {
 static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 {
 	struct tegra30_i2s *i2s;
-	const struct of_device_id *match;
+	const struct tegra30_i2s_soc_data *soc_data;
 	u32 cif_ids[2];
 	void __iomem *regs;
 	int ret;
@@ -418,13 +418,13 @@ static int tegra30_i2s_platform_probe(struct platform_device *pdev)
 	}
 	dev_set_drvdata(&pdev->dev, i2s);
 
-	match = of_device_get_match_data(&pdev->dev);
-	if (!match) {
+	soc_data = of_device_get_match_data(&pdev->dev);
+	if (!soc_data) {
 		dev_err(&pdev->dev, "Error: No device match found\n");
 		ret = -ENODEV;
 		goto err;
 	}
-	i2s->soc_data = (struct tegra30_i2s_soc_data *)match->data;
+	i2s->soc_data = soc_data;
 
 	i2s->dai = tegra30_i2s_dai_template;
 	i2s->dai.name = dev_name(&pdev->dev);
-- 
2.32.0

