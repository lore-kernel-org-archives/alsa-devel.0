Return-Path: <SRS0=AF2s=O2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1F2C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 17:37:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD337610FC
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Oct 2021 17:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BD337610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46550166A;
	Wed,  6 Oct 2021 19:36:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46550166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633541826;
	bh=Rwy7IWAigy+7/P/RSiqOEnlZYGXqbA8e1VV1VLVYnLE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nGAtcDZ0+hcwJ/HvIb89GU3TJYqyMroxAvrZ4PGXjBz4hc5qWyZFNvroMle1B4Hy6
	 hSdFL3t7ULRQBSaaaUs8cpge2yiFrRcJLDwJq4Qe8+diPWWIThnrTPjU4+exW6ytZi
	 FBmn/cH5Y4lf/jdCtIvfgKb4wxaTM2bqBUg3IWjI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB6C6F802D2;
	Wed,  6 Oct 2021 19:35:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4E3BF804E2; Wed,  6 Oct 2021 19:35:32 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D55CEF802D2
 for <alsa-devel@alsa-project.org>; Wed,  6 Oct 2021 19:35:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D55CEF802D2
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249341623"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="249341623"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2021 10:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; d="scan'208";a="478202551"
Received: from black.fi.intel.com ([10.237.72.28])
 by orsmga007.jf.intel.com with ESMTP; 06 Oct 2021 10:35:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id D029B299; Wed,  6 Oct 2021 20:35:15 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ASoC: Intel: bytcht_es8316: Utilize dev_err_probe() to
 avoid log saturation
Date: Wed,  6 Oct 2021 20:33:49 +0300
Message-Id: <20211006173349.84684-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006173349.84684-1-andriy.shevchenko@linux.intel.com>
References: <20211006173349.84684-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

dev_err_probe() avoids printing into log when the deferred probe is invoked.
This is possible when clock provider is pending to appear.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index d8dcf63825a6..9d86fea51a7d 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -532,11 +532,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 
 	/* get the clock */
 	priv->mclk = devm_clk_get(dev, "pmc_plt_clk_3");
-	if (IS_ERR(priv->mclk)) {
-		ret = PTR_ERR(priv->mclk);
-		dev_err(dev, "clk_get pmc_plt_clk_3 failed: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(priv->mclk))
+		return dev_err_probe(dev, PTR_ERR(priv->mclk), "clk_get pmc_plt_clk_3 failed\n");
 
 	/* get speaker enable GPIO */
 	codec_dev = acpi_get_first_physical_node(adev);
@@ -570,14 +567,9 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 				   /* see comment in byt_cht_es8316_resume() */
 				   GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(priv->speaker_en_gpio)) {
-		ret = PTR_ERR(priv->speaker_en_gpio);
-		switch (ret) {
-		default:
-			dev_err(dev, "get speaker GPIO failed: %d\n", ret);
-			fallthrough;
-		case -EPROBE_DEFER:
-			goto err_put_codec;
-		}
+		ret = dev_err_probe(dev, PTR_ERR(priv->speaker_en_gpio),
+				    "get speaker GPIO failed\n");
+		goto err_put_codec;
 	}
 
 	snprintf(components_string, sizeof(components_string),
-- 
2.33.0

