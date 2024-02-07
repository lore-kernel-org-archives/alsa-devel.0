Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A7EC4828F
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Feb 2024 12:10:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BA9B1CE;
	Wed,  7 Feb 2024 13:10:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BA9B1CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707307842;
	bh=RtezLeKtYqzMMlD7l4M22QwSiNc/vjvRHMceNkkvGLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RQkjrnM7dXYvqcvkLfKo9qLz31AUv9Sq0qOr9c6UIyDZq9TclbJXlSaV11G4gtkQC
	 /M0kH2nsiNRA9Gl2yqZ1z1xS/71Xj02d2J5PkNnHNH91CVhWyopHDvsNkwE5lajLOe
	 xl21uc7RR6NAVZ1JOqNgSZSEmSNdyqPMvj1Cq76g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2D9EF805F7; Wed,  7 Feb 2024 13:09:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5E45F805F0;
	Wed,  7 Feb 2024 13:09:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B944AF805AF; Wed,  7 Feb 2024 13:09:36 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BD5D1F8016E
	for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2024 13:09:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD5D1F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=S6i3Z63w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707307766; x=1738843766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtezLeKtYqzMMlD7l4M22QwSiNc/vjvRHMceNkkvGLc=;
  b=S6i3Z63wvoAFdeDtJmuvkkHbks8DeS/61yl9kHUF0/Jbr5iLASoGzDyU
   w521gVJh5v2DN4UoSDiiIc1C0SoQzP5IMISss/Mdpy9xOXkDofVK4QYea
   R/iw9qMWHHTnk63zACZUWWuUlpyjPDKGUG6nWSdaQ5HHJRd7vfO55QV49
   dBXBfBkItjzNp79FwVz/8m0P0e/vms9k4qBOXbjTUT3eAEH0QtomRyh1I
   BmVI3c9IsN/RnlvZ5pTM30ZIJ6NHn+ncgDEJx0kBzaqOPwbowaxVX4pDZ
   4Ysi3XS56PeQJyi3Cdb5qvmrTE/cRrICzcMYoCa1JbNHVZYfIpGXtKUwL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4757842"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400";
   d="scan'208";a="4757842"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2024 04:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400";
   d="scan'208";a="1631801"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orviesa007.jf.intel.com with ESMTP; 07 Feb 2024 04:09:18 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?=C5=81ukasz=20Majczak?= <lma@chromium.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 1/3] ASoC: Intel: avs: UAPI: Add tokens for initial config
 feature
Date: Wed,  7 Feb 2024 13:09:44 +0100
Message-Id: <20240207120946.2140480-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207120946.2140480-1-amadeuszx.slawinski@linux.intel.com>
References: <20240207120946.2140480-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3TKXPAF4AK46JWF5HIQ4K4GVUR7P3LQO
X-Message-ID-Hash: 3TKXPAF4AK46JWF5HIQ4K4GVUR7P3LQO
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3TKXPAF4AK46JWF5HIQ4K4GVUR7P3LQO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Allow for defining initial config which will be send after module
initialization to configure initial module state. This is only useful
for modules which need to be configured on init.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/uapi/sound/intel/avs/tokens.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/sound/intel/avs/tokens.h b/include/uapi/sound/intel/avs/tokens.h
index 4ffe546aa409a..4beca03405c07 100644
--- a/include/uapi/sound/intel/avs/tokens.h
+++ b/include/uapi/sound/intel/avs/tokens.h
@@ -19,6 +19,8 @@ enum avs_tplg_token {
 	AVS_TKN_MANIFEST_NUM_MODCFGS_EXT_U32		= 6,
 	AVS_TKN_MANIFEST_NUM_PPLCFGS_U32		= 7,
 	AVS_TKN_MANIFEST_NUM_BINDINGS_U32		= 8,
+	AVS_TKN_MANIFEST_NUM_CONDPATH_TMPLS_U32		= 9,
+	AVS_TKN_MANIFEST_NUM_INIT_CONFIGS_U32		= 10,
 
 	/* struct avs_tplg_library */
 	AVS_TKN_LIBRARY_ID_U32				= 101,
@@ -109,6 +111,8 @@ enum avs_tplg_token {
 	AVS_TKN_MOD_PROC_DOMAIN_U8			= 1705,
 	AVS_TKN_MOD_MODCFG_EXT_ID_U32			= 1706,
 	AVS_TKN_MOD_KCONTROL_ID_U32			= 1707,
+	AVS_TKN_MOD_INIT_CONFIG_NUM_IDS_U32		= 1708,
+	AVS_TKN_MOD_INIT_CONFIG_ID_U32			= 1709,
 
 	/* struct avs_tplg_path_template */
 	AVS_TKN_PATH_TMPL_ID_U32			= 1801,
@@ -125,6 +129,11 @@ enum avs_tplg_token {
 
 	/* struct avs_tplg_kcontrol */
 	AVS_TKN_KCONTROL_ID_U32				= 2301,
+
+	/* struct avs_tplg_init_config */
+	AVS_TKN_INIT_CONFIG_ID_U32			= 2401,
+	AVS_TKN_INIT_CONFIG_PARAM_U8			= 2402,
+	AVS_TKN_INIT_CONFIG_LENGTH_U32			= 2403,
 };
 
 #endif
-- 
2.34.1

