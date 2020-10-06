Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87120C41604
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 06:57:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641D420760
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 06:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="korsMm2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641D420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A782B1766;
	Tue,  6 Oct 2020 08:56:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A782B1766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601967452;
	bh=dC2d9Qk1rV1cogMw/OtOrsgfAtYRoxM669LTUExcN+8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=korsMm2Udl7GKyJbx63dDZMnvlZAbRYkc4nwkUB8jOQkP7hljnxPvRD2fSfaXgbQe
	 a/mmzfxq4qcKifXnmnScK4ErO2vqnDzwllRTyIRGxkD3XpF8kaVYmZaHq6pzDkF2t2
	 ZZn4SQoPVjpQNUgowtYtM7OIZDaXyc58YixB86GA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0ACF8F8035F;
	Tue,  6 Oct 2020 08:50:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51E64F80335; Tue,  6 Oct 2020 08:50:40 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9B15F80317
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 08:50:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9B15F80317
IronPort-SDR: IA5JmvHlQtAjIqj4nzozQEWPBF1t1UZg8l1c57xcVOEc950fgRMv/yB3eiZs2IWDFt85eTorFc
 P+Y6f+ar1ULQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="249091371"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; d="scan'208";a="249091371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2020 23:50:36 -0700
IronPort-SDR: nh1w+vMu5gCBo3CR+S4gRG6/zwUoaE27LytkoKxK4Z8ytl6TCNmk+4T8CIxBC4PVUmU9so/oLC
 euOa+9XBY3AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; d="scan'208";a="315491323"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga006.jf.intel.com with ESMTP; 05 Oct 2020 23:50:32 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 12/13] ASoC: Intel: Remove sst_pdata structure
Date: Tue,  6 Oct 2020 08:49:06 +0200
Message-Id: <20201006064907.16277-13-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006064907.16277-1-cezary.rojewski@intel.com>
References: <20201006064907.16277-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, andriy.shevchenko@linux.intel.com,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com, marcin.barlik@intel.com,
 zwisler@google.com, lgirdwood@gmail.com, tiwai@suse.com,
 filip.proborszcz@intel.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, michal.wasko@intel.com,
 cujomalainey@chromium.org, krzysztof.hejmowski@intel.com,
 ppapierkowski@habana.ai, vamshi.krishna.gopal@intel.com
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

struct sst_pdata is unused among remaining /sound/soc/intel solution so
remove it.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h |  2 +-
 sound/soc/intel/common/sst-dsp.h      | 28 ---------------------------
 sound/soc/intel/skylake/skl-sst-dsp.c |  2 +-
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 7d9834509f4a..5a5ce5069f9f 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -27,7 +27,7 @@ struct sst_ops {
 	irqreturn_t (*irq_handler)(int irq, void *context);
 
 	/* SST init and free */
-	int (*init)(struct sst_dsp *sst, struct sst_pdata *pdata);
+	int (*init)(struct sst_dsp *sst);
 	void (*free)(struct sst_dsp *sst);
 };
 
diff --git a/sound/soc/intel/common/sst-dsp.h b/sound/soc/intel/common/sst-dsp.h
index 021a36b2398a..f111fd3f334b 100644
--- a/sound/soc/intel/common/sst-dsp.h
+++ b/sound/soc/intel/common/sst-dsp.h
@@ -26,34 +26,6 @@ struct sst_dsp_device {
 	void *thread_context;
 };
 
-/*
- * SST Platform Data.
- */
-struct sst_pdata {
-	/* ACPI data */
-	u32 lpe_base;
-	u32 lpe_size;
-	u32 pcicfg_base;
-	u32 pcicfg_size;
-	u32 fw_base;
-	u32 fw_size;
-	int irq;
-
-	/* Firmware */
-	const struct firmware *fw;
-
-	/* DMA */
-	int resindex_dma_base; /* other fields invalid if equals to -1 */
-	u32 dma_base;
-	u32 dma_size;
-	int dma_engine;
-	struct device *dma_dev;
-
-	/* DSP */
-	u32 id;
-	void *dsp;
-};
-
 /* SHIM Read / Write */
 void sst_dsp_shim_write(struct sst_dsp *sst, u32 offset, u32 value);
 u32 sst_dsp_shim_read(struct sst_dsp *sst, u32 offset);
diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 225706d148d8..4ae3eae0d1fd 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -422,7 +422,7 @@ struct sst_dsp *skl_dsp_ctx_init(struct device *dev,
 
 	/* Initialise SST Audio DSP */
 	if (sst->ops->init) {
-		ret = sst->ops->init(sst, NULL);
+		ret = sst->ops->init(sst);
 		if (ret < 0)
 			return NULL;
 	}
-- 
2.17.1

