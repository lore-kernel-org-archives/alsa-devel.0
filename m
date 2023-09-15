Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D31EE6457
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Sep 2023 12:44:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2575E7D;
	Fri, 15 Sep 2023 14:43:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2575E7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694781884;
	bh=gIUeaog6rZ9DkgKcRoWsnvL1KNFZmqd7XdbNJXyfyWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jR5F19AIjJt15tmnDvbfdYRITrhICkAaN1VQwd7emjqQFhkz6edpjN0LUZWFFY1LK
	 QPFNiNOXy20MIrvHobBjzvikN9/C8v4o9aPPi2NBjDDwT3gAACDAFe4NwHecfKIP+i
	 sQhIolUj7FUOLomHEq8HF2FAPtO86lwk0GGqI9eA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F4F1F8060A; Fri, 15 Sep 2023 14:41:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 71A17F80606;
	Fri, 15 Sep 2023 14:41:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 75D0CF805B6; Fri, 15 Sep 2023 14:40:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE285F805AA
	for <alsa-devel@alsa-project.org>; Fri, 15 Sep 2023 14:40:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE285F805AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Pnal9k7L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694781639; x=1726317639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gIUeaog6rZ9DkgKcRoWsnvL1KNFZmqd7XdbNJXyfyWo=;
  b=Pnal9k7LX9euKGWhje8YfwP3umZ0HQmhzATdADFrI6hPliz63lZV+3kf
   GrqD05knY8zPLFzOP2x/hEOYk/KCWXIjdftM/kdf3I5dfXZpoz/L6fqjj
   /IGLUPtGnuSyyf3nBGkDsGxSFYcT4iy64rIZDmQPFXSKuoyExSL6pHOFD
   n1I0uAn+fNkBqjjqNL+GVDPquyeGnp67NxpPEd+prp7ALLpHPaTfVZ4XN
   FKNndwtwaVThvLZ1j2NSXUTRr9XJvB+v8xDmP+/y8iKmqQ67EWbAkevCE
   jNFcQj/IHG8pJxzNKPQYShBXuQhKNl7Ull4AoRLADfAg5NeOhmiRzBMR+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="358653200"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000";
   d="scan'208";a="358653200"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 05:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="774304601"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000";
   d="scan'208";a="774304601"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 05:40:34 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com,
	peter.ujfalusi@linux.intel.com,
	brent.lu@intel.com,
	uday.m.bhat@intel.com,
	balamurugan.c@intel.com
Subject: [PATCH 11/19] ASoC: Intel: sof_rt5682: add HDMI_In capture feature
 support for RPL.
Date: Fri, 15 Sep 2023 20:48:44 +0800
Message-Id: <20230915124852.1696857-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915124852.1696857-1-yung-chuan.liao@linux.intel.com>
References: <20230915124852.1696857-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: P34FVXOW7KTW5M3LYBE4KCCU63OUNWVS
X-Message-ID-Hash: P34FVXOW7KTW5M3LYBE4KCCU63OUNWVS
X-MailFrom: yung-chuan.liao@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P34FVXOW7KTW5M3LYBE4KCCU63OUNWVS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Balamurugan C <balamurugan.c@intel.com>

Added HDMI-in capture support for RPL boards. previously it used adl
machines and now its moved into separate match entry.

Signed-off-by: Balamurugan C <balamurugan.c@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c               | 8 ++++++++
 sound/soc/intel/common/soc-acpi-intel-rpl-match.c | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index f5767f9e506d..9ece71062a3b 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -1279,6 +1279,14 @@ static const struct platform_device_id board_ids[] = {
 					SOF_BT_OFFLOAD_SSP(2) |
 					SOF_SSP_BT_OFFLOAD_PRESENT),
 	},
+	{
+		.name = "rpl_rt5682_c1_h02",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(1) |
+					SOF_RT5682_NUM_HDMIDEV(3) |
+					/* SSP 0 and SSP 2 are used for HDMI IN */
+					SOF_HDMI_CAPTURE_SSP_MASK(0x5)),
+	},
 	{
 		.name = "mtl_mx98357_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
index 122673c1dae2..b0ffade5bb08 100644
--- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
@@ -402,6 +402,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 		.quirk_data = &rpl_rt1019p_amp,
 		.sof_tplg_filename = "sof-rpl-rt1019-rt5682.tplg",
 	},
+	{
+		.comp_ids = &rpl_rt5682_hp,
+		.drv_name = "rpl_rt5682_c1_h02",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &rpl_lt6911_hdmi,
+		.sof_tplg_filename = "sof-rpl-rt5682-ssp1-hdmi-ssp02.tplg",
+	},
 	{
 		.comp_ids = &rpl_essx_83x6,
 		.drv_name = "rpl_es83x6_c1_h02",
-- 
2.25.1

