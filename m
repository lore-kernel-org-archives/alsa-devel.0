Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B68DC25B76
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:28:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F7EA85D;
	Mon,  3 Jun 2024 12:28:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F7EA85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1717410527;
	bh=7NV3o9KauOpeQYT9WlCJbRb3c/G3kEQbMf65uPt62WU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=gb9V9s7kg93CqyN1Lkv3uxw1zgJs0rTRgdB5FmQvKcoD7fk1TdZwKYMb1jMuuxB4C
	 PxN9HqMQMd088czc5sHzbp0+5gKxpxndr6j3+rik6rdOZpE4oXiclEGAsyaBUtYecJ
	 2FtPA/Px8pHfztZoWdd44+MUSLVmP5/zMOIzbq4A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36E2EF805BD; Mon,  3 Jun 2024 12:27:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BD9DDF8055C;
	Mon,  3 Jun 2024 12:27:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2E15F804B0; Mon,  3 Jun 2024 12:27:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C7B3DF8025A
	for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2024 12:27:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7B3DF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FnKAjaEQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717410464; x=1748946464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7NV3o9KauOpeQYT9WlCJbRb3c/G3kEQbMf65uPt62WU=;
  b=FnKAjaEQUaz6OtoRgtF/I3TcExuf12/WrTrAA46DvpQulswmfYA+256F
   bCqO4x0sQ47oYn8oNodYPoe8VNifjd3mBYtj0tK/UpX+8pblSQJvSp1RD
   r8whxXEtmMx9x9hh3tblqqGmd98wgPcY8X0mn0Ts430krcNiA5z5TSyJq
   nvVaqiWSvHl5FyUmAsJ8pm4oq5fAPayZfkZu2FNrPdO/aYM0zMcFSWPxC
   aD/M36AKfvUd/2Z0Y1HK9vcKPedc5xC9u8m6WpF8MukgQwB7wiflkbrj8
   tm7N5OZrEV/gzk1XSGTf49l8Pip2Pz2/lq1hH0TTjZTylz10SSMb5Q28+
   g==;
X-CSE-ConnectionGUID: 4v2/Nk7EQwKmTO+oqE73cw==
X-CSE-MsgGUID: XVS9CZrnQ5SIay1P1ejfEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14017214"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000";
   d="scan'208";a="14017214"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 03:27:40 -0700
X-CSE-ConnectionGUID: LS3e7dOITR6X6UVDljEwfg==
X-CSE-MsgGUID: cNZioXGnQBG8Y3II7cVKHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000";
   d="scan'208";a="37430034"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orviesa008.jf.intel.com with ESMTP; 03 Jun 2024 03:27:38 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	Jason Montleon <jmontleo@redhat.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 1/4] ASoC: topology: Fix references to freed memory
Date: Mon,  3 Jun 2024 12:28:15 +0200
Message-Id: <20240603102818.36165-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603102818.36165-1-amadeuszx.slawinski@linux.intel.com>
References: <20240603102818.36165-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QTJK33O4MJNRH5HVLK54YKOOHZMM4FLD
X-Message-ID-Hash: QTJK33O4MJNRH5HVLK54YKOOHZMM4FLD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QTJK33O4MJNRH5HVLK54YKOOHZMM4FLD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Most users after parsing a topology file, release memory used by it, so
having pointer references directly into topology file contents is wrong.
Use devm_kmemdup(), to allocate memory as needed.

Reported-by: Jason Montleon <jmontleo@redhat.com>
Link: https://github.com/thesofproject/avs-topology-xml/issues/22#issuecomment-2127892605
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 90ca37e008b32..75d9395a18ed4 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1060,15 +1060,32 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		route->source = elem->source;
-		route->sink = elem->sink;
+		route->source = devm_kmemdup(tplg->dev, elem->source,
+					     min(strlen(elem->source),
+						 SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					     GFP_KERNEL);
+		route->sink = devm_kmemdup(tplg->dev, elem->sink,
+					   min(strlen(elem->sink), SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+					   GFP_KERNEL);
+		if (!route->source || !route->sink) {
+			ret = -ENOMEM;
+			break;
+		}
 
 		/* set to NULL atm for tplg users */
 		route->connected = NULL;
-		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0)
+		if (strnlen(elem->control, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) == 0) {
 			route->control = NULL;
-		else
-			route->control = elem->control;
+		} else {
+			route->control = devm_kmemdup(tplg->dev, elem->control,
+						      min(strlen(elem->control),
+							  SNDRV_CTL_ELEM_ID_NAME_MAXLEN),
+						      GFP_KERNEL);
+			if (!route->control) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
 
 		/* add route dobj to dobj_list */
 		route->dobj.type = SND_SOC_DOBJ_GRAPH;
-- 
2.34.1

