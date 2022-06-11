Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F004C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 11 Jun 2022 04:24:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E5491A75;
	Sat, 11 Jun 2022 06:23:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E5491A75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654921439;
	bh=7k3DQ7c67b9OAwDTFepLGrFRLJT/tjK1FhCdRN5z/P8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nh9mS+/vFpGJ2rIR3mqV4rG46JJJ9iehunGyj63Sp4zHJMeeYFtkvmKwrOEvyQtiJ
	 SnnGfPx6iPxUQtdm6qmcBGdhTzSHqpeW29sAuFlk44YbfnxCxVZQlxoNuUR9aWcGHa
	 F4WxnhN8+q8XCKKUVhLx6Yzlx5Gs6sLQW6yQm8KU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CD12F80238;
	Sat, 11 Jun 2022 06:23:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34F0AF8025A; Sat, 11 Jun 2022 06:23:06 +0200 (CEST)
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 405DDF800EC
 for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2022 06:23:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 405DDF800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="zAIZz9ur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1654921384; x=1686457384;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=tR0bvDE0SQjV6R7Pjg/uynrrDlzzDcB2SdzgAnvSe+A=;
 b=zAIZz9urBh+DjvM0yVMThSwcit5GDgMqIwl77zqkzVlBmAlzHCufBW3s
 YlJEuoomtNYDaIZXYSURaNeknWsN4B/1fH9g7TrmuAj/zbxs1vx6+bJ5B
 V5X9s90Mth90WyQs6eN+NdUnH8t4207OQitNfFBP/AlP4x16j/o+XfRMO Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jun 2022 21:22:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2022 21:22:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 21:22:59 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 21:22:53 -0700
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To: <agross@kernel.org>, <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>, 
 <broonie@kernel.org>, <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
 <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <swboyd@chromium.org>, <judyhsiao@chromium.org>, Linus Walleij
 <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v3 0/2] [PATCH v4 0/2] Add pinctrl support adsp bypass
 platforms
Date: Sat, 11 Jun 2022 09:52:35 +0530
Message-ID: <1654921357-16400-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

This patch set is to make clock voting optinal for adsp bypass 
sc7280 platforms.

Changes Since V3:
    -- Revert compatible type change in dt bindings.
    -- Update boolean flag description in dt bindings.
    -- Drop redundant clock optional flag initialization.
    -- Remove redundant if check.
Changes Since V2:
    -- Remove redundant lpi pincontrol variant data structure and 
       compatible entry.
    -- Add adsp bypass mode boolean param check.
    -- Remove compatible name in dt bindings.
    -- Update dt binding bypass mode boolean param.
Changes Since V1:
    -- Update commit message.
 
Srinivasa Rao Mandadapu (2):
  dt-bindings: pinctrl: qcom: sc7280: Add boolean param for ADSP bypass
    platforms
  pinctrl: qcom: sc7280: Add clock optional check for ADSP bypass
    targets

 .../devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml   | 5 +++++
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                             | 2 ++
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c                      | 1 -
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4

