Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2F9C2D0C4
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574442465C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 19:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZMCJsvsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574442465C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6532D1676;
	Mon,  9 Dec 2019 20:10:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6532D1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575918658;
	bh=f2esNWrt8xFhpUK4lswo8I+Jjg8Xhm3ShrcHaDwvoVQ=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ZMCJsvsHBYUEGfEDIoupxAaRZ60GPJSJUqVw/d1NVWP7DcuipJ346eudCMXyMxLso
	 MF5XsJGWPE4iWc2pOEOFxEQaFECmeb/4Un9kc3BDERkA9MOeywni/pcx/nqLc1wUwl
	 I6/6jguaSIvx7taeHbW9SViKh3bJ9DnO6Z86Os/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5694DF802FB;
	Mon,  9 Dec 2019 19:59:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23886F80304; Mon,  9 Dec 2019 19:59:22 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 801C2F802EB
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 19:59:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 801C2F802EB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0AAD11D4;
 Mon,  9 Dec 2019 10:59:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FFFE3F6CF;
 Mon,  9 Dec 2019 10:59:15 -0800 (PST)
Date: Mon, 09 Dec 2019 18:59:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
In-Reply-To: <20191204192005.31210-1-peter.ujfalusi@ti.com>
Message-Id: <applied-20191204192005.31210-1-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 lgirdwood@gmail.com
Subject: [alsa-devel] Applied "ASoC: ti: davinci-mcasp: Improve the sysclk
	selection" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: ti: davinci-mcasp: Improve the sysclk selection

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 253f584a0699d12a90bde9d524d499a921cc7827 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Wed, 4 Dec 2019 21:20:05 +0200
Subject: [PATCH] ASoC: ti: davinci-mcasp: Improve the sysclk selection

When McASP is master the bclk can be generated from two main source:
AUXCLK: functional clock for McASP or
AHCLK: from external source or internal mux in dra7x family

With this patch it is possible to select between the two source. The patch
is not breaking existing machine drivers since historically the clk_id was
ignored and left as 0 in all cases.

When output clock is configured - which can be only the AHCLK, we select
the AUXCLK as source for the internal HCLK. In this case the HCLK rate is
the same as the output clock.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20191204192005.31210-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 35 ++++++++++++++++++++++++++++-------
 sound/soc/ti/davinci-mcasp.h |  4 ++++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 8e5371801d88..e1e937eb1dc1 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -664,18 +664,39 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
 	pm_runtime_get_sync(mcasp->dev);
-	if (dir == SND_SOC_CLOCK_OUT) {
+
+	if (dir == SND_SOC_CLOCK_IN) {
+		switch (clk_id) {
+		case MCASP_CLK_HCLK_AHCLK:
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			clear_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
+			break;
+		case MCASP_CLK_HCLK_AUXCLK:
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG,
+				       AHCLKXE);
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG,
+				       AHCLKRE);
+			set_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
+			break;
+		default:
+			dev_err(mcasp->dev, "Invalid clk id: %d\n", clk_id);
+			goto out;
+		}
+	} else {
+		/* Select AUXCLK as HCLK */
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
 		set_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
-	} else {
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		clear_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
 	}
-
+	/*
+	 * When AHCLK X/R is selected to be output it means that the HCLK is
+	 * the same clock - coming via AUXCLK.
+	 */
 	mcasp->sysclk_freq = freq;
-
+out:
 	pm_runtime_put(mcasp->dev);
 	return 0;
 }
diff --git a/sound/soc/ti/davinci-mcasp.h b/sound/soc/ti/davinci-mcasp.h
index bc705d6ca48b..5de2b8a31061 100644
--- a/sound/soc/ti/davinci-mcasp.h
+++ b/sound/soc/ti/davinci-mcasp.h
@@ -295,6 +295,10 @@
 #define NUMEVT(x)	(((x) & 0xFF) << 8)
 #define NUMDMA_MASK	(0xFF)
 
+/* Source of High-frequency transmit/receive clock */
+#define MCASP_CLK_HCLK_AHCLK		0 /* AHCLKX/R */
+#define MCASP_CLK_HCLK_AUXCLK		1 /* Internal functional clock */
+
 /* clock divider IDs */
 #define MCASP_CLKDIV_AUXCLK		0 /* HCLK divider from AUXCLK */
 #define MCASP_CLKDIV_BCLK		1 /* BCLK divider from HCLK */
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
