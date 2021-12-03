Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA53C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 17:10:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C66972138;
	Fri,  3 Dec 2021 18:09:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C66972138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638551430;
	bh=HTNStJOVurnp3KXFZJr08Muw0W3evgQMTMQgx3MEmZ4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mEENPc81jUiaS6C6Zm+jviLWZyJoDQKUXsH7R8QQIm/6/ldCR0kP4vevjg8RPM1Lv
	 9a4GStqWJB/rseb3HbSkYiwyQQiqTdsq0OoE1fIB1gJmZ67G/lkyDx0L2Tg6CUY/cS
	 dmoxKm++Lufx2ECeYDtbQiBSmXlOmZAvxIUEvA/k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 46A39F800D3;
	Fri,  3 Dec 2021 18:09:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 709B9F80246; Fri,  3 Dec 2021 18:09:38 +0100 (CET)
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1A7FF800D3
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 18:09:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1A7FF800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="X5lLFpYw"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1638551376; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5AV0HBQ5bTOZ1ZlXigUPvuk/UL1rFaf1lLay1WSO41c=;
 b=X5lLFpYwXu5CeH9LijVicZW34pnytP1ZTczsPEcmfG8BbFVrwfIH/1VE6pDlbL9AlmiJA6nc
 29ukaxFFf5+vrj7OCmqNuEA9UmrJWUEUSzpk8Qxuv3ja9wLG/ROqL24e6W+WbJik6LTWq7Ty
 To4cLpUZ6uVevFPV4WURIKsBuwg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61aa4f4d2c7dc0a764d2ebab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 17:09:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id DEDFBC43616; Fri,  3 Dec 2021 17:09:32 +0000 (UTC)
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B0BBAC4338F;
 Fri,  3 Dec 2021 17:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B0BBAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=codeaurora.com
From: Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
 linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 swboyd@chromium.org, judyhsiao@chromium.org
Subject: [PATCH v8 0/3] Machine driver to support LPASS SC7280 sound card
 registration
Date: Fri,  3 Dec 2021 22:39:02 +0530
Message-Id: <1638551345-24979-1-git-send-email-srivasam@codeaurora.com>
X-Mailer: git-send-email 2.7.4
Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
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

This patch set is to add support for SC7280 sound card registration and
to add dt-bindings documentation file.

Srinivasa Rao Mandadapu (3):
  ASoC: google: dt-bindings: Add sc7280-herobrine machine bindings
  ASoC: qcom: Add macro for lpass DAI id's max limit
  ASoC: qcom: SC7280: Add machine driver

Changes Since V7:
    -- Create separate patch for dai id's macro.
    -- Remove unused dapm widget structure. 
Changes Since V6:
    -- Remove redundant headers.
    -- Move max ports macro to lpass.h header.
    -- Arrange structure alignment.
    -- Fix indentation errors.
    -- Update module license.
Changes Since V5:
    -- Add required properties to dt-bindings
Changes Since V4:
    -- Add COMPILE_TEST flag in sc7280 configuration.
    -- Remove redundant startup and shutdown callbacks of snd_soc_ops.
    -- Fix typo errors.
Changes Since V3:
    -- Change audio jack playpause key value.
Changes Since V2:
    -- updated required field in bindings
    -- updated Return type check with proper enum in sc7280.c
    -- Updated Header name and Typos in sc7280.c
Changes Since V1:
    -- Indentation changes and typo.

 .../bindings/sound/google,sc7280-herobrine.yaml    | 171 +++++++++++++
 sound/soc/qcom/Kconfig                             |  14 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass.h                             |   1 +
 sound/soc/qcom/sc7280.c                            | 284 +++++++++++++++++++++
 5 files changed, 472 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
 create mode 100644 sound/soc/qcom/sc7280.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

