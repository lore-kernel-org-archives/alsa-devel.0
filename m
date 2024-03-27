Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45375C54E67
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:28:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B2432BDC;
	Wed, 27 Mar 2024 17:28:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B2432BDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711556905;
	bh=kBjilh3lBSecefNieVDjy8yvJNKSl/RKrX7Hlh67ag8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=X5gxbCcriIVTVSxAARBVPOX98vjQzX62RNQlvXCPiUMNb7BopMFzMjTEDYlVjr64E
	 iDZViCZ7EGT+TbW+dU/vXttBAA2fveeMuqp+2n/ovpfjZFjx949oZU3WQ/QSXTOlkr
	 G2D91MF+RdllM/ycCCfEs4R/ttKwcJrLONkn7BiI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52221F80753; Wed, 27 Mar 2024 17:25:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EDC80F807D1;
	Wed, 27 Mar 2024 17:25:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C01CF806B5; Wed, 27 Mar 2024 17:25:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0E620F8025F
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 17:24:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E620F8025F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=hziAJQbh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711556682; x=1743092682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kBjilh3lBSecefNieVDjy8yvJNKSl/RKrX7Hlh67ag8=;
  b=hziAJQbhS8VN4Fg4y0YksvL46rhBinCe1N778jo3MYNWWCvU3E4MDZra
   uyKW2pE78uwIuqEIS2rDblRGXNw+uyZZNyYO51HYaQAggTEnfMwkyA6x9
   f+aCAt7680qgu8m5qGMm4tQ6J6SWFuN9f/Fh8mSBAOZnbh8A1+PKCenbg
   0z0mTPWfGikv7vtJxO7HNubetON7O0dLSCYwGlgUnOhY3zFDUEncf2plL
   mcEJ2SWN5Ek9JubPz1Cy32x7SzGyTKNXV5iGWS6shOPNjQCLsQTpETiL7
   Ti9g/dDZG1jfErk8RfM82e2iVkCiCmURs69XFVFhSAmdQXIz0E/ah/sAt
   g==;
X-CSE-ConnectionGUID: 8nS8TWRlS5mJOzBc3/uzdQ==
X-CSE-MsgGUID: snb/2ic7SuiHSQu8V8upyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17221552"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000";
   d="scan'208";a="17221552"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 09:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000";
   d="scan'208";a="53821319"
Received: from ssherman-mobl.amr.corp.intel.com (HELO
 pbossart-mobl6.intel.com) ([10.212.117.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 09:24:34 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 13/18] ASoC: Intel: sof_rt5682: mach cleanup for rpl boards
Date: Wed, 27 Mar 2024 11:24:03 -0500
Message-Id: <20240327162408.63953-14-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240327162408.63953-1-pierre-louis.bossart@linux.intel.com>
References: <20240327162408.63953-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: U5IEECE72KLVT3V6WV2ZWQKHDZJWKYVB
X-Message-ID-Hash: U5IEECE72KLVT3V6WV2ZWQKHDZJWKYVB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U5IEECE72KLVT3V6WV2ZWQKHDZJWKYVB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Add two common entries in enumeration table for all rt5682/rt5650
boards with/without speaker amplifier. All other rpl_rt5682_def
entries become redundant so get removed.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-rpl-match.c   | 40 +++++++------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
index 44be9077b4e0..e28a21667780 100644
--- a/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-rpl-match.c
@@ -348,7 +348,7 @@ static const struct snd_soc_acpi_link_adr rplp_crb[] = {
 
 static const struct snd_soc_acpi_codecs rpl_rt5682_hp = {
 	.num_codecs = 2,
-	.codecs = {"10EC5682", "RTL5682"},
+	.codecs = {RT5682_ACPI_HID, RT5682S_ACPI_HID},
 };
 
 static const struct snd_soc_acpi_codecs rpl_essx_83x6 = {
@@ -371,11 +371,6 @@ static const struct snd_soc_acpi_codecs rpl_lt6911_hdmi = {
 	.codecs = {"INTC10B0"}
 };
 
-static const struct snd_soc_acpi_codecs rpl_rt1019p_amp = {
-	.num_codecs = 1,
-	.codecs = {"RTL1019"}
-};
-
 struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 	{
 		.comp_ids = &rpl_rt5682_hp,
@@ -384,20 +379,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 		.quirk_data = &rpl_max98357a_amp,
 		.sof_tplg_filename = "sof-rpl-max98357a-rt5682.tplg",
 	},
-	{
-		.comp_ids = &rpl_rt5682_hp,
-		.drv_name = "rpl_rt5682_def",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &rpl_max98360a_amp,
-		.sof_tplg_filename = "sof-rpl-max98360a-rt5682.tplg",
-	},
-	{
-		.comp_ids = &rpl_rt5682_hp,
-		.drv_name = "rpl_rt5682_def",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &rpl_rt1019p_amp,
-		.sof_tplg_filename = "sof-rpl-rt1019-rt5682.tplg",
-	},
 	{
 		.comp_ids = &rpl_rt5682_hp,
 		.drv_name = "rpl_rt5682_c1_h02",
@@ -430,6 +411,20 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_AMP_NAME |
 					SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME,
 	},
+	{
+		.id = RT5650_ACPI_HID,
+		.drv_name = "rpl_rt5682_def",
+		.sof_tplg_filename = "sof-rpl", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_AMP_NAME |
+					SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME,
+	},
+	{
+		.comp_ids = &rpl_rt5682_hp,
+		.drv_name = "rpl_rt5682_def",
+		.sof_tplg_filename = "sof-rpl", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_AMP_NAME |
+					SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME,
+	},
 	/* place amp-only boards in the end of table */
 	{
 		.id = "INTC10B0",
@@ -443,11 +438,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[] = {
 		.quirk_data = &rpl_max98360a_amp,
 		.sof_tplg_filename = "sof-rpl-max98360a-da7219.tplg",
 	},
-	{
-		.id = "10EC5650",
-		.drv_name = "rpl_rt5682_def",
-		.sof_tplg_filename = "sof-rpl-rt5650.tplg",
-	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_rpl_machines);
-- 
2.40.1

