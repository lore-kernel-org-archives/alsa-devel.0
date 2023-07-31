Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EE1C001E0
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:50:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 352FCE8D;
	Mon, 31 Jul 2023 23:49:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 352FCE8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690840234;
	bh=Qa2CQYIzfYLynYqQHzT6LtxK/Ao+xvbnNkcPEaIfXkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JwoDn7uzBRS2r+qsBJOoC4pSBpohrbftePEFQRMQwGPCNFGxJ/gZ1dUciYHjREw23
	 yooVrw1gzSCKsVyxyjebGz71616bk1/8s7DjhxoYRBRNSzeWTTEwbuI0N8bwNXPKl0
	 KHv9EGXJij6meuwA9s/5WHFkyI0UQKhnTiMAa64A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC461F8068A; Mon, 31 Jul 2023 23:44:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DB75F80687;
	Mon, 31 Jul 2023 23:44:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B60A5F8057C; Mon, 31 Jul 2023 23:43:39 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1F3BDF805A0
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:43:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F3BDF805A0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=NGSzEtJx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839804; x=1722375804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qa2CQYIzfYLynYqQHzT6LtxK/Ao+xvbnNkcPEaIfXkU=;
  b=NGSzEtJxxqnENveA+l0RN/PxQ3r0k7+zd580D/9CyOU69Rxn/yT8ijgS
   6AZTkqfzn4i/eSIZI+F2nkD0KTi5XMTp3xpeCdqbCCYDn9Y0esg7T42fA
   st8Yd1Gwm5T60klw8ReP3e8z3QDWgOCu/jKoJpE23TLDpthCN89LpNlMt
   +KjC3YwEbHp2zaBXyj1S4xti/lefFZoAKTQu1PnjEIukrLgUXhHtTncrL
   L9ybAJUbw9UX6xZxvNfDeu667WbziyyuzcA2+vjJpLPUFU23/3Yf2fgdM
   NRz48XrPVjJ6UBE9urVRIIGvvpanNvtFHqtyF7XMuY1qWPSYx9pNpwMns
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435449802"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435449802"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763523565"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="763523565"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:19 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 18/23] ASoC: Intel: sof_sdw: break earlier when a adr link
 contains different codecs
Date: Mon, 31 Jul 2023 16:42:52 -0500
Message-Id: <20230731214257.444605-19-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
References: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VPG2UZY3FXASI3OQFJRZHATDHLX63JOB
X-Message-ID-Hash: VPG2UZY3FXASI3OQFJRZHATDHLX63JOB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VPG2UZY3FXASI3OQFJRZHATDHLX63JOB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

create_codec_dai_name() is used to create codec component's information
in different adr links. We can and should break before we do anything.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 1a60965439dd..846ba8e1515c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1157,6 +1157,15 @@ static int create_codec_dai_name(struct device *dev,
 
 		adr = adr_link->adr_d[i].adr;
 
+		codec_index = find_codec_info_part(adr);
+		if (codec_index < 0)
+			return codec_index;
+		if (_codec_index != -1 && codec_index != _codec_index) {
+			dev_dbg(dev, "Different devices on the same sdw link\n");
+			break;
+		}
+		_codec_index = codec_index;
+
 		sdw_version = SDW_VERSION(adr);
 		link_id = SDW_DISCO_LINK_ID(adr);
 		unique_id = SDW_UNIQUE_ID(adr);
@@ -1183,15 +1192,6 @@ static int create_codec_dai_name(struct device *dev,
 		if (!codec[comp_index].name)
 			return -ENOMEM;
 
-		codec_index = find_codec_info_part(adr);
-		if (codec_index < 0)
-			return codec_index;
-		if (_codec_index != -1 && codec_index != _codec_index) {
-			dev_dbg(dev, "Different devices on the same sdw link\n");
-			break;
-		}
-		_codec_index = codec_index;
-
 		codec[comp_index].dai_name =
 			codec_info_list[codec_index].dais[dai_index].dai_name;
 
-- 
2.39.2

