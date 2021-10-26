Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719E4C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 12:20:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E359E61057
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 12:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E359E61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 486E816D7;
	Tue, 26 Oct 2021 14:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 486E816D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635250842;
	bh=pS/3UnBrR3RwLQyOjT5Flptrax6GOsyHHzJxfimAI4k=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DSBTIgG9aQUG10JI8zVl1wZPJ/O5mwzrFdomYT9tqKjU7COzht1/3/BcWPVAYnRwL
	 +jXDSZGjXTnW+u98B7At6i9uXtfimtmJteGR4tzc5/UO52dAOEJZjlIiwt8qt9fvR5
	 2mDxMf7qpdLniER8ylz1/sT7vDAjBrfPBCj1Od8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BDF0BF80269;
	Tue, 26 Oct 2021 14:19:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8BA46F802C8; Tue, 26 Oct 2021 14:19:49 +0200 (CEST)
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BAAEF8010A
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 14:19:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BAAEF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="sVuj3oM6"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1635250784; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=lxambdPjjCTbsonlXAfW42PgjHSfRJVT1wXjJ/kn1go=;
 b=sVuj3oM60tdQBMZe82ZnTRtoxNDyE+5tMEsXDPlHBCIyFEQpJmvS2j88yMm/nqd5TZ9fh47c
 sGetoA6uhlcjOWB8nCoBxTsSf+Gk+V1K6NM0hSa23w2wHbi1WKKqXPHaGp/Bjq3umUv9N4yq
 9/3tcP0GKbzreRA9VRNG8zsMwJw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6177f25c14914866fa693052 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 Oct 2021 12:19:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id D6AD5C4338F; Tue, 26 Oct 2021 12:19:39 +0000 (UTC)
Received: from hu-srivasam-hyd.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: srivasam)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A001BC43616;
 Tue, 26 Oct 2021 12:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org A001BC43616
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
Subject: [PATCH v4 0/3] Update SoundWire RX and TX cgcr register control
Date: Tue, 26 Oct 2021 17:49:21 +0530
Message-Id: <1635250764-13994-1-git-send-email-srivasam@codeaurora.org>
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

This patch series is to add v1.6.0 compatable name for qcom soundwire
driver and to update soundwire RX and TX cgcr register control.

Changes Since V3:
    -- Add v1.6.0 compatable name and soundwire data structure.
    -- Change macro define name properly.
    -- Update bindings for new property.
    -- Change commit message description.
    -- Change signedoff by sequence.
Changes since v2:
    -- Update error check after ioremap.
Changes since v1:
    -- Add const name to mask value.
Srinivasa Rao Mandadapu (3):
  ASoC: qcom: soundwire: Disable soundwire rxtx cgcr hardware control
  dt-bindings: soundwire: qcom: Add bindings for RX and TX cgcr register
    control
  soundwire: qcom: Add compatible name for v1.6.0

 .../devicetree/bindings/soundwire/qcom,sdw.txt       |  9 +++++++++
 drivers/soundwire/qcom.c                             | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

