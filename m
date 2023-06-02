Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE886C7EE29
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 21:00:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B80584C;
	Fri,  2 Jun 2023 22:59:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B80584C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685739618;
	bh=HdKSnxgl3SAviTOBDDBA2JdFtJuxgH4j9Iq0co0z0ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eEezj0Vj5SrsLgYU8wqSXNUtIqNdadle3x+4i2En9qniB6DL5on7J0i06B+I6Plf4
	 fBCUlJ8yILYO/9oHsSI9R2pLLQVRSQDSfCzSpGWPBov8h7skaR42JikKKF9kUgXc0W
	 0jDwRLXSMGEgbYqVPgk91wjGL45cMufIfBnWAft4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C34AFF805D9; Fri,  2 Jun 2023 22:57:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24EEBF805D9;
	Fri,  2 Jun 2023 22:57:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 967A3F80558; Fri,  2 Jun 2023 22:56:46 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3C49CF800BD
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 22:56:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C49CF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eX9GTNdX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685739403; x=1717275403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HdKSnxgl3SAviTOBDDBA2JdFtJuxgH4j9Iq0co0z0ho=;
  b=eX9GTNdXTIoSHChXrmOedQG3o2Un/4ub+CG0Ta28xMJE+JwC6r5pQPmU
   Fm/6Uj1jpP6du4KHpvvGVrvE2e/1XVl0g3iNP1EQA4d5qNc2/wYk9oA9V
   /QzUxSX1Dc+tRltdUycNLJClV2tRgOCptOR2wsnBk1tnp8iEj6/hvu1kr
   /c65KESInD2ttnHfSxaqGCVr0oO3g4pKULuJN4BMDEpAJkrcniCjYYZwp
   oEkQWnmndavneZpZKfsZjG70P96ktav3p/KfEpY1UF0Cg8lAQ1PcfwFUE
   rmoM4j2c1OUU1+bvI74v4IwVfx9KbB3eMzzNC7DS3Qq/X/zINYd9HXamo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="359272115"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="359272115"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832092723"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="832092723"
Received: from sbalabha-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.190.110])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:56:38 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	vinod.koul@intel.com,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 8/9] ASoC: SOF: Intel: mtl: prepare for code reuse
Date: Fri,  2 Jun 2023 15:56:19 -0500
Message-Id: <20230602205620.310879-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230602205620.310879-1-pierre-louis.bossart@linux.intel.com>
References: <20230602205620.310879-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GMRZOVEFNBV2ZDJCVENG6RFGFHIGOCKX
X-Message-ID-Hash: GMRZOVEFNBV2ZDJCVENG6RFGFHIGOCKX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GMRZOVEFNBV2ZDJCVENG6RFGFHIGOCKX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Some functions can be used for newer LNL hardware.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/mtl.c | 12 ++++++------
 sound/soc/sof/intel/mtl.h |  7 +++++++
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 93dc2c9d8448..8ae331faca4e 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -55,7 +55,7 @@ static void mtl_ipc_dsp_done(struct snd_sof_dev *sdev)
 }
 
 /* Check if an IPC IRQ occurred */
-static bool mtl_dsp_check_ipc_irq(struct snd_sof_dev *sdev)
+bool mtl_dsp_check_ipc_irq(struct snd_sof_dev *sdev)
 {
 	u32 irq_status;
 	u32 hfintipptr;
@@ -118,7 +118,7 @@ static int mtl_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *ms
 	return 0;
 }
 
-static void mtl_enable_ipc_interrupts(struct snd_sof_dev *sdev)
+void mtl_enable_ipc_interrupts(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
@@ -132,7 +132,7 @@ static void mtl_enable_ipc_interrupts(struct snd_sof_dev *sdev)
 				MTL_DSP_REG_HFIPCXCTL_BUSY | MTL_DSP_REG_HFIPCXCTL_DONE);
 }
 
-static void mtl_disable_ipc_interrupts(struct snd_sof_dev *sdev)
+void mtl_disable_ipc_interrupts(struct snd_sof_dev *sdev)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
@@ -173,7 +173,7 @@ static void mtl_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable)
 			enable ? "enable" : "disable");
 }
 
-static int mtl_enable_interrupts(struct snd_sof_dev *sdev, bool enable)
+int mtl_enable_interrupts(struct snd_sof_dev *sdev, bool enable)
 {
 	u32 hfintipptr;
 	u32 irqinten;
@@ -394,7 +394,7 @@ static int mtl_dsp_core_power_down(struct snd_sof_dev *sdev, int core)
 	return ret;
 }
 
-static int mtl_power_down_dsp(struct snd_sof_dev *sdev)
+int mtl_power_down_dsp(struct snd_sof_dev *sdev)
 {
 	u32 dsphfdsscs, cpa;
 	int ret;
@@ -421,7 +421,7 @@ static int mtl_power_down_dsp(struct snd_sof_dev *sdev)
 					     HDA_DSP_RESET_TIMEOUT_US);
 }
 
-static int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot)
+int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot)
 {
 	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
 	const struct sof_intel_dsp_desc *chip = hda->desc;
diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index 26418fb08807..2794fe6e8139 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -82,3 +82,10 @@
 #define MTL_DSP_REG_HfIMRIS1		0x162088
 #define MTL_DSP_REG_HfIMRIS1_IU_MASK	BIT(0)
 
+void mtl_enable_ipc_interrupts(struct snd_sof_dev *sdev);
+void mtl_disable_ipc_interrupts(struct snd_sof_dev *sdev);
+bool mtl_dsp_check_ipc_irq(struct snd_sof_dev *sdev);
+
+int mtl_enable_interrupts(struct snd_sof_dev *sdev, bool enable);
+int mtl_dsp_cl_init(struct snd_sof_dev *sdev, int stream_tag, bool imr_boot);
+int mtl_power_down_dsp(struct snd_sof_dev *sdev);
-- 
2.37.2

