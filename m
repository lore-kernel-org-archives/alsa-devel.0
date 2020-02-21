Return-Path: <SRS0=sxeJ=4J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB6C35656
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:23:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC0C208C4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ey5rAqLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC0C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83C9216B9;
	Fri, 21 Feb 2020 15:22:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83C9216B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582294978;
	bh=NObKApBSCoVwX7bYn9XZKlfO+0MBCetTBbmkMY3XzRs=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ey5rAqLUtRLSZWWIFbEoQn/kTeDH01SHEDdAO6ZNCl3/TrFYvZg8Mfzg6iND4ViUh
	 M1CEdVmk69hqPHW+dM6whFGq8uoip63zQBBnapP9zKXwJHYfPo/mfTa1wwB2hA2MpE
	 ufF5lwMUlhdbdA5qP0zMtw/fcNlQZOgCrwOgTdno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11107F80273;
	Fri, 21 Feb 2020 15:21:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A3CCF8025F; Fri, 21 Feb 2020 15:21:13 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 89E21F80114
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2020 15:21:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89E21F80114
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BD8130E;
 Fri, 21 Feb 2020 06:21:09 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6AD83F703;
 Fri, 21 Feb 2020 06:21:08 -0800 (PST)
Date: Fri, 21 Feb 2020 14:21:07 +0000
From: Mark Brown <broonie@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Subject: Applied "ASoC: sun8i-codec: Remove unused dev from codec struct" to
 the asoc tree
In-Reply-To: <20200217064250.15516-5-samuel@sholland.org>
Message-Id: <applied-20200217064250.15516-5-samuel@sholland.org>
X-Patchwork-Hint: ignore
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>,
 =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org
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

The patch

   ASoC: sun8i-codec: Remove unused dev from codec struct

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 150cbf8e66ec86966c13fd7a0e3de8813bca03d8 Mon Sep 17 00:00:00 2001
From: Samuel Holland <samuel@sholland.org>
Date: Mon, 17 Feb 2020 00:42:20 -0600
Subject: [PATCH] ASoC: sun8i-codec: Remove unused dev from codec struct

This field is not used anywhere in the driver, so remove it.

Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
Signed-off-by: Samuel Holland <samuel@sholland.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20200217064250.15516-5-samuel@sholland.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun8i-codec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 55798bc8eae2..41471bd01042 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -85,7 +85,6 @@
 #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
 
 struct sun8i_codec {
-	struct device	*dev;
 	struct regmap	*regmap;
 	struct clk	*clk_module;
 	struct clk	*clk_bus;
@@ -541,8 +540,6 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 	if (!scodec)
 		return -ENOMEM;
 
-	scodec->dev = &pdev->dev;
-
 	scodec->clk_module = devm_clk_get(&pdev->dev, "mod");
 	if (IS_ERR(scodec->clk_module)) {
 		dev_err(&pdev->dev, "Failed to get the module clock\n");
-- 
2.20.1

