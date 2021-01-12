Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBA6C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:01:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0640123117
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0640123117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F36716E8;
	Tue, 12 Jan 2021 14:00:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F36716E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610456475;
	bh=K5+JYAQYo+AidPSotuCndFBykdWMadi34AXGKpPEf0M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVzvo8/6PYXulEtucBul4bE+uh6yjvlywAa5tB/Jyl90jINtc0a5Z+X3wrMSar9tZ
	 yv7CJBzlOnGVEjcVbZsb1Qw3/vPR6kNWNcphHsyVowyNRtwDBCnQoFu5UGQe+scnb4
	 1e/0Zazvzv589m5Z9Q3+QvM+DD4rRMeNBYlsKx40=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52040F804D6;
	Tue, 12 Jan 2021 13:59:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC344F804DF; Tue, 12 Jan 2021 13:59:29 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A38A4F800EB
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 13:59:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A38A4F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="SZvxWZU5"
Received: by mail-lf1-x12d.google.com with SMTP id o17so3234285lfg.4
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 04:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/HJcNkl5nY2t78OqKeve4KEQLTFTI0WusBFcveQbI3Y=;
 b=SZvxWZU5jtXaZBiFOiUZMu98ooM1VwI1kj9mG6vlqmCv4ys2GnpwNHVRUpfvNScNRb
 ntv2kKjpGNxmtbBZ2NeJjOU3GzN4oTjCay44Hnvpd2tn96K2eS8nzcsjRmdo2G/loc3h
 K4EjWnB7Izgt3mwocLD8tdpedPAjDu0naVleeToWGgN33QEwERj52bpIY0V2Uvl8P7Pv
 Ny3rB8Ss9XjokprFxbYF/ZEsvTwDZcUcbIDDMxUW0Qz4mpJ4oWhNhhXGF/YH7v4KdDRC
 Y+ViCHaS6+ScdFpzWR/MKrFmPtFZF7w+7fw0yvOvpc8oJ9nv48oC8SxxLsDvxhRyIuoO
 44aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/HJcNkl5nY2t78OqKeve4KEQLTFTI0WusBFcveQbI3Y=;
 b=bQWt90A4otdLuA8TyV+0KUVgbFyE8vF1MSiGxk2UZgCnozhJ8284hxaK7/4lz/5FTK
 9ZzqpkElCBPaS3+UYWrz4FmSmKK+6oyQDndabYHXNZcqNhEz0S7cT63U1BIbIAxOgh2w
 LNr+t0kNkI/Gk20VonhvyBHNYvDARsEldBgiVoNnSdhEmgw7iKLdTXp8dBlpUM/oJ6aI
 K7KIOS0k7CQoIHj4cKoWi29Wq55FlPDbHcEu/41vh4TMFWzqOM4ObR1vw2xaYVDVL32h
 m97+Pn4aC4sj6WYNQLNwhl5UBQ4+p1yzjAkjFxw9O6PMzpQvLKK9CGoIPr0tD5oOBHRN
 bGuQ==
X-Gm-Message-State: AOAM531bzbe3NbNeZ4UqgW5ETomLOEsxT8uzRbJ8u6V3zIhfQZbB45EO
 I7qt2LjR7bFdxfCtHl72n8M=
X-Google-Smtp-Source: ABdhPJzddiXeMJzKEZTcHQxQ5aGewHJJB9sTdUVVkIaXRul9O3svaRqJU1kH5fYbL3uBqHhYx/Ah7A==
X-Received: by 2002:a05:6512:504:: with SMTP id
 o4mr2352275lfb.398.1610456365037; 
 Tue, 12 Jan 2021 04:59:25 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.gmail.com with ESMTPSA id 192sm384211lfa.219.2021.01.12.04.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 04:59:24 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 Peter Geis <pgwipeout@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v1 4/5] ASoC: tegra: ahub: Use clk_bulk helpers
Date: Tue, 12 Jan 2021 15:58:33 +0300
Message-Id: <20210112125834.21545-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112125834.21545-1-digetx@gmail.com>
References: <20210112125834.21545-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

Use clk_bulk helpers to make code cleaner.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra30_ahub.c | 30 +++++++-----------------------
 sound/soc/tegra/tegra30_ahub.h |  4 ++--
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 1e9767c75b11..4dbb58f7ea36 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -45,8 +45,7 @@ static int tegra30_ahub_runtime_suspend(struct device *dev)
 	regcache_cache_only(ahub->regmap_apbif, true);
 	regcache_cache_only(ahub->regmap_ahub, true);
 
-	clk_disable_unprepare(ahub->clk_apbif);
-	clk_disable_unprepare(ahub->clk_d_audio);
+	clk_bulk_disable_unprepare(ahub->nclocks, ahub->clocks);
 
 	return 0;
 }
@@ -66,17 +65,9 @@ static int tegra30_ahub_runtime_resume(struct device *dev)
 {
 	int ret;
 
-	ret = clk_prepare_enable(ahub->clk_d_audio);
-	if (ret) {
-		dev_err(dev, "clk_enable d_audio failed: %d\n", ret);
-		return ret;
-	}
-	ret = clk_prepare_enable(ahub->clk_apbif);
-	if (ret) {
-		dev_err(dev, "clk_enable apbif failed: %d\n", ret);
-		clk_disable(ahub->clk_d_audio);
+	ret = clk_bulk_prepare_enable(ahub->nclocks, ahub->clocks);
+	if (ret)
 		return ret;
-	}
 
 	regcache_cache_only(ahub->regmap_apbif, false);
 	regcache_cache_only(ahub->regmap_ahub, false);
@@ -509,19 +500,12 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	ahub->soc_data = soc_data;
 	ahub->dev = &pdev->dev;
 
-	ahub->clk_d_audio = devm_clk_get(&pdev->dev, "d_audio");
-	if (IS_ERR(ahub->clk_d_audio)) {
-		dev_err(&pdev->dev, "Can't retrieve ahub d_audio clock\n");
-		ret = PTR_ERR(ahub->clk_d_audio);
-		return ret;
-	}
+	ahub->clocks[ahub->nclocks++].id = "apbif";
+	ahub->clocks[ahub->nclocks++].id = "d_audio";
 
-	ahub->clk_apbif = devm_clk_get(&pdev->dev, "apbif");
-	if (IS_ERR(ahub->clk_apbif)) {
-		dev_err(&pdev->dev, "Can't retrieve ahub apbif clock\n");
-		ret = PTR_ERR(ahub->clk_apbif);
+	ret = devm_clk_bulk_get(&pdev->dev, ahub->nclocks, ahub->clocks);
+	if (ret)
 		return ret;
-	}
 
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs_apbif = devm_ioremap_resource(&pdev->dev, res0);
diff --git a/sound/soc/tegra/tegra30_ahub.h b/sound/soc/tegra/tegra30_ahub.h
index 5a2500b4ea06..063aed5037d7 100644
--- a/sound/soc/tegra/tegra30_ahub.h
+++ b/sound/soc/tegra/tegra30_ahub.h
@@ -510,8 +510,8 @@ struct tegra30_ahub_soc_data {
 struct tegra30_ahub {
 	const struct tegra30_ahub_soc_data *soc_data;
 	struct device *dev;
-	struct clk *clk_d_audio;
-	struct clk *clk_apbif;
+	struct clk_bulk_data clocks[2];
+	unsigned int nclocks;
 	resource_size_t apbif_addr;
 	struct regmap *regmap_apbif;
 	struct regmap *regmap_ahub;
-- 
2.29.2

