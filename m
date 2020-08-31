Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0BAC433E6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:53:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A9D20720
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 03:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="r0fwrpnh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="GOAghqLp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W3HRXU80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A9D20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91EB61814;
	Mon, 31 Aug 2020 05:52:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91EB61814
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598846020;
	bh=AcZ/4di7NOukMbypU/G4/BotSk1fKOyxnDcoPZjas4w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r0fwrpnhVE7FAT7gBGZmyIXut1ZmKbfGEYOJJCDczGVPs3HVgePhfDO+b9HkfBj/K
	 mmfbNB8FNqrG6rowdd2/49wyC5YUC+eU4c3uF1v+ICkBDmdykAtL4UFcveR7+3l6N6
	 hkl5MnubXktLFCUKDM9TuGTmrm/t10+R1qaRMnMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16A67F802E7;
	Mon, 31 Aug 2020 05:49:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C99DDF802C3; Mon, 31 Aug 2020 05:49:18 +0200 (CEST)
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com
 [66.111.4.221])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D691F8026F
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 05:49:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D691F8026F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="GOAghqLp"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="W3HRXU80"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 31C31580561;
 Sun, 30 Aug 2020 23:48:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 30 Aug 2020 23:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=PQrBkezYLt6Fy
 +c/uvjYlgs8mBO389cR4ftCESf2x2w=; b=GOAghqLpYvqRBtj+22uIKS1yiT2Zq
 iN1BaVVzITn8OsPxZZiLtSAZv3U58dFoTOXCVhDdgYVu8amWGGChbmLxEP9Yjpjg
 uwvpewclR/+gAtwzfBzBRjYIKd0GT4enBzsF/VB46pV77Ft95QyuwIr2cZeYIvLt
 ebcCvu5SgZbnUsz7rK2EF8/wsqTR2mzLyfqjSLKPAMl2i9JhkNGcj1hBZdww//oa
 oO5k0/0cn1rdOvHRDXRaWYdUm8nmB6jTXbZboAbGWEsnjo4FYH2nQfcoQT5Npkb5
 SzTETC24HanYxFWXFzDk+N+s7h+pzvlWEuRBG5U/sUSEEa5NiHk9ZtMcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=PQrBkezYLt6Fy+c/uvjYlgs8mBO389cR4ftCESf2x2w=; b=W3HRXU80
 Qc+lFonH+f++2P25QSzXSmxBgpoPZ/g/3YHu8HppAOjIY6WNWAwtuFMrIwBSGOEp
 glqRr7cuVaGfHpD5/vOs5cLOYJWx2aTUXH6raIucM8aa9Yb9Bu91vuT3/QAR02BC
 sc2ZpPtOiynB2nal2f+S+FS09430fwxNiWVWUouFRNea1aCPIbMN0LCvasuPEI9e
 V/dRDN1gvz/wLNpDzAHP7QYPcYdwC4ZWInY5/W7FHe/N+ZqYmZKlXrujAiOGb5Zz
 J5ZGn8S3dTOctJC2N8lfhwROAuLV0tm/ROODWXqu8q78eQ1BldlQrvx/X9ltITvJ
 phJ8Pdr/Cek8zQ==
X-ME-Sender: <xms:KnNMX-j5DadaiJK1KFZSL4ZXDLO1zmQBY50SW6CkXfkxwCABnnHtaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgedgjeehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
 gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
 iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
 ugdrohhrgh
X-ME-Proxy: <xmx:KnNMX_DzT4nfumGn_ZuJ80EkL5E6zVNIQ3ZeD2mWMzihCB-2QxsXmQ>
 <xmx:KnNMX2HV1EQq5kCbjEX57GeNveR_BynfUphz5lBCqn7iw-knheWkfQ>
 <xmx:KnNMX3Rso55QwepAJr4O4qBJ8o1NlC9joF-MBUp5ujSejF_7v3iR8w>
 <xmx:KnNMXyxaXvizF7OA9mH4uSBMIVwacKb5VCPSrBcgykDV5alHSktyag>
Received: from titanium.stl.sholland.net
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 964263280060;
 Sun, 30 Aug 2020 23:48:57 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 8/9] ASoC: sun8i-codec: Attach the bus clock to the regmap
Date: Sun, 30 Aug 2020 22:48:51 -0500
Message-Id: <20200831034852.18841-9-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Samuel Holland <samuel@sholland.org>
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

When attached to the regmap, the bus clock is automatically enabled as
needed to access device registers. This avoids needing code to manage it
separately in the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index c25cdd3f3057..8a7f98910347 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -94,7 +94,6 @@ struct sun8i_codec_quirks {
 struct sun8i_codec {
 	struct regmap			*regmap;
 	struct clk			*clk_module;
-	struct clk			*clk_bus;
 	const struct sun8i_codec_quirks	*quirks;
 };
 
@@ -109,12 +108,6 @@ static int sun8i_codec_runtime_resume(struct device *dev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(scodec->clk_bus);
-	if (ret) {
-		dev_err(dev, "Failed to enable the bus clock\n");
-		goto err_disable_modclk;
-	}
-
 	regcache_cache_only(scodec->regmap, false);
 
 	ret = regcache_sync(scodec->regmap);
@@ -126,9 +119,6 @@ static int sun8i_codec_runtime_resume(struct device *dev)
 	return 0;
 
 err_disable_clk:
-	clk_disable_unprepare(scodec->clk_bus);
-
-err_disable_modclk:
 	clk_disable_unprepare(scodec->clk_module);
 
 	return ret;
@@ -142,7 +132,6 @@ static int sun8i_codec_runtime_suspend(struct device *dev)
 	regcache_mark_dirty(scodec->regmap);
 
 	clk_disable_unprepare(scodec->clk_module);
-	clk_disable_unprepare(scodec->clk_bus);
 
 	return 0;
 }
@@ -612,20 +601,14 @@ static int sun8i_codec_probe(struct platform_device *pdev)
 		return PTR_ERR(scodec->clk_module);
 	}
 
-	scodec->clk_bus = devm_clk_get(&pdev->dev, "bus");
-	if (IS_ERR(scodec->clk_bus)) {
-		dev_err(&pdev->dev, "Failed to get the bus clock\n");
-		return PTR_ERR(scodec->clk_bus);
-	}
-
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_err(&pdev->dev, "Failed to map the registers\n");
 		return PTR_ERR(base);
 	}
 
-	scodec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					       &sun8i_codec_regmap_config);
+	scodec->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "bus", base,
+						   &sun8i_codec_regmap_config);
 	if (IS_ERR(scodec->regmap)) {
 		dev_err(&pdev->dev, "Failed to create our regmap\n");
 		return PTR_ERR(scodec->regmap);
-- 
2.26.2

