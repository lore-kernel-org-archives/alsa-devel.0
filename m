Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBA3C001DE
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Jul 2023 21:47:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C98B857;
	Mon, 31 Jul 2023 23:46:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C98B857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690840027;
	bh=bfAsfdR1m5rNV6IDYq+veLT3EdgKfQPCNjNFFcD+vmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=deGUps/cnYGa8aqZCp441kEFSD9Zoi5qyC6XcqRpQ84gAEWzjvPc3PVBdDobu4DPL
	 ApwvDAlDJqW9Vw7wnz/xzrvZ2GwAadgwx1AWlBnoSvr1RdoU19doRcFjCOFGocZkXC
	 LJZDmoPnNT+tt/OxUQKtsP51mGtrCZi6ZUzOJUUQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C695DF805E1; Mon, 31 Jul 2023 23:43:51 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DFCA1F805E1;
	Mon, 31 Jul 2023 23:43:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 045BBF805B1; Mon, 31 Jul 2023 23:43:28 +0200 (CEST)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A79A8F80153
	for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2023 23:43:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A79A8F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nozE3Svz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690839797; x=1722375797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfAsfdR1m5rNV6IDYq+veLT3EdgKfQPCNjNFFcD+vmY=;
  b=nozE3SvzemflQtrGMhk7FDj5f/gBuzjwfhW9icNM4QhbALVcddIJXCTP
   8oZtWcw8rXTHRyt+Mp9BqsViIxsvKln68WCyFz6bNWqlWEa7nz4B9xrUV
   GmWoe+4NHrf6ttxMV6uLdfd0PRTA4AYjSg8vmg05UBIaIHF8y58qLDmkd
   iubmx4GHLJLbSv6tvl26eqhABWxaojm1VKq6vchedDY0KIUto0f2u3FoY
   m4iz25bK2R2oX3ybnUfAXNTg6PT213W0Yw7O6yk0iMQpPB9r0h2nMolTa
   ifP4jQQeyrc0R7+Gwep3BagyZpO1+l8HLXH1iLOxXwp8zk0KroHbT2SBG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435449757"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="435449757"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="763523536"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200";
   d="scan'208";a="763523536"
Received: from youngnic-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.180.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 14:43:12 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 08/23] ASoC: Intel: sof_sdw: add support for SKU 0AFE
Date: Mon, 31 Jul 2023 16:42:42 -0500
Message-Id: <20230731214257.444605-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
References: <20230731214257.444605-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LKBKWEVR4STFVG7T5EKFU7JH4YED25OI
X-Message-ID-Hash: LKBKWEVR4STFVG7T5EKFU7JH4YED25OI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LKBKWEVR4STFVG7T5EKFU7JH4YED25OI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Yet another missing configuration, with the standard configuration

link0: rt711-sdca
link 1 and 2: rt1316-sdca
link3: rt714-sdca

Link: https://github.com/thesofproject/sof/issues/7799
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index acaedd3b2224..ffb0cd0700c4 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -307,6 +307,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
 					SOF_SDW_FOUR_SPK),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0AFE")
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2 |
+					SOF_SDW_FOUR_SPK),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.39.2

