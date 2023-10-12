Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768E2CDB47E
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Oct 2023 19:16:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94D26E8C;
	Thu, 12 Oct 2023 21:15:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94D26E8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1697138178;
	bh=0URt3vABXKqeI1RoGGSyvCl2v7cE3o8yAFv6Xg/VBjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O/BS6Bg8m9hxBfLZ5QoRwbNHTW3917TXGwNXbtcPrF5hAHXOsiCTegC2kyd7Efeii
	 7e03PxnU3MF/kkvVt2XGQ9r6xmAwZDponmJXvAHpup9414w/HbQCbw3OEiP2kztUf8
	 rt6FyyarQm04KnyE8RcPL8wKpEMsaihDhSyDFll0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 858CAF805BB; Thu, 12 Oct 2023 21:10:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 104F0F805B4;
	Thu, 12 Oct 2023 21:10:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62DAFF80589; Thu, 12 Oct 2023 21:10:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 903A2F802E8
	for <alsa-devel@alsa-project.org>; Thu, 12 Oct 2023 21:08:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 903A2F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mNFdpXHh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697137740; x=1728673740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0URt3vABXKqeI1RoGGSyvCl2v7cE3o8yAFv6Xg/VBjw=;
  b=mNFdpXHhXvjkKKCcYZFbasYVO/C75xLTKfc5hzmSP1dsCh1WTM1F8ClH
   qtXQwOV7Lwm+geAm0xAZqyrebxnpqLh18aj3rIvdnhW3Zs9F7BtYgvhAM
   60FUBH2PNw/kbYWtFRazp1P/6KYWgL62IQ4Zy75rglJl3byc6xhZDKmtz
   XCKGpB3SJkj6H1bjNF/Jbz0qhmIhkP63+vpVoCDZVQMAilAQbYPjv7Php
   byBq+lZ9bMXVoQPeae0w5Pr+5sTsojJDyYkHOEJb0q4YrvY41HGQ1+bbv
   dAG975wo6NpVnH1364irVjfePTZbADw52dl38d1kfrY2Kssn1C/4FjDhM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416060180"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200";
   d="scan'208";a="416060180"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 12:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845108062"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200";
   d="scan'208";a="845108062"
Received: from gchoudha-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.hsd1.md.comcast.net) ([10.212.114.241])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 12:08:40 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Balamurugan C <balamurugan.c@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 05/23] ASoC: Intel: MTL: Add entry for HDMI-In capture support
 to non-I2S codec boards.
Date: Thu, 12 Oct 2023 15:08:08 -0400
Message-Id: <20231012190826.142619-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012190826.142619-1-pierre-louis.bossart@linux.intel.com>
References: <20231012190826.142619-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IRMBWO6TUAYWLQBZMOH2TIYO4A7ZI6YC
X-Message-ID-Hash: IRMBWO6TUAYWLQBZMOH2TIYO4A7ZI6YC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IRMBWO6TUAYWLQBZMOH2TIYO4A7ZI6YC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Balamurugan C <balamurugan.c@intel.com>

Adding HDMI-In capture support for the MTL products which doesn't have
onboard I2S codec. But need to support HDMI-In capture via I2S and
audio playback through HDMI/DP monitor.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Balamurugan C <balamurugan.c@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_ssp_amp.c              | 9 +++++++++
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/sof_ssp_amp.c b/sound/soc/intel/boards/sof_ssp_amp.c
index e8447da24e59..22abcf9f7f74 100644
--- a/sound/soc/intel/boards/sof_ssp_amp.c
+++ b/sound/soc/intel/boards/sof_ssp_amp.c
@@ -512,6 +512,15 @@ static const struct platform_device_id board_ids[] = {
 					SOF_NO_OF_HDMI_PLAYBACK(3) |
 					SOF_HDMI_PLAYBACK_PRESENT),
 	},
+	{
+		.name = "mtl_lt6911_hdmi_ssp",
+		.driver_data = (kernel_ulong_t)(SOF_NO_OF_HDMI_CAPTURE_SSP(2) |
+				SOF_HDMI_CAPTURE_1_SSP(0) |
+				SOF_HDMI_CAPTURE_2_SSP(2) |
+				SOF_SSP_HDMI_CAPTURE_PRESENT |
+				SOF_NO_OF_HDMI_PLAYBACK(3) |
+				SOF_HDMI_PLAYBACK_PRESENT),
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, board_ids);
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index 5e8881bf0768..301b8142d554 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -77,6 +77,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 					SND_SOC_ACPI_TPLG_INTEL_SSP_MSB |
 					SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER,
 	},
+	/* place amp-only boards in the end of table */
+	{
+		.id = "INTC10B0",
+		.drv_name = "mtl_lt6911_hdmi_ssp",
+		.sof_tplg_filename = "sof-mtl-hdmi-ssp02.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_mtl_machines);
-- 
2.39.2

