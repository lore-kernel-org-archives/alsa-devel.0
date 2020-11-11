Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6229BC388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 21:37:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FA92087D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 21:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eWpseYGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FA92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 609621703;
	Wed, 11 Nov 2020 22:36:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 609621703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605130663;
	bh=k/nwMiB7ajs92UUFhRGALIDgoiMVSwgqy38d3HVfIpQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eWpseYGJ6eCmNjIH/GXkVwXSTGpzJG8pjbQPzUAKndgGOr9dbXF5dhXuulmkUBca1
	 KQQORPUZcXpggb/Ku3gDz1k1qjkHh/GndfqVgPCQJbQ7cWETKOwviDNYv/A9nQI7Ax
	 InOvWfsnLhF1+FM296DGv9ILCCaoi4gyVbez+/0g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0119CF804BC;
	Wed, 11 Nov 2020 22:36:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F18EF804BD; Wed, 11 Nov 2020 22:36:04 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0946F8020C
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 22:35:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0946F8020C
IronPort-SDR: ykVDqUsDk0wuiABTssl/88pmqZGCKuX1YqblzmX1Nv0LzcBKbDByFGBF65h5mQTBUOB7Rf8eDn
 hz/lIPuhCEgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="157237675"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; d="scan'208";a="157237675"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2020 13:35:48 -0800
IronPort-SDR: NykGh6Z9Dlm+W/O4Edm/0ZtRQ/JZiB7snn7cvd3KINI8LW7KWvjCkiCIR3XqZQc7PrLPV0eK91
 GPF1mNAPxRAA==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; d="scan'208";a="328266637"
Received: from cmurill1-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.130.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2020 13:35:47 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/4] ASoC: SOF: Intel: fix Kconfig punctuation and wording
Date: Wed, 11 Nov 2020 15:35:32 -0600
Message-Id: <20201111213533.149963-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111213533.149963-1-pierre-louis.bossart@linux.intel.com>
References: <20201111213533.149963-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Randy Dunlap <rdunlap@infradead.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Rander Wang <rander.wang@linux.intel.com>
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

From: Randy Dunlap <rdunlap@infradead.org>

Add periods at the end of sentences in help text.
Insert a "not" in one place.
Fix help text indentation.
Remove a duplicate "Intel(R)" in one place.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 62 ++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index d44acbabda5f..720dce5d7d1e 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -15,7 +15,7 @@ config SND_SOC_SOF_INTEL_ACPI
 	select SND_SOC_SOF_BROADWELL if SND_SOC_SOF_BROADWELL_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_INTEL_PCI
 	def_tristate SND_SOC_SOF_PCI
@@ -32,13 +32,13 @@ config SND_SOC_SOF_INTEL_PCI
 	select SND_SOC_SOF_ALDERLAKE   if SND_SOC_SOF_ALDERLAKE_SUPPORT
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_INTEL_HIFI_EP_IPC
 	tristate
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	tristate
@@ -46,7 +46,7 @@ config SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_INTEL_COMMON
 	tristate
@@ -56,7 +56,7 @@ config SND_SOC_SOF_INTEL_COMMON
 	select SND_SOC_ACPI if ACPI
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 if SND_SOC_SOF_INTEL_ACPI
 
@@ -73,7 +73,7 @@ config SND_SOC_SOF_BAYTRAIL_SUPPORT
 	  recommended for distros. At some point all legacy drivers will be
 	  deprecated but not before all userspace firmware/topology/UCM files
 	  are made available to downstream distros.
-	  Say Y if you want to enable SOF on Baytrail/Cherrytrail
+	  Say Y if you want to enable SOF on Baytrail/Cherrytrail.
 	  If unsure select "N".
 
 config SND_SOC_SOF_BAYTRAIL
@@ -81,7 +81,7 @@ config SND_SOC_SOF_BAYTRAIL
 	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_BROADWELL_SUPPORT
 	bool "SOF support for Broadwell"
@@ -92,11 +92,11 @@ config SND_SOC_SOF_BROADWELL_SUPPORT
 	  This option is mutually exclusive with the Haswell/Broadwell legacy
 	  driver. If you want to enable SOF on Broadwell you need to deselect
 	  the legacy driver first.
-	  SOF does fully support Broadwell yet, so this option is not
+	  SOF does not fully support Broadwell yet, so this option is not
 	  recommended for distros. At some point all legacy drivers will be
 	  deprecated but not before all userspace firmware/topology/UCM files
 	  are made available to downstream distros.
-	  Say Y if you want to enable SOF on Broadwell
+	  Say Y if you want to enable SOF on Broadwell.
 	  If unsure select "N".
 
 config SND_SOC_SOF_BROADWELL
@@ -105,7 +105,7 @@ config SND_SOC_SOF_BROADWELL
 	select SND_SOC_SOF_INTEL_HIFI_EP_IPC
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 endif ## SND_SOC_SOF_INTEL_ACPI
 
@@ -124,7 +124,7 @@ config SND_SOC_SOF_MERRIFIELD
 	select SND_SOC_SOF_INTEL_ATOM_HIFI_EP
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_APOLLOLAKE_SUPPORT
 	bool "SOF support for Apollolake"
@@ -139,7 +139,7 @@ config SND_SOC_SOF_APOLLOLAKE
 	select SND_SOC_SOF_HDA_COMMON
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_GEMINILAKE_SUPPORT
 	bool "SOF support for GeminiLake"
@@ -154,7 +154,7 @@ config SND_SOC_SOF_GEMINILAKE
 	select SND_SOC_SOF_HDA_COMMON
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_CANNONLAKE_SUPPORT
 	bool "SOF support for Cannonlake"
@@ -170,7 +170,7 @@ config SND_SOC_SOF_CANNONLAKE
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_COFFEELAKE_SUPPORT
 	bool "SOF support for CoffeeLake"
@@ -186,7 +186,7 @@ config SND_SOC_SOF_COFFEELAKE
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_ICELAKE_SUPPORT
 	bool "SOF support for Icelake"
@@ -202,7 +202,7 @@ config SND_SOC_SOF_ICELAKE
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_COMETLAKE
 	tristate
@@ -210,7 +210,7 @@ config SND_SOC_SOF_COMETLAKE
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_COMETLAKE_SUPPORT
 	bool
@@ -237,7 +237,7 @@ config SND_SOC_SOF_TIGERLAKE
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_ELKHARTLAKE_SUPPORT
 	bool "SOF support for ElkhartLake"
@@ -253,7 +253,7 @@ config SND_SOC_SOF_ELKHARTLAKE
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_JASPERLAKE_SUPPORT
 	bool "SOF support for JasperLake"
@@ -268,7 +268,7 @@ config SND_SOC_SOF_JASPERLAKE
 	select SND_SOC_SOF_HDA_COMMON
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_ALDERLAKE_SUPPORT
 	bool "SOF support for Alderlake"
@@ -291,7 +291,7 @@ config SND_SOC_SOF_HDA_COMMON
 	select SND_SOC_SOF_HDA_LINK_BASELINE
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 if SND_SOC_SOF_HDA_COMMON
 
@@ -301,7 +301,7 @@ config SND_SOC_SOF_HDA_LINK
 	select SND_SOC_SOF_PROBE_WORK_QUEUE
 	help
 	  This adds support for HDA links(HDA/HDMI) with Sound Open Firmware
-		  for Intel(R) platforms.
+	  for Intel(R) platforms.
 	  Say Y if you want to enable HDA links with SOF.
 	  If unsure select "N".
 
@@ -310,7 +310,7 @@ config SND_SOC_SOF_HDA_AUDIO_CODEC
 	depends on SND_SOC_SOF_HDA_LINK
 	help
 	  This adds support for HDAudio codecs with Sound Open Firmware
-		  for Intel(R) platforms.
+	  for Intel(R) platforms.
 	  Say Y if you want to enable HDAudio codecs with SOF.
 	  If unsure select "N".
 
@@ -318,8 +318,8 @@ config SND_SOC_SOF_HDA_PROBES
 	bool "SOF enable probes over HDA"
 	depends on SND_SOC_SOF_DEBUG_PROBES
 	help
-	  This option enables the data probing for Intel(R).
-		  Intel(R) Skylake and newer platforms.
+	  This option enables the data probing for Intel(R)
+	  Skylake and newer platforms.
 	  Say Y if you want to enable probes.
 	  If unsure, select "N".
 
@@ -330,7 +330,7 @@ config SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1
 	  and disables known workarounds for specific HDAudio platforms.
 	  Only use to look into power optimizations on platforms not
 	  affected by DMI L1 issues. This option is not recommended.
-	  Say Y if you want to enable DMI Link L1
+	  Say Y if you want to enable DMI Link L1.
 	  If unsure, select "N".
 
 endif ## SND_SOC_SOF_HDA_COMMON
@@ -340,7 +340,7 @@ config SND_SOC_SOF_HDA_LINK_BASELINE
 	select SND_SOC_SOF_HDA if SND_SOC_SOF_HDA_LINK
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_HDA
 	tristate
@@ -349,14 +349,14 @@ config SND_SOC_SOF_HDA
 	select SND_INTEL_DSP_CONFIG
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
 	bool "SOF support for SoundWire"
 	depends on SOUNDWIRE && ACPI
 	help
 	  This adds support for SoundWire with Sound Open Firmware
-		  for Intel(R) platforms.
+	  for Intel(R) platforms.
 	  Say Y if you want to enable SoundWire links with SOF.
 	  If unsure select "N".
 
@@ -365,14 +365,14 @@ config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	select SND_SOC_SOF_INTEL_SOUNDWIRE if SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE
 	tristate
 	select SOUNDWIRE_INTEL
 	help
 	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level
+	  'select' statements at a higher level.
 
 endif ## SND_SOC_SOF_INTEL_PCI
 
-- 
2.25.1

