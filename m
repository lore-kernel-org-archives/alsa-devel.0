Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07676C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 13:43:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49C5600D4
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 13:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D49C5600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7100D16A3;
	Wed, 27 Oct 2021 15:42:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7100D16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635342178;
	bh=PuBXXIOSQiVNN/95dP82TRYOpB9A/Cm6fr//0WMhCU0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mvws/eg/fw2O7yLUdG9aDmVg/RNpqHEk7ZahLUuTHS5PyMZcmN3xF5AtFnaNCfTCW
	 0ohnik/hA1VEiNZpaa/QmClU4qWsJm3xmDcTnrdilWu873KaJL1X+sU/l3TpihMEQV
	 pzq8j3d0FW7xBSqUdQat7J9Ztf4I1gnWwW/JhQ2E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF412F8010A;
	Wed, 27 Oct 2021 15:42:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACE9AF8025E; Wed, 27 Oct 2021 15:42:05 +0200 (CEST)
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 175E4F8010A
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 15:41:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 175E4F8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="PciDfDs2"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1635342116; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1SBLZFfunh195ytL1Uq9ouEIPWsOVkbMBN8wi1cWkN4=;
 b=PciDfDs2DFoHW0bLxvTR01E6dQvfSaQ2X9PSBYrHyTDPp1hTW+rsMUA4qw+zlWM/BPKRNc4k
 LW5OEjOrcdt4BjfAjaBtQXU0edNb88KiRSKCfOfCy4Scu8Km9EJJU5wXfp6FrEo1joMgWW+M
 4uCX6Qdq3Ykog6tXiKfCnut8/mk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 61795721c8c1b282a51357e4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 27 Oct 2021 13:41:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E2D5CC4338F; Wed, 27 Oct 2021 13:41:53 +0000 (UTC)
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id BFE67C4360C;
 Wed, 27 Oct 2021 13:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BFE67C4360C
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
Subject: [PATCH v2 0/3] Add pin control support for lpass sc7280
Date: Wed, 27 Oct 2021 19:11:34 +0530
Message-Id: <1635342097-2726-1-git-send-email-srivasam@codeaurora.org>
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

This patch series is to make lpass varient independent pin control
functions common and to add lpass sc7280 pincontrol support.
It also includes dt-bindings for lpass sc7280 lpi compatible. 

Changes Since V1:
    -- Make lpi pinctrl variant data structure as constant
    -- Add appropriate commit message
    -- Change signedoff by sequence.

Srinivasa Rao Mandadapu (3):
  pinctrl: qcom: Update lpass variant independent functions as generic
  dt-bindings: pinctrl: qcom: Add sc7280 lpass lpi pinctrl compatible
  pinctrl: qcom: Add SC7280 lpass pin configuration

 .../bindings/pinctrl/qcom,lpass-lpi-pinctrl.yaml   |  4 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           | 56 ++++++++++++++++++----
 2 files changed, 51 insertions(+), 9 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

