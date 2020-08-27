Return-Path: <SRS0=PqWm=CF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72242C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:59:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59C12087C
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LwjYy2rI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Bq33MAdZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59C12087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 03B091820;
	Thu, 27 Aug 2020 18:58:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 03B091820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598547553;
	bh=oMOr26uWSy9dGLSxS9du+ndnoEpG5cy0ET6Np2QatTw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LwjYy2rIKzPLqvbQNuQn7s7GB8fnQQj4UFGup1g9Ir0xm0aMXf9FCnSpuGSUlIh9L
	 pMQumCUkCx4VE/MWvWN/2L0IML+I7klCTTsb8hXEmnU7rJuOJp5jBt9w7haDR5Dfpg
	 3s2czQdK9c9FJqzd1myP/bN4NJrU11kDTxDTRdQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94979F80338;
	Thu, 27 Aug 2020 18:51:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A88B3F8016F; Thu, 27 Aug 2020 11:29:01 +0200 (CEST)
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE397F80085
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2020 11:28:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE397F80085
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="Bq33MAdZ"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1598520536; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zVYq2PzZHW22lNU+KVi4IO8QWzdS+OdIZj/XtAHJAlQ=;
 b=Bq33MAdZBsCpO6AsDfq9G4QYlV1W+pispmXAk9l8wLItKd2J0YxjTc8q7rTx9jzkJ7ZpVLy6
 tW3SlMvdSHNLD6bPSXNrd/cRKhRl1ZYzF/yjgSok1IF1+QuOr0G5r3NKAfkb0MsbbcreayQK
 Qp2hZlYr0MVADeIJOFWofDSVYf8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f477cc2883d767477073613 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 27 Aug 2020 09:28:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A265DC433B2; Thu, 27 Aug 2020 09:28:33 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3539CC43395;
 Thu, 27 Aug 2020 09:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3539CC43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=srivasam@codeaurora.org
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] ASoC: Add sc7180-lpass binding header hdmi define
Date: Thu, 27 Aug 2020 14:58:11 +0530
Message-Id: <1598520495-21741-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Thu, 27 Aug 2020 18:50:45 +0200
Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
 Srinivasa Rao <srivasam@codeaurora.org>
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

Add header defining hdmi dai-id for SC7180 lpass soc
in dt bindings.

Signed-off-by: Srinivasa Rao <srivasam@codeaurora.org>
Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
---
 include/dt-bindings/sound/sc7180-lpass.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/sound/sc7180-lpass.h b/include/dt-bindings/sound/sc7180-lpass.h
index 7d988f6..0b4991e 100644
--- a/include/dt-bindings/sound/sc7180-lpass.h
+++ b/include/dt-bindings/sound/sc7180-lpass.h
@@ -4,6 +4,7 @@
 
 #define MI2S_PRIMARY	0
 #define MI2S_SECONDARY	1
+#define HDMI	2
 
 #define LPASS_MCLK0	0
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

