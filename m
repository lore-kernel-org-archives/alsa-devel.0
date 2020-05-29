Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31B7C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 19:37:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FBC9208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 19:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MS7W5Ico"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FBC9208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B93F71786;
	Fri, 29 May 2020 21:37:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B93F71786
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590781070;
	bh=31NvR38vcQ4QqDTal8GiMLcICXrdaX6IgWIhTK77rPI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MS7W5IcoO/i+uzTfQyZoOG0yQY4xJvNUMU100sCrK+ct252/5YU3PGYA9C9vGgdit
	 cTTR723SmHNXSoYEFsMIwtBueGmror6v3WbMhBbcqbzVZM5Hu8L0DS5MCUEeMzDCzl
	 zBL0Hp69EMtMBYKett/w25pBgTrpr426o8bYsV3E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3AC7F8014E;
	Fri, 29 May 2020 21:36:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 43D00F80273; Fri, 29 May 2020 21:36:08 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E9B4F80107
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 21:36:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E9B4F80107
IronPort-SDR: H53aVvEB1jwyNTQuUEM1O0hs+OwpcBxFl3dSTVT0Nz1xv4vyon70hx5nHEqpAnyenIpoX3kV1e
 5/J46MHi9iXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 12:35:52 -0700
IronPort-SDR: IMzTlnNIKUa0mojOxb+2iEuf1QHYLbGgOHWd45y6TAtAKBH2fpG06Ty0TvnPeoV/cx9WQczWhD
 ynFrPD/DrNvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; d="scan'208";a="469605868"
Received: from jbrayton-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.97.254])
 by fmsmga006.fm.intel.com with ESMTP; 29 May 2020 12:35:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 1/3] ASoC: intel: add depends on
 SND_SOC_SOF_HDA_AUDIO_CODEC for common hdmi
Date: Fri, 29 May 2020 14:35:45 -0500
Message-Id: <20200529193547.6077-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200529193547.6077-1-pierre-louis.bossart@linux.intel.com>
References: <20200529193547.6077-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Libin Yang <libin.yang@linux.intel.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Libin Yang <libin.yang@linux.intel.com>

If the driver uses common hdmi, SND_SOC_SOF_HDA_AUDIO_CODEC is required
to be enabled. Otherwise, the legacy hda codec driver will not be used.

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 46073c04364a..a2a5798c9139 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -411,13 +411,13 @@ config SND_SOC_INTEL_KBL_RT5660_MACH
 
 endif ## SND_SOC_INTEL_KBL
 
-if SND_SOC_SOF_GEMINILAKE  && SND_SOC_SOF_HDA_LINK
+if SND_SOC_SOF_GEMINILAKE
 
 config SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH
 	tristate "GLK with DA7219 and MAX98357A in I2S Mode"
 	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
-	depends on SND_HDA_CODEC_HDMI
+	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
 	select SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON
 	help
 	   This adds support for ASoC machine driver for Geminilake platforms
@@ -429,7 +429,7 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	tristate "GLK with RT5682 and MAX98357A in I2S Mode"
 	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
-	depends on SND_HDA_CODEC_HDMI
+	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_MAX98357A
 	select SND_SOC_DMIC
@@ -440,7 +440,7 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	   Say Y if you have such a device.
 	   If unsure select "N".
 
-endif ## SND_SOC_SOF_GEMINILAKE  && SND_SOC_SOF_HDA_LINK
+endif ## SND_SOC_SOF_GEMINILAKE
 
 if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC
 
@@ -463,9 +463,9 @@ if SND_SOC_SOF_HDA_LINK || SND_SOC_SOF_BAYTRAIL
 config SND_SOC_INTEL_SOF_RT5682_MACH
 	tristate "SOF with rt5682 codec in I2S Mode"
 	depends on I2C && ACPI && GPIOLIB
-	depends on (SND_SOC_SOF_HDA_LINK && (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
+	depends on ((SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC) &&\
+		    (MFD_INTEL_LPSS || COMPILE_TEST)) ||\
 		   (SND_SOC_SOF_BAYTRAIL && (X86_INTEL_LPSS || COMPILE_TEST))
-	depends on SND_HDA_CODEC_HDMI
 	select SND_SOC_MAX98373
 	select SND_SOC_RT1015
 	select SND_SOC_RT5682_I2C
@@ -509,7 +509,7 @@ config SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH
 	tristate "CML with RT1011 and RT5682 in I2S Mode"
 	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
-	depends on SND_HDA_CODEC_HDMI
+	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
 	select SND_SOC_RT1011
 	select SND_SOC_RT5682_I2C
 	select SND_SOC_DMIC
@@ -528,7 +528,7 @@ config SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH
 	tristate "SOF with DA7219 and MAX98373/MAX98360A in I2S Mode"
 	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
-	depends on SND_HDA_CODEC_HDMI
+	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
 	select SND_SOC_DA7219
 	select SND_SOC_MAX98373
 	select SND_SOC_DMIC
@@ -546,7 +546,7 @@ config SND_SOC_INTEL_EHL_RT5660_MACH
 	tristate "EHL with RT5660 in I2S mode"
 	depends on I2C && ACPI && GPIOLIB
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
-	depends on SND_HDA_CODEC_HDMI
+	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
 	select SND_SOC_RT5660
 	select SND_SOC_DMIC
 	help
@@ -563,7 +563,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	depends on MFD_INTEL_LPSS || COMPILE_TEST
 	depends on SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES || COMPILE_TEST
 	depends on SOUNDWIRE
-	depends on SND_HDA_CODEC_HDMI
+	depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
 	select SND_SOC_RT700_SDW
 	select SND_SOC_RT711_SDW
 	select SND_SOC_RT1308_SDW
-- 
2.20.1

