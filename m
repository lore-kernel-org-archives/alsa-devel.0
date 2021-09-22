Return-Path: <SRS0=ED1W=OM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A5C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Sep 2021 12:34:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CBF60F9D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Sep 2021 12:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92CBF60F9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3048782A;
	Wed, 22 Sep 2021 14:34:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3048782A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632314096;
	bh=Sr/koOMnyhlHmMJRgOdo+K63zC9w7YX6FmKaoLaTiY0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TZIBXxKgiGAX8chAIk4MtcqHY+JEWhQoKgHq0DfhdcNwVWjvfmzaxHChnqu2J2Nri
	 rpaiCwIzieBzO4Dpwr76mmHiTthO3pAw9JKUk3myRSFL++AYg58l6rrhmrPLP35X05
	 uvK8qPaWpyujlUq2w+kcBMMuCy0FsCjkJKjlWn84=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2B4DF80279;
	Wed, 22 Sep 2021 14:32:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 852FEF8025D; Wed, 22 Sep 2021 14:32:54 +0200 (CEST)
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EBD9F804FB
 for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2021 14:32:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EBD9F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="TWwkePwo"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1632313969; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ONfhviwd9VOib+IHTwvjYtTVT1j7IHHl6KkzeCNnwFM=;
 b=TWwkePwohaQpNO3MwcjVqmmPjxs+2P4KAD0rMr8tr2MCE83fbCdz3CwbZ2ZA13PF0LJDBh0g
 p/b3V0zCInxmegGGmtBv0OwGJvrxGMDp0ncaOvNxH7FjmE+0nT9hmfNIKHuLeVZv5E4t6X8V
 HCI33HJ4vXG0YZqXS4AJl1a8An4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 614b22526c4c0e0dc336d2ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Sep 2021 12:32:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 846FFC43638; Wed, 22 Sep 2021 12:32:15 +0000 (UTC)
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F8A4C43638;
 Wed, 22 Sep 2021 12:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 7F8A4C43638
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=codeaurora.org
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
Subject: [PATCH v2 5/5] ASoC: codecs: Change bulk clock voting to optional
 voting in digital codecs
Date: Wed, 22 Sep 2021 18:01:18 +0530
Message-Id: <1632313878-12089-6-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
References: <agross@kernel.org; bjorn.andersson@linaro.org; lgirdwood@gmail.com;
 broonie@kernel.org; robh+dt@kernel.org; plai@codeaurora.org;
 bgoswami@codeaurora.org; perex@perex.cz; tiwai@suse.com;
 srinivas.kandagatla@linaro.org; rohitkr@codeaurora.org;
 linux-arm-msm@vger.kernel.org; alsa-devel@alsa-project.org;
 devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; swboyd@chromium.org;
 judyhsiao@chromium.org; >
 <1632313878-12089-1-git-send-email-srivasam@codeaurora.org>
Cc: Venkata Prasad Potturu <potturu@codeaurora.org>,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
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

Change bulk clock frequency voting to optional bulk voting in va, rx and tx macros
to accommodate both ADSP and ADSP bypass based lpass architectures.

Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 sound/soc/codecs/lpass-tx-macro.c | 2 +-
 sound/soc/codecs/lpass-va-macro.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index c2b9333..2bed5cf 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3531,7 +3531,7 @@ static int rx_macro_probe(struct platform_device *pdev)
 	rx->clks[3].id = "npl";
 	rx->clks[4].id = "fsgen";
 
-	ret = devm_clk_bulk_get(dev, RX_NUM_CLKS_MAX, rx->clks);
+	ret = devm_clk_bulk_get_optional(dev, RX_NUM_CLKS_MAX, rx->clks);
 	if (ret) {
 		dev_err(dev, "Error getting RX Clocks (%d)\n", ret);
 		return ret;
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 66c39fb..c288471 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1794,7 +1794,7 @@ static int tx_macro_probe(struct platform_device *pdev)
 	tx->clks[3].id = "npl";
 	tx->clks[4].id = "fsgen";
 
-	ret = devm_clk_bulk_get(dev, TX_NUM_CLKS_MAX, tx->clks);
+	ret = devm_clk_bulk_get_optional(dev, TX_NUM_CLKS_MAX, tx->clks);
 	if (ret) {
 		dev_err(dev, "Error getting RX Clocks (%d)\n", ret);
 		return ret;
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 70f09b4..11147e3 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1408,7 +1408,7 @@ static int va_macro_probe(struct platform_device *pdev)
 	va->clks[1].id = "dcodec";
 	va->clks[2].id = "mclk";
 
-	ret = devm_clk_bulk_get(dev, VA_NUM_CLKS_MAX, va->clks);
+	ret = devm_clk_bulk_get_optional(dev, VA_NUM_CLKS_MAX, va->clks);
 	if (ret) {
 		dev_err(dev, "Error getting VA Clocks (%d)\n", ret);
 		return ret;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

