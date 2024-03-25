Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB41C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Mar 2024 22:17:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47FB423D3;
	Mon, 25 Mar 2024 23:17:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47FB423D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711405049;
	bh=gQL3YXeDyA5WniIBUY3v0SIELfeKyoQhHUp8fHkCRPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=p1WC9jPS/h6xH5VAi07rtR/3FrlEwx0Pcs8BU7rXyF03Fo9QdviaI2wiq+FBDLGxX
	 giHCC8soiyrTUXJScNYCg/IT6o+zkQI4bMhSUWkZy+yZq+e0PouTufZBkifnrqJrjI
	 fwkAA3Grux/JysswHCRc6Nm01DmT5AWcm5oY3yzM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 164A6F8058C; Mon, 25 Mar 2024 23:12:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CD36F896F8;
	Mon, 25 Mar 2024 23:12:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A14EF805BF; Mon, 25 Mar 2024 23:12:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60653F805C6
	for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2024 23:11:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60653F805C6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P7YLjql7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711404694; x=1742940694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQL3YXeDyA5WniIBUY3v0SIELfeKyoQhHUp8fHkCRPY=;
  b=P7YLjql7rDqOqw61Vm+B7SE1j+OgLmQRxlBbXj4z8ZcgnHOAMz5gRWB5
   3SBDiszw9cW/rmQNR9EnEEXwFve5xgwpzyl/rFcrvZNY4oztiMOArakZE
   1iqj5U56/u4CJf+mqarsV2/OIU9NP9vtwYkrIUvfFO+aQdEgHjRVXGlS1
   p3UKuOJ/PPzf17CR6tJQ32EUD3KZh15gmqFVIAB0GZu5cpiGvHQrkMHW7
   W9mpp5iOQIuK/yMT667V1+/xeToDDGZxh/viX+3nmlX/W4rGg1ljR0+Wr
   TwsPI8Q7zI+L+KJcuTN3Wf/E81aFx/LignnmF+7ZCjNxfUscS7Zl8i2dF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6643692"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000";
   d="scan'208";a="6643692"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000";
   d="scan'208";a="15722182"
Received: from jaimbres-mobl2.amr.corp.intel.com (HELO pbossart-mobl6.lan)
 ([10.212.98.109])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 15:11:27 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Brent Lu <brent.lu@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 20/21] ASoC: Intel: sof_nau8825: remove sof_nau8825 board id
Date: Mon, 25 Mar 2024 17:10:58 -0500
Message-Id: <20240325221059.206042-21-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325221059.206042-1-pierre-louis.bossart@linux.intel.com>
References: <20240325221059.206042-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: I6DRVJWXJOIAYG7W5FWQFRTISYOW2RJZ
X-Message-ID-Hash: I6DRVJWXJOIAYG7W5FWQFRTISYOW2RJZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I6DRVJWXJOIAYG7W5FWQFRTISYOW2RJZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Brent Lu <brent.lu@intel.com>

Remove sof_nau8825 board id and use adl_nau8825_def instead since SSP
port assignment is the same.

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Brent Lu <brent.lu@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_nau8825.c              | 14 +++-----------
 sound/soc/intel/common/soc-acpi-intel-adl-match.c |  2 +-
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/boards/sof_nau8825.c b/sound/soc/intel/boards/sof_nau8825.c
index b9db6e236a93..23fe8b4015cc 100644
--- a/sound/soc/intel/boards/sof_nau8825.c
+++ b/sound/soc/intel/boards/sof_nau8825.c
@@ -271,10 +271,10 @@ static int sof_audio_probe(struct platform_device *pdev)
 	case CODEC_RT1015P:
 		sof_rt1015p_codec_conf(&sof_audio_card_nau8825);
 		break;
+	case CODEC_MAX98360A:
+	case CODEC_NAU8318:
+	case CODEC_RT1019P:
 	case CODEC_NONE:
-	case CODEC_MAX98360A:
-	case CODEC_NAU8318:
-	case CODEC_RT1019P:
 		/* no codec conf required */
 		break;
 	default:
@@ -297,14 +297,6 @@ static int sof_audio_probe(struct platform_device *pdev)
 }
 
 static const struct platform_device_id board_ids[] = {
-	{
-		.name = "sof_nau8825",
-		.driver_data = (kernel_ulong_t)(SOF_SSP_PORT_CODEC(0) |
-					SOF_NUM_IDISP_HDMI(4) |
-					SOF_SSP_PORT_BT_OFFLOAD(2) |
-					SOF_BT_OFFLOAD_PRESENT),
-
-	},
 	{
 		.name = "adl_rt1019p_8825",
 		.driver_data = (kernel_ulong_t)(SOF_SSP_PORT_CODEC(0) |
diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 6c710e9a26f1..7ce8aade07d7 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -563,7 +563,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
 	},
 	{
 		.id = "10508825",
-		.drv_name = "sof_nau8825",
+		.drv_name = "adl_nau8825_def",
 		.sof_tplg_filename = "sof-adl-nau8825.tplg",
 	},
 	{
-- 
2.40.1

