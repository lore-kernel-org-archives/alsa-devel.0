Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408BDCA9EB9
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:17:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AD120663
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SBbr54DC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AD120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E97F61671;
	Wed, 23 Oct 2019 23:16:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E97F61671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571865426;
	bh=zKHLuqekawIgQ8tI+n58AZQLe2MZPIAhcIGCDdVWdqk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SBbr54DCQgAj5rCpGe07O97ydf4GLopI9jEI4aeJXDNfeXFQ6mGkTfo65g/kyOVOj
	 dwPbUC3oA86NuuSfMUlxQk12KHCwRw/H0f9x2eiGE/kOrHak+2PinmYkym13t2N/8E
	 j80NmiXv5tLiJY5kG1oaUZgCaajREGrO9jK3ZnA4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93C96F80112;
	Wed, 23 Oct 2019 23:15:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DDCA4F805FD; Wed, 23 Oct 2019 23:15:35 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2A68F805E2
 for <alsa-devel@alsa-project.org>; Wed, 23 Oct 2019 23:15:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2A68F805E2
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 14:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; d="scan'208";a="373003416"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.254.95.208])
 by orsmga005.jf.intel.com with ESMTP; 23 Oct 2019 14:15:28 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 23 Oct 2019 16:15:00 -0500
Message-Id: <20191023211504.32675-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
References: <20191023211504.32675-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>,
 Keyon Jie <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 srinivas.kandagatla@linaro.org, jank@cadence.com,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 YueHaibing <yuehaibing@huawei.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
 broonie@kernel.org, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, gregkh@linuxfoundation.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, slawomir.blauciak@intel.com
Subject: [alsa-devel] [PATCH 1/5] ASoC: SOF: Intel: add SoundWire
	configuration interface
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Now that the SoundWire core supports the multi-step initialization,
call the relevant APIs.

The actual hardware enablement can be done in two places, ideally we'd
want to startup the SoundWire IP as soon as possible (while still
taking power rail dependencies into account)

However when suspend/resume is implemented, the DSP device will be
resumed first, and only when the DSP firmware is downloaded/booted
would the SoundWire child devices be resumed, so there are only
marginal benefits in starting the IP earlier for the first probe.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c |  13 ++++
 sound/soc/sof/intel/hda.c        | 121 ++++++++++++++++++++++++++++++-
 sound/soc/sof/intel/hda.h        |  44 +++++++++++
 3 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index b1783360fe10..2f5cd2c1ea3c 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -397,6 +397,19 @@ int hda_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 /* post fw run operations */
 int hda_dsp_post_fw_run(struct snd_sof_dev *sdev)
 {
+	int ret;
+
+	if (sdev->first_boot) {
+		ret = hda_sdw_startup(sdev);
+		if (ret < 0) {
+			dev_err(sdev->dev,
+				"error: could not startup SoundWire links\n");
+			return ret;
+		}
+	}
+
+	hda_sdw_int_enable(sdev, true);
+
 	/* re-enable clock gating and power gating */
 	return hda_dsp_ctrl_clock_power_gating(sdev, true);
 }
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 103f4273c4d3..7e36f3bd6b39 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -18,7 +18,9 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_register.h>
 
+#include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/soundwire/sdw_intel.h>
 #include <sound/intel-nhlt.h>
 #include <sound/sof.h>
 #include <sound/sof/xtensa.h>
@@ -34,6 +36,98 @@
 
 #define EXCEPT_MAX_HDR_SIZE	0x400
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
+
+void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+{
+	sdw_intel_enable_irq(sdev->bar[HDA_DSP_BAR], enable);
+}
+
+static int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	acpi_handle handle;
+	int ret;
+
+	handle = ACPI_HANDLE(sdev->dev);
+
+	/* save ACPI info for the probe step */
+	hdev = sdev->pdata->hw_pdata;
+
+	ret = sdw_intel_acpi_scan(handle, &hdev->info);
+	if (ret < 0) {
+		dev_err(sdev->dev, "%s failed\n", __func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hda_sdw_probe(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+	struct sdw_intel_res res;
+	acpi_handle handle;
+	void *sdw;
+
+	handle = ACPI_HANDLE(sdev->dev);
+
+	hdev = sdev->pdata->hw_pdata;
+
+	memset(&res, 0, sizeof(res));
+
+	res.mmio_base = sdev->bar[HDA_DSP_BAR];
+	res.irq = sdev->ipc_irq;
+	res.handle = hdev->info.handle;
+	res.parent = sdev->dev;
+
+	/*
+	 * ops and arg fields are not populated for now,
+	 * they will be needed when the DAI callbacks are
+	 * provided
+	 */
+
+	/* we could filter links here if needed, e.g for quirks */
+	res.count = hdev->info.count;
+	res.link_mask = hdev->info.link_mask;
+
+	sdw = sdw_intel_probe(&res);
+	if (!sdw) {
+		dev_err(sdev->dev, "error: SoundWire probe failed\n");
+		return -EINVAL;
+	}
+
+	/* save context */
+	hdev->sdw = sdw;
+
+	return 0;
+}
+
+int hda_sdw_startup(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+
+	hdev = sdev->pdata->hw_pdata;
+
+	return sdw_intel_startup(hdev->sdw);
+}
+
+static int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	struct sof_intel_hda_dev *hdev;
+
+	hdev = sdev->pdata->hw_pdata;
+
+	hda_sdw_int_enable(sdev, false);
+
+	if (hdev->sdw)
+		sdw_intel_exit(hdev->sdw);
+	hdev->sdw = NULL;
+
+	return 0;
+}
+#endif
+
 /*
  * Debug
  */
@@ -337,11 +431,11 @@ static const char *fixup_tplg_name(struct snd_sof_dev *sdev,
 static int hda_init_caps(struct snd_sof_dev *sdev)
 {
 	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct snd_sof_pdata *pdata = sdev->pdata;
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	struct hdac_ext_link *hlink;
 	struct snd_soc_acpi_mach_params *mach_params;
 	struct snd_soc_acpi_mach *hda_mach;
-	struct snd_sof_pdata *pdata = sdev->pdata;
 	struct snd_soc_acpi_mach *mach;
 	const char *tplg_filename;
 	const char *idisp_str;
@@ -350,6 +444,8 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 	int codec_num = 0;
 	int i;
 #endif
+	struct sof_intel_hda_dev *hdev = pdata->hw_pdata;
+	u32 link_mask;
 	int ret = 0;
 
 	device_disable_async_suspend(bus->dev);
@@ -378,6 +474,27 @@ static int hda_init_caps(struct snd_sof_dev *sdev)
 		return ret;
 	}
 
+	/* scan SoundWire capabilities exposed by DSDT */
+	ret = hda_sdw_acpi_scan(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire ACPI scan error\n");
+		return ret;
+	}
+
+	link_mask = hdev->info.link_mask;
+	if (!link_mask) {
+		/*
+		 * probe/allocated SoundWire resources.
+		 * The hardware configuration takes place in hda_sdw_startup
+		 * after power rails are enabled.
+		 */
+		ret = hda_sdw_probe(sdev);
+		if (ret < 0) {
+			dev_err(sdev->dev, "error: SoundWire probe error\n");
+			return ret;
+		}
+	}
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 	if (bus->mlcap)
 		snd_hdac_ext_bus_get_ml_capabilities(bus);
@@ -682,6 +799,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	snd_hdac_ext_bus_device_remove(bus);
 #endif
 
+	hda_sdw_exit(sdev);
+
 	if (!IS_ERR_OR_NULL(hda->dmic_dev))
 		platform_device_unregister(hda->dmic_dev);
 
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 0e7c366b8f71..e63630f5c547 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -11,6 +11,8 @@
 #ifndef __SOF_INTEL_HDA_H
 #define __SOF_INTEL_HDA_H
 
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_intel.h>
 #include <sound/hda_codec.h>
 #include <sound/hdaudio_ext.h>
 #include "shim.h"
@@ -408,6 +410,12 @@ struct sof_intel_hda_dev {
 
 	/* DMIC device */
 	struct platform_device *dmic_dev;
+
+	/* ACPI information stored between scan and probe steps */
+	struct sdw_intel_acpi_info info;
+
+	/* sdw context allocated by SoundWire driver */
+	struct sdw_intel_ctx *sdw;
 };
 
 static inline struct hdac_bus *sof_to_bus(struct snd_sof_dev *s)
@@ -598,6 +606,42 @@ int hda_dsp_trace_init(struct snd_sof_dev *sdev, u32 *stream_tag);
 int hda_dsp_trace_release(struct snd_sof_dev *sdev);
 int hda_dsp_trace_trigger(struct snd_sof_dev *sdev, int cmd);
 
+/*
+ * SoundWire support
+ */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
+
+int hda_sdw_startup(struct snd_sof_dev *sdev);
+void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable);
+
+#else
+
+static inline int hda_sdw_acpi_scan(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_probe(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_startup(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline int hda_sdw_exit(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static inline void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
+{
+}
+
+#endif
+
 /* common dai driver */
 extern struct snd_soc_dai_driver skl_dai[];
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
