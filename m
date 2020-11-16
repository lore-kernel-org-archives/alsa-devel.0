Return-Path: <SRS0=lYVm=EW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4C2C4742C
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:37:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B9E22245
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Nov 2020 13:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="npUZtPAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B9E22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BECC7176F;
	Mon, 16 Nov 2020 14:36:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BECC7176F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605533840;
	bh=WAzo1tX7NO9OTl3bUmpSLlJ3m+dZW7DxqOHTO4Lc2q4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=npUZtPAyoBs5HSYVhjyJkyeTZ+8eio3+Wis/iAoLiUwIYOeiKc8Ji/TSARMowj51a
	 6Lfor1r7tseAHG6HnsB+hC/KXGUD2z1dD0HzNbUyg4LFQDe99XmC0w+Iq9YKvzl6Ql
	 az4rI7rq9wJ5vaLvxJDao6WqsRW3yLL07C9Mb2Zc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16EEEF804CC;
	Mon, 16 Nov 2020 14:34:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB517F80167; Mon, 16 Nov 2020 14:34:11 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9692F8016E
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2020 14:34:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9692F8016E
IronPort-SDR: 1VSEn0Xb0EZPSStOTop6lhSlVLN6wK9uDp3PqWyHKK3NHiRDZVNWO7NcrD4WA3Yzi2COyxy3fl
 zBUSvFyhwBDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158520558"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="158520558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2020 05:33:57 -0800
IronPort-SDR: LmbnIsAobHn+GP4d/dsJaXrvq1d7Tbq3XLSWfoFcC1BgV+KuwfBI3NKLn9ZMV8847WhQ02how8
 4bW4IvPLSEkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; d="scan'208";a="475525055"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga004.jf.intel.com with ESMTP; 16 Nov 2020 05:33:55 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ASoC: Intel: catpt: Cleanup after power routines
 streamlining
Date: Mon, 16 Nov 2020 14:33:32 +0100
Message-Id: <20201116133332.8530-6-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201116133332.8530-1-cezary.rojewski@intel.com>
References: <20201116133332.8530-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 lgirdwood@gmail.com, hdegoede@redhat.com, broonie@kernel.org
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

With LPT switching to WPT-based power on/off routines, functions that
have been previously used by it are rendered redundant so remove them.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/catpt/core.h |  4 ----
 sound/soc/intel/catpt/dsp.c  | 46 ------------------------------------
 2 files changed, 50 deletions(-)

diff --git a/sound/soc/intel/catpt/core.h b/sound/soc/intel/catpt/core.h
index 693dc4a4b621..0f53a0d43254 100644
--- a/sound/soc/intel/catpt/core.h
+++ b/sound/soc/intel/catpt/core.h
@@ -83,8 +83,6 @@ struct catpt_spec {
 	u32 d3srampgd_bit;
 	u32 d3pgd_bit;
 	void (*pll_shutdown)(struct catpt_dev *cdev, bool enable);
-	int (*power_up)(struct catpt_dev *cdev);
-	int (*power_down)(struct catpt_dev *cdev);
 };
 
 struct catpt_dev {
@@ -128,8 +126,6 @@ int catpt_dma_memcpy_fromdsp(struct catpt_dev *cdev, struct dma_chan *chan,
 
 void lpt_dsp_pll_shutdown(struct catpt_dev *cdev, bool enable);
 void wpt_dsp_pll_shutdown(struct catpt_dev *cdev, bool enable);
-int lpt_dsp_power_up(struct catpt_dev *cdev);
-int lpt_dsp_power_down(struct catpt_dev *cdev);
 int catpt_dsp_power_up(struct catpt_dev *cdev);
 int catpt_dsp_power_down(struct catpt_dev *cdev);
 int catpt_dsp_stall(struct catpt_dev *cdev, bool stall);
diff --git a/sound/soc/intel/catpt/dsp.c b/sound/soc/intel/catpt/dsp.c
index dfa442a3c1f1..9c5fd18f2600 100644
--- a/sound/soc/intel/catpt/dsp.c
+++ b/sound/soc/intel/catpt/dsp.c
@@ -344,52 +344,6 @@ static void catpt_dsp_set_regs_defaults(struct catpt_dev *cdev)
 	}
 }
 
-int lpt_dsp_power_down(struct catpt_dev *cdev)
-{
-	catpt_dsp_reset(cdev, true);
-
-	/* set 24Mhz clock for both SSPs */
-	catpt_updatel_shim(cdev, CS1, CATPT_CS_SBCS(0) | CATPT_CS_SBCS(1),
-			   CATPT_CS_SBCS(0) | CATPT_CS_SBCS(1));
-	catpt_dsp_select_lpclock(cdev, true, false);
-
-	/* DRAM power gating all */
-	catpt_dsp_set_srampge(cdev, &cdev->dram, cdev->spec->dram_mask,
-			      cdev->spec->dram_mask);
-	catpt_dsp_set_srampge(cdev, &cdev->iram, cdev->spec->iram_mask,
-			      cdev->spec->iram_mask);
-
-	catpt_updatel_pci(cdev, PMCS, PCI_PM_CTRL_STATE_MASK, PCI_D3hot);
-	/* give hw time to drop off */
-	udelay(50);
-
-	return 0;
-}
-
-int lpt_dsp_power_up(struct catpt_dev *cdev)
-{
-	/* SRAM power gating none */
-	catpt_dsp_set_srampge(cdev, &cdev->dram, cdev->spec->dram_mask, 0);
-	catpt_dsp_set_srampge(cdev, &cdev->iram, cdev->spec->iram_mask, 0);
-
-	catpt_updatel_pci(cdev, PMCS, PCI_PM_CTRL_STATE_MASK, PCI_D0);
-	/* give hw time to wake up */
-	udelay(100);
-
-	catpt_dsp_select_lpclock(cdev, false, false);
-	catpt_updatel_shim(cdev, CS1,
-			   CATPT_CS_SBCS(0) | CATPT_CS_SBCS(1),
-			   CATPT_CS_SBCS(0) | CATPT_CS_SBCS(1));
-	/* stagger DSP reset after clock selection */
-	udelay(50);
-
-	catpt_dsp_reset(cdev, false);
-	/* generate int deassert msg to fix inversed int logic */
-	catpt_updatel_shim(cdev, IMC, CATPT_IMC_IPCDB | CATPT_IMC_IPCCD, 0);
-
-	return 0;
-}
-
 int catpt_dsp_power_down(struct catpt_dev *cdev)
 {
 	u32 mask, val;
-- 
2.17.1

