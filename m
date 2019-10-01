Return-Path: <SRS0=w4sP=X2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB4BECE589
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:01:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A144E20700
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LbaNW+Ev";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="POM3ArrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A144E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E73DA16BB;
	Tue,  1 Oct 2019 14:00:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E73DA16BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569931309;
	bh=wLTKZknzjML/OJt84TqF2YxQryAp5phB8LWaQjTVBis=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=LbaNW+EvaTbJQbd+86WAaRbdpG5Jb5VAcOnLmQqJa3ohBMm8GJb0IYtx2TRwO6v2j
	 zMCcmTJS4Gx9bg5mcqAu4H0EhrlHAC4m7z2hcX6oAcxLFZF2jGM6KCsa3PcePvVELP
	 w040NJH1lFJFc0PNLq1r81VNKdGVPTcebcKoDTME=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06EBCF80CAA;
	Tue,  1 Oct 2019 13:41:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 148FDF80714; Tue,  1 Oct 2019 13:41:19 +0200 (CEST)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0112F80518
 for <alsa-devel@alsa-project.org>; Tue,  1 Oct 2019 13:40:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0112F80518
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="POM3ArrC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=HLoALoLZhTD98ys834r884WXj3CIP196fQnwS7WkHN4=; b=POM3ArrCDrCL
 2kOkHxcD4JCtuNOPuTSiOF8tNZDoWMU6vnvTq9Sjq6Fm2xFI0KGq3aE6zmRNQiTZn39UzfW5XX4+I
 uTD34byk6GupMyE1I54tdYgzaP6iC+EtNIFvCL9pVrHsNjZ7PjFWwZMXILEBLUIfLEKwM3ed5RbXq
 ck9ms=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iFGWS-0004VY-Mh; Tue, 01 Oct 2019 11:40:52 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 21DC52742A10; Tue,  1 Oct 2019 12:40:52 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Sam McNally <sammc@chromium.org>
In-Reply-To: <20190917054933.209335-1-sammc@chromium.org>
X-Patchwork-Hint: ignore
Message-Id: <20191001114052.21DC52742A10@ypsilon.sirena.org.uk>
Date: Tue,  1 Oct 2019 12:40:52 +0100 (BST)
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
Subject: [alsa-devel] Applied "ASoC: Intel: cht_bsw_rt5645: Add quirk for
	boards using pmc_plt_clk_0" to the asoc tree
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

   ASoC: Intel: cht_bsw_rt5645: Add quirk for boards using pmc_plt_clk_0

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From adebb11139029ddf1fba6f796c4a476f17eacddc Mon Sep 17 00:00:00 2001
From: Sam McNally <sammc@chromium.org>
Date: Tue, 17 Sep 2019 15:49:33 +1000
Subject: [PATCH] ASoC: Intel: cht_bsw_rt5645: Add quirk for boards using
 pmc_plt_clk_0

As of commit 648e921888ad ("clk: x86: Stop marking clocks as
CLK_IS_CRITICAL"), the cht_bsw_rt5645 driver needs to enable the clock
it's using for the codec's mclk. It does this from commit 7735bce05a9c
("ASoC: Intel: boards: use devm_clk_get() unconditionally"), enabling
pmc_plt_clk_3. However, Strago family Chromebooks use pmc_plt_clk_0 for
the codec mclk, resulting in white noise with some digital microphones.
Add a DMI-based quirk for Strago family Chromebooks to use pmc_plt_clk_0
instead - mirroring the changes made to cht_bsw_max98090_ti in
commit a182ecd3809c ("ASoC: intel: cht_bsw_max98090_ti: Add quirk for
boards using pmc_plt_clk_0") and making use of the existing
dmi_check_system() call and related infrastructure added in
commit 22af29114eb4 ("ASoC: Intel: cht-bsw-rt5645: add quirks for
SSP0/AIF1/AIF2 routing").

Signed-off-by: Sam McNally <sammc@chromium.org>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190917054933.209335-1-sammc@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 26 +++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 8879c3be29d5..c68a5b85a4a0 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -48,6 +48,7 @@ struct cht_mc_private {
 #define CHT_RT5645_SSP2_AIF2     BIT(16) /* default is using AIF1  */
 #define CHT_RT5645_SSP0_AIF1     BIT(17)
 #define CHT_RT5645_SSP0_AIF2     BIT(18)
+#define CHT_RT5645_PMC_PLT_CLK_0 BIT(19)
 
 static unsigned long cht_rt5645_quirk = 0;
 
@@ -59,6 +60,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk SSP0_AIF1 enabled");
 	if (cht_rt5645_quirk & CHT_RT5645_SSP0_AIF2)
 		dev_info(dev, "quirk SSP0_AIF2 enabled");
+	if (cht_rt5645_quirk & CHT_RT5645_PMC_PLT_CLK_0)
+		dev_info(dev, "quirk PMC_PLT_CLK_0 enabled");
 }
 
 static int platform_clock_control(struct snd_soc_dapm_widget *w,
@@ -226,15 +229,21 @@ static int cht_aif1_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/* uncomment when we have a real quirk
 static int cht_rt5645_quirk_cb(const struct dmi_system_id *id)
 {
 	cht_rt5645_quirk = (unsigned long)id->driver_data;
 	return 1;
 }
-*/
 
 static const struct dmi_system_id cht_rt5645_quirk_table[] = {
+	{
+		/* Strago family Chromebooks */
+		.callback = cht_rt5645_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_Strago"),
+		},
+		.driver_data = (void *)CHT_RT5645_PMC_PLT_CLK_0,
+	},
 	{
 	},
 };
@@ -526,6 +535,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	int dai_index = 0;
 	int ret_val = 0;
 	int i;
+	const char *mclk_name;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
 	if (!drv)
@@ -662,11 +672,15 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	if (ret_val)
 		return ret_val;
 
-	drv->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
+	if (cht_rt5645_quirk & CHT_RT5645_PMC_PLT_CLK_0)
+		mclk_name = "pmc_plt_clk_0";
+	else
+		mclk_name = "pmc_plt_clk_3";
+
+	drv->mclk = devm_clk_get(&pdev->dev, mclk_name);
 	if (IS_ERR(drv->mclk)) {
-		dev_err(&pdev->dev,
-			"Failed to get MCLK from pmc_plt_clk_3: %ld\n",
-			PTR_ERR(drv->mclk));
+		dev_err(&pdev->dev, "Failed to get MCLK from %s: %ld\n",
+			mclk_name, PTR_ERR(drv->mclk));
 		return PTR_ERR(drv->mclk);
 	}
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
