Return-Path: <SRS0=kA1C=XM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0837CC4CECD
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 05:51:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8368721852
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Sep 2019 05:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MlVnwUhC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d0SWSejf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8368721852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEF4B1660;
	Tue, 17 Sep 2019 07:50:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEF4B1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568699466;
	bh=NvkIt5LH1nMDoDcd8UdgVTZgv058LiMU2Y8KaGbeYQc=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MlVnwUhCEyDxe8mbqwjFGl3ZWV/bFSSOkeM4zIuVPFQg8zNuwmEyeFUz/7XjZm3md
	 YaDaYA6SX1vFTtB8tr9ro+k+p9JUrHzfNQVsfuv+Cz65lCKAKVW8eE6KNc1kIxtRX7
	 T8sZoF3VOvoGgaqfPLwzN4VMiTmy6oC8Lwh6mFAM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 620DBF80307;
	Tue, 17 Sep 2019 07:50:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2462F80361; Tue, 17 Sep 2019 07:50:14 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1801FF802BD
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2019 07:50:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1801FF802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="d0SWSejf"
Received: by mail-pf1-x443.google.com with SMTP id q12so1449250pff.9
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PE7y4UnexTZtj6Z1UuDfVzUfjM4W0/Oc+G3eQHvgH6Q=;
 b=d0SWSejfE3uf+S6K7tXMbtmy6fN4VINDTAfBJcv66+2G2omQP75Kc1AnJYdGyPmXsO
 ryasTnTMRA5/MftlxllAnncfznji2GnjYrLgrny8395DclGY6hUg6xsYzO7ZKLSGnU2H
 dlJ2OxOFxeYSgzEL/COaRGRLTzfVmx0H9gH+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PE7y4UnexTZtj6Z1UuDfVzUfjM4W0/Oc+G3eQHvgH6Q=;
 b=gLbKyslWx1Vog8u1NJRyxdnHndyOomQFIbansZ6p55LfyCubrQxH1oGgJ5qrPNbjZn
 /e1ubHVgt0jYsCTsewTWlBantIGJ46o2RDlFe6NMuppaUa3K2KWf4OkNX1nlxoTOufQ4
 WYeSRYM3aKVJPnogKXIz2j//uPsUxEnlBXY7RXfGEGghTH//IpD+5URuu7fHtOcdrmIk
 cYuCeHJRUS2ZUKZlvuRk0JZkMM0TE7aXISmxFwmKxkPkYmRy/2zbaL45HCpvZDrrFWcw
 8lmB50vEQHTyBNzd3U3yUI8wo7m8/ObZg0AZLgE+U+cP1jA/BXiOC9xSU/eEtB4IgpR/
 RQvg==
X-Gm-Message-State: APjAAAUeIfxS7nZQXAGW31pvh7nsjiLnrpz4hVFChuiXjOpzR9gvWNRL
 3wB7BbU+1nJAM18guA4bIfgGU1NWZys=
X-Google-Smtp-Source: APXvYqxs2/jONWysyN+Hz6uKSol0O5P2zp2OZDvQP5A2mFZMOB6qIw8vcFuQVJ73ThYarl2MWsGIFw==
X-Received: by 2002:aa7:8009:: with SMTP id j9mr793863pfi.107.1568699409668;
 Mon, 16 Sep 2019 22:50:09 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:c479:b58e:61d1:15d5])
 by smtp.gmail.com with ESMTPSA id v43sm2355596pjb.1.2019.09.16.22.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 22:50:08 -0700 (PDT)
From: Sam McNally <sammc@chromium.org>
To: alsa-devel@alsa-project.org
Date: Tue, 17 Sep 2019 15:49:33 +1000
Message-Id: <20190917054933.209335-1-sammc@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Cc: Sam McNally <sammc@chromium.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>
Subject: [alsa-devel] [PATCH v2] ASoC: Intel: cht_bsw_rt5645: Add quirk for
	boards using pmc_plt_clk_0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

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
---

Changes in v2:
- Added to the description references to more related commits (similar
  cht_bsw_max98090_ti clock quirks inspiring this change and and the
  cht_bsw_rt5645 quirks setup)

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
2.23.0.237.gc6a4ce50a0-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
