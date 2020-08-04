Return-Path: <SRS0=lfZM=BO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378E7C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:09:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16A82076C
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k9rFUzuQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OcAAPemw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16A82076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56E1A165E;
	Tue,  4 Aug 2020 10:08:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56E1A165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596528542;
	bh=C8pOdTnF+PqpzLcQGRh9w6ySK9rQn6I3A2jcEfbiM0U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k9rFUzuQei53MTM7ude4N6dg/KGgjnEotXZh7wtRoRX320id9oSAtWkvQdSKj7j7k
	 UYMikNYEpVV2jl/Gy04XxmynbCGdNt9VbzSqt1Gn42pCkUIn7G8ES6b4PhtIariF7D
	 VYZgrXTre5neZp3uxzMAWnszz+aH3sMQv9nVoiNQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECDD3F8014C;
	Tue,  4 Aug 2020 10:08:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED8CFF80150; Tue,  4 Aug 2020 10:08:10 +0200 (CEST)
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB65CF80148
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2020 10:07:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB65CF80148
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="OcAAPemw"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1596528485; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kh1oVc6YO4R1j2xoiwGx/wGlgh7RD83i0V1vly7q1ok=;
 b=OcAAPemwZyDqBjuF4MZD3s4m2xTvv0vb7hJYfoDJnpz/3guky8UQzNLg9HF8de/xTPJkxKUs
 QT7nRjlpqBLx7DrZTnaV4aOxM3Dvnv29wvlU7rejlDnojsQOnXGfIa0QopFSMLYwDwtcuIt5
 IBjKYPXDEQsi6KREThz8PVdBp+o=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f2917534e5050c6c594f772 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 08:07:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B6BF1C433C9; Tue,  4 Aug 2020 08:07:47 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: rohitkr)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E105C433CA;
 Tue,  4 Aug 2020 08:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2E105C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=rohitkr@codeaurora.org
From: Rohit kumar <rohitkr@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/12] ASoC: qcom: Add support for SC7180 lpass variant
Date: Tue,  4 Aug 2020 13:37:21 +0530
Message-Id: <1596528453-11437-1-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Cc: Rohit kumar <rohitkr@codeaurora.org>
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

This patch chain add audio support for SC7180 soc by doing the required
modification in existing common lpass-cpu/lpass-platform driver.
This also fixes some concurrency issue.

This patch series is already tested by Srinivas on Dragon Board 410c.
Changes since v4:
        - Updated compatible string for sc7180 lpass cpu as suggested by Rob
        - Addressed comments by Rob in yaml Documentation.

Ajit Pandey (4):
  ASoC: qcom: Add common array to initialize soc based core clocks
  ASoC: qcom: lpass-platform: Replace card->dev with component->dev
  include: dt-bindings: sound: Add sc7180-lpass bindings header
  ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio

Rohit kumar (8):
  ASoC: qcom: lpass-cpu: Move ahbix clk to platform specific function
  ASoC: qcom: lpass-platform: fix memory leak
  ASoC: qcom: lpass: Use regmap_field for i2sctl and dmactl registers
  ASoC: qcom: lpass-cpu: fix concurrency issue
  dt-bindings: sound: lpass-cpu: Add sc7180 lpass cpu node
  ASoC: qcom: lpass-cpu: Use platform_get_resource
  ASoC: qcom: lpass-platform: Use platform_get_irq
  dt-bindings: sound: lpass-cpu: Move to yaml format

 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  79 --------
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 179 +++++++++++++++++
 include/dt-bindings/sound/sc7180-lpass.h           |  10 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-apq8016.c                     |  86 ++++++--
 sound/soc/qcom/lpass-cpu.c                         | 204 ++++++++++---------
 sound/soc/qcom/lpass-ipq806x.c                     |  67 +++++++
 sound/soc/qcom/lpass-lpaif-reg.h                   | 157 ++++++++-------
 sound/soc/qcom/lpass-platform.c                    | 155 +++++++++++----
 sound/soc/qcom/lpass-sc7180.c                      | 216 +++++++++++++++++++++
 sound/soc/qcom/lpass.h                             |  63 +++++-
 12 files changed, 924 insertions(+), 299 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
 create mode 100644 include/dt-bindings/sound/sc7180-lpass.h
 create mode 100644 sound/soc/qcom/lpass-sc7180.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

