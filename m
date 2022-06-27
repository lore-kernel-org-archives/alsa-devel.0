Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7182C43334
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jun 2022 07:50:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76308E11;
	Mon, 27 Jun 2022 09:49:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76308E11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656316248;
	bh=pnG6KRzmqsOGGNalx1xP+/W4zokpSMTaiEMmaS149U8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BPCYm7rOYg2XYkSF6g/MtRdl/IjuG3IAuh2aAam7XRSGYJx+GXuMv+95eWzMfgctJ
	 LkmEktQVXCohagQItSeC1KxWB6B3evRaC/slGJqvBE/lZJT77H6ZvPrSEhMNqbb3aP
	 TjOaxUUWp1UBocpkvnrh8VmS8GADY5xFR2wgcRzI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 173B2F8012F;
	Mon, 27 Jun 2022 09:49:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 459BDF8028B; Mon, 27 Jun 2022 09:49:57 +0200 (CEST)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A63E1F800E9
 for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2022 09:49:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A63E1F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="lkHU18/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1656316196; x=1687852196;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=ot6ZzLJfsJy2wfTJYmauJNIOEnRIseAlsYBRCJcdO1A=;
 b=lkHU18/hNjyyJ4AJHyOuSJCXf2XjTCWMT+gCzAWVripj2EJZlH0od+ie
 F84svfMikeUyMr50SVT1feJeobox5ysCRBOeKrj2YkZ71iaV814FgB8bZ
 x4HNtFyi9eFgh+DClScNHiHH64Qxxqiy58bcM1G+ipa/HYF5Cnn9/y3u5 g=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
 by alexa-out.qualcomm.com with ESMTP; 27 Jun 2022 00:49:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 00:49:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 00:49:48 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 27 Jun 2022 00:49:42 -0700
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To: <agross@kernel.org>, <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>, 
 <broonie@kernel.org>, <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
 <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <swboyd@chromium.org>, <judyhsiao@chromium.org>, Linus Walleij
 <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v5 0/2]  Add pinctrl support adsp bypass platforms
Date: Mon, 27 Jun 2022 13:19:22 +0530
Message-ID: <1656316164-28666-1-git-send-email-quic_srivasam@quicinc.com>
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
Changes Since V4:
    -- Fix the improper device node variable usage.
    -- Optimize the code by removing redundant private 
	variant data structure variable "is_clk_optional".
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
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c                             | 2 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h                             | 1 -
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c                      | 1 -
 4 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.7.4

