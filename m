Return-Path: <SRS0=I0Ma=5Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E8DC2BA19
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:04:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496712074F
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2020 20:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ryrY44V4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496712074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9798A16A1;
	Thu,  9 Apr 2020 22:03:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9798A16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586462647;
	bh=lyDwRWuncuJKeJ922nuuk0EKcHmd3wTiKs989WK7CXM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ryrY44V4VC+Yt/9Ob7SxPWp2kAlnOr4n3GpXEqTJWjoXaUoKdzaIbaFLAuIoOF+iT
	 B+nBhWdUwTDJEn482XE2sCoK4ZXHgBdsU9V+WDmnsTNZ6nlFoi8atn1uiZsu6YdZxS
	 MYsAKNI6Orykr+OEmQ1ftSQxISvqC2N06a7bEZmQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08653F802DC;
	Thu,  9 Apr 2020 21:59:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFA67F802A0; Thu,  9 Apr 2020 21:59:21 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B4B9CF802A0
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2020 21:59:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B4B9CF802A0
IronPort-SDR: elj9it1Tevp8J+FAP0oFIXwQmsUVoZn9BsH9mVBcNRDm8NkUtlsUmjIYt0odq+s/uPWyKCcfBG
 6U2+pyeaz0Cw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2020 12:59:17 -0700
IronPort-SDR: 3WujSN8sErlH4LsZZeBQSMcfeDIlK8/K1hfbi8ZRpRH8qOmudVT8BrRdvDgS1VkJLQv2wo7pfZ
 H4yYlItESZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; d="scan'208";a="242745352"
Received: from davidadu-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.151.218])
 by fmsmga007.fm.intel.com with ESMTP; 09 Apr 2020 12:59:15 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 09/16] clk: hifiberry-dacpro: style cleanups, use devm_
Date: Thu,  9 Apr 2020 14:58:34 -0500
Message-Id: <20200409195841.18901-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Daniel Matuschek <daniel@hifiberry.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, Matthias Reichl <hias@horus.com>,
 broonie@kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
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

Lots of small issues, xmas style, alignment, wrong comments, memory leak

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/clk/clk-hifiberry-dacpro.c | 42 +++++++++++-------------------
 1 file changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk-hifiberry-dacpro.c b/drivers/clk/clk-hifiberry-dacpro.c
index eb67a8c47c49..78ede325d237 100644
--- a/drivers/clk/clk-hifiberry-dacpro.c
+++ b/drivers/clk/clk-hifiberry-dacpro.c
@@ -21,13 +21,13 @@
 #define CLK_48EN_RATE 24576000UL
 
 /**
- * struct hifiberry_dacpro_clk - Common struct to the HiFiBerry DAC Pro
+ * struct clk_hifiberry_hw - Common struct to the HiFiBerry DAC Pro
  * @hw: clk_hw for the common clk framework
  * @mode: 0 => CLK44EN, 1 => CLK48EN
  */
 struct clk_hifiberry_hw {
 	struct clk_hw hw;
-	uint8_t mode;
+	u8 mode;
 };
 
 #define to_hifiberry_clk(_hw) container_of(_hw, struct clk_hifiberry_hw, hw)
@@ -39,14 +39,15 @@ static const struct of_device_id clk_hifiberry_dacpro_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, clk_hifiberry_dacpro_dt_ids);
 
 static unsigned long clk_hifiberry_dacpro_recalc_rate(struct clk_hw *hw,
-	unsigned long parent_rate)
+						      unsigned long parent_rate)
 {
 	return (to_hifiberry_clk(hw)->mode == 0) ? CLK_44EN_RATE :
 		CLK_48EN_RATE;
 }
 
 static long clk_hifiberry_dacpro_round_rate(struct clk_hw *hw,
-	unsigned long rate, unsigned long *parent_rate)
+					    unsigned long rate,
+					    unsigned long *parent_rate)
 {
 	long actual_rate;
 
@@ -66,21 +67,20 @@ static long clk_hifiberry_dacpro_round_rate(struct clk_hw *hw,
 	return actual_rate;
 }
 
-
 static int clk_hifiberry_dacpro_set_rate(struct clk_hw *hw,
-	unsigned long rate, unsigned long parent_rate)
+					 unsigned long rate,
+					 unsigned long parent_rate)
 {
-	unsigned long actual_rate;
 	struct clk_hifiberry_hw *clk = to_hifiberry_clk(hw);
+	unsigned long actual_rate;
 
 	actual_rate = (unsigned long)clk_hifiberry_dacpro_round_rate(hw, rate,
-		&parent_rate);
+								&parent_rate);
 	clk->mode = (actual_rate == CLK_44EN_RATE) ? 0 : 1;
 	return 0;
 }
 
-
-const struct clk_ops clk_hifiberry_dacpro_rate_ops = {
+static const struct clk_ops clk_hifiberry_dacpro_rate_ops = {
 	.recalc_rate = clk_hifiberry_dacpro_recalc_rate,
 	.round_rate = clk_hifiberry_dacpro_round_rate,
 	.set_rate = clk_hifiberry_dacpro_set_rate,
@@ -88,15 +88,15 @@ const struct clk_ops clk_hifiberry_dacpro_rate_ops = {
 
 static int clk_hifiberry_dacpro_probe(struct platform_device *pdev)
 {
-	int ret;
 	struct clk_hifiberry_hw *proclk;
-	struct clk *clk;
-	struct device *dev;
 	struct clk_init_data init;
+	struct device *dev;
+	struct clk *clk;
+	int ret;
 
 	dev = &pdev->dev;
 
-	proclk = kzalloc(sizeof(struct clk_hifiberry_hw), GFP_KERNEL);
+	proclk = devm_kzalloc(dev, sizeof(*proclk), GFP_KERNEL);
 	if (!proclk)
 		return -ENOMEM;
 
@@ -115,7 +115,6 @@ static int clk_hifiberry_dacpro_probe(struct platform_device *pdev)
 			clk);
 	} else {
 		dev_err(dev, "Fail to register clock driver\n");
-		kfree(proclk);
 		ret = PTR_ERR(clk);
 	}
 	return ret;
@@ -135,18 +134,7 @@ static struct platform_driver clk_hifiberry_dacpro_driver = {
 		.of_match_table = clk_hifiberry_dacpro_dt_ids,
 	},
 };
-
-static int __init clk_hifiberry_dacpro_init(void)
-{
-	return platform_driver_register(&clk_hifiberry_dacpro_driver);
-}
-core_initcall(clk_hifiberry_dacpro_init);
-
-static void __exit clk_hifiberry_dacpro_exit(void)
-{
-	platform_driver_unregister(&clk_hifiberry_dacpro_driver);
-}
-module_exit(clk_hifiberry_dacpro_exit);
+module_platform_driver(clk_hifiberry_dacpro_driver);
 
 MODULE_DESCRIPTION("HiFiBerry DAC Pro clock driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

