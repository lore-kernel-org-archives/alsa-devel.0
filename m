Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA0AC3404C
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:21:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD6D2465A
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 00:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N/jd7VdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD6D2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8A1116DE;
	Wed, 19 Feb 2020 01:20:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8A1116DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582071660;
	bh=LrpbHDx/gKTEtRKlBEkJqB6J1FpPYTkarNy5Qy9LFQY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=N/jd7VdZw6yAwE49Qepp2FxNnm9A76STybcH8yPcFEx7SiPvOum99JJRcImO7q6YA
	 po9Zm3gXjtNdRpOBRsg1Eyk1xzzET5LfkYsFMvPJdfGgoJhzaDHzjXrBYoD2N9RJV/
	 Eha+uVE+ybBNW/hlH8JboztJqj2jd1olEbPYtUl4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2B21F8033D;
	Wed, 19 Feb 2020 01:10:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A277CF8033E; Wed, 19 Feb 2020 01:10:29 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 69509F80331
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 01:10:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69509F80331
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC9191FB;
 Tue, 18 Feb 2020 16:10:25 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40BF23F68F;
 Tue, 18 Feb 2020 16:10:25 -0800 (PST)
Date: Wed, 19 Feb 2020 00:10:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Derek Fang <derek.fang@realtek.com>
Subject: Applied "ASoC: rt5682: Add DAI clock binding info for WCLK/BCLK CCF
 usage" to the asoc tree
In-Reply-To: 
Message-Id: 
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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
Message-ID: <20200219001023.TuIdfSHNKzzg_Ra4NsIl79mYR_RHyxcXyqen7jaL9_o@z>

The patch

   ASoC: rt5682: Add DAI clock binding info for WCLK/BCLK CCF usage

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 8b59e642d05f0ae9800b057350c063fe7debd6bc Mon Sep 17 00:00:00 2001
From: Derek Fang <derek.fang@realtek.com>
Date: Tue, 18 Feb 2020 21:51:52 +0800
Subject: [PATCH] ASoC: rt5682: Add DAI clock binding info for WCLK/BCLK CCF
 usage

This patch describes that rt5682 can expose WCLK and BCLK clocks
and how to use.

Signed-off-by: Derek Fang <derek.fang@realtek.com>
Link: https://lore.kernel.org/r/1582033912-6841-2-git-send-email-derek.fang@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5682.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index 30e927a28369..ac98151d29e4 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -32,6 +32,12 @@ Optional properties:
   The delay time is realtek,btndet-delay value multiple of 8.192 ms.
   If absent, the default is 16.
 
+- #clock-cells : Should be set to '<1>',  wclk and bclk sources provided.
+- clock-output-names : Name given for DAI clocks output.
+
+- clocks : phandle and clock specifier for codec MCLK.
+- clock-names : Clock name string for 'clocks' attribute, should be "mclk".
+
 Pins on the device (for linking into audio routes) for RT5682:
 
   * DMIC L1
@@ -53,4 +59,10 @@ rt5682 {
 	realtek,dmic1-clk-pin = <1>;
 	realtek,jd-src = <1>;
 	realtek,btndet-delay = <16>;
+
+	#clock-cells = <1>;
+	clock-output-names = "rt5682-dai-wclk", "rt5682-dai-bclk";
+
+	clocks = <&osc>;
+	clock-names = "mclk";
 };
-- 
2.20.1

