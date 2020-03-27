Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A26C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:35:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70853214D8
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LpwZs+5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70853214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D5121670;
	Fri, 27 Mar 2020 16:34:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D5121670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585323322;
	bh=hI2S5kJTu6Ws6sSngOtK+29GJO6z2n3LZy0/haruSkg=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=LpwZs+5yyL1FhyqpTm5NoYzL0QA9INbDzAmgJf8pRJT/cVUEHykL+PjeFEn20AuH+
	 RGh60QNfCWmZCf7OQ6EcJfi+xOvsX3lbchqQK0KQKLU5P0f3aN7zJhoYMettyZU1kc
	 b0TaSImtTdlyIDGy77XfZnmQTg+I+c2ov+5OoCE8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C8CDF80248;
	Fri, 27 Mar 2020 16:33:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98C5CF80158; Fri, 27 Mar 2020 16:33:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id E7430F8011B
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 16:33:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7430F8011B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C5C21FB;
 Fri, 27 Mar 2020 08:33:27 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B48883F71F;
 Fri, 27 Mar 2020 08:33:26 -0700 (PDT)
Date: Fri, 27 Mar 2020 15:33:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Shuming Fan <shumingf@realtek.com>
Subject: Applied "ASoC: rt5682: move DAI clock registry to I2S mode" to the
 asoc tree
In-Reply-To: <20200327073849.18291-1-shumingf@realtek.com>
Message-Id: <applied-20200327073849.18291-1-shumingf@realtek.com>
X-Patchwork-Hint: ignore
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, rander.wang@intel.com,
 albertchen@realtek.com, Mark Brown <broonie@kernel.org>,
 derek.fang@realtek.com, bard.liao@intel.com, flove@realtek.com
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

   ASoC: rt5682: move DAI clock registry to I2S mode

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

From 914f674bec6efe42f9d6b036850a618fd1698290 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Fri, 27 Mar 2020 15:38:49 +0800
Subject: [PATCH] ASoC: rt5682: move DAI clock registry to I2S mode

The SoundWire mode doesn't need the DAI clocks.
Therefore, the DAI clock registry moves to I2S mode case.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20200327073849.18291-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5682.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 923541a52504..ce4fe7a683f9 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -2856,26 +2856,6 @@ static int rt5682_probe(struct snd_soc_component *component)
 #endif
 	rt5682->component = component;
 
-#ifdef CONFIG_COMMON_CLK
-	/* Check if MCLK provided */
-	rt5682->mclk = devm_clk_get(component->dev, "mclk");
-	if (IS_ERR(rt5682->mclk)) {
-		if (PTR_ERR(rt5682->mclk) != -ENOENT) {
-			ret = PTR_ERR(rt5682->mclk);
-			return ret;
-		}
-		rt5682->mclk = NULL;
-	}
-
-	/* Register CCF DAI clock control */
-	ret = rt5682_register_dai_clks(component);
-	if (ret)
-		return ret;
-
-	/* Initial setup for CCF */
-	rt5682->lrck[RT5682_AIF1] = CLK_48;
-#endif
-
 	if (rt5682->is_sdw) {
 		slave = rt5682->slave;
 		time = wait_for_completion_timeout(
@@ -2885,6 +2865,25 @@ static int rt5682_probe(struct snd_soc_component *component)
 			dev_err(&slave->dev, "Initialization not complete, timed out\n");
 			return -ETIMEDOUT;
 		}
+	} else {
+#ifdef CONFIG_COMMON_CLK
+		/* Check if MCLK provided */
+		rt5682->mclk = devm_clk_get(component->dev, "mclk");
+		if (IS_ERR(rt5682->mclk)) {
+			if (PTR_ERR(rt5682->mclk) != -ENOENT) {
+				ret = PTR_ERR(rt5682->mclk);
+				return ret;
+			}
+			rt5682->mclk = NULL;
+		} else {
+			/* Register CCF DAI clock control */
+			ret = rt5682_register_dai_clks(component);
+			if (ret)
+				return ret;
+		}
+		/* Initial setup for CCF */
+		rt5682->lrck[RT5682_AIF1] = CLK_48;
+#endif
 	}
 
 	return 0;
-- 
2.20.1

