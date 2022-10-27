Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB98ECAAA1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Oct 2022 19:41:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 62EC12D0E;
	Thu, 27 Oct 2022 21:40:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 62EC12D0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666899678;
	bh=oh9GwDEXGDl40MOU2ehkI97ifbWQpll98R0058EUd7U=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sk/RAPfAaq5XFeoFOlf0QXNipCCncl/dUIilT5FoABdWSnaOJ9fVNH+QhFBxe4MBh
	 LJROjTD6QfJbZU4/OMsoJc+2SP8IETXEgY+yZVaf4E4Eda3tehF7Dwfxx8ly20Zd3r
	 BbZoCpY90KLQAXA9olXzK+CY54qxFQdbcW9wrlHc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01A89F805C8;
	Thu, 27 Oct 2022 21:36:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C734F805C2; Thu, 27 Oct 2022 21:36:35 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A946F80588
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 21:36:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A946F80588
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="iSeH4k21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666899384; x=1698435384;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oh9GwDEXGDl40MOU2ehkI97ifbWQpll98R0058EUd7U=;
 b=iSeH4k21R3Avffs6jMcDSQszMVbO9UjDt1dZ78p2B4F68qGVFRA8Ppvy
 a5R25HkQfItC/Em/QxpeaTp9gWPklUepCJ4hepzf3euk1kzbSN+Gzqm3X
 B8jxCNc6X5aW1jLDjboJAPFD9185EtcSlkUtPMNYjKshjn0/HGfuyrgLz
 VsOfSkIxYgXm/g0T3uYX/ADPClGKfVwuifWH1Z9NVSbcFJiWxSdccH2e7
 /9kmvatIN3OsY1qN3XeHyj+bsKXJpAor9MApv7ZoIqniG8BxttX28hS3Y
 BfKzUhv7T/exHEwPpyoT78wD97jOai02loC4nLFFZ7Gns+qIdlifwFPKy w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="334957859"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; d="scan'208";a="334957859"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2022 12:36:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="632527058"
X-IronPort-AV: E=Sophos;i="5.95,218,1661842800"; d="scan'208";a="632527058"
Received: from vmehta-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.6.254])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2022 12:36:21 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 16/21] ASoC: SOF: Intel: clarify bus_init and bus_exit
 sequences
Date: Thu, 27 Oct 2022 15:35:35 -0400
Message-Id: <20221027193540.259520-17-pierre-louis.bossart@linux.intel.com>
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

The dependencies are on SND_SOC_SOF_HDA_AUDIO_CODEC and the bus_exit
sequence should be well identified.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-bus.c | 23 +++++++++++++++--------
 sound/soc/sof/intel/hda.c     |  7 +++----
 sound/soc/sof/intel/hda.h     |  3 ++-
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
index 0862ff8b6627..acb4b85868d0 100644
--- a/sound/soc/sof/intel/hda-bus.c
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -18,11 +18,7 @@
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 #include "../../codecs/hdac_hda.h"
 #define sof_hda_ext_ops	snd_soc_hdac_hda_get_ops()
-#else
-#define sof_hda_ext_ops	NULL
-#endif
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 static void update_codec_wake_enable(struct hdac_bus *bus, unsigned int addr, bool link_power)
 {
 	unsigned int mask = snd_hdac_chip_readw(bus, WAKEEN);
@@ -70,11 +66,13 @@ static const struct hdac_bus_ops bus_core_ops = {
 /*
  * This can be used for both with/without hda link support.
  */
-void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev)
+void sof_hda_bus_init(struct snd_sof_dev *sdev, struct device *dev)
 {
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	struct hdac_bus *bus = sof_to_bus(sdev);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 	snd_hdac_ext_bus_init(bus, dev, &bus_core_ops, sof_hda_ext_ops);
-#else /* CONFIG_SND_SOC_SOF_HDA */
+#else /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 	memset(bus, 0, sizeof(*bus));
 	bus->dev = dev;
 
@@ -89,5 +87,14 @@ void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev)
 	bus->idx = 0;
 
 	spin_lock_init(&bus->reg_lock);
-#endif /* CONFIG_SND_SOC_SOF_HDA */
+#endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
+}
+
+void sof_hda_bus_exit(struct snd_sof_dev *sdev)
+{
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
+	struct hdac_bus *bus = sof_to_bus(sdev);
+
+	snd_hdac_ext_bus_exit(bus);
+#endif
 }
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index e08b57fa3bfc..aa56f2967edc 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -696,7 +696,7 @@ static int hda_init(struct snd_sof_dev *sdev)
 	bus = sof_to_bus(sdev);
 
 	/* HDA bus init */
-	sof_hda_bus_init(bus, &pci->dev);
+	sof_hda_bus_init(sdev, &pci->dev);
 
 	if (sof_hda_position_quirk == SOF_HDA_POSITION_QUIRK_USE_DPIB_REGISTERS)
 		bus->use_posbuf = 0;
@@ -1208,9 +1208,8 @@ int hda_dsp_remove(struct snd_sof_dev *sdev)
 	iounmap(sdev->bar[HDA_DSP_BAR]);
 	iounmap(bus->remap_addr);
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-	snd_hdac_ext_bus_exit(bus);
-#endif
+	sof_hda_bus_exit(sdev);
+
 	hda_codec_i915_exit(sdev);
 
 	return 0;
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index e1f3d03cd4f7..0214097389d3 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -708,7 +708,8 @@ void hda_dsp_ctrl_stop_chip(struct snd_sof_dev *sdev);
 /*
  * HDA bus operations.
  */
-void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev);
+void sof_hda_bus_init(struct snd_sof_dev *sdev, struct device *dev);
+void sof_hda_bus_exit(struct snd_sof_dev *sdev);
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 /*
-- 
2.34.1

