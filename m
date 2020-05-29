Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6631C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 16:05:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63334206E2
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UsUCLP/8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63334206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92327177C;
	Fri, 29 May 2020 18:04:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92327177C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590768339;
	bh=NkJEA/SXfUeEBLEj8Bwc2g1buZUVNFrNK0z+nAv10Yc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UsUCLP/8CK6TCB2hsVa9IrNobiTBGq+siCilR9LVRJpl+VulJWlJABSRZKn0wDT2E
	 c64q+bggs/4u0SKj+uyCRIcZ+4t6PaKP2LChwxQHjZk7f6KKq0NkxbWJUojGPsY9M3
	 uhIfP6KEx8UFRPIln/CT6Dk4KEfOvLI67vfmy14Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E11DF80149;
	Fri, 29 May 2020 18:04:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B273F8014E; Fri, 29 May 2020 18:04:47 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6628F800FF
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 18:04:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6628F800FF
IronPort-SDR: YsU2tB7Jf0n7Z4qvyjRf1Fqf+nx31TWIvzElo/RZffbkghpd8NWK6iHIQhVUde5hSv1vd8upVz
 ATG0k8FYclvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2020 09:04:06 -0700
IronPort-SDR: N6lFY5m+cYgxlsKFlsrL4z0CiZeYEv3POlh5K9uhbDcjPWI3YoAQDZkyU+9Ha9po35V2oCoxZG
 lgvsoA63MyLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,449,1583222400"; d="scan'208";a="443441286"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga005.jf.intel.com with ESMTP; 29 May 2020 09:04:03 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: Intel: hda: fix generic hda codec support
Date: Fri, 29 May 2020 19:03:58 +0300
Message-Id: <20200529160358.12134-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, Hui Wang <hui.wang@canonical.com>,
 daniel.baluta@nxp.com
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

Add support for using generic codec driver with SOF. Generic driver
is used if:
 - snd_sof_intel_hda_common.hda_model="generic" is set, or
 - fallback if no other codec driver is found

The implementation is aligned with snd-hda-intel driver, and fixes audio
support for systems like Acer Swift 3 SF314-57G, on which this issue was
originally reported.

BugLink: https://github.com/thesofproject/linux/issues/1807
BugLink: https://bugs.launchpad.net/bugs/1877757
Reviewed-by: Hui Wang <hui.wang@canonical.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-codec.c | 51 +++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index c3299be119a1..2c5c451fa19d 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -24,19 +24,44 @@
 #define IDISP_VID_INTEL	0x80860000
 
 /* load the legacy HDA codec driver */
-static int hda_codec_load_module(struct hda_codec *codec)
+static int request_codec_module(struct hda_codec *codec)
 {
 #ifdef MODULE
 	char alias[MODULE_NAME_LEN];
-	const char *module = alias;
+	const char *mod = NULL;
 
-	snd_hdac_codec_modalias(&codec->core, alias, sizeof(alias));
-	dev_dbg(&codec->core.dev, "loading codec module: %s\n", module);
-	request_module(module);
+	switch (codec->probe_id) {
+	case HDA_CODEC_ID_GENERIC:
+#if IS_MODULE(CONFIG_SND_HDA_GENERIC)
+		mod = "snd-hda-codec-generic";
 #endif
+		break;
+	default:
+		snd_hdac_codec_modalias(&codec->core, alias, sizeof(alias));
+		mod = alias;
+		break;
+	}
+
+	if (mod) {
+		dev_dbg(&codec->core.dev, "loading codec module: %s\n", mod);
+		request_module(mod);
+	}
+#endif /* MODULE */
 	return device_attach(hda_codec_dev(codec));
 }
 
+static int hda_codec_load_module(struct hda_codec *codec)
+{
+	int ret = request_codec_module(codec);
+
+	if (ret <= 0) {
+		codec->probe_id = HDA_CODEC_ID_GENERIC;
+		ret = request_codec_module(codec);
+	}
+
+	return ret;
+}
+
 /* enable controller wake up event for all codecs with jack connectors */
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev)
 {
@@ -78,6 +103,13 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev) {}
 EXPORT_SYMBOL_NS(hda_codec_jack_wake_enable, SND_SOC_SOF_HDA_AUDIO_CODEC);
 EXPORT_SYMBOL_NS(hda_codec_jack_check, SND_SOC_SOF_HDA_AUDIO_CODEC);
 
+#if IS_ENABLED(CONFIG_SND_HDA_GENERIC)
+#define is_generic_config(bus) \
+	((bus)->modelname && !strcmp((bus)->modelname, "generic"))
+#else
+#define is_generic_config(x)	0
+#endif
+
 /* probe individual codec */
 static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 			   bool hda_codec_use_common_hdmi)
@@ -87,6 +119,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 #endif
 	struct hda_bus *hbus = sof_to_hbus(sdev);
 	struct hdac_device *hdev;
+	struct hda_codec *codec;
 	u32 hda_cmd = (address << 28) | (AC_NODE_ROOT << 20) |
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	u32 resp = -1;
@@ -108,6 +141,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 
 	hda_priv->codec.bus = hbus;
 	hdev = &hda_priv->codec.core;
+	codec = &hda_priv->codec;
 
 	ret = snd_hdac_ext_bus_device_init(&hbus->core, address, hdev);
 	if (ret < 0)
@@ -122,6 +156,11 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 		hda_priv->need_display_power = true;
 	}
 
+	if (is_generic_config(hbus))
+		codec->probe_id = HDA_CODEC_ID_GENERIC;
+	else
+		codec->probe_id = 0;
+
 	/*
 	 * if common HDMI codec driver is not used, codec load
 	 * is skipped here and hdac_hdmi is used instead
@@ -129,7 +168,7 @@ static int hda_codec_probe(struct snd_sof_dev *sdev, int address,
 	if (hda_codec_use_common_hdmi ||
 	    (resp & 0xFFFF0000) != IDISP_VID_INTEL) {
 		hdev->type = HDA_DEV_LEGACY;
-		ret = hda_codec_load_module(&hda_priv->codec);
+		ret = hda_codec_load_module(codec);
 		/*
 		 * handle ret==0 (no driver bound) as an error, but pass
 		 * other return codes without modification
-- 
2.26.2

