Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F49C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 10:15:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92047619F7
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 10:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92047619F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1673D1684;
	Wed, 24 Mar 2021 11:14:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1673D1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616580915;
	bh=/2nF/UDczEMNL0yv/bcwxaT62aLecbeRs5vr7vdOu3E=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ACSl2ChJGVEKVZGbmKOpxOBQQjEv28YyhUqwshEWGHvrOHVaTRdNgzJXGX4UA+TNZ
	 F2PTbxq0MDsoEPG1UnapvUqXmIiOTJSnqgtjk9nF7lnMfhnRPZMWq+9bjzKxnSc2Jh
	 fKfRLmrzzRRkiaP/w9RPto0TRKCMUvHvGB0nJSRU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0FFAFF80424;
	Wed, 24 Mar 2021 11:13:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09F12F8032B; Wed, 24 Mar 2021 11:13:16 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43514F801D5
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 11:13:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43514F801D5
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8140A1A27DC;
 Wed, 24 Mar 2021 11:13:03 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F98E1A1D0A;
 Wed, 24 Mar 2021 11:12:59 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C03284029B;
 Wed, 24 Mar 2021 11:12:29 +0100 (CET)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH 0/6] ASoC: fsl: Don't use devm_regmap_init_mmio_clk
Date: Wed, 24 Mar 2021 17:58:42 +0800
Message-Id: <1616579928-22428-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

When there is power domain bind with ipg clock,

The call flow:
devm_regmap_init_mmio_clk
    - clk_prepare()
        - clk_pm_runtime_get()

cause the power domain of clock always be enabled after
regmap_init(). which impact the power consumption.

So use devm_regmap_init_mmio instead of
devm_regmap_init_mmio_clk.

Shengjiu Wang (6):
  ASoC: fsl_esai: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_spdif: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_asrc: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_easrc: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_audmix: Don't use devm_regmap_init_mmio_clk
  ASoC: fsl_micfil: Don't use devm_regmap_init_mmio_clk

 sound/soc/fsl/fsl_asrc.c   | 57 +++++++++++++++++++++++++++++---------
 sound/soc/fsl/fsl_audmix.c |  3 +-
 sound/soc/fsl/fsl_easrc.c  |  3 +-
 sound/soc/fsl/fsl_esai.c   | 48 ++++++++++++++++++++++++--------
 sound/soc/fsl/fsl_micfil.c | 25 +++++++++++++----
 sound/soc/fsl/fsl_spdif.c  |  3 +-
 6 files changed, 103 insertions(+), 36 deletions(-)

-- 
2.27.0

