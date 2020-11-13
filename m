Return-Path: <SRS0=KFnC=ET=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83D4C55ABD
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 18:40:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF456206FB
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2020 18:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O7GtCvuR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="WPjG9+iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF456206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33DBC18A7;
	Fri, 13 Nov 2020 19:39:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33DBC18A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605292829;
	bh=ehunYTddlmf8fZwQLkum5BVuugYwAXf9fzlSWHo445I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=O7GtCvuRVe31S8nQ6TSNdK7DAtcuAlOi2c6XTae4/9oLKriOpLrQGKbXXJJ8GD0Ho
	 752IxhMIiaP2IVbNNzAa18wxOSAK0vDOoFlzYmzTPGpEMq4PWdivHcXdiFfMcmH2aW
	 +BqqYpgcgnMCZUP8MIBd2MQDi6fLMGkv8VxOQkE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A930DF801F5;
	Fri, 13 Nov 2020 19:39:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5EB9F8020C; Fri, 13 Nov 2020 19:39:36 +0100 (CET)
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77718F800E9
 for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2020 19:39:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77718F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="WPjG9+iL"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1605292771; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bNE4U6NO9Qnui5qzRXhH3mUphBMnNuk7wBLDCqEHGzQ=;
 b=WPjG9+iLkzlM4/oqzJq9YlOkNyiLViVrT+gG9Fr284ma2HNrD+rsjmePOc3l4CGH40AFn3D1
 Qmyo4ytjYlRN/iX7USbUNEAFeu/Xujbh5A9xCxDW45c4qK54TsOuLD1QR3rMNIDEj/QTt+gx
 3Dl2Z4mDXBvTCxOV9AFBXo2vUc8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5faed2b0d3e05bb6db0188a2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 13 Nov 2020 18:38:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id CFB80C433C8; Fri, 13 Nov 2020 18:38:39 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 21977C433C6;
 Fri, 13 Nov 2020 18:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21977C433C6
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
Subject: [PATCH] Asoc: qcom: sc7180: Register shutdown handler for lpass
 platform
Date: Sat, 14 Nov 2020 00:08:22 +0530
Message-Id: <1605292702-25046-1-git-send-email-srivasam@codeaurora.org>
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

Register shutdown handler to stop sc7180 lpass platform driver
and to disable audio clocks.

Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 sound/soc/qcom/lpass-cpu.c    | 10 ++++++++++
 sound/soc/qcom/lpass-sc7180.c |  1 +
 sound/soc/qcom/lpass.h        |  1 +
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
index 1fd862e..d33eae6 100644
--- a/sound/soc/qcom/lpass-cpu.c
+++ b/sound/soc/qcom/lpass-cpu.c
@@ -914,5 +914,15 @@ int asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_remove);
 
+void asoc_qcom_lpass_cpu_platform_shutdown(struct platform_device *pdev)
+{
+	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+
+	if (drvdata->variant->exit)
+		drvdata->variant->exit(pdev);
+
+}
+EXPORT_SYMBOL_GPL(asoc_qcom_lpass_cpu_platform_shutdown);
+
 MODULE_DESCRIPTION("QTi LPASS CPU Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index f619590..61b51b5 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -297,6 +297,7 @@ static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 	},
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
 	.remove = asoc_qcom_lpass_cpu_platform_remove,
+	.shutdown = asoc_qcom_lpass_cpu_platform_shutdown,
 };
 
 module_platform_driver(sc7180_lpass_cpu_platform_driver);
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index b4830f3..32a68c4 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -255,6 +255,7 @@ struct lpass_variant {
 /* register the platform driver from the CPU DAI driver */
 int asoc_qcom_lpass_platform_register(struct platform_device *);
 int asoc_qcom_lpass_cpu_platform_remove(struct platform_device *pdev);
+void asoc_qcom_lpass_cpu_platform_shutdown(struct platform_device *pdev);
 int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev);
 int asoc_qcom_lpass_cpu_dai_probe(struct snd_soc_dai *dai);
 extern const struct snd_soc_dai_ops asoc_qcom_lpass_cpu_dai_ops;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

