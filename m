Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD05C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:57:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1924E60ED5
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1924E60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A43BD168A;
	Wed, 18 Aug 2021 09:56:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A43BD168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629273450;
	bh=ceAon+d8smzRLYLTi1PvIXqBMMzHlu5+mREQCYYA2lc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFGPyvdkWuswnO5YMxFN3+DhSRl656YkX+wNDx83I8ZiB9/AlmrAbGZB783owM2w3
	 xGzaN2qtWD+D5G0BwExPsEDJKqW1W8mk/gIMXZPML4OQEU9VF2zt3qb7MiY9nrZuOv
	 AgSjevtnfrypsmjwDgmbLPjRwMvqJ97uSv0+KCGc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BB01F804DA;
	Wed, 18 Aug 2021 09:55:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9288EF804F1; Wed, 18 Aug 2021 09:55:20 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BD44F804DA
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 09:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BD44F804DA
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="195855523"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="195855523"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 00:55:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="676974829"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2021 00:55:08 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/11] ASoC: Intel: Skylake: Fix module configuration for KPB
 and MIXER
Date: Wed, 18 Aug 2021 09:57:36 +0200
Message-Id: <20210818075742.1515155-6-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818075742.1515155-1-cezary.rojewski@intel.com>
References: <20210818075742.1515155-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, jairaj.arava@intel.com,
 upstream@semihalf.com, harshapriya.n@intel.com, cujomalainey@google.com,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
 broonie@kernel.org, jenny.tc@intel.com, lma@semihalf.com,
 vamshi.krishna.gopal@intel.com
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

KeyPhrasebuffer, Mixin and Mixout modules configuration is described by
firmware's basic module configuration structure. There are no extended
parameters required. Update functions taking part in building
INIT_INSTANCE IPC payload to reflect that.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index 476ef1897961..79c6cf2c14bf 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -802,9 +802,12 @@ static u16 skl_get_module_param_size(struct skl_dev *skl,
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
 	case SKL_MODULE_TYPE_MIC_SELECT:
-	case SKL_MODULE_TYPE_KPB:
 		return sizeof(struct skl_base_outfmt_cfg);
 
+	case SKL_MODULE_TYPE_MIXER:
+	case SKL_MODULE_TYPE_KPB:
+		return sizeof(struct skl_base_cfg);
+
 	default:
 		/*
 		 * return only base cfg when no specific module type is
@@ -857,10 +860,14 @@ static int skl_set_module_format(struct skl_dev *skl,
 
 	case SKL_MODULE_TYPE_BASE_OUTFMT:
 	case SKL_MODULE_TYPE_MIC_SELECT:
-	case SKL_MODULE_TYPE_KPB:
 		skl_set_base_outfmt_format(skl, module_config, *param_data);
 		break;
 
+	case SKL_MODULE_TYPE_MIXER:
+	case SKL_MODULE_TYPE_KPB:
+		skl_set_base_module_format(skl, module_config, *param_data);
+		break;
+
 	default:
 		skl_set_base_module_format(skl, module_config, *param_data);
 		break;
-- 
2.25.1

