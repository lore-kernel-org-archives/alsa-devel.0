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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0EC433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:01:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A82C2310F
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 13:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A82C2310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8150D16E3;
	Tue, 12 Jan 2021 14:00:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8150D16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610456509;
	bh=oSU07iLhTNAcmZSgB3NWPXYbLE3v52HEQa49sGvP590=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aIA4wfeYR2c+UK38aGVFPIkq6OOKwieQcqEhKK8rFdID865BUvpRzLqXHTC4ziE1t
	 HpHbCBJbSf30Zxqh/JnsHvAg8vx2A3c6rUy9LHwG+n1P7A597mBy6lPVeP0Ocom8gm
	 +NhWLllIA8Yh0nLvQQ0vs0mOzkrkhY3FIM4iIuSs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 795B8F804E6;
	Tue, 12 Jan 2021 13:59:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16918F804E1; Tue, 12 Jan 2021 13:59:30 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C8E74F804AB
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 13:59:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C8E74F804AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="eZFDw+8/"
Received: by mail-lf1-x12e.google.com with SMTP id s26so3202702lfc.8
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 04:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nOG+laR8Z5VOVTmF6Sy12FrgatG6zkwMpzVTv/S/8wI=;
 b=eZFDw+8/9/u7p+6fE1KA+XuOc6IySAthr3QWG7sQ9wciyLXHwxqPmnd2TBj2rmiMA/
 kvkYSkCtyWfbYYR1GhkIQIja6M0n4ZdDQkPxNXYonpGg2ZpbTT6nv4rHoLtcnmsAOn7v
 1a2pHxVLGmfZLtEfZbIRID2BIWylr3NOpnlH5hewfUN4WbbvXpkSsSH61ojjBcxot+/3
 Pbn/OIix7bCWfJvKDiDs7HmH4d2g5Ogh87fuKFDiKNJfiAjy6oFM+xrKiOvroIv50097
 fy6k2sTEeR0n5K2wzW3BT4iYqxel3GONb5JkzWRwq18luiUVjKAkFhnB2dRMATPo3rkq
 f6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nOG+laR8Z5VOVTmF6Sy12FrgatG6zkwMpzVTv/S/8wI=;
 b=Trhj6ZgnQZYYVuY2JjWfNUzlxAUIL4362TPbQI2huseT2fwU4G50MR7opDv2q/gI2V
 jPzhr8JvWZJvqmAWrr+fc3TELtGFNPcVIqrH46NrZiZbTMvqx/zr7vh0/PTQ1ggXrw6N
 n9AMve/NCMrnmhz3CZPeMsVQ7Gjsrc4+iExp70VMO0YcqdxqR2vAIlQMNaLHAIOuxcsc
 A2kC9EYZn3GclEuvvaj+H+dN8rVLcsAA7Fz7zDNy3lm/xH1IO1xonSSuoe3qfIFXe1TR
 Mby+B15jCS+iSM3av5TePWIEQduZUJJyLF68px/ipf0HRxLNoKLMdEuebQHYiTsjXYB6
 Cvfw==
X-Gm-Message-State: AOAM5307K0x2cORM4vDwKc86UUcDeQZZXXdFGCNZLwbj5M0zmyGGv194
 Mxk+Lb4cPHbDJxcUWsr871Q=
X-Google-Smtp-Source: ABdhPJzlh6OOuLbC8EC9OmOQTflk2L6Zk58HxRZ5bEDEI01eSz/ACM8jjB2rGcDt9/JBGJJ+N95Smg==
X-Received: by 2002:a19:6447:: with SMTP id b7mr2135081lfj.206.1610456364216; 
 Tue, 12 Jan 2021 04:59:24 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.gmail.com with ESMTPSA id 192sm384211lfa.219.2021.01.12.04.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 04:59:23 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>,
 Peter Geis <pgwipeout@gmail.com>, Nicolas Chauvet <kwizart@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH v1 3/5] ASoC: tegra: ahub: Use
 of_reset_control_array_get_exclusive()
Date: Tue, 12 Jan 2021 15:58:32 +0300
Message-Id: <20210112125834.21545-4-digetx@gmail.com>
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

Some of resets are erroneously missed in the configlink_mods[], like APBIF
for example. Use of_reset_control_array_get_exclusive() which requests all
the resets. The problem was hidden by the clk driver which implicitly
de-asserts the missing resets.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra30_ahub.c | 66 +++++-----------------------------
 sound/soc/tegra/tegra30_ahub.h |  1 -
 2 files changed, 9 insertions(+), 58 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 156e3b9d613c..1e9767c75b11 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -323,41 +323,6 @@ int tegra30_ahub_unset_rx_cif_source(enum tegra30_ahub_rxcif rxcif)
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_unset_rx_cif_source);
 
-#define MOD_LIST_MASK_TEGRA30	BIT(0)
-#define MOD_LIST_MASK_TEGRA114	BIT(1)
-#define MOD_LIST_MASK_TEGRA124	BIT(2)
-
-#define MOD_LIST_MASK_TEGRA30_OR_LATER \
-		(MOD_LIST_MASK_TEGRA30 | MOD_LIST_MASK_TEGRA114 | \
-			MOD_LIST_MASK_TEGRA124)
-#define MOD_LIST_MASK_TEGRA114_OR_LATER \
-		(MOD_LIST_MASK_TEGRA114 | MOD_LIST_MASK_TEGRA124)
-
-static const struct {
-	const char *rst_name;
-	u32 mod_list_mask;
-} configlink_mods[] = {
-	{ "i2s0", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s1", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s2", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s3", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s4", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "dam0", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "dam1", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "dam2", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "spdif", MOD_LIST_MASK_TEGRA30_OR_LATER },
-	{ "amx", MOD_LIST_MASK_TEGRA114_OR_LATER },
-	{ "adx", MOD_LIST_MASK_TEGRA114_OR_LATER },
-	{ "amx1", MOD_LIST_MASK_TEGRA124 },
-	{ "adx1", MOD_LIST_MASK_TEGRA124 },
-	{ "afc0", MOD_LIST_MASK_TEGRA124 },
-	{ "afc1", MOD_LIST_MASK_TEGRA124 },
-	{ "afc2", MOD_LIST_MASK_TEGRA124 },
-	{ "afc3", MOD_LIST_MASK_TEGRA124 },
-	{ "afc4", MOD_LIST_MASK_TEGRA124 },
-	{ "afc5", MOD_LIST_MASK_TEGRA124 },
-};
-
 #define LAST_REG(name) \
 	(TEGRA30_AHUB_##name + \
 	 (TEGRA30_AHUB_##name##_STRIDE * TEGRA30_AHUB_##name##_COUNT) - 4)
@@ -484,17 +449,14 @@ static const struct regmap_config tegra30_ahub_ahub_regmap_config = {
 };
 
 static struct tegra30_ahub_soc_data soc_data_tegra30 = {
-	.mod_list_mask = MOD_LIST_MASK_TEGRA30,
 	.set_audio_cif = tegra30_ahub_set_cif,
 };
 
 static struct tegra30_ahub_soc_data soc_data_tegra114 = {
-	.mod_list_mask = MOD_LIST_MASK_TEGRA114,
 	.set_audio_cif = tegra30_ahub_set_cif,
 };
 
 static struct tegra30_ahub_soc_data soc_data_tegra124 = {
-	.mod_list_mask = MOD_LIST_MASK_TEGRA124,
 	.set_audio_cif = tegra124_ahub_set_cif,
 };
 
@@ -510,7 +472,6 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	const struct tegra30_ahub_soc_data *soc_data;
 	struct reset_control *rst;
-	int i;
 	struct resource *res0;
 	void __iomem *regs_apbif, *regs_ahub;
 	int ret = 0;
@@ -528,26 +489,17 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	 * operate correctly, all devices on this bus must be out of reset.
 	 * Ensure that here.
 	 */
-	for (i = 0; i < ARRAY_SIZE(configlink_mods); i++) {
-		if (!(configlink_mods[i].mod_list_mask &
-					soc_data->mod_list_mask))
-			continue;
-
-		rst = reset_control_get_exclusive(&pdev->dev,
-						  configlink_mods[i].rst_name);
-		if (IS_ERR(rst)) {
-			dev_err(&pdev->dev, "Can't get reset %s\n",
-				configlink_mods[i].rst_name);
-			ret = PTR_ERR(rst);
-			return ret;
-		}
-
-		ret = reset_control_deassert(rst);
-		reset_control_put(rst);
-		if (ret)
-			return ret;
+	rst = of_reset_control_array_get_exclusive(pdev->dev.of_node);
+	if (IS_ERR(rst)) {
+		dev_err(&pdev->dev, "Can't get reset: %p\n", rst);
+		return PTR_ERR(rst);
 	}
 
+	ret = reset_control_deassert(rst);
+	reset_control_put(rst);
+	if (ret)
+		return ret;
+
 	ahub = devm_kzalloc(&pdev->dev, sizeof(struct tegra30_ahub),
 			    GFP_KERNEL);
 	if (!ahub)
diff --git a/sound/soc/tegra/tegra30_ahub.h b/sound/soc/tegra/tegra30_ahub.h
index 6889c5f23d02..5a2500b4ea06 100644
--- a/sound/soc/tegra/tegra30_ahub.h
+++ b/sound/soc/tegra/tegra30_ahub.h
@@ -491,7 +491,6 @@ void tegra124_ahub_set_cif(struct regmap *regmap, unsigned int reg,
 			   struct tegra30_ahub_cif_conf *conf);
 
 struct tegra30_ahub_soc_data {
-	u32 mod_list_mask;
 	void (*set_audio_cif)(struct regmap *regmap,
 			      unsigned int reg,
 			      struct tegra30_ahub_cif_conf *conf);
-- 
2.29.2

