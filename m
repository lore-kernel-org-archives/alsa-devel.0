Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C9AC4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Nov 2023 12:50:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE2EDA4E;
	Thu,  2 Nov 2023 13:50:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE2EDA4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698929453;
	bh=6EGi9V6cboKw6AotQz4ekyMvQb/rXSF85eucGOf3JYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UXhAJV5xVfgqmgPYhcCnwWJ22w141ANA04F4xQtIv4PIzBVS1SycajPkTZzGtgYTF
	 9hoHD5/SIHfBUCcjQFj29mr5OAkksbMGgXaUUumnqcD8uo8RNRt2Jspt3Ju3Xy0tRE
	 d88vw96u2QMPStoNvlhn3uKQqVMcvyBz7qvAhvyA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 883C4F805EB; Thu,  2 Nov 2023 13:47:40 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C0AEF805E3;
	Thu,  2 Nov 2023 13:47:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5F153F805A1; Thu,  2 Nov 2023 13:47:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2BBEEF80563
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2023 13:47:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BBEEF80563
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=CAF6moUB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698929244; x=1730465244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EGi9V6cboKw6AotQz4ekyMvQb/rXSF85eucGOf3JYU=;
  b=CAF6moUBgXFz9/xd3+tgMSBCykpkSRmf8OhdSdDOx/GtXvNGZo65A3Tc
   1aqYmQySgdP2R5YJQJoYsbKx8f8lSPAMMkSiqipmVb2TLN/BCwqreHtJN
   A5LKy94kEKiw4G/9XvgkRQX+ba6Wht2ioAj4PreUZ3FheBoxh1DhCqOs1
   P+hVwrVNcMBuyzhXQ7wZDLy02HKRcBqmvCXo2GwysXVrIpW4lZSl85Ujn
   DohsD7mI6UkcIkNkNDPBoOQ8cV601iEJh7QU2aDxEZeSfsKS5FPFZp0cz
   EOBdx/gSZl7jqCm+UY8pCAUl0paqi/K1NxOE93YJu2PZ/CIWw3iNM3G73
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7343529"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200";
   d="scan'208";a="7343529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 05:47:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1008454771"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200";
   d="scan'208";a="1008454771"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2023 05:47:20 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 10/17] ASoC: Intel: avs: probe: Add proper id_table
Date: Thu,  2 Nov 2023 13:47:05 +0100
Message-Id: <20231102124712.2549327-11-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102124712.2549327-1-amadeuszx.slawinski@linux.intel.com>
References: <20231102124712.2549327-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 73MEHKTOM7FDZTZNJ5EGTFFVP5E4VBYX
X-Message-ID-Hash: 73MEHKTOM7FDZTZNJ5EGTFFVP5E4VBYX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/73MEHKTOM7FDZTZNJ5EGTFFVP5E4VBYX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add id_table and use it instead of alias to load module.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/boards/probe.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/probe.c b/sound/soc/intel/avs/boards/probe.c
index 411acaee74f9..a9469b5ecb40 100644
--- a/sound/soc/intel/avs/boards/probe.c
+++ b/sound/soc/intel/avs/boards/probe.c
@@ -50,15 +50,23 @@ static int avs_probe_mb_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(dev, card);
 }
 
+static const struct platform_device_id avs_probe_mb_driver_ids[] = {
+	{
+		.name = "avs_probe_mb",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, avs_probe_mb_driver_ids);
+
 static struct platform_driver avs_probe_mb_driver = {
 	.probe = avs_probe_mb_probe,
 	.driver = {
 		.name = "avs_probe_mb",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = avs_probe_mb_driver_ids,
 };
 
 module_platform_driver(avs_probe_mb_driver);
 
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:avs_probe_mb");
-- 
2.34.1

