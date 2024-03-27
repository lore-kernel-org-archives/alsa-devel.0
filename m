Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DFAC47DD9
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:27:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CB862C2A;
	Wed, 27 Mar 2024 17:27:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CB862C2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711556856;
	bh=7O66xi+xRTn70v7wSDGhlnfMnYCGKr0ry+FUMCrIqcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rHjBYsudazYH2j21YwwYmEsC/OURUYAczZcjka+rbs0S+iX/4K3V/kff6n3JkUrKJ
	 XgmoYDGcV0FfhjI/R00Pbcu4uuhHXAI32lgNZsqxppZlV+gRZID3P1/1R+3rZaHK2K
	 FXQtdilcwNxa9ruaqNv1y3sHdQeG6U8+lHOns52Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38462F806E2; Wed, 27 Mar 2024 17:25:11 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A19CF806D7;
	Wed, 27 Mar 2024 17:25:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 36ABDF8067A; Wed, 27 Mar 2024 17:24:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 408CFF80570
	for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2024 17:24:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 408CFF80570
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=B2Dm8Ky0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711556678; x=1743092678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7O66xi+xRTn70v7wSDGhlnfMnYCGKr0ry+FUMCrIqcA=;
  b=B2Dm8Ky0whFMz+p2Atcs+Tm//oRXKYI0Ka/9uzCxIkbhG+5x8+qFBLWs
   uWzxlzHaao0FRdaCqNtGQsJ+b5JVoj4Sh2yWcDY5SHJY4ng4/ya5C2A3K
   sMP9BpXLc+AEGdyeSwIlLzsL+1DIQloTZgvq669SyPOhvtbDCvoYTWqcq
   T4ygFLN35lIUtzMkcgqSMYdOSbY7H4bCiN8WmGYc+s2oqHClyExi0mFTy
   ZjrDTdv2DWfTXZ58xS8fKcyP0HFk87vzzo1ra3TKgSOi6BWSqioHzlzfW
   iRcM1XpMgixgyqmJ0ZOc30E1KGVMACbFoadgD7fII8K1ajv7bwMdVtWVk
   g==;
X-CSE-ConnectionGUID: jcO8Wk+5S+y8kIsx874KDA==
X-CSE-MsgGUID: PKThWTMpSISja1NHLJ283Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17221524"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000";
   d="scan'208";a="17221524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 09:24:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000";
   d="scan'208";a="53821291"
Received: from ssherman-mobl.amr.corp.intel.com (HELO
 pbossart-mobl6.intel.com) ([10.212.117.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 09:24:31 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 08/18] ASoC: Intel: sof_nau8825: mach cleanup for adl boards
Date: Wed, 27 Mar 2024 11:23:58 -0500
Message-Id: <20240327162408.63953-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240327162408.63953-1-pierre-louis.bossart@linux.intel.com>
References: <20240327162408.63953-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CX456CC4CQ2BCUWKQHMMC77A74QEUJ23
X-Message-ID-Hash: CX456CC4CQ2BCUWKQHMMC77A74QEUJ23
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CX456CC4CQ2BCUWKQHMMC77A74QEUJ23/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Add a common entry in enumeration table for all nau8825 boards
with/without speaker amplifier. All other adl_nau8825_def entries
become redundant so get removed.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-adl-match.c   | 54 ++++---------------
 1 file changed, 11 insertions(+), 43 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 7ce8aade07d7..f8b8864b5ec6 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -7,6 +7,7 @@
 
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
+#include <sound/soc-acpi-intel-ssp-common.h>
 
 static const struct snd_soc_acpi_codecs essx_83x6 = {
 	.num_codecs = 3,
@@ -467,11 +468,6 @@ static const struct snd_soc_acpi_codecs adl_rt5682_rt5682s_hp = {
 	.codecs = {"10EC5682", "RTL5682"},
 };
 
-static const struct snd_soc_acpi_codecs adl_rt1015p_amp = {
-	.num_codecs = 1,
-	.codecs = {"RTL1015"}
-};
-
 static const struct snd_soc_acpi_codecs adl_rt1019p_amp = {
 	.num_codecs = 1,
 	.codecs = {"RTL1019"}
@@ -487,11 +483,6 @@ static const struct snd_soc_acpi_codecs adl_lt6911_hdmi = {
 	.codecs = {"INTC10B0"}
 };
 
-static const struct snd_soc_acpi_codecs adl_nau8318_amp = {
-	.num_codecs = 1,
-	.codecs = {"NVTN2012"}
-};
-
 static struct snd_soc_acpi_codecs adl_rt5650_amp = {
 	.num_codecs = 1,
 	.codecs = {"10EC5650"}
@@ -526,20 +517,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.quirk_data = &adl_rt1019p_amp,
 		.sof_tplg_filename = "sof-adl-rt1019-nau8825.tplg",
 	},
-	{
-		.id = "10508825",
-		.drv_name = "adl_nau8825_def",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &adl_max98373_amp,
-		.sof_tplg_filename = "sof-adl-max98373-nau8825.tplg",
-	},
-	{
-		.id = "10508825",
-		.drv_name = "adl_nau8825_def",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &adl_max98360a_amp,
-		.sof_tplg_filename = "sof-adl-max98360a-nau8825.tplg",
-	},
 	{
 		.comp_ids = &adl_rt5682_rt5682s_hp,
 		.drv_name = "adl_rt5682_def",
@@ -547,25 +524,6 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.quirk_data = &adl_rt1019p_amp,
 		.sof_tplg_filename = "sof-adl-rt1019-rt5682.tplg",
 	},
-	{
-		.id = "10508825",
-		.drv_name = "adl_nau8825_def",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &adl_rt1015p_amp,
-		.sof_tplg_filename = "sof-adl-rt1015-nau8825.tplg",
-	},
-	{
-		.id = "10508825",
-		.drv_name = "adl_nau8825_def",
-		.machine_quirk = snd_soc_acpi_codec_list,
-		.quirk_data = &adl_nau8318_amp,
-		.sof_tplg_filename = "sof-adl-nau8318-nau8825.tplg",
-	},
-	{
-		.id = "10508825",
-		.drv_name = "adl_nau8825_def",
-		.sof_tplg_filename = "sof-adl-nau8825.tplg",
-	},
 	{
 		.comp_ids = &adl_rt5682_rt5682s_hp,
 		.drv_name = "adl_rt5682_def",
@@ -621,6 +579,16 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 		.quirk_data = &adl_max98360a_amp,
 		.sof_tplg_filename = "sof-adl-max98360a-da7219.tplg",
 	},
+	/* place boards for each headphone codec: sof driver will complete the
+	 * tplg name and machine driver will detect the amp type
+	 */
+	{
+		.id = NAU8825_ACPI_HID,
+		.drv_name = "adl_nau8825_def",
+		.sof_tplg_filename = "sof-adl", /* the tplg suffix is added at run time */
+		.tplg_quirk_mask = SND_SOC_ACPI_TPLG_INTEL_AMP_NAME |
+					SND_SOC_ACPI_TPLG_INTEL_CODEC_NAME,
+	},
 	/* place amp-only boards in the end of table */
 	{
 		.id = "CSC3541",
-- 
2.40.1

