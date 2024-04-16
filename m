Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263B5C4345F
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Apr 2024 21:24:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F74EDF6;
	Tue, 16 Apr 2024 23:23:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F74EDF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713302641;
	bh=lQ5OIiTxH3d7/GtHAwbCbRqsjUip1dqXcePJ5Z/9Mo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LNQzYBdHov8UJJDJRKvD71HB/e5HfQeS/WDpqGAJJdRQR3MVOlBLUXEN7U4LTXV4v
	 9ButEneZ9gENA1LYfk40ZVueuB1TrawJ9i9yyJ2rO96ovBqwOr5orybmJ5pvPLGJsN
	 vfZhFCaq3G7Aspg9S+34LthFLkc6U8UUa4Ehhsmo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C7E7F8057C; Tue, 16 Apr 2024 23:23:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9221EF8057F;
	Tue, 16 Apr 2024 23:23:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57ADEF8025A; Tue, 16 Apr 2024 23:23:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2EF4F80124
	for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2024 23:23:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2EF4F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lBROpU2o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713302598; x=1744838598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQ5OIiTxH3d7/GtHAwbCbRqsjUip1dqXcePJ5Z/9Mo8=;
  b=lBROpU2oD6pUSdcDB9EdTwxkRVqnrIVP0DG/M89DC/TYpCk81pjqMakn
   rrOW9ooc7+ZBuJEMdRDjOHJa/VWmH2LnSiwnL9jIJ/JU5XlsT2qAesSFO
   0HlPILgyoPP/9KAjzuJvoBNw4zc/YhD9O46WU7eGkEm4xVnMlKOaYYFn1
   9c1c9QbOs7jg4Z+Dqd3utACrldujMCU5jurJdFd25lpNlOx+3rV/er+/t
   lRP9j5bAi2Ewp7dVu6FkFN+EMHi5JjZV9J7d8BWZelH7/Ogmi62cWcLXD
   JPJHIyvm845OXEZl/q8CMLz9LlOzeH2yL4UOV/BQJe7scS/YvrhF9Yceb
   Q==;
X-CSE-ConnectionGUID: jPsrZEmDTaOVP4CHW9lq5g==
X-CSE-MsgGUID: FQUox1KMQrm47T1PFDaHUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="31254771"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000";
   d="scan'208";a="31254771"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 14:23:12 -0700
X-CSE-ConnectionGUID: zRuizkB5TkyetIbfBPokmw==
X-CSE-MsgGUID: 8WXKnsQbQuqAuGLLrtIkmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000";
   d="scan'208";a="45678000"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 14:23:04 -0700
From: Tony Luck <tony.luck@intel.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Tony Luck <tony.luck@intel.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v3 71/74] x86/cpu/vfm: Update
 sound/soc/intel/avs/boards/es8336.c
Date: Tue, 16 Apr 2024 14:22:57 -0700
Message-ID: <20240416212257.10009-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416211941.9369-1-tony.luck@intel.com>
References: <20240416211941.9369-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QZKCFSP4CRJWJV4R5RHPPFT6A4B26Z2H
X-Message-ID-Hash: QZKCFSP4CRJWJV4R5RHPPFT6A4B26Z2H
X-MailFrom: tony.luck@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QZKCFSP4CRJWJV4R5RHPPFT6A4B26Z2H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 sound/soc/intel/avs/boards/es8336.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/avs/boards/es8336.c b/sound/soc/intel/avs/boards/es8336.c
index 5c90a6007577..6c86c581877e 100644
--- a/sound/soc/intel/avs/boards/es8336.c
+++ b/sound/soc/intel/avs/boards/es8336.c
@@ -18,6 +18,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/soc-acpi.h>
+#include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
 #include "../utils.h"
 
@@ -153,9 +154,9 @@ static int avs_es8336_hw_params(struct snd_pcm_substream *substream,
 	int clk_freq;
 	int ret;
 
-	switch (boot_cpu_data.x86_model) {
-	case INTEL_FAM6_KABYLAKE_L:
-	case INTEL_FAM6_KABYLAKE:
+	switch (boot_cpu_data.x86_vfm) {
+	case INTEL_KABYLAKE_L:
+	case INTEL_KABYLAKE:
 		clk_freq = 24000000;
 		break;
 	default:
-- 
2.44.0

