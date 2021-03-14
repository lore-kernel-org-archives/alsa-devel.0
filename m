Return-Path: <SRS0=8nxE=IM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7281C433E0
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:48:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D501164E69
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Mar 2021 15:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D501164E69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C1951755;
	Sun, 14 Mar 2021 16:47:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C1951755
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615736904;
	bh=CYJjRJhoMnn2KFhzl7+b3xrxw3bi3OGb5u7HaEYOyzE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TW1724W6ojvGnpfBRzMfN4EtvzI/qFxxqEXEgJU2ywMjzw7UQmX1XTK6yVIepZAFs
	 mYtC/v7+RLUjKzNbS1nfoWy2jNDdziUF3iNQbhH0OHM+2J0o8Iu5DMikiohSqmG7m4
	 yYF4OC0/iU2hl1JwaMZhfkPO6w5UAQdAtHTyTq8I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A68A6F804B0;
	Sun, 14 Mar 2021 16:45:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DD41F804A9; Sun, 14 Mar 2021 16:45:38 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33240F80272
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 16:45:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33240F80272
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="S807ZZou"
Received: by mail-wr1-x435.google.com with SMTP id e9so4449094wrw.10
 for <alsa-devel@alsa-project.org>; Sun, 14 Mar 2021 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eNVjcoR01FRpoFa6dcxhxiG3Pm0KTDWnEWsUfy39F9k=;
 b=S807ZZouwwXiXTG9Ad2UTbCgVHcjn+TJkKy79koNKTWXToOcN5pCugUwW2KqtIKlPp
 /EsL6mXU035kVSJRt93PADxI6okFbFjSjYYwnFdgO8ynIqU4cIrMYVXlAKzoYmz0fTpV
 PxOo+suXTtWMLnTdBpzlTlTkBI4VDiTphXnG0+mLH7xmdI1TNblny2RSJntcYASg8Kl+
 CI7YQijzu0ULHEMZbYGst8nCY+4b6cs+qyqXn4MTTf1+OfS4AvskmTnTHojroPqwcYJA
 kqwdm02weAlrnqaA0Y5aHY7YmiILqznrJSEe/bZDn45smGLMrb9Lic3ULsOZynMmqbCw
 7yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eNVjcoR01FRpoFa6dcxhxiG3Pm0KTDWnEWsUfy39F9k=;
 b=MhA3wTmPwprqscImcNbS3jfBU7MdNM3Ydj+j3xUzA+UX0hyXvicU0zQ2LviMBaUlce
 wc1PTDM1nMTQMPaQnhfQUvbLIuStFBswAfLvExUmAlQ9aMaU6dnX2smrUXA0tzFuG9gT
 /K1dKAoHCVqN9ILVaMAS02zey5kCMhykT3DU3nWOyZRqKqkOUFYHnossmYHvFxLBmKEU
 co1bLGFYt6E3RA7HLjmevQYCw1FgP4FwfoYUT1AafuB7vWCl1PyL1Ggr9q6NHJ+Rm8gm
 MrIzbvFrV4K3p65OQc2nVyTXGsIBu64OeCJWVkrVQ9x0wQwdW7TefleUiCiDC5GdUuy8
 N0zw==
X-Gm-Message-State: AOAM53237P7jbUUblaVP74+68OmjJ7zkCZC2Hd6csJMmin4j3bu1NB1D
 4CjscE4GcXbsDp5AGn42tFt5+0fZSD4=
X-Google-Smtp-Source: ABdhPJwBV24pahHUbzEGPiCqN4pR8i0eptAX4fnHzjRjhlfAqP+aMc5WU7Bvqptcvr1lzzuVbjG9SQ==
X-Received: by 2002:adf:ef4a:: with SMTP id c10mr23063976wrp.427.1615736721372; 
 Sun, 14 Mar 2021 08:45:21 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.gmail.com with ESMTPSA id f14sm9673507wmf.7.2021.03.14.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Mar 2021 08:45:21 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Fertser <fercerpav@gmail.com>
Subject: [PATCH v5 01/17] ASoC: tegra20: ac97: Add reset control
Date: Sun, 14 Mar 2021 18:44:43 +0300
Message-Id: <20210314154459.15375-2-digetx@gmail.com>
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

Tegra20 AC97 driver doesn't manage the AC97 controller reset, relying on
implicit deassertion of the reset by tegra-clk driver, which needs to be
fixed since this behaviour is unacceptable by other Tegra drivers. Add
explicit reset control to the Tegra20 AC97 driver.

Note that AC97 reset was always specified in Tegra20 device-tree, hence
DTB ABI changes aren't required.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_ac97.c | 21 +++++++++++++++++++++
 sound/soc/tegra/tegra20_ac97.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
index 06c728ae17ed..c454a34c15c4 100644
--- a/sound/soc/tegra/tegra20_ac97.c
+++ b/sound/soc/tegra/tegra20_ac97.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -313,6 +314,12 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 	}
 	dev_set_drvdata(&pdev->dev, ac97);
 
+	ac97->reset = devm_reset_control_get_exclusive(&pdev->dev, "ac97");
+	if (IS_ERR(ac97->reset)) {
+		dev_err(&pdev->dev, "Can't retrieve ac97 reset\n");
+		return PTR_ERR(ac97->reset);
+	}
+
 	ac97->clk_ac97 = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ac97->clk_ac97)) {
 		dev_err(&pdev->dev, "Can't retrieve ac97 clock\n");
@@ -364,12 +371,26 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
 	ac97->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	ac97->playback_dma_data.maxburst = 4;
 
+	ret = reset_control_assert(ac97->reset);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to assert AC'97 reset: %d\n", ret);
+		goto err_clk_put;
+	}
+
 	ret = clk_prepare_enable(ac97->clk_ac97);
 	if (ret) {
 		dev_err(&pdev->dev, "clk_enable failed: %d\n", ret);
 		goto err_clk_put;
 	}
 
+	usleep_range(10, 100);
+
+	ret = reset_control_deassert(ac97->reset);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to deassert AC'97 reset: %d\n", ret);
+		goto err_clk_disable_unprepare;
+	}
+
 	ret = snd_soc_set_ac97_ops(&tegra20_ac97_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to set AC'97 ops: %d\n", ret);
diff --git a/sound/soc/tegra/tegra20_ac97.h b/sound/soc/tegra/tegra20_ac97.h
index e467cd1ff2ca..870ea09ff301 100644
--- a/sound/soc/tegra/tegra20_ac97.h
+++ b/sound/soc/tegra/tegra20_ac97.h
@@ -78,6 +78,7 @@ struct tegra20_ac97 {
 	struct clk *clk_ac97;
 	struct snd_dmaengine_dai_dma_data capture_dma_data;
 	struct snd_dmaengine_dai_dma_data playback_dma_data;
+	struct reset_control *reset;
 	struct regmap *regmap;
 	int reset_gpio;
 	int sync_gpio;
-- 
2.30.2

