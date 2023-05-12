Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ADCC77B7C
	for <alsa-devel@archiver.kernel.org>; Fri, 12 May 2023 18:20:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74C53E91;
	Fri, 12 May 2023 20:19:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74C53E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683915623;
	bh=hCDHpIYOYSSnE/xPKLb7169z5P2gyjKEPF4IguhCs98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p5qYD4NWfaU3nnATEltnpPPmrpEihYvtXueIRXL10eIK0SCjg6JwSr/Fd7isszXpd
	 VmSsuupixQcLyODY9CpBjqptY8L9BEH3tPdKBBRDjOOkH+lA2NAf7ryYFOI8mVOTnX
	 3oRW6TfWuTucmLOMk85EDQnru1H0iE/Mv/FGvl7s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44230F805B6; Fri, 12 May 2023 20:18:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CACE7F805AC;
	Fri, 12 May 2023 20:17:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AFF6CF8055B; Fri, 12 May 2023 20:17:48 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1947EF8053D
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2023 20:17:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1947EF8053D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=d6otz8MB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683915465; x=1715451465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hCDHpIYOYSSnE/xPKLb7169z5P2gyjKEPF4IguhCs98=;
  b=d6otz8MBjbEoUEkvmod5HIWkixjQVscBhsq8dSCZZQGOqyxSM7YCkbYL
   vTeGdAmrbO4gBPYHkdN64NTMGaZ8773xRtJVT2L+dGya442EcgKlHVhiD
   Ob6jB3beU62Maw1zugYNF4qU6/DtC2ABQF+Paj0ADyispEYZl+ieoyGGz
   DREr8Gbgp3pLMqCpabPtnLQi0tPYx9CeAoSwkLvBzCn2fGKkMWNeD6uQI
   8g1rcVfSaLvxtOCD2S8ZlbiXWTnOwSnzVGN1UzVPsSCVhdABKCtOwKuBC
   YXUaQGbLTrtSTuN/VFQ8CRCx6LcLqM7IBeLGyS7/Uxuck6mro9h1Wa7JO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="331223240"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200";
   d="scan'208";a="331223240"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 11:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="769895112"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200";
   d="scan'208";a="769895112"
Received: from winkelru-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.144.249])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 11:17:22 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	vkoul@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 9/9] ASoC: SOF: Intel: remove mutual exclusion between NOCODEC
 and HDA_LINK
Date: Fri, 12 May 2023 13:17:02 -0500
Message-Id: <20230512181702.117483-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512181702.117483-1-pierre-louis.bossart@linux.intel.com>
References: <20230512181702.117483-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: QQASYAVECDPB2XVJLEACH3OMDWKEGRFA
X-Message-ID-Hash: QQASYAVECDPB2XVJLEACH3OMDWKEGRFA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QQASYAVECDPB2XVJLEACH3OMDWKEGRFA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The nocodec mode served two purposes so far
a) generate a test driver for DMIC/SSP without any codec connected
b) make sure the use of snd_hdac_ libraries was contained

b) is no longer an option for LunarLake, the HDaudio DMA is used for
DMIC/SSP and the HDA_LINK option needs to be enabled.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 88529a6cb20d..69c1a370d3b6 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -284,7 +284,6 @@ if SND_SOC_SOF_HDA_COMMON
 
 config SND_SOC_SOF_HDA_LINK
 	bool "SOF support for HDA Links(HDA/HDMI)"
-	depends on SND_SOC_SOF_NOCODEC_SUPPORT=n
 	help
 	  This adds support for HDA links(HDA/HDMI) with Sound Open Firmware
 	  for Intel(R) platforms.
-- 
2.37.2

