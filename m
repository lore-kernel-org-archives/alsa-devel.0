Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EFDC77B7A
	for <alsa-devel@archiver.kernel.org>; Fri, 19 May 2023 11:57:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3BF21FE;
	Fri, 19 May 2023 13:56:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3BF21FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684497420;
	bh=JBKztdWoY4/izRQ7rvvFxSEV9UWrDbzjxVvyDdi3lTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p7FzzsqIA+cPQHwoLTe0lcSVfDW9iWckiW+afnK1UpFN+zH2OTW5J9cBIBtpUMevG
	 eDrYd22DRFwLH0Z6Iph6xVk1My7rgu8pPSoOVHBgsMWz4bbS/gFYbci5s1dHbvNiIB
	 zSqSDNYhebJOS2PKoTLYO/dV/saR2Y1BCqDL/sqE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7571FF80568; Fri, 19 May 2023 13:55:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EBA6FF80568;
	Fri, 19 May 2023 13:55:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B51D8F802E8; Fri, 19 May 2023 13:55:05 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 618D2F8025A
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2023 13:55:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 618D2F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nZpK0q3Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684497302; x=1716033302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JBKztdWoY4/izRQ7rvvFxSEV9UWrDbzjxVvyDdi3lTQ=;
  b=nZpK0q3Y8Qfau7LmFHwcNNu5VycDeg5BxlZWwm4UKRO4YombdDZgxPtY
   QQNett8cBw3AWjq18NKHBj1sTycdpMB4zQi+L8W6gVvWjo7DD0OcpAUUL
   a3JTK6RcJhHskIaaocBCl8RtY8MaTVPC6Yv6tt5FIdOLs0lpD1uW9Q09c
   V1ZXORPZibcQ6LAOKBTMCVpoScBPTYmwuiFE4axfOIiiV/RVXcfqnsegl
   iWGApMhl57e6vawXLxXO0SFeD+OwvFlI2Qd+RCy4xIOA5qIbF2a6GJsSv
   2ebqMDqpJAi6kbNSsaq9rmunUJXKpfGHV9DzAy651nQ/46j+REU7p6eIR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336946042"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400";
   d="scan'208";a="336946042"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 04:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="705593816"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400";
   d="scan'208";a="705593816"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2023 04:54:58 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 3/5] ASoC: topology: Do not split message string on multiple
 lines
Date: Fri, 19 May 2023 21:56:09 +0200
Message-Id: <20230519195611.4068853-4-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519195611.4068853-1-amadeuszx.slawinski@linux.intel.com>
References: <20230519195611.4068853-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TIRIQXL6MPRKNPTRYPREWL4O6VA4DDNT
X-Message-ID-Hash: TIRIQXL6MPRKNPTRYPREWL4O6VA4DDNT
X-MailFrom: amadeuszx.slawinski@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TIRIQXL6MPRKNPTRYPREWL4O6VA4DDNT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Kernel coding guidelines recommend to not split string unnecessarily.
While at it adapt the other print present in the function to 100
characters line limit.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index b5c47b3c63ab..0249e915eafe 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1513,15 +1513,13 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	 * If so, just return success.
 	*/
 	if (!snd_soc_card_is_instantiated(card)) {
-		dev_warn(tplg->dev, "ASoC: Parent card not yet available,"
-			" widget card binding deferred\n");
+		dev_warn(tplg->dev, "ASoC: Parent card not yet available, widget card binding deferred\n");
 		return 0;
 	}
 
 	ret = snd_soc_dapm_new_widgets(card);
 	if (ret < 0)
-		dev_err(tplg->dev, "ASoC: failed to create new widgets %d\n",
-			ret);
+		dev_err(tplg->dev, "ASoC: failed to create new widgets %d\n", ret);
 
 	return ret;
 }
-- 
2.34.1

