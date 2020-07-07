Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8415C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:09:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C20C206E9
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I71BPr3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C20C206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D73D61679;
	Tue,  7 Jul 2020 21:08:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D73D61679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594148947;
	bh=eE8DlOdmyadMmXKYGmL73xpLzgLMcvd1vs/kTv43eDs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I71BPr3BtdrwwCH5UCjCYLNcl6O+amBMvGMg9y6jRtUf8cIsY6sHmQ0te1HOHRK5U
	 LxR5coPO90KSZmdr0uy3qYuRsudn1Mh4UrkPK3YS3SaGkqthAlV38wXbWaYJ7+VMKY
	 xdnJKCASIm3Mfk6z4Pb4mZnRmH2QJ6PL8qpnf3Hk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3158BF8027C;
	Tue,  7 Jul 2020 21:06:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46750F802E1; Tue,  7 Jul 2020 21:06:49 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC5FEF80274
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:06:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC5FEF80274
IronPort-SDR: Cu2pOpJUgV/dGBk4PwfZjFr3bS1sg+bm0XyGKIfdd3G3TOtlkK+edvIG+HLGeTfF67PK+Ss/BT
 9md5epMlCwag==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="149202900"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="149202900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:06:36 -0700
IronPort-SDR: c+QrqvRHvqybbsdzESVBZe6ihASfuLsit4oMA8N5Lkv3gCadq23nUsiXYUmgU7+FeMSfTXq6+G
 zW4BMEc2C0VQ==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="268278550"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:06:35 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 04/13] ASoC: tegra: tegra20_das: remove always-true
 comparison
Date: Tue,  7 Jul 2020 14:06:03 -0500
Message-Id: <20200707190612.97799-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
References: <20200707190612.97799-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 broonie@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, Lee Jones <lee.jones@linaro.org>
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

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
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

