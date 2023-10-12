Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B97CDB46E
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Oct 2023 19:10:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4670686E;
	Thu, 12 Oct 2023 21:10:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4670686E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697137851;
	bh=xANLt8R2xdVc6+kRpZd0Py54RK/5ma4hhPpfjrUdDPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CTHje2rWv5m864hgHyUeCWtC9jN4kocJBxAcoI4c8k1/INjI3gvxSP/GGYGb+Wr53
	 tw4vBZEQ6oOkLUPe1hJbsE72yvguGg0zCauaQhMpWcSHfMoA61BM39giw0sRCjEaIK
	 rcNdbfD37z3HBFXSr0WlEoeMErGGmVNGKnwssh0k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E753F805A9; Thu, 12 Oct 2023 21:09:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6B599F80589;
	Thu, 12 Oct 2023 21:09:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F648F8056F; Thu, 12 Oct 2023 21:09:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 52FB6F8015B
	for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2023 21:08:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52FB6F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jVe9cxk0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697137737; x=1728673737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xANLt8R2xdVc6+kRpZd0Py54RK/5ma4hhPpfjrUdDPU=;
  b=jVe9cxk00axYlCGCpWwNXo73q1FHP8VLtA51iC0K0WrqOvkuKyQ069wp
   712RXBkFxzcUt8FVCYvIu5uF97DLMdGSTnrAWQPOWeIO9sFm93CxTJ3mH
   J+A8JC5lEbNsSbBFiOmdAncfvZLLtt+w3BhEVnOGDfqARQxMNFbxrGjwJ
   dJRlOiH2rFPauWGo2+AFLWx9Ke6xl1CDWmHag9md2+WmXjevxr8AWDz5z
   pjSlm12pfNWgTFx9C3516BBvf1UFxpxDB6DA1ROajDZ/LQq7A92Hbv3Nv
   CY4ya+cTUMFCG/iQBH+T1WmWki6IZah9AYGMLPPMTRVrYeX5TBZsaI975
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416060166"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200";
   d="scan'208";a="416060166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 12:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845108043"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200";
   d="scan'208";a="845108043"
Received: from gchoudha-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.hsd1.md.comcast.net) ([10.212.114.241])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 12:08:37 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 01/23] ASoC: Intel: sof_sdw: update HP Omen match
Date: Thu, 12 Oct 2023 15:08:04 -0400
Message-Id: <20231012190826.142619-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012190826.142619-1-pierre-louis.bossart@linux.intel.com>
References: <20231012190826.142619-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MPNNGOFJ5OIHKYL2EZARBV3ZEU2GZSUK
X-Message-ID-Hash: MPNNGOFJ5OIHKYL2EZARBV3ZEU2GZSUK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MPNNGOFJ5OIHKYL2EZARBV3ZEU2GZSUK/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

New platforms have a slightly different DMI product name, remove
trailing characters/digits to handle all cases.

Closes: https://github.com/thesofproject/linux/issues/4611
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 226a74a4c340..cb5d71350f58 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -402,7 +402,7 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-k0xxx"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16"),
 		},
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
 					RT711_JD2),
-- 
2.39.2

