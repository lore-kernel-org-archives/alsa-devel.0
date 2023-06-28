Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF20EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jun 2023 12:53:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F207F74C;
	Wed, 28 Jun 2023 14:52:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F207F74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687956824;
	bh=zsrEFmYJgsJtMrAjtYSetFWnmu1Q7S8gVoYkzK5EYQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p0tOz7XVKtBFUKnhKPo+JLwDjgTPShR56tXtuulPfFqPjJjJtAJpNTJ1a1Wd4nkJN
	 UUv2Tmo8KOB4DWPw4pP3KeBQFmdk4GRZjBAwruTf1DlHDkwyAYUYV52AdBrK6+RVc9
	 FVt92IZO4kEpiIUxphHvgP9AX5Avifr5gCCsACNA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E4C1F805C1; Wed, 28 Jun 2023 14:51:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9F1CF805BF;
	Wed, 28 Jun 2023 14:51:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0442EF805B1; Wed, 28 Jun 2023 14:51:27 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6040EF80431
	for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2023 14:50:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6040EF80431
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EAtrYudy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687956654; x=1719492654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zsrEFmYJgsJtMrAjtYSetFWnmu1Q7S8gVoYkzK5EYQs=;
  b=EAtrYudyZtsrKPA9qdL3Gf4SNeZW4T54ittY1LPzWvz2yWt4zgj65y/Y
   mu3riK1bZz8vtvUJG8/bQGwvzhjapPbpLifvdzjO/VPZPB5um5ofPUYcq
   l/p01n4iKwgvqbZQt055zOFzxhqiEyxPau3Kn0TzlQvF32oePupijwK4K
   GPJWXc5zSVw04k2ab6xrfcXQtDX805jDqkLnzWnbCYIFegNOprfxJ2Ayy
   gA2uoOXsHxA/t1fg4zHS+y6mocjOFjGmMWzssFDuPf/m5tNy1qgQSN+wd
   Bq2BxSMnqF/AFK2E38JmJF2yBTdNodQ71Eq9CyzSG5WZWcEv+prToeOBY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361875598"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200";
   d="scan'208";a="361875598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 05:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="891035117"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200";
   d="scan'208";a="891035117"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2023 05:50:34 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [RFC PATCH 6/8] ASoC: Intel: avs: Update PCI ID list
Date: Wed, 28 Jun 2023 22:51:33 +0200
Message-Id: <20230628205135.517241-7-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JW66OPLGNQHX54GUU2NHWHTKVK46CCZQ
X-Message-ID-Hash: JW66OPLGNQHX54GUU2NHWHTKVK46CCZQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JW66OPLGNQHX54GUU2NHWHTKVK46CCZQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use PCI device IDs from pci_ids.h header. Adjust AVS_MACH_ENTRY macro,
so device id can be provided in short form.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/board_selection.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 60f8fb0bff95..b2d17124c978 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -263,14 +263,14 @@ struct avs_acpi_boards {
 };
 
 #define AVS_MACH_ENTRY(_id, _mach) \
-	{ .id = (_id), .machs = (_mach), }
+	{ .id = PCI_DEVICE_ID_INTEL_HDA_##_id, .machs = (_mach), }
 
 /* supported I2S boards per platform */
 static const struct avs_acpi_boards i2s_boards[] = {
-	AVS_MACH_ENTRY(0x9d70, avs_skl_i2s_machines), /* SKL */
-	AVS_MACH_ENTRY(0x9d71, avs_kbl_i2s_machines), /* KBL */
-	AVS_MACH_ENTRY(0x5a98, avs_apl_i2s_machines), /* APL */
-	AVS_MACH_ENTRY(0x3198, avs_gml_i2s_machines), /* GML */
+	AVS_MACH_ENTRY(SKL_LP,	avs_skl_i2s_machines),
+	AVS_MACH_ENTRY(KBL_LP,	avs_kbl_i2s_machines),
+	AVS_MACH_ENTRY(APL,	avs_apl_i2s_machines),
+	AVS_MACH_ENTRY(GML,	avs_gml_i2s_machines),
 	{},
 };
 
-- 
2.34.1

