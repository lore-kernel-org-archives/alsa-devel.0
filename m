Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75740C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri, 19 May 2023 11:57:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BC07206;
	Fri, 19 May 2023 13:56:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BC07206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684497467;
	bh=J8IlpiZ0cWfskFgS6fMco2Ui2XwVN+JFcGr15tILLfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EpjuSuizft4fdeRoJZJF9NYgeB864flFoc7CQtYIsW+kJdE98OJDHRDXjvLuTDYC+
	 beh7wfQgSH5ozBq9iZjyoxmIA8JtrZ0QDqyh9MECxwt20UJ7So57ZfuajtagtWlrKy
	 V93QN3X3nvG3WWB3ZT+GkA8xZq/aQF+hW+77Oh6w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B8938F805BF; Fri, 19 May 2023 13:55:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 819F5F805B2;
	Fri, 19 May 2023 13:55:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 05958F80564; Fri, 19 May 2023 13:55:10 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5EE61F80431
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2023 13:55:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EE61F80431
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hSuv5Yln
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684497304; x=1716033304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8IlpiZ0cWfskFgS6fMco2Ui2XwVN+JFcGr15tILLfE=;
  b=hSuv5YlnAAIiweYjhk5a22jlflYAwCn4NtbJcZh2LaIVg+fC54N5OTsP
   lGNNZyBvM7SlgG1V2aIPydr0/6XSVjreHgTCeVJlwSkUKs3HsQwR3NXOJ
   vteV2foD7EJv3pK4I0u02Z78kpemG0PEoddrTWIRAfR1DFF/3J0Gp1US0
   5buJf8XGIXhjY1Q1Sgbm5WtA6uKx/PbMbX+KQJ6DLy9irOBiN6/qesXo2
   OVfYs6BJOlqMIaUCz9W4j6Jl5iPYERJgkg1mrHI4qlNGMOZ1EhMMFI3Ox
   qEz97b/xxCrNNABizL/94AZ6LaKh/sHaw8OemYmfM0Ot/7RxPw1Q1aH4B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="336946051"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400";
   d="scan'208";a="336946051"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 04:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="705593826"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400";
   d="scan'208";a="705593826"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga007.fm.intel.com with ESMTP; 19 May 2023 04:55:00 -0700
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
Subject: [PATCH 4/5] ASoC: topology: Remove redundant log
Date: Fri, 19 May 2023 21:56:10 +0200
Message-Id: <20230519195611.4068853-5-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519195611.4068853-1-amadeuszx.slawinski@linux.intel.com>
References: <20230519195611.4068853-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JT5UGCS4CSRI5LXIAGXVLQTNHQISP2CI
X-Message-ID-Hash: JT5UGCS4CSRI5LXIAGXVLQTNHQISP2CI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JT5UGCS4CSRI5LXIAGXVLQTNHQISP2CI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

soc_tplg_dapm_complete() logs all the failures in detail already.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 0249e915eafe..9bb4c6d2a2c9 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2510,9 +2510,6 @@ static int soc_tplg_process_headers(struct soc_tplg *tplg)
 
 	/* signal DAPM we are complete */
 	ret = soc_tplg_dapm_complete(tplg);
-	if (ret < 0)
-		dev_err(tplg->dev,
-			"ASoC: failed to initialise DAPM from Firmware\n");
 
 	return ret;
 }
-- 
2.34.1

