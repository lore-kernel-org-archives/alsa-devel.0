Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30757C3DA7F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Aug 2024 09:45:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6788A1944;
	Mon, 12 Aug 2024 11:45:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6788A1944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723455934;
	bh=IQNUWGHC66UR4O6UUaQ6ngebQk8RtJDKO+WWALJfVFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=l6UXHiJ3vVMuHjmJAtOuPApmIs/DYdgUeKPBG3rETmuU+kRALl6BJpJeustNELz1l
	 oBj5dBdfg578gRm03CWWbf249xwo2yihxDJWSLFDMainjjSda0ghn0o0GvA3haYYm+
	 XlwiT4kgkMTdmilDJpsuVA9pfJ79fiBvm8+5k4kA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 85546F8067F; Mon, 12 Aug 2024 11:44:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DBA1F80675;
	Mon, 12 Aug 2024 11:44:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CF97F805C3; Mon, 12 Aug 2024 11:43:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2E08BF805D8
	for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2024 11:43:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E08BF805D8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Wdgh+CAd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723455800; x=1754991800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQNUWGHC66UR4O6UUaQ6ngebQk8RtJDKO+WWALJfVFY=;
  b=Wdgh+CAdxQath4ZZV7tjKxGzkwGXYbrieLjGTVVgNrDJ8wzfFPpbxNzS
   qieTTszeZawGn1kYilgvRxDfwBlnDf4bPLHVAEfaXDweuynR/H5xfThqg
   e04BhhmGki9885ZB/t/xfrYh3UkWqXqKMUKvO3TQKh5IJNx5/CwvSE8Gz
   3rlcRWYZd3TzZmX+7wGNIpE5JWLoSw4w4MTO6s8wJlMvb0r/+YgwBrLOh
   xvIlPVyOh9JVYi9w0IdEUDMRQ1t3hpbCHE3ItF9Q/IVDjaUkRK1YE8fMW
   sfeuzYuQsnceddmB9WAyyk1OXPXik/+sALyVHPOPAUFhBmoSkN5FJ+b9w
   Q==;
X-CSE-ConnectionGUID: 0mx4FacRQeej+LdKfdcbvA==
X-CSE-MsgGUID: TYVCE8AzSmelD5k4QC1PAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21705466"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800";
   d="scan'208";a="21705466"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2024 02:43:17 -0700
X-CSE-ConnectionGUID: Rux49i+NR+6oqFQQaRignQ==
X-CSE-MsgGUID: YWWQee5FQzGm4yhSf8w1+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800";
   d="scan'208";a="63057027"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by orviesa005.jf.intel.com with ESMTP; 12 Aug 2024 02:43:14 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	andriy.shevchenko@linux.intel.com,
	cujomalainey@chromium.org,
	lmajczak@google.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH 12/12] ASoC: Intel: avs: Enable by default for all SST
 configurations
Date: Mon, 12 Aug 2024 11:43:28 +0200
Message-Id: <20240812094328.842661-13-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812094328.842661-1-cezary.rojewski@intel.com>
References: <20240812094328.842661-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 32WPWUFUUJHVRFFRKQEA2REKW7OYRM37
X-Message-ID-Hash: 32WPWUFUUJHVRFFRKQEA2REKW7OYRM37
X-MailFrom: cezary.rojewski@intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/32WPWUFUUJHVRFFRKQEA2REKW7OYRM37/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The skylake-driver is deprecated in favour of the avs-driver. As the
latter supports all configurations of its predecessor and more, update
the existing selection mechanism to acknowledge the SST flag.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index f2dc82a2abc7..da7bac09acb4 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -422,8 +422,14 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	int ret;
 
 	ret = snd_intel_dsp_driver_probe(pci);
-	if (ret != SND_INTEL_DSP_DRIVER_ANY && ret != SND_INTEL_DSP_DRIVER_AVS)
+	switch (ret) {
+	case SND_INTEL_DSP_DRIVER_ANY:
+	case SND_INTEL_DSP_DRIVER_SST:
+	case SND_INTEL_DSP_DRIVER_AVS:
+		break;
+	default:
 		return -ENODEV;
+	}
 
 	ret = pcim_enable_device(pci);
 	if (ret < 0)
-- 
2.25.1

