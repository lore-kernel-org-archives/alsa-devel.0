Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C72C761A6
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Apr 2023 09:23:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89EC8201;
	Tue,  4 Apr 2023 11:22:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89EC8201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680600221;
	bh=t265by1nbCo6UP7C5lsxB5RkHZBLzoJKfk4PcTYDm18=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YV6P8YkX8pM9uo6Y6S6foTfjNm9Ex5uN2RFA2w9l4ukecKrGO95QVm0wV1LQHto6k
	 er+b08caM1W0AuelZ/cJabSo79kX41C1NIAThy9nephpU9WVM2wEuUHZeRAsMnGqF9
	 j1PX9F7mrwO9qYWLDR4T5bjaqlyQQwHWSsLLP8E4=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A4A97F8056F;
	Tue,  4 Apr 2023 11:21:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F578F80553; Tue,  4 Apr 2023 11:21:16 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C6BA7F80542
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2023 11:21:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6BA7F80542
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HMsnqPGt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680600066; x=1712136066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t265by1nbCo6UP7C5lsxB5RkHZBLzoJKfk4PcTYDm18=;
  b=HMsnqPGtInpiBe9IQKaYDAC0xmL6cRxknjy6GmkdAxSmi23vuYs0iddg
   iRT9+RS+3MY7kkTknrKX+gREWmD7MzM1YsWY1eTwgPwKNX72K3IqBV2IY
   ZIuM2GWqx7G7Xbp7wES0rDbCQVZaNR/D9iCUnDpLxviRMlk+w3G0LwJeC
   sTWWwA5y6kqwwC4MJZqt5DUBb7QLYe2q2bFml9aO8mgL2N61dBWK9jMe5
   R4Sb6P2gNYhVEHfI+xguvU5uTnhgSkuKTy6miziT+V4s6NR/uUXaOtTb3
   NgonbnnSeCN+hquYa7E8PN28CqoMtHLbuYjf0naSJ3lzS63WjvgZlBwoj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="339620635"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400";
   d="scan'208";a="339620635"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2023 02:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="688820099"
X-IronPort-AV: E=Sophos;i="5.98,317,1673942400";
   d="scan'208";a="688820099"
Received: from vsysoevx-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.33.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2023 02:21:01 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 09/12] ASoC: SOF: Intel: pci-icl: Allow DSPless mode
Date: Tue,  4 Apr 2023 12:21:12 +0300
Message-Id: <20230404092115.27949-10-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230404092115.27949-1-peter.ujfalusi@linux.intel.com>
References: <20230404092115.27949-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OT7HKVURUWGWYYKIK7TE6YMKLOBAS3BO
X-Message-ID-Hash: OT7HKVURUWGWYYKIK7TE6YMKLOBAS3BO
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 rander.wang@intel.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OT7HKVURUWGWYYKIK7TE6YMKLOBAS3BO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

set the dspless_mode_supported flag to true for icl/jsl family to allow
DSPless mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/sof/intel/pci-icl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/intel/pci-icl.c b/sound/soc/sof/intel/pci-icl.c
index 6785669113b3..5fb5a820693e 100644
--- a/sound/soc/sof/intel/pci-icl.c
+++ b/sound/soc/sof/intel/pci-icl.c
@@ -30,6 +30,7 @@ static const struct sof_dev_desc icl_desc = {
 	.chip_info = &icl_chip_info,
 	.ipc_supported_mask	= BIT(SOF_IPC) | BIT(SOF_INTEL_IPC4),
 	.ipc_default		= SOF_IPC,
+	.dspless_mode_supported	= true,		/* Only supported for HDaudio */
 	.default_fw_path = {
 		[SOF_IPC] = "intel/sof",
 		[SOF_INTEL_IPC4] = "intel/avs/icl",
@@ -61,6 +62,7 @@ static const struct sof_dev_desc jsl_desc = {
 	.chip_info = &jsl_chip_info,
 	.ipc_supported_mask	= BIT(SOF_IPC) | BIT(SOF_INTEL_IPC4),
 	.ipc_default		= SOF_IPC,
+	.dspless_mode_supported	= true,		/* Only supported for HDaudio */
 	.default_fw_path = {
 		[SOF_IPC] = "intel/sof",
 		[SOF_INTEL_IPC4] = "intel/avs/jsl",
-- 
2.40.0

