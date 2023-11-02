Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2F9C4332F
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Nov 2023 12:51:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C1828DF9;
	Thu,  2 Nov 2023 13:50:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C1828DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698929472;
	bh=B4bI3Klz+igU/UXJr5zqGf2V6r43W6VxINMqAsc1jhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cBq/PgwuA3nBNMZZh4b4qnW3jsmFpY9q0vtF5RoVFNxggIxeRrmzIRWHIJeuJNzD/
	 YUgIcNHBg+oFWcWyfMNIoIM33mzuXwlRK4l9PYonMfFjhe4YbBZhvMVkxpKaKFSpXF
	 CxtGGOCr1WJDXkqPXwE7DsQWdNVhvUphLUo5hMbE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 584D4F805EE; Thu,  2 Nov 2023 13:47:41 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EEAAF805EC;
	Thu,  2 Nov 2023 13:47:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEC2EF805A1; Thu,  2 Nov 2023 13:47:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 23142F805A0
	for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2023 13:47:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23142F805A0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Wsk/TBC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698929246; x=1730465246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4bI3Klz+igU/UXJr5zqGf2V6r43W6VxINMqAsc1jhM=;
  b=Wsk/TBC2IT2H7aEZZLc6A5hbpp+SSc23tsFDkPJr2r7b44GA9GoRCBQd
   lEFb1Y5wLpITvkyYK8gDJN1XoHgHpQ3ZXceflL1yULdpHaBCqjIf2GlGb
   XI79IZL9gKFAXqrv6llvs1qM1WlPObjOW7fY2sZL0VHbqbLRYsqxuYFXC
   Ph8fpHB3+nn/KTv/+tY5wCG6RQsVUIywh2/a1R6SLY04eJ9DjXDsCWLoM
   jPID+9G/KpGOU64frjyLrZIp8DaRIGI1dCFJcW8ozoVQWyLUE6LCUqad+
   tClm+g6DsyePetOIhQu4JYypeZz7AD7KMZ1u4cQJ9CCKiyz0qcXbVdW4t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7343535"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200";
   d="scan'208";a="7343535"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 05:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1008454775"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200";
   d="scan'208";a="1008454775"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2023 05:47:22 -0700
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
Subject: [PATCH 11/17] ASoC: Intel: avs: rt274: Add proper id_table
Date: Thu,  2 Nov 2023 13:47:06 +0100
Message-Id: <20231102124712.2549327-12-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102124712.2549327-1-amadeuszx.slawinski@linux.intel.com>
References: <20231102124712.2549327-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: SLE5GBXG7PFPGAZHVMGPC4FHN35I7TP6
X-Message-ID-Hash: SLE5GBXG7PFPGAZHVMGPC4FHN35I7TP6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SLE5GBXG7PFPGAZHVMGPC4FHN35I7TP6/>
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
 sound/soc/intel/avs/boards/rt274.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/rt274.c b/sound/soc/intel/avs/boards/rt274.c
index 157183b1de24..bfcb8845fd15 100644
--- a/sound/soc/intel/avs/boards/rt274.c
+++ b/sound/soc/intel/avs/boards/rt274.c
@@ -257,15 +257,23 @@ static int avs_rt274_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(dev, card);
 }
 
+static const struct platform_device_id avs_rt274_driver_ids[] = {
+	{
+		.name = "avs_rt274",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(platform, avs_rt274_driver_ids);
+
 static struct platform_driver avs_rt274_driver = {
 	.probe = avs_rt274_probe,
 	.driver = {
 		.name = "avs_rt274",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = avs_rt274_driver_ids,
 };
 
 module_platform_driver(avs_rt274_driver);
 
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:avs_rt274");
-- 
2.34.1

