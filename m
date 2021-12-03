Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00675C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 12:07:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25355226A;
	Fri,  3 Dec 2021 13:06:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25355226A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638533264;
	bh=70FxLFja52XD2l3251wz0u1qRt0ntC3wO3jPsspgju4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iIw7SNWOL2EbAWMicbNZMZyLqrkhbL40NVs0o5a9/5u8UErMDO7G0Cq6Ukkcb5zmb
	 lj8UkcDyI4jQM8fkaQA4dHTmZCKtFoj5fApClVQpYv9AbnHJINra0ugFagZvZeVyWs
	 vJCZ4u4VqWuE9Iclew2u+zsP/XMskPG/w4PJ2gfo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BB0D5F80085;
	Fri,  3 Dec 2021 13:06:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66D9DF8015B; Fri,  3 Dec 2021 13:06:49 +0100 (CET)
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA453F800A7
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 13:06:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA453F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="ZNdMv3yn"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1638533205; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pQZT8IsW4jYbFaXDYqbHE6v8CLACutQ1h0TkuVwudoo=;
 b=ZNdMv3ynh3IkwJS0UL/172fhbYSciciXUOejDPJ9XRf8larMzAEJiKY21axEKfrDsSQ+IlZg
 H31s+DOyYDtipWJz1CMvxGNfz9U1WbUHLEB+B+M0l6b1WcuRE5awvpXq8pHtqptgEECn7pav
 In7bLDxmPslhrKjeTNuKBuARJNA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 61aa084e642caac318e547b3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Dec 2021 12:06:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id BBAA5C4360D; Fri,  3 Dec 2021 12:06:37 +0000 (UTC)
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 61E28C4360C;
 Fri,  3 Dec 2021 12:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 61E28C4360C
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
Subject: [PATCH v7 0/2] Machine driver to support LPASS SC7280 sound card
 registration
Date: Fri,  3 Dec 2021 17:36:21 +0530
Message-Id: <1638533183-19023-1-git-send-email-srivasam@codeaurora.com>
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

Srinivasa Rao Mandadapu (2):
  ASoC: google: dt-bindings: Add sc7280-herobrine machine bindings
  ASoC: qcom: SC7280: Add machine driver

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

 .../bindings/sound/google,sc7280-herobrine.yaml    | 171 ++++++++++++
 sound/soc/qcom/Kconfig                             |  14 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass.h                             |   1 +
 sound/soc/qcom/sc7280.c                            | 290 +++++++++++++++++++++
 5 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
 create mode 100644 sound/soc/qcom/sc7280.c

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

