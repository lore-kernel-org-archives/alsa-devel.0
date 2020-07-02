Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20BCC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:04:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F9B206E2
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mvDh77PO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F9B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B735116D1;
	Thu,  2 Jul 2020 19:03:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B735116D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593709471;
	bh=pI1O/heCj0W3G5v7rXF03duSk9hhYSMNTKyXimD+X1o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mvDh77POefS/xrBvpHh9inJh/D1/Z5NUHvGHyljAiyZMpFeRIxGNrK9uq02TyaQPm
	 Nm09xjZkOk2YFKecWybwNLSFw2U+t1n99TNZKqUxVtT2gGFZdLb2w8zFSyPb8tM6nQ
	 HtZflSiRYga8oOQCvstM0uHN+TptQyhFCtC/aFeg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DDD5F802FD;
	Thu,  2 Jul 2020 18:59:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73FA1F802E2; Thu,  2 Jul 2020 18:59:32 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5097CF80247
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 18:59:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5097CF80247
IronPort-SDR: sGFJZPIav1t1YB4241bxh2Eu/SUrgaFaoopWehbXn/vti1CnmLxbmI4esJbBrgv/ZuTAyWolFu
 xy2xkEcn8/7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="126583318"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="126583318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:59:24 -0700
IronPort-SDR: uUNoPoufGcDhF3lI9DepTyS3pbZwmKLRfRKKDU8qbLmkcyhDNzk0RXqZgOc1hoxkiIKrwOAEYA
 KvSWPxPGwstg==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="426014906"
Received: from nzbastur-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.182])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 09:59:23 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 7/8] ASoC: tegra: tegra20_das: remove always-true comparison
Date: Thu,  2 Jul 2020 11:59:00 -0500
Message-Id: <20200702165901.164100-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Takashi Iwai <tiwai@suse.com>, broonie@kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>
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

Fix W=1 warning:

sound/soc//tegra/tegra20_das.c:101:11: warning:
comparison of unsigned expression >= 0 is always true [-Wtype-limits]
  101 |  if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
      |           ^~

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/tegra/tegra20_das.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
index 1070b2710d5e..79dba878d854 100644
--- a/sound/soc/tegra/tegra20_das.c
+++ b/sound/soc/tegra/tegra20_das.c
@@ -98,8 +98,7 @@ EXPORT_SYMBOL_GPL(tegra20_das_connect_dac_to_dap);
 
 static bool tegra20_das_wr_rd_reg(struct device *dev, unsigned int reg)
 {
-	if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
-	    (reg <= LAST_REG(DAP_CTRL_SEL)))
+	if (reg <= LAST_REG(DAP_CTRL_SEL))
 		return true;
 	if ((reg >= TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL) &&
 	    (reg <= LAST_REG(DAC_INPUT_DATA_CLK_SEL)))
-- 
2.25.1

