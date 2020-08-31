Return-Path: <SRS0=wuVw=CJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0316C433E6
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 06:41:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CB1208A9
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Aug 2020 06:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mgHgn97N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ONCTIOJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CB1208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 955A4183D;
	Mon, 31 Aug 2020 08:41:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 955A4183D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598856117;
	bh=hh8b+foUdL49APaz8FqyTdt0qwx03FQV8IKGXDgIh3c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mgHgn97Nr/W2oul7YAnjCqgrwM6i46NwqzbzLMKEKHIYU1/2p0vCakFFrf/w/x63+
	 vzVzCbsZStHxxkDxJLbkSrG2SreQC40ReII+9aT+FVez9hIz33JBdGk8n5kA/M4K3J
	 DYTbdEqJ177VDXSX6l4jtXffQElLKrsg7R41c79k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5323EF802BC;
	Mon, 31 Aug 2020 08:40:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93DF6F802A1; Mon, 31 Aug 2020 08:40:13 +0200 (CEST)
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8DED7F80212
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2020 08:39:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8DED7F80212
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="ONCTIOJO"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1598856000; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=avckrwYFEozKXmUhvp7Wi5KC3VIiONL98Qh2vw0wCrM=;
 b=ONCTIOJOVx/mt4tI6BZECaSJLh/JdIG1Jcds2H1QXENg9bdcCLSLcXKiE2Im6MLl/lt5F2at
 IgoGpbkRM3BVduE3Do6YFyoQclq9pXITrI7cmy4B7lvTKqYFvIvf4xEBwOUsbkATmRomg4EP
 JytHLvk8AMdqHU9ilaCqRXUT0AQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f4c9b3008e77d893c87fadf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 06:39:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8962FC43387; Mon, 31 Aug 2020 06:39:43 +0000 (UTC)
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4847BC433C6;
 Mon, 31 Aug 2020 06:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4847BC433C6
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
Subject: [PATCH v3 0/5] Qualcomm's lpass-hdmi ASoC driver to support audio
 over dp port
Date: Mon, 31 Aug 2020 12:09:19 +0530
Message-Id: <1598855964-1042-1-git-send-email-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
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

These patches are to support audio over DP port on Qualcomm's SC7180 LPASS Asoc.
It includes machine driver, cpu driver, platform driver updates for HDMI path support, 
device tree documention, lpass variant structure optimization and configuration changes.
These patches depends on the DP patch series 
https://patchwork.kernel.org/project/dri-devel/list/?series=332029

Changes Since v2:
	-- Audio buffer size(i.e. LPASS_PLATFORM_BUFFER_SIZE) in lpass-platform.c increased.

V Sujith Kumar Reddy (5):
  ASoC: Add sc7180-lpass binding header hdmi define
  ASoC: dt-bindings: Add dt binding for lpass hdmi
  ASoC: qcom: Add support for lpass hdmi driver
  ASoC: qcom: Add support for audio over DP
  ASoC: qcom: Optimise lpass variant structure

 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |  51 +-
 include/dt-bindings/sound/sc7180-lpass.h           |   1 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-apq8016.c                     |  25 +-
 sound/soc/qcom/lpass-cpu.c                         |  92 ++-
 sound/soc/qcom/lpass-hdmi.c                        | 685 +++++++++++++++++++++
 sound/soc/qcom/lpass-hdmi.h                        | 129 ++++
 sound/soc/qcom/lpass-ipq806x.c                     |  25 +-
 sound/soc/qcom/lpass-lpaif-reg.h                   |  51 +-
 sound/soc/qcom/lpass-platform.c                    | 287 +++++++--
 sound/soc/qcom/lpass-sc7180.c                      | 147 ++++-
 sound/soc/qcom/lpass.h                             | 123 +++-
 13 files changed, 1472 insertions(+), 151 deletions(-)
 create mode 100644 sound/soc/qcom/lpass-hdmi.c
 create mode 100644 sound/soc/qcom/lpass-hdmi.h

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

