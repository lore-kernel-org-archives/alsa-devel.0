Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE43FC7EE29
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jun 2023 20:28:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDE0E3E7;
	Fri,  2 Jun 2023 22:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDE0E3E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685737687;
	bh=FlsrxnMr8lu/jOu4PQ+dGH6EOSk6xuEsrF7Rr0q1w5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AjRYRvFj6ljVDmsQz1ew7V3nY/0036Bwz84B47QLs4vbrbmKd68m4ospe8S6BK0PA
	 I+PcLoOU7s10890du+xREKx1O0zgsYDin7nSSSa5Vh0orQtrD8XMrja5aQrCJQ0gVw
	 mJAJgoOqDk4lQXJ8KynZBLytSmBQ/ywqfgKgCx34=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C7EFF8057B; Fri,  2 Jun 2023 22:24:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B7ECF8061A;
	Fri,  2 Jun 2023 22:24:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07F64F805F0; Fri,  2 Jun 2023 22:23:50 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 95C9EF80551
	for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2023 22:23:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95C9EF80551
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=eNoDyMi4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685737392; x=1717273392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlsrxnMr8lu/jOu4PQ+dGH6EOSk6xuEsrF7Rr0q1w5c=;
  b=eNoDyMi4wlxDNM9/kJjz3oGf9UZgQPY5OCmNySwPPMSTJlI/H9Fh4ihl
   5H9jQHG9A6LntgHJ1rpLiQ/bCOP1aVDRYy4eScz9Ny1tPUN0D2DjJETY+
   qBEdSrDeAlnwZzGAPlKINP++VNpWPkrFaXGWUy2q/TJR/bJaHSh5mGnpg
   H1tnY2G6TZGIDUHhpUOqVwy8JhEcNGHxIZaJO2LFSt86iNpGT+MmZtFuB
   x49jnvjSDoSoGMJC7+EBkKaf+LEwDYnA5MoghVBrwxVL+E1jf/pxThbfL
   c/xk/2SDX34LTkOCUFcBwpJ3Vhrdch/ZNvMIoTT9M9H76CVSwyU58P9aB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="354811277"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="354811277"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:22:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="773020028"
X-IronPort-AV: E=Sophos;i="6.00,214,1681196400";
   d="scan'208";a="773020028"
Received: from clatorre-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.190.110])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2023 13:22:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [PATCH 16/28] ASoC: Intel: sof_sdw: add quick for Dell SKU 0BDA
Date: Fri,  2 Jun 2023 15:22:13 -0500
Message-Id: <20230602202225.249209-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230602202225.249209-1-pierre-louis.bossart@linux.intel.com>
References: <20230602202225.249209-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: B2UKXSKOVNHMYAOFTBYFA274QRLBELCW
X-Message-ID-Hash: B2UKXSKOVNHMYAOFTBYFA274QRLBELCW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/B2UKXSKOVNHMYAOFTBYFA274QRLBELCW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The SKU numbering isn't quite consistent with the existing RaptorLake
SKUs but the PCI ID is definitively RaptorLake.

Closes: https://github.com/thesofproject/linux/issues/4380
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index a032628f8925..582f8e908e8c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -386,6 +386,16 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 					RT711_JD2),
 	},
 	/* RaptorLake devices */
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0BDA")
+		},
+		.driver_data = (void *)(SOF_SDW_TGL_HDMI |
+					RT711_JD2 |
+					SOF_SDW_FOUR_SPK),
+	},
 	{
 		.callback = sof_sdw_quirk_cb,
 		.matches = {
-- 
2.37.2

