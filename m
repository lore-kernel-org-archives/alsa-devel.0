Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EB7C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:35:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1313486E;
	Mon, 31 Jul 2023 23:35:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1313486E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690839356;
	bh=o5+u+aXtqWZYYh0DiPq7Vb3s8bYdtiMpfZN9dpGMVIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UYLmuT9kjAUA5v7z0wBosIKLXQh6bmpnt5wD30PcBnj1otX0HEhNZB02DMH1W5VTx
	 4sk7e7KPjDLcSPqMlN2OYPgtc+z78eAChFcmqS44+P9sMdUNl0rilXcyVEN1OkFejR
	 kFcBSOY0ftJxwqF7T4SY7ffvLSIsL2fN/QhVsG8Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70AA7F80571; Mon, 31 Jul 2023 23:34:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9F25F80553;
	Mon, 31 Jul 2023 23:34:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E226AF801D5; Mon, 31 Jul 2023 23:34:47 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 035BEF80425
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:33:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 035BEF80425
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=kdGd5aq1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839191; x=1722375191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5+u+aXtqWZYYh0DiPq7Vb3s8bYdtiMpfZN9dpGMVIg=;
  b=kdGd5aq1uVfR605sVB9CQ7xlmmybdzeRa2cnIwGo8QS7xym7XF1gq77q
   B+FQMQHuyElnSksKYi2npuccgYY7FZdYhdfnP0/bNhe2fDyK4vMJrMn0O
   7x6Vc+QPWhvnZ8hzhWZE7gLjfBylTgYEbkYRKJs5vJ0j0SeqWGmmpFeO5
   d3oq929UmaRurrN+6cFMmG99IZQ62QJ2SNY67zUAxYcml309y7HptcXSs
   hZU55oomzzWXjUza9RgA12kiI5cVkxxDWpWl5NVvlY7EMC+i83rF195md
   zgqWhW4FExlOcJ66dcoZ/T/ixW8SjKnB384kcOveJMONt/FWLmPG457hf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435447541"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435447541"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731708915"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="731708915"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:33:08 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Trevor Wu <trevor.wu@mediatek.com>,
	Yaochun Hung <yc.hung@mediatek.com>,
	Kuan-Hsun Cheng <Allen-KH.Cheng@mediatek.com>
Subject: [PATCH 6/6] ASoC: SOF: mediatek: mt8186 modify dram type as non-cache
Date: Mon, 31 Jul 2023 16:32:42 -0500
Message-Id: <20230731213242.434594-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731213242.434594-1-pierre-louis.bossart@linux.intel.com>
References: <20230731213242.434594-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4FYWEJVAR2S3R32GTDHH2UAKXDJF3DCD
X-Message-ID-Hash: 4FYWEJVAR2S3R32GTDHH2UAKXDJF3DCD
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4FYWEJVAR2S3R32GTDHH2UAKXDJF3DCD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Trevor Wu <trevor.wu@mediatek.com>

To prevent incorrect access between the host and DSP sides, we need to
modify DRAM as a non-cache memory type. Additionally, we can retrieve
the size of shared DMA from the device tree.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
Reviewed-by: Kuan-Hsun Cheng <Allen-KH.Cheng@mediatek.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 40 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 3e0ea0e109e2..f587edf9e0a7 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -111,6 +111,14 @@ static int platform_parse_resource(struct platform_device *pdev, void *data)
 
 	dev_dbg(dev, "DMA %pR\n", &res);
 
+	adsp->pa_shared_dram = (phys_addr_t)res.start;
+	adsp->shared_size = resource_size(&res);
+	if (adsp->pa_shared_dram & DRAM_REMAP_MASK) {
+		dev_err(dev, "adsp shared dma memory(%#x) is not 4K-aligned\n",
+			(u32)adsp->pa_shared_dram);
+		return -EINVAL;
+	}
+
 	ret = of_reserved_mem_device_init(dev);
 	if (ret) {
 		dev_err(dev, "of_reserved_mem_device_init failed\n");
@@ -244,23 +252,18 @@ static int adsp_shared_base_ioremap(struct platform_device *pdev, void *data)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_adsp_chip_info *adsp = data;
-	u32 shared_size;
 
 	/* remap shared-dram base to be non-cachable */
-	shared_size = TOTAL_SIZE_SHARED_DRAM_FROM_TAIL;
-	adsp->pa_shared_dram = adsp->pa_dram + adsp->dramsize - shared_size;
-	if (adsp->va_dram) {
-		adsp->shared_dram = adsp->va_dram + DSP_DRAM_SIZE - shared_size;
-	} else {
-		adsp->shared_dram = devm_ioremap(dev, adsp->pa_shared_dram,
-						 shared_size);
-		if (!adsp->shared_dram) {
-			dev_err(dev, "ioremap failed for shared DRAM\n");
-			return -ENOMEM;
-		}
+	adsp->shared_dram = devm_ioremap(dev, adsp->pa_shared_dram,
+					 adsp->shared_size);
+	if (!adsp->shared_dram) {
+		dev_err(dev, "failed to ioremap base %pa size %#x\n",
+			adsp->shared_dram, adsp->shared_size);
+		return -ENOMEM;
 	}
-	dev_dbg(dev, "shared-dram vbase=%p, phy addr :%pa, size=%#x\n",
-		adsp->shared_dram, &adsp->pa_shared_dram, shared_size);
+
+	dev_dbg(dev, "shared-dram vbase=%p, phy addr :%pa,  size=%#x\n",
+		adsp->shared_dram, &adsp->pa_shared_dram, adsp->shared_size);
 
 	return 0;
 }
@@ -307,9 +310,12 @@ static int mt8186_dsp_probe(struct snd_sof_dev *sdev)
 		return -ENOMEM;
 	}
 
-	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap_wc(sdev->dev,
-							  priv->adsp->pa_dram,
-							  priv->adsp->dramsize);
+	priv->adsp->va_sram = sdev->bar[SOF_FW_BLK_TYPE_IRAM];
+
+	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(sdev->dev,
+						       priv->adsp->pa_dram,
+						       priv->adsp->dramsize);
+
 	if (!sdev->bar[SOF_FW_BLK_TYPE_SRAM]) {
 		dev_err(sdev->dev, "failed to ioremap base %pa size %#x\n",
 			&priv->adsp->pa_dram, priv->adsp->dramsize);
-- 
2.39.2

