Return-Path: <SRS0=6kKU=DL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46848C4363C
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 10:07:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AEB206C1
	for <alsa-devel@archiver.kernel.org>; Sun,  4 Oct 2020 10:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QKz+Yn0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AEB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1F2D18C1;
	Sun,  4 Oct 2020 12:06:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1F2D18C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601806026;
	bh=ugFABMbs6M0rbzl+jTVXHKpAAO48Wwq55cOpojqhb3Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QKz+Yn0Z9niYmyvYvC4R5UWkHH1Se82NiGK92T2XWJBeUY7OiQtR6I1SoKPrfqIWB
	 OG/6T4NQqvjnowMtGNKIpZUpkLNurfk/7QN7e+DzcgOFy8HYRd3SiG+ovQ88zuO9xI
	 /YKL6D88Gddvq5m18hZbIXKqb1fTsSglpQLbPVBA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48826F80333;
	Sun,  4 Oct 2020 12:02:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 248F4F80307; Sun,  4 Oct 2020 12:02:23 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39CBFF802EB
 for <alsa-devel@alsa-project.org>; Sun,  4 Oct 2020 12:02:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39CBFF802EB
IronPort-SDR: d64JyORGreopEKX6FqUQmZWuXR0tIhIv+40b0kcvJfYq9FlNPKKwdX3YYsae97OezSJtHIAG1R
 2kY+vIJVUeGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9763"; a="163384001"
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; d="scan'208";a="163384001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2020 03:02:07 -0700
IronPort-SDR: gfObwInbK6ThGdrBITd4CMDED0klJwsaWQiVC5pBqlqglbreE6ntNNwDLdndtG9xxxLwHwn25g
 kvOTIGCycZBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,335,1596524400"; d="scan'208";a="340527913"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2020 03:02:03 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/13] ASoC: Intel: Skylake: Unassign ram_read and read_write
 ops
Date: Sun,  4 Oct 2020 12:01:22 +0200
Message-Id: <20201004100128.5842-8-cezary.rojewski@intel.com>
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

Skylake driver makes no use of ram_read or ram_write operation so remove
the assignments. This prepares sound/soc/common/sst-dsp* for following
removal of unused DSP operations.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/bxt-sst.c | 2 --
 sound/soc/intel/skylake/cnl-sst.c | 2 --
 sound/soc/intel/skylake/skl-sst.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/sound/soc/intel/skylake/bxt-sst.c b/sound/soc/intel/skylake/bxt-sst.c
index 38b9d7494083..fd4fdcb95224 100644
--- a/sound/soc/intel/skylake/bxt-sst.c
+++ b/sound/soc/intel/skylake/bxt-sst.c
@@ -533,8 +533,6 @@ static struct sst_ops skl_ops = {
 	.irq_handler = skl_dsp_sst_interrupt,
 	.write = sst_shim32_write,
 	.read = sst_shim32_read,
-	.ram_read = sst_memcpy_fromio_32,
-	.ram_write = sst_memcpy_toio_32,
 	.free = skl_dsp_free,
 };
 
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index c6abcd5aa67b..355a7b116886 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -300,8 +300,6 @@ static struct sst_ops cnl_ops = {
 	.irq_handler = cnl_dsp_sst_interrupt,
 	.write = sst_shim32_write,
 	.read = sst_shim32_read,
-	.ram_read = sst_memcpy_fromio_32,
-	.ram_write = sst_memcpy_toio_32,
 	.free = cnl_dsp_free,
 };
 
diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 00a97cea58b4..39d027ac16ec 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -506,8 +506,6 @@ static struct sst_ops skl_ops = {
 	.irq_handler = skl_dsp_sst_interrupt,
 	.write = sst_shim32_write,
 	.read = sst_shim32_read,
-	.ram_read = sst_memcpy_fromio_32,
-	.ram_write = sst_memcpy_toio_32,
 	.free = skl_dsp_free,
 };
 
-- 
2.17.1

