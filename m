Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E06C77B7A
	for <alsa-devel@archiver.kernel.org>; Fri, 26 May 2023 20:44:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06EAC823;
	Fri, 26 May 2023 22:43:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06EAC823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685133858;
	bh=vf8ODbSAgf5UWt39HwG2bjF9nNF6glT8g+Rg41XQYAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rKOotJ84bqajFuzQmSgw//UUKpEKhLR4hVTgidD6pg0u0tfKke0IpngZ+FtHTLrhi
	 p07FIC1FhZrI4vtsAeRxSGovTAf6+y8JvZVL7CSVNgGM6+oSk2mww5EVXeaAmWzt71
	 2S9i1Rr2lPShIGu35b6Y51SKM0kkl7Ey3LTTLtuY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0647F80578; Fri, 26 May 2023 22:42:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D440DF80567;
	Fri, 26 May 2023 22:42:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A41D3F80249; Fri, 26 May 2023 22:42:24 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08742F8016A
	for <alsa-devel@alsa-project.org>; Fri, 26 May 2023 22:42:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08742F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SeJuQVjM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685133736; x=1716669736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vf8ODbSAgf5UWt39HwG2bjF9nNF6glT8g+Rg41XQYAE=;
  b=SeJuQVjMgoNncbbmMzrgF4kWVpZYUnMESaAAMCkjeuFI+prUYWz6LPg/
   f6zdTJD7wr876n/L6nwfWkQgQUYjUB7R6pW4BYNPaX+vfJQgIWeujzzNz
   ebUCurqtSmE9LdDbB43ws1uz7++cgtDy+gekhDLSa3nT+KeDCaYYtlmrD
   lWCBLfc6MPoXpich8xiGNimjafl8p8f20jlxg2Ru0I4JToJV0Tl1N1wjp
   NyxF2kk5pZCp19T1ua1kdNEqOIS3GdZqQKpxf0wLJ7HW6BV/Sl5CQaQ7f
   3gMrJ7nt9ZvaNvBHS7NO8EGv/rb808z32hmYsQzJ2+8Mqq80ME9HB6Gpy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="333926237"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400";
   d="scan'208";a="333926237"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 13:42:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="699527114"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400";
   d="scan'208";a="699527114"
Received: from bedriarm-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.48.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 13:41:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 2/3] ASoC: SOF: topology: Use partial match for connecting DAI
 link and DAI widget
Date: Fri, 26 May 2023 15:41:48 -0500
Message-Id: <20230526204149.456068-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230526204149.456068-1-pierre-louis.bossart@linux.intel.com>
References: <20230526204149.456068-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: E7P3B227HOJHNW2F5Y6KVA34JOBDKV35
X-Message-ID-Hash: E7P3B227HOJHNW2F5Y6KVA34JOBDKV35
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E7P3B227HOJHNW2F5Y6KVA34JOBDKV35/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

This allows setting shorter names for the widget stream names in
topology. For example, in the case of HDA Analog DAI link, the stream
name is "Analog Playback and Capture". But it is enough to match "Analog"
in the DAI link stream name with a widget's stream name. This is needed
to set more meaningful names for the DAI widgets using the stream name
in topology.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index f160dc454b44..698129dccc7d 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1077,7 +1077,7 @@ static int sof_connect_dai_widget(struct snd_soc_component *scomp,
 	list_for_each_entry(rtd, &card->rtd_list, list) {
 		/* does stream match DAI link ? */
 		if (!rtd->dai_link->stream_name ||
-		    strcmp(w->sname, rtd->dai_link->stream_name))
+		    !strstr(rtd->dai_link->stream_name, w->sname))
 			continue;
 
 		for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
-- 
2.37.2

