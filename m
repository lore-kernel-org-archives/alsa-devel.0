Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE781EB64DC
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Jul 2023 11:50:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD306DED;
	Mon, 17 Jul 2023 13:49:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD306DED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689594600;
	bh=0AXpV0FjivTzBstr/PQwlZnSEFZXSw8dA2CnQf5ffBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=giho9O5kZ8msvwOZl2wBuugOCnFbJp85JtdHT0DnPuGnZzV/pdoh8a6tP5/Vi0KsO
	 ed0/GBCjmU+PEK0tNZVSzOkYcUgXuT+9cNzQdq1FniEXZay7NbbBmNk2+DzY55FRV6
	 H/M8lhlBLIRmuHajsh/xVMvny3b9kj5zYFYvvd5E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 81A35F805F8; Mon, 17 Jul 2023 13:46:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C6B53F805F8;
	Mon, 17 Jul 2023 13:46:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 284BFF805CA; Mon, 17 Jul 2023 13:46:13 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 95F7FF805AB
	for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2023 13:46:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95F7FF805AB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=SSHIAZ0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689594362; x=1721130362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0AXpV0FjivTzBstr/PQwlZnSEFZXSw8dA2CnQf5ffBE=;
  b=SSHIAZ0oGcYUmT9m+2KDEdo9DFfS683TtT9J9gsmPxLwAftZPkx20k1q
   4y/aXRfv43qUf3H6B8b7Z9sEjEt0ettHmUtTzYFJOxLRGs/dEzarkZKMo
   y0otl6tIMeyNI3KE2ZmlPb9LPdIK71K9xlaQ+84eE0EyYfzdSAwnwv4N3
   BjVH1T5cPAw+c3bg3Z3MxBZq2+LwUScsU98jk9xdFw2pV0LWFbLQ/Um3S
   P0LvED/MsTI+9LzoPrBNvP5YTqVyQlTV8saD14wRrYP5Z6S2ULI5LcxMU
   QsoH9QJmcsRUk2+C+R4MEQV04/9/+gwZOwhxTFIDQLmn5FP+gxm08o6ZH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363372972"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200";
   d="scan'208";a="363372972"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2023 04:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969856544"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200";
   d="scan'208";a="969856544"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 04:45:58 -0700
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
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 12/15] ASoC: Intel: avs: Convert to PCI device IDs defines
Date: Mon, 17 Jul 2023 13:45:08 +0200
Message-Id: <20230717114511.484999-13-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
References: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BUGW4M3ZJM5RR45CLHJSTJDIMHU7FBJP
X-Message-ID-Hash: BUGW4M3ZJM5RR45CLHJSTJDIMHU7FBJP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BUGW4M3ZJM5RR45CLHJSTJDIMHU7FBJP/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use PCI device IDs from pci_ids.h header. Adjust AVS_MACH_ENTRY() macro,
so device ID can be provided in short form.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/board_selection.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 60f8fb0bff95..b32e02940e30 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -263,14 +263,14 @@ struct avs_acpi_boards {
 };
 
 #define AVS_MACH_ENTRY(_id, _mach) \
-	{ .id = (_id), .machs = (_mach), }
+	{ .id = PCI_DEVICE_ID_INTEL_##_id, .machs = (_mach), }
 
 /* supported I2S boards per platform */
 static const struct avs_acpi_boards i2s_boards[] = {
-	AVS_MACH_ENTRY(0x9d70, avs_skl_i2s_machines), /* SKL */
-	AVS_MACH_ENTRY(0x9d71, avs_kbl_i2s_machines), /* KBL */
-	AVS_MACH_ENTRY(0x5a98, avs_apl_i2s_machines), /* APL */
-	AVS_MACH_ENTRY(0x3198, avs_gml_i2s_machines), /* GML */
+	AVS_MACH_ENTRY(HDA_SKL_LP, avs_skl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_KBL_LP, avs_kbl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_APL, avs_apl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_GML, avs_gml_i2s_machines),
 	{},
 };
 
-- 
2.34.1

