Return-Path: <SRS0=gpx6=EC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C59C388F9
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:36:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B50222283
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Oct 2020 11:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cjOWOwA0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mzDBky2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B50222283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC21B168A;
	Tue, 27 Oct 2020 12:35:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC21B168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603798570;
	bh=o18nCzkVS/URoWNnQssjIB1Qso5ZsQyfJxVUN96rXYg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cjOWOwA03qeNah+BUlM7H9zgTM9yE8z8yvvYzZ2d7JRHubrfKLdcfZ6uiqfRH8IGv
	 64zfCiEeA+p3HAgJn/IsQuLVKhGIJKxco5koWiXEZoscgqUbCouBRula3in/7s5GYI
	 M0b/irOiQ0DD+CBFQoszu7PV/hpGZH2FGKasjkHU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46872F801D8;
	Tue, 27 Oct 2020 12:35:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0D72F8020D; Tue, 27 Oct 2020 12:35:18 +0100 (CET)
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6272FF80086
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2020 12:35:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6272FF80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="mzDBky2V"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1603798516; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=80VjFtcHJmmKKdKN4NkUpi73cDwAskFrHfK10HG4QSk=;
 b=mzDBky2VAqy/FcxmrSwLrbIO5v2A5Z0iXNwOHEX82LscZQeZ+7fAc0VzsofuXot3a99mUM7H
 kajrnjEeiLftRYXo7/CzIep9CUuUT/8BaUwKisXmTA0Wtcl9vquDbnRFdrz9xzzfC/nlTNXJ
 Y7NqAIQOibA9Pkvb6PO1CtwUOoc=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f9805db1e4642bf759c5faa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 27 Oct 2020 11:34:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 6765FC433C9; Tue, 27 Oct 2020 11:34:50 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id EC47AC433CB;
 Tue, 27 Oct 2020 11:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC47AC433CB
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
Subject: [PATCH v2] Asoc: qcom: lpass-sc7180: Fix MI2S bitwidth field bit
 positions
Date: Tue, 27 Oct 2020 17:04:34 +0530
Message-Id: <1603798474-4897-1-git-send-email-srivasam@codeaurora.org>
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

Update SC7180 lpass_variant structure with proper I2S bitwidth
field bit positions, as bitwidth denotes 0 to 1 bits,
but previously used only 0 bit.

Fixes: cba62c8b49be ("ASoC: qcom: Add support for SC7180 lpass variant")
Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
Changes Since v1:
    -- Commit message is changed

 sound/soc/qcom/lpass-sc7180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index c6292f9e..bc998d5 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -188,7 +188,7 @@ static struct lpass_variant sc7180_data = {
 	.micmode		= REG_FIELD_ID(0x1000, 4, 8, 3, 0x1000),
 	.micmono		= REG_FIELD_ID(0x1000, 3, 3, 3, 0x1000),
 	.wssrc			= REG_FIELD_ID(0x1000, 2, 2, 3, 0x1000),
-	.bitwidth		= REG_FIELD_ID(0x1000, 0, 0, 3, 0x1000),
+	.bitwidth		= REG_FIELD_ID(0x1000, 0, 1, 3, 0x1000),
 
 	.rdma_dyncclk		= REG_FIELD_ID(0xC000, 21, 21, 5, 0x1000),
 	.rdma_bursten		= REG_FIELD_ID(0xC000, 20, 20, 5, 0x1000),
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

