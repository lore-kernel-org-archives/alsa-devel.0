Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7891C43463
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:05:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE7320719
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tjQ6SD54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE7320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2BE216C1;
	Mon, 21 Sep 2020 14:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2BE216C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600689940;
	bh=AA9eZtvjtvLyMhjI5WztkXpysF+nOXqQoEmmQCVIbF4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjQ6SD54Z18DoYCWMa8GAnpL7/17blFeuujSYWhOsVpsRGI739Fg+VdDzYlPol7jU
	 Puo3gPcMxWZPRxvok9Yh9ce2NiB7kXgLqONknKauMjPNBjIm4Hyrk2eNKMMDsWDSJi
	 f4pPHkcfNUfDhDeyGjkux8xZVm/L4rItXS4ZZTr4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D0D7F80368;
	Mon, 21 Sep 2020 13:56:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51F81F80369; Mon, 21 Sep 2020 13:56:47 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E280F8035F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 13:56:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E280F8035F
IronPort-SDR: sDI9PReEcUcpORAD3CSEZsZ8DSSLPEOijqdHXkI0Ga3bSX1V/lEJPUNzv7bimCcs7LURvDc+GJ
 egK3PlJSFGfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="159657341"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="159657341"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 04:56:39 -0700
IronPort-SDR: 5Yme8YrE4QdR9l01RSrRCCPzw7DYbR7xx1vRynxcrs/VJwbcECAfbJBT7daK4S8U+Foad81PZY
 lMu4A45ZyYlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; d="scan'208";a="304486541"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga003.jf.intel.com with ESMTP; 21 Sep 2020 04:56:35 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v7 14/14] ASoC: Intel: Select catpt and deprecate haswell
Date: Mon, 21 Sep 2020 13:54:24 +0200
Message-Id: <20200921115424.4105-15-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921115424.4105-1-cezary.rojewski@intel.com>
References: <20200921115424.4105-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, andriy.shevchenko@linux.intel.com,
 filip.kaczmarski@intel.com, harshapriya.n@intel.com,
 gregkh@linuxfoundation.org, marcin.barlik@intel.com, zwisler@google.com,
 lgirdwood@gmail.com, tiwai@suse.com, filip.proborszcz@intel.com,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 michal.wasko@intel.com, cujomalainey@chromium.org,
 krzysztof.hejmowski@intel.com, ppapierkowski@habana.ai,
 vamshi.krishna.gopal@intel.com
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

Prevent sound/soc/intel/haswell code compile and select catpt instead as
a recommended solution. Userspace-exposed members are compatible with
what is exposed by deprecated solution thus no harm is done. The only
visible difference is the newly added 'Loopback Mute' kcontrol.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

Changes in v7:
- patch: 10/14 'ASoC: Intel: Select catpt and deprecate haswell' has
  been moved to the back of the list: enable catpt after machine boards
  have been prepared for it first

Changes in v5:
- remove DMADEVICES depends on: DW_DMAC_CORE already covers that
- add optional COMPILE_TEST depends on

 sound/soc/intel/Kconfig        | 24 ++++++++++++------------
 sound/soc/intel/Makefile       |  2 +-
 sound/soc/intel/boards/Kconfig |  8 ++++----
 sound/soc/intel/catpt/Makefile |  6 ++++++
 4 files changed, 23 insertions(+), 17 deletions(-)
 create mode 100644 sound/soc/intel/catpt/Makefile

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0e48c4f532ce..dfc20f2bb859 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -47,21 +47,21 @@ config SND_SOC_INTEL_SST_FIRMWARE
 	# Haswell/Broadwell/Baytrail legacy and will be set
 	# when these platforms are enabled
 
-config SND_SOC_INTEL_HASWELL
-	tristate "Haswell/Broadwell Platforms"
+config SND_SOC_INTEL_CATPT
+	tristate "Haswell and Broadwell"
+	depends on ACPI || COMPILE_TEST
 	depends on SND_DMA_SGBUF
-	depends on DMADEVICES && ACPI
-	select SND_SOC_INTEL_SST
-	select SND_SOC_INTEL_SST_ACPI
-	select SND_SOC_INTEL_SST_FIRMWARE
+	select DW_DMAC_CORE
 	select SND_SOC_ACPI_INTEL_MATCH
 	help
-	  If you have a Intel Haswell or Broadwell platform connected to
-	  an I2S codec, then enable this option by saying Y or m. This is
-	  typically used for Chromebooks. This is a recommended option.
-	  This option is mutually exclusive with the SOF support on
-	  Broadwell. If you want to enable SOF on Broadwell, you need to
-	  deselect this option first.
+	  Enable support for Intel(R) Haswell and Broadwell platforms
+	  with I2S codec present. This is a recommended option.
+	  Say Y or m if you have such device.
+	  If unsure, say N.
+
+config SND_SOC_INTEL_HASWELL
+	tristate
+	select SND_SOC_INTEL_CATPT
 
 config SND_SOC_INTEL_BAYTRAIL
 	tristate "Baytrail (legacy) Platforms"
diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 04ee48204fc9..c88c615f85f7 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -3,9 +3,9 @@
 obj-$(CONFIG_SND_SOC) += common/
 
 # Platform Support
-obj-$(CONFIG_SND_SOC_INTEL_HASWELL) += haswell/
 obj-$(CONFIG_SND_SOC_INTEL_BAYTRAIL) += baytrail/
 obj-$(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM) += atom/
+obj-$(CONFIG_SND_SOC_INTEL_CATPT) += catpt/
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += skylake/
 obj-$(CONFIG_SND_SOC_INTEL_KEEMBAY) += keembay/
 
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 12dd41796e82..6afdd9ac4478 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -26,7 +26,7 @@ config SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES
 	  interface.
 	  If unsure select N.
 
-if SND_SOC_INTEL_HASWELL
+if SND_SOC_INTEL_CATPT
 
 config SND_SOC_INTEL_HASWELL_MACH
 	tristate "Haswell Lynxpoint"
@@ -40,9 +40,9 @@ config SND_SOC_INTEL_HASWELL_MACH
 	  Say Y or m if you have such a device.
 	  If unsure select "N".
 
-endif ## SND_SOC_INTEL_HASWELL
+endif ## SND_SOC_INTEL_CATPT
 
-if SND_SOC_INTEL_HASWELL || SND_SOC_SOF_BROADWELL
+if SND_SOC_INTEL_CATPT || SND_SOC_SOF_BROADWELL
 
 config SND_SOC_INTEL_BDW_RT5650_MACH
 	tristate "Broadwell with RT5650 codec"
@@ -83,7 +83,7 @@ config SND_SOC_INTEL_BROADWELL_MACH
 	  Ultrabook platforms.
 	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
-endif ## SND_SOC_INTEL_HASWELL || SND_SOC_SOF_BROADWELL
+endif ## SND_SOC_INTEL_CATPT || SND_SOC_SOF_BROADWELL
 
 if SND_SOC_INTEL_BAYTRAIL
 
diff --git a/sound/soc/intel/catpt/Makefile b/sound/soc/intel/catpt/Makefile
new file mode 100644
index 000000000000..c393a45795da
--- /dev/null
+++ b/sound/soc/intel/catpt/Makefile
@@ -0,0 +1,6 @@
+snd-soc-catpt-objs := device.o dsp.o loader.o ipc.o messages.o pcm.o sysfs.o
+
+# tell define_trace.h where to find the trace header
+CFLAGS_device.o := -I$(src)
+
+obj-$(CONFIG_SND_SOC_INTEL_CATPT) += snd-soc-catpt.o
-- 
2.17.1

