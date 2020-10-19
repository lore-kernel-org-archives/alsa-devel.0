Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A4C433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:07:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4142225F
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kDFc/uPy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jCFfmRAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4142225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E73A1716;
	Mon, 19 Oct 2020 11:06:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E73A1716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603098454;
	bh=mzkw9ZdoFWYaAU3Rt98dW9y8q2uHT5vxYnegk4z/tYg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kDFc/uPyITpsb+O6L13Yna4b8irkmfzkqDTUOdcxlpWVe3P7AUbwptSoz0nENA5Ji
	 kYU2Gyeop19Y4dBTH2L9NKY3MT5cWFaQIcGCoBB56dXyJj8uXoSRgfaML/E2XUxUdw
	 HpnD7wxv5ua0+gjWqTdIZXFCx+kDaOOBqLtQzv6U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1744BF80121;
	Mon, 19 Oct 2020 11:06:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 822FDF80247; Mon, 19 Oct 2020 11:06:42 +0200 (CEST)
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9975DF80121
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 11:06:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9975DF80121
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="jCFfmRAo"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1603098396; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=CSSINleGh6w/76KIFdxve8Idpf2dccGeHvGZNRQeQPU=;
 b=jCFfmRAoqQNTjsFkNkkwipvUJ9fcxblbgF8o+fMABMTFCth/3YM1Eclh0EzZjdib9FN2Z4NP
 7FS4A5yn6hqZuFQ3+vjaCV2FGN4mwejC5MsEslSQUGN1kh0JxRfi5FDL0EYjq7bQLEd0twl4
 w1ofPUVAnSAuW5h2HoZAXc954gM=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f8d570bad37af35ec2ee638 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Oct 2020 09:06:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 851B4C433FE; Mon, 19 Oct 2020 09:06:19 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 60CBEC433CB;
 Mon, 19 Oct 2020 09:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60CBEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=srivasam@codeaurora.org
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Asoc: qcom: lpass-cpu: Fix clock disable failure
Date: Mon, 19 Oct 2020 14:36:03 +0530
Message-Id: <1603098363-9251-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
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

From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>

Disable MI2S bit clock from PAUSE/STOP/SUSPEND usecase instead of
shutdown time. Acheive this by invoking clk_disable API from
cpu daiops trigger instead of cpu daiops shutdown.
Change non-atomic API "clk_prepare_enable" to atomic API
"clk_enable" in trigger, as trigger is being called from atomic context.

Fixes: commit 7e6799d8f87d ("ASoC: qcom: lpass-cpu: Enable MI2S BCLK and LRCLK together")

Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 78de888..6001049 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -80,6 +80,12 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 		dev_err(dai->dev, "error in enabling mi2s osr clk: %d\n", ret);
 		return ret;
 	}
+	ret = clk_prepare(drvdata->mi2s_bit_clk[dai->driver->id]);
+	if (ret) {
+		dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
+		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+		return ret;
+	}
 	return 0;
 }
 
@@ -88,9 +94,8 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
 {
 	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
 
-	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
-
 	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
+	clk_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
 }
 
 static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
@@ -303,10 +308,10 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
 				ret);
 
-		ret = clk_prepare_enable(drvdata->mi2s_bit_clk[id]);
+		ret = clk_enable(drvdata->mi2s_bit_clk[id]);
 		if (ret) {
 			dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
-			clk_disable_unprepare(drvdata->mi2s_osr_clk[id]);
+			clk_disable(drvdata->mi2s_osr_clk[id]);
 			return ret;
 		}
 
@@ -324,6 +329,7 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 		if (ret)
 			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
 				ret);
+		clk_disable(drvdata->mi2s_bit_clk[dai->driver->id]);
 		break;
 	}
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

