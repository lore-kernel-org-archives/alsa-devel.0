Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A622C54E4A
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 03:31:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB3120746
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 03:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sVAtLxl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB3120746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15C0E15F2;
	Mon, 11 May 2020 05:30:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15C0E15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589167907;
	bh=OCnoVpjZuzeyPykHwK9AlEwcRpV7E9uMuT6f2cxq7+4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sVAtLxl6WAqstXytQCV8TkpsdzE6XHBgNSsJ8BXpSFVZGGO9znhN5O38pTJLdj6Bo
	 ErGIRQgzh+iBH9LFwrzIIYm/Kj9CsrMsSRpKSigi7Xc9VkLZ7pmB1kEYVq9yiGBVc7
	 jcAUdz/oDJx/clWM+PFrKWvz9fejEoUHKObcv+Ns=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A80E0F8029B;
	Mon, 11 May 2020 05:29:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9991FF8014C; Mon, 11 May 2020 05:29:04 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55A2EF8014C
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 05:28:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55A2EF8014C
IronPort-SDR: 2eGdvmG56gdSIeLNAt/RUKYPlsZiYQ3Zcyk+ARjEJRyRPNQnpA+Dc0KM6SrcbPM549aZeqY5JF
 pO1bMCMNSKJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2020 20:28:53 -0700
IronPort-SDR: cYyaAsNLwz6zYN56IzkafeCqjkeayc0OiFBTO72rVXq11EEmdbCZszrX7TYxBY+YevG9VmW7BM
 ZxL/9LvCuCCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,378,1583222400"; d="scan'208";a="265024245"
Received: from unknown (HELO jsia-HP-Z620-Workstation.png.intel.com)
 ([10.221.118.135])
 by orsmga006.jf.intel.com with ESMTP; 10 May 2020 20:28:51 -0700
From: Sia Jee Heng <jee.heng.sia@intel.com>
To: <alsa-devel@alsa-project.org>
Subject: [PATCH 2/4] ASoC: Intel: Boards: Add KeemBay machine driver
Date: Mon, 11 May 2020 11:16:02 +0800
Message-Id: <1589166964-8985-3-git-send-email-jee.heng.sia@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589166964-8985-1-git-send-email-jee.heng.sia@intel.com>
References: <1589166964-8985-1-git-send-email-jee.heng.sia@intel.com>
Cc: liam.r.girdwood@linux.intel.com, broonie@kernel.org, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com
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

Add KeemBay machine driver which glues the tlv320aic3204 codec driver
and kmb_platform driver to form the asoc sound driver.

Signed-off-by: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 sound/soc/intel/boards/kmb_tlv3204.c | 144 +++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 sound/soc/intel/boards/kmb_tlv3204.c

diff --git a/sound/soc/intel/boards/kmb_tlv3204.c b/sound/soc/intel/boards/kmb_tlv3204.c
new file mode 100644
index 0000000..813c291
--- /dev/null
+++ b/sound/soc/intel/boards/kmb_tlv3204.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*  KeemBay ASOC Machine driver
+ *
+ *  Copyright (C) 2020 Intel Corporation.
+ *
+ */
+
+#include <linux/module.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/soc.h>
+#include "../../codecs/tlv320aic32x4.h"
+
+static unsigned int channels[] = {
+	2,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_ch = {
+	.count	= ARRAY_SIZE(channels),
+	.list	= channels,
+};
+
+static unsigned int rates[] = {
+	16000,
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count	= ARRAY_SIZE(rates),
+	.list	= rates,
+};
+
+static int kmb_mach_hw_params(struct snd_pcm_substream *substream,
+			      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
+	int ret;
+	unsigned int sysclk;
+
+	/* As per codec datasheet Sysclk = 256 * fs */
+	sysclk = 12288000;
+
+	/* set the codec system clock */
+	ret = snd_soc_dai_set_sysclk(codec_dai, 1, sysclk, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		dev_err(rtd->dev, "snd_soc_dai_set_sysclk err = %d\n", ret);
+
+	return ret;
+}
+
+static int kmb_mach_dai_link_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *str_runtime;
+
+	str_runtime = substream->runtime;
+
+	snd_pcm_hw_constraint_list(str_runtime, 0,
+				   SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_ch);
+
+	snd_pcm_hw_constraint_list(str_runtime, 0,
+				   SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
+	return 0;
+}
+
+static const struct snd_soc_ops kmb_mach_dai_link_ops = {
+	.startup = kmb_mach_dai_link_startup,
+	.hw_params = kmb_mach_hw_params,
+};
+
+static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("External Mic", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
+};
+
+static const struct snd_soc_dapm_route aic32x4_dapm_routes[] = {
+	{"Headphone", NULL, "HPL"},
+	{"Headphone", NULL, "HPR"},
+	{"IN3_R", NULL, "External Mic"},
+	{"IN3_L", NULL, "External Mic"},
+};
+
+/* Linking platform to the codec-drivers  */
+SND_SOC_DAILINK_DEFS(link1,
+	DAILINK_COMP_ARRAY(COMP_CPU("20140000.i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("tlv320aic32x4.2-0018",
+					"tlv320aic32x4-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("20140000.i2s")));
+
+/* kmb digital audio interface glue */
+static struct snd_soc_dai_link kmb_mach_dais[] = {
+	{
+		.name		= "tlv320aic32x4",
+		.stream_name	= "TLV320AIC32X4",
+		.ops = &kmb_mach_dai_link_ops,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+				SND_SOC_DAIFMT_NB_NF |
+				SND_SOC_DAIFMT_CBS_CFS,
+		SND_SOC_DAILINK_REG(link1),
+	},
+};
+
+/* kmb audio machine driver */
+static struct snd_soc_card kmb_mach = {
+	.name = "kmb_audio_card",
+	.dai_link = kmb_mach_dais,
+	.num_links = ARRAY_SIZE(kmb_mach_dais),
+	.dapm_routes = aic32x4_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(aic32x4_dapm_routes),
+	.dapm_widgets = aic32x4_dapm_widgets,
+	.num_dapm_widgets =  ARRAY_SIZE(aic32x4_dapm_widgets),
+	.fully_routed = true,
+};
+
+static int kmb_mach_audio_probe(struct platform_device *pdev)
+{
+	kmb_mach.dev = &pdev->dev;
+
+	return devm_snd_soc_register_card(&pdev->dev, &kmb_mach);
+}
+
+static const struct of_device_id kmb_mach_of_match[] = {
+	{ .compatible = "intel,kmb-snd-asoc", },
+	{}
+};
+
+static struct platform_driver kmb_mach_audio = {
+	.probe = kmb_mach_audio_probe,
+	.driver = {
+		.name = "kmb_tlv3204",
+		.of_match_table = kmb_mach_of_match,
+	},
+};
+
+module_platform_driver(kmb_mach_audio)
+
+/* Module information */
+MODULE_DESCRIPTION("Intel Audio tlv3204 machine driver for KeemBay");
+MODULE_AUTHOR("Sia Jee Heng <jee.heng.sia@intel.com>");
+MODULE_AUTHOR("Sit, Michael Wei Hong <michael.wei.hong.sit@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:kmb_tlv3204");
-- 
1.9.1

