Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60EECD1292
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Apr 2024 19:43:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB6532BA9;
	Mon,  8 Apr 2024 21:42:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB6532BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712605382;
	bh=5VYQbJzHtePmAsZ7fybcYiPbcVVJUhOwXJpqC9isW64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e2MZqOicDKO/PJpPk1hy5wChSRpqvaGNW+yi5SwRhsVdVUe2RuNj+d7fjSEn3qKxY
	 2OsMWghFijBd10WfW2drGLpUI7SAeWDkPKULFLY1REeBPy0NjrS3R7B19l/c3INHl7
	 anktZU6/ijl94TkW7k5Tqy2o36+M2jt1DJStnNHY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B86B2F805CA; Mon,  8 Apr 2024 21:42:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E0567F805D2;
	Mon,  8 Apr 2024 21:42:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47608F8026D; Mon,  8 Apr 2024 21:42:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E09D1F800C9
	for <alsa-devel@alsa-project.org>; Mon,  8 Apr 2024 21:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E09D1F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=I9Q7BFZ2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712605325; x=1744141325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5VYQbJzHtePmAsZ7fybcYiPbcVVJUhOwXJpqC9isW64=;
  b=I9Q7BFZ2O0mIoEjHtF0CJHd26WmmjEZ4AXqVE0aGds1ALWm2JYW1sWOd
   G4pkELKlYYtEGRdbDHDfrVkgy2mP1O+Uv5w1RTFICBl4PUaRNp2COclMe
   eYE4M5kptmTacajyyBrToV+oizSBIEN35fU6xdD40FOdxwSHImMKypHil
   ZaJNrVH+aqGVaIdid6ZZKrOSE4t9VWYVlXrHjniY0NX+lZpRGfVhBrXtg
   g7Hg59eQDfVetrujtDZEq1C5UYRwuMfmsp4gRKz73H4EqAhfYkHR64JKU
   xrSd6FXEWQTKg/60cFvMCC0qOLi3/MBQnghBguPbda3pk6yNn+jFveLLD
   A==;
X-CSE-ConnectionGUID: vJyUI6spR0OHUx0G8dJMOA==
X-CSE-MsgGUID: vkAcpWOKTRaECBU6oaMOuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="30390455"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000";
   d="scan'208";a="30390455"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 12:41:57 -0700
X-CSE-ConnectionGUID: Q+7yzZQBSk6uKTX5XEmz9A==
X-CSE-MsgGUID: vauK4FXEQjWVkabfMbP5Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000";
   d="scan'208";a="24776958"
Received: from aikuseru-mobl1.amr.corp.intel.com (HELO pbossart-mobl6.lan)
 ([10.212.40.188])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 12:41:57 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 1/3] ASoC: SOF: Intel: add default firmware library path for
 LNL
Date: Mon,  8 Apr 2024 14:41:45 -0500
Message-Id: <20240408194147.28919-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240408194147.28919-1-pierre-louis.bossart@linux.intel.com>
References: <20240408194147.28919-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BIEHC3NVKLUU3LO6IXAPNALLN3RTGWRG
X-Message-ID-Hash: BIEHC3NVKLUU3LO6IXAPNALLN3RTGWRG
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BIEHC3NVKLUU3LO6IXAPNALLN3RTGWRG/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The commit cd6f2a2e6346 ("ASoC: SOF: Intel: Set the default firmware
library path for IPC4") added the default_lib_path field for all
platforms, but this was missed when LunarLake was later introduced.

Fixes: 64a63d9914a5 ("ASoC: SOF: Intel: LNL: Add support for Lunarlake platform")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/pci-lnl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/intel/pci-lnl.c b/sound/soc/sof/intel/pci-lnl.c
index b26ffe767fab..b14e508f1f31 100644
--- a/sound/soc/sof/intel/pci-lnl.c
+++ b/sound/soc/sof/intel/pci-lnl.c
@@ -35,6 +35,9 @@ static const struct sof_dev_desc lnl_desc = {
 	.default_fw_path = {
 		[SOF_IPC_TYPE_4] = "intel/sof-ipc4/lnl",
 	},
+	.default_lib_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-lib/lnl",
+	},
 	.default_tplg_path = {
 		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-tplg",
 	},
-- 
2.40.1

