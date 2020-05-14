Return-Path: <SRS0=rado=64=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A3CC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 16:40:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D364207C3
	for <alsa-devel@archiver.kernel.org>; Thu, 14 May 2020 16:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eUwMugMI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="n1GosyLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D364207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42885950;
	Thu, 14 May 2020 18:39:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42885950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589474401;
	bh=+xEWlR784BhRsg4ynhQQLxjbrgb4RL6hT2eX7I4GlPo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eUwMugMIg/og+WLhA3PbEMamHyD1OdQj8CeQkyZewnqlS329x6aXD7eanRexfRY50
	 2hyZnu6qgjWEUotWRHrVR36sW9kTkRQP1Y0iGu47a8QCE4rC46woTcwQIjoHOmVgB2
	 t9QlFfl4fpSXVzNJg9Djsbca8oamAF2HQxWDhPc0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A0E0F8015A;
	Thu, 14 May 2020 18:39:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 23E61F8014C; Thu, 14 May 2020 18:38:57 +0200 (CEST)
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A632EF800E3
 for <alsa-devel@alsa-project.org>; Thu, 14 May 2020 18:38:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A632EF800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="n1GosyLU"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1589474332; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=XtijKa57sDu7SGNlekBLq6pKnJsPytXBb8GduvE5HTM=;
 b=n1GosyLUlx/rL98/VYzE/9TkH4Ygp0JKOQksdUtDqKxLf9Va71RbV8jvBhqWx7gPcrC4kb86
 n7k3OcKuziRYSTwFCsdppnb+SmH0DwbyLqkR3PckLdnnACLKnB4NOgn3prjUJ+BYv21ObCOS
 y382U/0LVzteSVyqKlj7Pw68quw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd7419.7fa2382add18-smtp-out-n03;
 Thu, 14 May 2020 16:38:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 55D5BC432C2; Thu, 14 May 2020 16:38:49 +0000 (UTC)
Received: from c-ajitp-linux.qualcomm.com
 (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ajitp)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 589B1C433D2;
 Thu, 14 May 2020 16:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 589B1C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=ajitp@codeaurora.org
From: Ajit Pandey <ajitp@codeaurora.org>
To: broonie@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
 srinivas.kandagatla@linaro.org
Subject: [PATCH v2 0/7] ASoC: QCOM: Add support for SC7180 lpass variant
Date: Thu, 14 May 2020 22:08:11 +0530
Message-Id: <1589474298-29437-1-git-send-email-ajitp@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <“1586592171-31644-1-git-send-email-ajitp@codeaurora.org”>
References: <“1586592171-31644-1-git-send-email-ajitp@codeaurora.org”>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Ajit Pandey <ajitp@codeaurora.org>
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

We've common ASoC cpu driver for QCOM LPASS soc varaints. This patch chain add support for new variant SC7180 soc by doing the required
modification in existing common lpass-cpu driver. Below is a brief summary of patch series:

PATCH v2 0001 ... 0004: Update lpass-cpu driver and documentation to make it more generic and support newer soc registers configuration.
PATCH v2 0005 ... 0007: Add documentation and platform driver for newer SC7180 SOC variant.

Ajit Pandey (7):
  Documentation: device-tree: sound: Update lpass-cpu driver binding
  ASoC: qcom: Add common array to initialize soc based core clocks
  ASoC: qcom: lpass-cpu: Make "ahbix-clk" an optional clock.
  ASoC: qcom: lpass: Use regmap_field for i2sctl and dmactl registers
  include: dt-bindings: sound: Add sc7180-lpass bindings header
  device-tree: bindings: sound: lpass-cpu: Add new compatible soc
  ASoC: qcom: lpass-sc7180: Add platform driver for lpass audio

 .../devicetree/bindings/sound/qcom,lpass-cpu.txt   |  79 -------
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 154 +++++++++++++
 include/dt-bindings/sound/sc7180-lpass.h           |  10 +
 sound/soc/qcom/Kconfig                             |   5 +
 sound/soc/qcom/Makefile                            |   2 +
 sound/soc/qcom/lpass-apq8016.c                     | 100 ++++++--
 sound/soc/qcom/lpass-cpu.c                         | 116 ++++++----
 sound/soc/qcom/lpass-lpaif-reg.h                   | 203 ++++++++++-------
 sound/soc/qcom/lpass-platform.c                    |  86 ++++---
 sound/soc/qcom/lpass-sc7180.c                      | 252 +++++++++++++++++++++
 sound/soc/qcom/lpass.h                             |  40 +++-
 11 files changed, 790 insertions(+), 257 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
 create mode 100644 include/dt-bindings/sound/sc7180-lpass.h
 create mode 100644 sound/soc/qcom/lpass-sc7180.c

-- 
('The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project')
