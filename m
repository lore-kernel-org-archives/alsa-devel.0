Return-Path: <SRS0=6kKU=DL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CA9C4363C
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 10:10:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0063C2078B
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 10:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A9zBESJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0063C2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7573318C8;
	Sun,  4 Oct 2020 12:09:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7573318C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601806231;
	bh=f+nXn3EVr0Ewp3LtqjSrXQW1XmmkZpC0QdsmgnjQO4E=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A9zBESJuV+igyqrRVKIUyhLvTKAIpxjA6hR/mKHt3zYk628xgzUlI7+kQZf5Ro2sR
	 xeZGVX9rz7XgToVqY4aVLccGxgALfLrHGTX8vakhNWyaLsWrUU/KfaKuYSWBvrVckJ
	 kJbc6uPySv1mMlVRmIQLHhe3v4Zz7fBJCfRKj3fQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 836D1F80363;
	Sun,  4 Oct 2020 12:02:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2003F80348; Sun,  4 Oct 2020 12:02:38 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B223F8032A
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2020 12:02:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B223F8032A
IronPort-SDR: LSOuSIn/NempjlUrIBs2K+tpYrdt5SFqvFBJYEvqWoiV7OnkBokTkJxjdWaZZQYXjD0ing5Tjz
 BrnX3JTD8k3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="163384025"
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; d="scan'208";a="163384025"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2020 03:02:28 -0700
IronPort-SDR: r4BifZa3TdAMHhbr2dQVABjmTfgPkhxoin7clG9teWxoIJ60stvwYtzY6A5YOKEqQa5PgTNfFa
 YGNs/FNoNBkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; d="scan'208";a="340527979"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2020 03:02:25 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 13/13] ASoC: Intel: Remove sst_dsp_get_thread_context
Date: Sun,  4 Oct 2020 12:01:28 +0200
Message-Id: <20201004100128.5842-14-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004100128.5842-1-cezary.rojewski@intel.com>
References: <20201004100128.5842-1-cezary.rojewski@intel.com>
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

While sst_dsp_get_thread_context() is declared as solution-agnostic, it
is only used by /skylake/ solution. Majority of thread_context field
usages are direct accesses. Improve code cohesiveness and convert to
single usage model.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/common/sst-dsp-priv.h | 5 -----
 sound/soc/intel/skylake/cnl-sst.c     | 2 +-
 sound/soc/intel/skylake/skl-sst-ipc.c | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp-priv.h b/sound/soc/intel/common/sst-dsp-priv.h
index 5a5ce5069f9f..de2b44568feb 100644
--- a/sound/soc/intel/common/sst-dsp-priv.h
+++ b/sound/soc/intel/common/sst-dsp-priv.h
@@ -98,9 +98,4 @@ struct sst_dsp {
 	struct snd_dma_buffer dmab;
 };
 
-static inline void *sst_dsp_get_thread_context(struct sst_dsp *sst)
-{
-	return sst->thread_context;
-}
-
 #endif
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 355a7b116886..fcd8dff27ae8 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -311,7 +311,7 @@ static struct sst_ops cnl_ops = {
 static irqreturn_t cnl_dsp_irq_thread_handler(int irq, void *context)
 {
 	struct sst_dsp *dsp = context;
-	struct skl_dev *cnl = sst_dsp_get_thread_context(dsp);
+	struct skl_dev *cnl = dsp->thread_context;
 	struct sst_generic_ipc *ipc = &cnl->ipc;
 	struct skl_ipc_header header = {0};
 	u32 hipcida, hipctdr, hipctdd;
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 667cdddc289f..7a425271b08b 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -489,7 +489,7 @@ void skl_ipc_process_reply(struct sst_generic_ipc *ipc,
 irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
 {
 	struct sst_dsp *dsp = context;
-	struct skl_dev *skl = sst_dsp_get_thread_context(dsp);
+	struct skl_dev *skl = dsp->thread_context;
 	struct sst_generic_ipc *ipc = &skl->ipc;
 	struct skl_ipc_header header = {0};
 	u32 hipcie, hipct, hipcte;
-- 
2.17.1

