Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D1BC43464
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:07:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A2521534
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 17:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DqzUT49W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="eQjKGeEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A2521534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6971716BB;
	Fri, 18 Sep 2020 19:06:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6971716BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600448826;
	bh=JgXwqCZ/pFCUfZx9+NzK7onVcuxROsfgQL99Vk/F7vI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DqzUT49WBFY2hTM9FKEJ+9jBDHCbfs3Ni4UoZ8mghuJKjZPXjenUvgDTRCOUbhUkP
	 6ZYU4s7I0oIoqRz2zaCdcs2rlufcLu/yHcBKHSMi6RoojdAfIFsCY/DZ2o1rJtCvl6
	 RTs3atxgqZAkXiJ35JSctgxuZ3hOEa8bhRjil/Eo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93251F80150;
	Fri, 18 Sep 2020 19:06:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87154F8015A; Fri, 18 Sep 2020 19:06:13 +0200 (CEST)
Received: from so254-54.mailgun.net (so254-54.mailgun.net [198.61.254.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ADADAF8012D
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 19:06:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ADADAF8012D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="eQjKGeEP"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1600448763; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GvoHhNZXEhEePaycPGrMSPaqU1/ITiUda54Uc4ClNck=;
 b=eQjKGeEP90tmabHWr5O4EFfEycmCOHuw57BerP1ScJLDmSWHPL/2EI2+W0wJAjT2l41AaoCq
 9e3jCFKulVKcp6KsweINURNuHtosRpQ51Heuu4KwsTwddhiAWw8IlE84vELJOM+NjFwMKlPc
 IIs9GtAbYFzWWwOno+wVw9Bogho=
X-Mailgun-Sending-Ip: 198.61.254.54
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f64e8f94398385e3007cd2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Sep 2020 17:06:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id ABCF0C433CA; Fri, 18 Sep 2020 17:06:00 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A29BCC433C8;
 Fri, 18 Sep 2020 17:05:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A29BCC433C8
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
Subject: [PATCH] Asoc: qcom: lpass-cpu: Enable MI2S BCLK and LRCLK together
Date: Fri, 18 Sep 2020 22:24:33 +0530
Message-Id: <1600448073-6709-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: vsujithk <vsujithk@codeaurora.org>,
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

From: vsujithk <vsujithk@codeaurora.org>

Update lpass-cpu.c to enable I2S BCLK and LRCLK together.
Remove BCLK enable in lpass_cpu_daiops_startup and
add in lpass_cpu_daiops_trigger API.

Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 41a2470..8db2cdb 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -80,14 +80,6 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
 		dev_err(dai->dev, "error in enabling mi2s osr clk: %d\n", ret);
 		return ret;
 	}
-
-	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
-	if (ret) {
-		dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
-		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -310,6 +302,14 @@ static int lpass_cpu_daiops_trigger(struct snd_pcm_substream *substream,
 		if (ret)
 			dev_err(dai->dev, "error writing to i2sctl reg: %d\n",
 				ret);
+
+		ret = clk_prepare_enable(drvdata->mi2s_bit_clk[id]);
+		if (ret) {
+			dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
+			clk_disable_unprepare(drvdata->mi2s_osr_clk[id]);
+			return ret;
+		}
+
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

