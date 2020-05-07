Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B81C38A24
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 07:29:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BFD62078C
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 07:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vsssT5sk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFD62078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D04B17E1;
	Thu,  7 May 2020 09:28:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D04B17E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588836575;
	bh=SAiQzIPxFn62QiIYRrNoMG0+hieGel9636zQyEfkwkc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vsssT5sk30AQNOWoamjcDaOQuGqnw5/84ZWgW9/MsjxLr9Tuhm7gpWlYj8dSeu1V1
	 8ptoTkpIsBr9xW3ywGUB+FMAojSkZi79RLtylrzq0h+6sm3+pLX284C3aiwWqPhup/
	 lRdudDacWlp0qWiUe4HfID6o9PNfcGgezOl+Rk5k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C1D09F8015B;
	Thu,  7 May 2020 09:28:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 390C2F8015F; Thu,  7 May 2020 09:28:40 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 09EA3F800F6;
 Thu,  7 May 2020 09:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09EA3F800F6
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 133FA643564DA37E02CB;
 Thu,  7 May 2020 15:28:26 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 15:28:16 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
 <ranjani.sridharan@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
 <daniel.baluta@nxp.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <joe@perches.com>
Subject: [PATCH v2 -next] ASoC: SOF: Intel: Fix unused variable warning
Date: Thu, 7 May 2020 15:27:35 +0800
Message-ID: <20200507072735.16588-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200507031911.38644-1-yuehaibing@huawei.com>
References: <20200507031911.38644-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
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

When CONFIG_SND_SOC_SOF_BAYTRAIL is not set, gcc warns:

sound/soc/sof/intel/byt.c:85:41: warning: ‘cht_debugfs’ defined but not used [-Wunused-const-variable=]
 static const struct snd_sof_debugfs_map cht_debugfs[] = {
                                         ^~~~~~~~~~~
Move the variable inside #ifdef

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: Move the variable inside #ifdef as Joe's suggestion
---
 sound/soc/sof/intel/byt.c | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index f872bb1f2682..3747f2c2c28b 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -82,33 +82,6 @@ static const struct snd_sof_debugfs_map byt_debugfs[] = {
 	 SOF_DEBUGFS_ACCESS_ALWAYS},
 };
 
-static const struct snd_sof_debugfs_map cht_debugfs[] = {
-	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"dmac2", BYT_DSP_BAR,  DMAC2_OFFSET, DMAC_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp0",  BYT_DSP_BAR, SSP0_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp1", BYT_DSP_BAR, SSP1_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp2", BYT_DSP_BAR, SSP2_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp3", BYT_DSP_BAR, SSP3_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp4", BYT_DSP_BAR, SSP4_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"ssp5", BYT_DSP_BAR, SSP5_OFFSET, SSP_SIZE,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-	{"iram", BYT_DSP_BAR, IRAM_OFFSET, IRAM_SIZE,
-	 SOF_DEBUGFS_ACCESS_D0_ONLY},
-	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
-	 SOF_DEBUGFS_ACCESS_D0_ONLY},
-	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE_CHT,
-	 SOF_DEBUGFS_ACCESS_ALWAYS},
-};
-
 static void byt_host_done(struct snd_sof_dev *sdev);
 static void byt_dsp_done(struct snd_sof_dev *sdev);
 static void byt_get_reply(struct snd_sof_dev *sdev);
@@ -681,6 +654,33 @@ EXPORT_SYMBOL_NS(tng_chip_info, SND_SOC_SOF_MERRIFIELD);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
 
+static const struct snd_sof_debugfs_map cht_debugfs[] = {
+	{"dmac0", BYT_DSP_BAR, DMAC0_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"dmac1", BYT_DSP_BAR,  DMAC1_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"dmac2", BYT_DSP_BAR,  DMAC2_OFFSET, DMAC_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp0",  BYT_DSP_BAR, SSP0_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp1", BYT_DSP_BAR, SSP1_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp2", BYT_DSP_BAR, SSP2_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp3", BYT_DSP_BAR, SSP3_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp4", BYT_DSP_BAR, SSP4_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"ssp5", BYT_DSP_BAR, SSP5_OFFSET, SSP_SIZE,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+	{"iram", BYT_DSP_BAR, IRAM_OFFSET, IRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"dram", BYT_DSP_BAR, DRAM_OFFSET, DRAM_SIZE,
+	 SOF_DEBUGFS_ACCESS_D0_ONLY},
+	{"shim", BYT_DSP_BAR, SHIM_OFFSET, SHIM_SIZE_CHT,
+	 SOF_DEBUGFS_ACCESS_ALWAYS},
+};
+
 static int byt_acpi_probe(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_pdata *pdata = sdev->pdata;
-- 
2.17.1


