Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4B8ECAAA1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Oct 2022 19:38:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B31F92DD2;
	Thu, 27 Oct 2022 21:37:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B31F92DD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666899524;
	bh=EYxmHDedQOVkFJKx2sulQeNstXHm6+z/yml1059+PQY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2czqvlZbaJ8YaWBwzuGQAn1Gpn/QT0Y+MYPbI0isn5X+s+3kceE/EVJoH8V0eNIy
	 2jHIyrqr7McO4YL+pNUeSmeT62Kn64Rc0VCcXbSNj0UmTky7DAKDnIypy+UNIz+rMV
	 QBIS2ewtJQ1kxEfzpZa1Wjei1iMBHZ4g58rkJwYM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0DEC8F80100;
	Thu, 27 Oct 2022 21:36:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0DA8F80578; Thu, 27 Oct 2022 21:36:21 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A2732F8025A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 21:36:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2732F8025A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="lV83VELV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666899373; x=1698435373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EYxmHDedQOVkFJKx2sulQeNstXHm6+z/yml1059+PQY=;
 b=lV83VELVL2Zgod0lWCk43D4fLErBrT8cu/nhQOiwsMMNocTM5RGr7LMg
 PSkEeOU5qL+Scvt+gHckziFcO5sE4+TzVC/JvoUTP7ZuY7NjU5T/1ZB9Z
 KWVMrAJF2XE1SM6B9LjiB+XfDvFbGVzi27wc1uKpnWJvAtx713p4Eg1ub
 3TFaxU/UNO0xojqIjLHSfAVUHU21ygjo7pT/faX8uPvgqhyBGW0HY4Vdr
 +0g3IjDAo7S0Z11pylcbUAMSmyp+4JORqmqiOWGqqXUy325BoiUuHSXAO
 dDvkWgXnTqzlRSj2AxJrf6OFi2T8Qgf9v3RGPpQVkspUbbavx5i4C/3jt A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="334957824"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; d="scan'208";a="334957824"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2022 12:36:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="632526993"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; d="scan'208";a="632526993"
Received: from vmehta-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.6.254])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2022 12:36:10 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/21] ASoC: SOF: Intel: move all RIRB/CMD_IO helpers to
 hda-codec.c
Date: Thu, 27 Oct 2022 15:35:26 -0400
Message-Id: <20221027193540.259520-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221027193540.259520-1-pierre-louis.bossart@linux.intel.com>
References: <20221027193540.259520-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

We need to split basic stream functionality from RIRB/CORB, which are
completely codec-related.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-codec.c | 43 +++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/hda-ctrl.c  | 33 +++----------------------
 sound/soc/sof/intel/hda.h       |  6 +++++
 3 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index c493d5664475..e04a350dd52c 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -24,6 +24,10 @@
 
 #define IDISP_VID_INTEL	0x80860000
 
+static int hda_codec_mask = -1;
+module_param_named(codec_mask, hda_codec_mask, int, 0444);
+MODULE_PARM_DESC(codec_mask, "SOF HDA codec mask for probing");
+
 /* load the legacy HDA codec driver */
 static int request_codec_module(struct hda_codec *codec)
 {
@@ -229,6 +233,45 @@ void hda_codec_check_for_state_change(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_check_for_state_change, SND_SOC_SOF_HDA_AUDIO_CODEC);
 
+void hda_codec_detect_mask(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+
+	/* Accept unsolicited responses */
+	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, AZX_GCTL_UNSOL);
+
+	/* detect codecs */
+	if (!bus->codec_mask) {
+		bus->codec_mask = snd_hdac_chip_readw(bus, STATESTS);
+		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", bus->codec_mask);
+	}
+
+	if (hda_codec_mask != -1) {
+		bus->codec_mask &= hda_codec_mask;
+		dev_dbg(bus->dev, "filtered codec_mask = 0x%lx\n",
+			bus->codec_mask);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(hda_codec_detect_mask, SND_SOC_SOF_HDA_AUDIO_CODEC);
+
+void hda_codec_init_cmd_io(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+
+	/* initialize the codec command I/O */
+	snd_hdac_bus_init_cmd_io(bus);
+}
+EXPORT_SYMBOL_NS_GPL(hda_codec_init_cmd_io, SND_SOC_SOF_HDA_AUDIO_CODEC);
+
+void hda_codec_rirb_status_clear(struct snd_sof_dev *sdev)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+
+	/* clear rirb status */
+	snd_hdac_chip_writeb(bus, RIRBSTS, RIRB_INT_MASK);
+}
+EXPORT_SYMBOL_NS_GPL(hda_codec_rirb_status_clear, SND_SOC_SOF_HDA_AUDIO_CODEC);
+
 #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC) && IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 449e1e93505e..e65562618ab8 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -22,12 +22,6 @@
 #include "../ops.h"
 #include "hda.h"
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-static int hda_codec_mask = -1;
-module_param_named(codec_mask, hda_codec_mask, int, 0444);
-MODULE_PARM_DESC(codec_mask, "SOF HDA codec mask for probing");
-#endif
-
 /*
  * HDA Operations.
  */
@@ -210,22 +204,7 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev)
 		goto err;
 	}
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* Accept unsolicited responses */
-	snd_hdac_chip_updatel(bus, GCTL, AZX_GCTL_UNSOL, AZX_GCTL_UNSOL);
-
-	/* detect codecs */
-	if (!bus->codec_mask) {
-		bus->codec_mask = snd_hdac_chip_readw(bus, STATESTS);
-		dev_dbg(bus->dev, "codec_mask = 0x%lx\n", bus->codec_mask);
-	}
-
-	if (hda_codec_mask != -1) {
-		bus->codec_mask &= hda_codec_mask;
-		dev_dbg(bus->dev, "filtered codec_mask = 0x%lx\n",
-			bus->codec_mask);
-	}
-#endif
+	hda_codec_detect_mask(sdev);
 
 	/* clear stream status */
 	list_for_each_entry(stream, &bus->stream_list, list) {
@@ -239,19 +218,13 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev)
 	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_WAKESTS,
 			  SOF_HDA_WAKESTS_INT_MASK);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* clear rirb status */
-	snd_hdac_chip_writeb(bus, RIRBSTS, RIRB_INT_MASK);
-#endif
+	hda_codec_rirb_status_clear(sdev);
 
 	/* clear interrupt status register */
 	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTSTS,
 			  SOF_HDA_INT_CTRL_EN | SOF_HDA_INT_ALL_STREAM);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	/* initialize the codec command I/O */
-	snd_hdac_bus_init_cmd_io(bus);
-#endif
+	hda_codec_init_cmd_io(sdev);
 
 	/* enable CIE and GIE interrupts */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index a82b17596a27..d43af8c5f483 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -718,6 +718,9 @@ void hda_codec_probe_bus(struct snd_sof_dev *sdev);
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable);
 void hda_codec_jack_check(struct snd_sof_dev *sdev);
 void hda_codec_check_for_state_change(struct snd_sof_dev *sdev);
+void hda_codec_init_cmd_io(struct snd_sof_dev *sdev);
+void hda_codec_detect_mask(struct snd_sof_dev *sdev);
+void hda_codec_rirb_status_clear(struct snd_sof_dev *sdev);
 
 #else
 
@@ -725,6 +728,9 @@ static inline void hda_codec_probe_bus(struct snd_sof_dev *sdev) { }
 static inline void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev, bool enable) { }
 static inline void hda_codec_jack_check(struct snd_sof_dev *sdev) { }
 static inline void hda_codec_check_for_state_change(struct snd_sof_dev *sdev) { }
+static inline void hda_codec_init_cmd_io(struct snd_sof_dev *sdev) { }
+static inline void hda_codec_detect_mask(struct snd_sof_dev *sdev) { }
+static inline void hda_codec_rirb_status_clear(struct snd_sof_dev *sdev) { }
 
 #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 
-- 
2.34.1

