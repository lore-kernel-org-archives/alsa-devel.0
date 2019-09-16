Return-Path: <SRS0=lXbg=XL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60388C4CECC
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:16:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D182206A4
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ka/LuSfO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QNoJi4UK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D182206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99F721614;
	Mon, 16 Sep 2019 09:15:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99F721614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568618184;
	bh=EHIzRAsnfv64xlqOJ/jWQEWyh9T05Gg8ZzfzlbL9mcQ=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ka/LuSfOceFxMVr+RHLuhb4B/sUB8EMmNNN0BnIhzqaRDmkgzwIh9OmacX+UuMRLn
	 9cZwsVGT0vpUVKPBfNhyrBxIlPu6iSvW5pcHr+Dj+3a/pP+0z3It3LVO1cOFZiX7zG
	 zKqdpGcWrL4h49kbq5dqFCzJqIycIP/mtsVaivhM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16B69F804FF;
	Mon, 16 Sep 2019 09:15:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6F35F80506; Mon, 16 Sep 2019 09:15:32 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B60BF80137
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 09:15:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B60BF80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="QNoJi4UK"
Received: by mail-pf1-x442.google.com with SMTP id q12so2117355pff.9
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2019 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qmRm7fpnzQX0SJt+e3zxCBZps6u9b1b32KnV4ZPUyTg=;
 b=QNoJi4UKyn2ymKTb0o7bE3ivosQZxoYkLF70rN+mY7kaW06Vigrn/hCBxV9uhMHH6w
 wmadHZkCMqL0n9LCxZ1B1nUsd0MCf2/j+RROQz1ntW+HgrvSaHIg+nZAnXG3F6XV5eiW
 v+LhZ4tnQfrIl2tRPqZ0DQNru5U7XTAIZc60w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qmRm7fpnzQX0SJt+e3zxCBZps6u9b1b32KnV4ZPUyTg=;
 b=SiTvW29U0geOgRYb8sw/+9vmq0LO8UapgVteb4tms0Byr7rE6pr2dLnk7biLiCByEp
 rPbiLPWU3n4rNlCNQywRfllZmeZZsEXiFq9U+MfP1DekdY7SoI48t0zDOpK0jDRV5RJr
 heRkq/fgzTHOkmRISmsLeXq1f8IsZNdht1odSZFJx+wckkjnMipxvF1pnguE4/k2T4RV
 OEzppVymdVCn0b/GLsbfyTbw1sF40z8XMqRv6/u5N5T1M5yZbR0WSGHEkZuetvH6sYpb
 W+HbQW39HxoCTT413I7eiZipa1wKt320YF/LSQN/3OyjJnHEl12/NRdArT4yb1RhuQtW
 NiEw==
X-Gm-Message-State: APjAAAX+97tMhjFzu+IaDLlNuFQF6nxMIT0q32JEBMczIGy1XvUQZC67
 xHFcQDCp85vSeE0BlAQPahsN9e1dOXE=
X-Google-Smtp-Source: APXvYqzLsbRmTeo0FiJ5yw4xcANPzGmtc9SoRmEwj4KsKNl76fW66qrAJs5vCUGOLGBI53NOtGSRXQ==
X-Received: by 2002:a65:6493:: with SMTP id e19mr24921402pgv.115.1568618127011; 
 Mon, 16 Sep 2019 00:15:27 -0700 (PDT)
Received: from localhost ([2401:fa00:9:15:c479:b58e:61d1:15d5])
 by smtp.gmail.com with ESMTPSA id u5sm38998120pfl.25.2019.09.16.00.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 00:15:25 -0700 (PDT)
From: Sam McNally <sammc@chromium.org>
To: alsa-devel@alsa-project.org
Date: Mon, 16 Sep 2019 17:15:11 +1000
Message-Id: <20190916071511.5909-1-sammc@chromium.org>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0-goog
MIME-Version: 1.0
Cc: Sam McNally <sammc@chromium.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH] ASoC: Intel: cht_bsw_rt5645: Add quirk for
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
instead.

Signed-off-by: Sam McNally <sammc@chromium.org>
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
2.23.0.237.gc6a4ce50a0-goog

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
