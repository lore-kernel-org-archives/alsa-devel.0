Return-Path: <SRS0=9FQT=JZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5376FC433ED
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 12:28:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CE561419
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Apr 2021 12:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CE561419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8EF116CA;
	Wed, 28 Apr 2021 14:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8EF116CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619612917;
	bh=+epKB/MaV0WQk+vOzkfHdkYkSQThsI5IoUL/JFA3kH4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SyCxhgmp5r/mA4VJT8HsKOlv06/eJ4qawvLlwYxySgqb7gRGyUoowUtgUvLABkXRV
	 cOTGTWF4z/eizX+QFm5r+WQdLzKNCTbum7QxZ8/Nf4/PeC62VzPmLYHv25/i9ndP49
	 iTnJaHGXWmlEyBUpdh9ygzEXjX5TrGf08PelCfRw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 615A3F80117;
	Wed, 28 Apr 2021 14:26:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBB67F8032D; Wed, 28 Apr 2021 14:26:54 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EA0CF80117
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 14:26:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EA0CF80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="Vi2yGBQw"
Received: by mail-wr1-x42b.google.com with SMTP id x7so62792483wrw.10
 for <alsa-devel@alsa-project.org>; Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2s9J474JZEARtTyoYarg8YHk4rTHZwi14Y+KDirOQUE=;
 b=Vi2yGBQwLLvbUL/PZNfqnZWUQEW3eb7RyybrpCOByvM/YIEE2TP7jdEk9ko1KePQFR
 YyrdEbq58ghqLszXpKU+fYwHdOLGtF6OCedhP02ErXj9yK8kXGyNoLe/qD5ECmD9UAjh
 nrD85fsrfFfbNSgLBEocEDoYjeLirccPc4egnhMjXoNJcDTlHG4dkswd8mojF734iJ1v
 p0rs4ClW4Cro5OQpbHuRHercHRDTSLCr8QwSzClGK/64A8VonQ3nGwUk4ZtUG1Fkyvs+
 sjAXa8PrGInVtf3757M9CWvszPWEjgtsILgad0FJEpPm0WvZe43UR5W5ceCYdlUUiOtl
 jfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2s9J474JZEARtTyoYarg8YHk4rTHZwi14Y+KDirOQUE=;
 b=h9pjhh+ZSMjzu/4C4mhDS6vOk7VaZbssD2wjavfx6MqxgWoWI5ImQ6XznbIwDYTn7v
 oTIlYSgY2oaJkybFE/jvVFgzErRkBU93P0AlqWv1sq99ByQwSPm3A7Mj/l4mR6UHPGiM
 RYG2v4M5czqTIPYFS1DJyB1crhlhA3rc9DKIrppvbjvQuVVqIvnawWBn6BMXjJ/4CImj
 /4IxfZJvNai01bxrnG6vAr201uiGaVDOA6rkKDettVhKzcGVtsRBx9kp0CMGFrIOQdZ9
 sJXSCPVCUMmeVl+67rFwOxiOqGqNqco4JwlmL78i0DCJK5wRZ0niFqMKiU8Ic8fG5QJ1
 SMvA==
X-Gm-Message-State: AOAM531dGcJrNP8PfynUFwjQ21VMhSs9XnUWemmYaULkvrHH22TXzK2e
 y2EVUd7oHNI+4uLJorw7kREXvw==
X-Google-Smtp-Source: ABdhPJzsHvIsdh84+IkiXywToPZY4EDZs2ETaU+bB51962XC6NGy8KF0p7RFdurlu0tLNFYvg44EJQ==
X-Received: by 2002:a05:6000:1290:: with SMTP id
 f16mr2680463wrx.52.1619612802473; 
 Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net.
 [82.65.169.74])
 by smtp.googlemail.com with ESMTPSA id 6sm7872021wmg.9.2021.04.28.05.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Apr 2021 05:26:42 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: da7219: do not request a new clock consummer
 reference
Date: Wed, 28 Apr 2021 14:26:32 +0200
Message-Id: <20210428122632.46244-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210428122632.46244-1-jbrunet@baylibre.com>
References: <20210428122632.46244-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Cc: Stephen Boyd <sboyd@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Jerome Brunet <jbrunet@baylibre.com>
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

This reverts commit 12f8127fe9e6154dd4197df97e44f3fd67583071.

There is problem with clk_hw_get_hw(). Using it pins the clock provider to
itself, making it impossible to remove the module.

Revert commit 12f8127fe9e6 ("ASoC: da7219: properly get clk from the
provider") until this gets sorted out.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/da7219.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index bd3c523a8617..13009d08b09a 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2181,10 +2181,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 				 ret);
 			goto err;
 		}
-
-		da7219->dai_clks[i] = devm_clk_hw_get_clk(dev, dai_clk_hw, NULL);
-		if (IS_ERR(da7219->dai_clks[i]))
-			return PTR_ERR(da7219->dai_clks[i]);
+		da7219->dai_clks[i] = dai_clk_hw->clk;
 
 		/* For DT setup onecell data, otherwise create lookup */
 		if (np) {
-- 
2.31.1

