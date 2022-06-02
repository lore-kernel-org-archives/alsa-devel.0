Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ED9C43334
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 11:28:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95EBB173A;
	Thu,  2 Jun 2022 13:28:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95EBB173A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654169335;
	bh=iqX6SWKaXwPPTKpkLnEPqd4WIQAD1V7r3Rh8jC75WZE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GwSXWV9QgfGzV402pVJmhpvWwSAn0pJ16HYDYBCppnhd8kEgaWed5DCgTa0F0JhTw
	 6Gh1vSWvrbCwcciobCWJ4fkDrxQx3tXOKqi7i5qYLQc7cnEgvQDgYPTxPc+0HSTEZ1
	 1CHOqfBJmG4X0zcgozS0TgVL7xgK21zI+cEf/Crk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17805F804D0;
	Thu,  2 Jun 2022 13:27:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34B30F80526; Thu,  2 Jun 2022 13:27:26 +0200 (CEST)
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B1380F80425
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 13:27:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1380F80425
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="e9gTGApO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1654169240; x=1685705240;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=H9dBjTw0cbAQOjaubAyGRHRBW53k1gZfcUzCESN/OuQ=;
 b=e9gTGApOW23erEjoDRHepxp6UxRv5Z+DrnhxtPKzSyUEoDDwgjrwjfT/
 C/QP5q6JdEtUtEePLcl3r7uBp5Eq97aWJzjWI0GKJwLkxKvcnYFcMoHOi
 Xv+dTVOsEACsNInK7QQBP3kSOvRbWsmP0gnohwioxWqCQQ9sxRKRoRSwi Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2022 04:27:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2022 04:27:16 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 04:27:16 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 04:27:10 -0700
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To: <agross@kernel.org>, <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>, 
 <broonie@kernel.org>, <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
 <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
 <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: qcom: lpass-sc7280: Update external mclk0 name
Date: Thu, 2 Jun 2022 16:56:46 +0530
Message-ID: <1654169206-12255-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654169206-12255-1-git-send-email-quic_srivasam@quicinc.com>
References: <1654169206-12255-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
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

Update "audio_cc_ext_mclk0" name to "core_cc_ext_mclk0",
as MI2S mclk is being used is from lpass core cc.

Fixes: b62c4e5fba2f ("ASoC: qcom: lpass-sc7280: Add platform driver for lpass audio")
Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 sound/soc/qcom/lpass-sc7280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-sc7280.c b/sound/soc/qcom/lpass-sc7280.c
index 70c4df8..e65bf7e 100644
--- a/sound/soc/qcom/lpass-sc7280.c
+++ b/sound/soc/qcom/lpass-sc7280.c
@@ -403,7 +403,7 @@ static struct lpass_variant sc7280_data = {
 	.dai_driver			= sc7280_lpass_cpu_dai_driver,
 	.num_dai			= ARRAY_SIZE(sc7280_lpass_cpu_dai_driver),
 	.dai_osr_clk_names		= (const char *[]) {
-							"audio_cc_ext_mclk0",
+							"core_cc_ext_mclk0",
 							"null"
 							},
 	.dai_bit_clk_names		= (const char *[]) {
-- 
2.7.4

