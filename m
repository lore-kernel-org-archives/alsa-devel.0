Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19DFC3403D
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:45:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A7220801
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LJjQ2C6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A7220801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D75BA16A4;
	Tue, 18 Feb 2020 15:44:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D75BA16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582037132;
	bh=aQCBVW1AmTcqhv/zN18L832wkViEHEKiFFs5ISCPo/4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LJjQ2C6z6t+mKtIsCgc794PfpzF2acfSOFaKpzqV9iMi3TRGRTmyshFaft2bprihs
	 /eboTplnvM9dEp8sAurWu7oHodXMobvl806XOxjrLuDdgUaclSuOYzmr2gdv4c2p6g
	 C+FlI5NpiXMjnlPRZXkY+0AH9RjWk/XiWlRdK1M0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C814F802C2;
	Tue, 18 Feb 2020 15:40:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB51EF8028D; Tue, 18 Feb 2020 15:40:21 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AEED6F8025F
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 15:40:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AEED6F8025F
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 06:40:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; d="scan'208";a="235549873"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 06:40:11 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v5 7/9] ASoC: SOF: Intel: Probe compress operations
Date: Tue, 18 Feb 2020 15:39:22 +0100
Message-Id: <20200218143924.10565-8-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218143924.10565-1-cezary.rojewski@intel.com>
References: <20200218143924.10565-1-cezary.rojewski@intel.com>
Cc: pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com,
 tiwai@suse.com, vkoul@kernel.org, broonie@kernel.org
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

Add HDA handlers for soc_compr_ops and snd_compr_ops which cover probe
related operations. Implementation supports both connection purposes.
These merely define stream setups as core flow is covered by SOF
compress core.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

Changes in v5:
- Removed SND_SOC_SOF_HDA_LINK requirement for hda probes. Instead of
  sound/hda/ext, sof hda operations are used

Changes in v4:
- Reverted SND_SOC_SOF_HDA_LINK requirement-removal change for HDA probes.
  Code requires SND_HDA_EXT_CORE in order to function on Intel platforms

Changes in v2:
- probes over HDA no longer require SND_SOC_SOF_HDA_LINK enabled


 sound/soc/sof/intel/Kconfig        |   9 +++
 sound/soc/sof/intel/Makefile       |   1 +
 sound/soc/sof/intel/apl.c          |   9 +++
 sound/soc/sof/intel/cnl.c          |   9 +++
 sound/soc/sof/intel/hda-compress.c | 114 +++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda.h          |  24 ++++++
 6 files changed, 166 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-compress.c

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 56a837d2cb95..3bc64dee7c39 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -305,6 +305,15 @@ config SND_SOC_SOF_HDA_AUDIO_CODEC
 	  Say Y if you want to enable HDAudio codecs with SOF.
 	  If unsure select "N".
 
+config SND_SOC_SOF_HDA_PROBES
+	bool "SOF enable probes over HDA"
+	depends on SND_SOC_SOF_DEBUG_PROBES
+	help
+	  This option enables the data probing for Intel(R).
+		  Intel(R) Skylake and newer platforms.
+	  Say Y if you want to enable probes.
+	  If unsure, select "N".
+
 config SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1
 	bool "SOF enable DMI Link L1"
 	help
diff --git a/sound/soc/sof/intel/Makefile b/sound/soc/sof/intel/Makefile
index b8f58e006e29..cee02a2e00f4 100644
--- a/sound/soc/sof/intel/Makefile
+++ b/sound/soc/sof/intel/Makefile
@@ -9,6 +9,7 @@ snd-sof-intel-hda-common-objs := hda.o hda-loader.o hda-stream.o hda-trace.o \
 				 hda-dsp.o hda-ipc.o hda-ctrl.o hda-pcm.o \
 				 hda-dai.o hda-bus.o \
 				 apl.o cnl.o
+snd-sof-intel-hda-common-$(CONFIG_SND_SOC_SOF_HDA_PROBES) += hda-compress.o
 
 snd-sof-intel-hda-objs := hda-codec.o
 
diff --git a/sound/soc/sof/intel/apl.c b/sound/soc/sof/intel/apl.c
index 2483b15699e7..02218d22e51f 100644
--- a/sound/soc/sof/intel/apl.c
+++ b/sound/soc/sof/intel/apl.c
@@ -73,6 +73,15 @@ const struct snd_sof_dsp_ops sof_apl_ops = {
 	.pcm_trigger	= hda_dsp_pcm_trigger,
 	.pcm_pointer	= hda_dsp_pcm_pointer,
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_PROBES)
+	/* probe callbacks */
+	.probe_assign	= hda_probe_compr_assign,
+	.probe_free	= hda_probe_compr_free,
+	.probe_set_params	= hda_probe_compr_set_params,
+	.probe_trigger	= hda_probe_compr_trigger,
+	.probe_pointer	= hda_probe_compr_pointer,
+#endif
+
 	/* firmware loading */
 	.load_firmware = snd_sof_load_firmware_raw,
 
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 8a59fec72919..05125cb0be6e 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -284,6 +284,15 @@ const struct snd_sof_dsp_ops sof_cnl_ops = {
 	.pcm_trigger	= hda_dsp_pcm_trigger,
 	.pcm_pointer	= hda_dsp_pcm_pointer,
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_PROBES)
+	/* probe callbacks */
+	.probe_assign	= hda_probe_compr_assign,
+	.probe_free	= hda_probe_compr_free,
+	.probe_set_params	= hda_probe_compr_set_params,
+	.probe_trigger	= hda_probe_compr_trigger,
+	.probe_pointer	= hda_probe_compr_pointer,
+#endif
+
 	/* firmware loading */
 	.load_firmware = snd_sof_load_firmware_raw,
 
diff --git a/sound/soc/sof/intel/hda-compress.c b/sound/soc/sof/intel/hda-compress.c
new file mode 100644
index 000000000000..38a1ebec8478
--- /dev/null
+++ b/sound/soc/sof/intel/hda-compress.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2019-2020 Intel Corporation. All rights reserved.
+//
+// Author: Cezary Rojewski <cezary.rojewski@intel.com>
+//
+
+#include <sound/hdaudio_ext.h>
+#include <sound/soc.h>
+#include "../sof-priv.h"
+#include "hda.h"
+
+static inline struct hdac_ext_stream *
+hda_compr_get_stream(struct snd_compr_stream *cstream)
+{
+	return cstream->runtime->private_data;
+}
+
+int hda_probe_compr_assign(struct snd_sof_dev *sdev,
+			   struct snd_compr_stream *cstream,
+			   struct snd_soc_dai *dai)
+{
+	struct hdac_ext_stream *stream;
+
+	stream = hda_dsp_stream_get(sdev, cstream->direction);
+	if (!stream)
+		return -EBUSY;
+
+	hdac_stream(stream)->curr_pos = 0;
+	hdac_stream(stream)->cstream = cstream;
+	cstream->runtime->private_data = stream;
+
+	return hdac_stream(stream)->stream_tag;
+}
+
+int hda_probe_compr_free(struct snd_sof_dev *sdev,
+			 struct snd_compr_stream *cstream,
+			 struct snd_soc_dai *dai)
+{
+	struct hdac_ext_stream *stream = hda_compr_get_stream(cstream);
+	int ret;
+
+	ret = hda_dsp_stream_put(sdev, cstream->direction,
+				 hdac_stream(stream)->stream_tag);
+	if (ret < 0) {
+		dev_dbg(sdev->dev, "stream put failed: %d\n", ret);
+		return ret;
+	}
+
+	hdac_stream(stream)->cstream = NULL;
+	cstream->runtime->private_data = NULL;
+
+	return 0;
+}
+
+int hda_probe_compr_set_params(struct snd_sof_dev *sdev,
+			       struct snd_compr_stream *cstream,
+			       struct snd_compr_params *params,
+			       struct snd_soc_dai *dai)
+{
+	struct hdac_ext_stream *stream = hda_compr_get_stream(cstream);
+	struct hdac_stream *hstream = hdac_stream(stream);
+	struct snd_dma_buffer *dmab;
+	u32 bits, rate;
+	int bps, ret;
+
+	dmab = cstream->runtime->dma_buffer_p;
+	/* compr params do not store bit depth, default to S32_LE */
+	bps = snd_pcm_format_physical_width(SNDRV_PCM_FORMAT_S32_LE);
+	if (bps < 0)
+		return bps;
+	bits = hda_dsp_get_bits(sdev, bps);
+	rate = hda_dsp_get_mult_div(sdev, params->codec.sample_rate);
+
+	hstream->format_val = rate | bits | (params->codec.ch_out - 1);
+	hstream->bufsize = cstream->runtime->buffer_size;
+	hstream->period_bytes = cstream->runtime->fragment_size;
+	hstream->no_period_wakeup = 0;
+
+	ret = hda_dsp_stream_hw_params(sdev, stream, dmab, NULL);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: hdac prepare failed: %x\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+int hda_probe_compr_trigger(struct snd_sof_dev *sdev,
+			    struct snd_compr_stream *cstream, int cmd,
+			    struct snd_soc_dai *dai)
+{
+	struct hdac_ext_stream *stream = hda_compr_get_stream(cstream);
+
+	return hda_dsp_stream_trigger(sdev, stream, cmd);
+}
+
+int hda_probe_compr_pointer(struct snd_sof_dev *sdev,
+			    struct snd_compr_stream *cstream,
+			    struct snd_compr_tstamp *tstamp,
+			    struct snd_soc_dai *dai)
+{
+	struct hdac_ext_stream *stream = hda_compr_get_stream(cstream);
+	struct snd_soc_pcm_stream *pstream;
+
+	pstream = &dai->driver->capture;
+	tstamp->copied_total = hdac_stream(stream)->curr_pos;
+	tstamp->sampling_rate = snd_pcm_rate_bit_to_rate(pstream->rates);
+
+	return 0;
+}
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 2b5fde372790..ca44ecb76534 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -11,6 +11,7 @@
 #ifndef __SOF_INTEL_HDA_H
 #define __SOF_INTEL_HDA_H
 
+#include <sound/compress_driver.h>
 #include <sound/hda_codec.h>
 #include <sound/hdaudio_ext.h>
 #include "shim.h"
@@ -552,6 +553,29 @@ int hda_ipc_pcm_params(struct snd_sof_dev *sdev,
 		       struct snd_pcm_substream *substream,
 		       const struct sof_ipc_pcm_params_reply *reply);
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_PROBES)
+/*
+ * Probe Compress Operations.
+ */
+int hda_probe_compr_assign(struct snd_sof_dev *sdev,
+			   struct snd_compr_stream *cstream,
+			   struct snd_soc_dai *dai);
+int hda_probe_compr_free(struct snd_sof_dev *sdev,
+			 struct snd_compr_stream *cstream,
+			 struct snd_soc_dai *dai);
+int hda_probe_compr_set_params(struct snd_sof_dev *sdev,
+			       struct snd_compr_stream *cstream,
+			       struct snd_compr_params *params,
+			       struct snd_soc_dai *dai);
+int hda_probe_compr_trigger(struct snd_sof_dev *sdev,
+			    struct snd_compr_stream *cstream, int cmd,
+			    struct snd_soc_dai *dai);
+int hda_probe_compr_pointer(struct snd_sof_dev *sdev,
+			    struct snd_compr_stream *cstream,
+			    struct snd_compr_tstamp *tstamp,
+			    struct snd_soc_dai *dai);
+#endif
+
 /*
  * DSP IPC Operations.
  */
-- 
2.17.1

