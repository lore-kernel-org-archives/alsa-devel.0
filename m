Return-Path: <SRS0=RV9o=ZS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEDC432C3
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:57:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E632071A
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="b9aKtRGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E632071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90FCA1741;
	Tue, 26 Nov 2019 15:56:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90FCA1741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574780219;
	bh=NNU4mIuXIqSWxvvb0rNRLpYWrHUQk1BqnU//q+jvv/c=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9aKtRGS1onhUxzYOttQG0kselenxLZ/ZeMTHbF3asdUlecYuAui79dRvYygy0mYy
	 uYpTH6jsG8567boilpMgWQFz+Os/YA3BHY83s2ZTKPoC64KZSSif87UEGtD4iLOZha
	 JWOe/ykVvtu87dMt4Iox9mEaPs+DlMwtJfxoIEoQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E433CF80217;
	Tue, 26 Nov 2019 15:53:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACCD5F801F7; Tue, 26 Nov 2019 15:53:44 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67C51F800AB
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2019 15:53:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67C51F800AB
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Nov 2019 06:53:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; d="scan'208";a="239951784"
Received: from vramali2-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.155.193])
 by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2019 06:53:36 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue, 26 Nov 2019 08:53:04 -0600
Message-Id: <20191126145304.24204-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191126145304.24204-1-pierre-louis.bossart@linux.intel.com>
References: <20191126145304.24204-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH 3/3] ASoC: hdac_hdmi: Drop support for Icelake
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

This reverts commit 019033c854a2 ("ASoC: Intel: hdac_hdmi:
add Icelake support").

Icelake HDMI audio is supported by the HDMI codec driver,
which can be used both in non-DSP (legacy HDA) and with
DSP (SOF) configurations.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 63 ++++++------------------------------
 1 file changed, 9 insertions(+), 54 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 18c173e6a13b..e6558475e006 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -115,16 +115,8 @@ struct hdac_hdmi_dai_port_map {
 	struct hdac_hdmi_cvt *cvt;
 };
 
-/*
- * pin to port mapping table where the value indicate the pin number and
- * the index indicate the port number with 1 base.
- */
-static const int icl_pin2port_map[] = {0x4, 0x6, 0x8, 0xa, 0xb};
-
 struct hdac_hdmi_drv_data {
 	unsigned int vendor_nid;
-	const int *port_map; /* pin to port mapping table */
-	int port_num;
 };
 
 struct hdac_hdmi_priv {
@@ -1374,12 +1366,11 @@ static int hdac_hdmi_add_pin(struct hdac_device *hdev, hda_nid_t nid)
 	return 0;
 }
 
-#define INTEL_VENDOR_NID_0x2 0x02
-#define INTEL_VENDOR_NID_0x8 0x08
-#define INTEL_VENDOR_NID_0xb 0x0b
+#define INTEL_VENDOR_NID 0x08
+#define INTEL_GLK_VENDOR_NID 0x0b
 #define INTEL_GET_VENDOR_VERB 0xf81
 #define INTEL_SET_VENDOR_VERB 0x781
-#define INTEL_EN_DP12		0x02 /* enable DP 1.2 features */
+#define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
 #define INTEL_EN_ALL_PIN_CVTS	0x01 /* enable 2nd & 3rd pins and convertors */
 
 static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdev)
@@ -1566,26 +1557,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_device *hdev,
 
 static int hdac_hdmi_pin2port(void *aptr, int pin)
 {
-	struct hdac_device *hdev = aptr;
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
-	const int *map = hdmi->drv_data->port_map;
-	int i;
-
-	if (!hdmi->drv_data->port_num)
-		return pin - 4; /* map NID 0x05 -> port #1 */
-
-	/*
-	 * looking for the pin number in the mapping table and return
-	 * the index which indicate the port number
-	 */
-	for (i = 0; i < hdmi->drv_data->port_num; i++) {
-		if (pin == map[i])
-			return i + 1;
-	}
-
-	/* return -1 if pin number exceeds our expectation */
-	dev_err(&hdev->dev, "Can't find the port for pin %d\n", pin);
-	return -1;
+	return pin - 4; /* map NID 0x05 -> port #1 */
 }
 
 static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
@@ -1596,18 +1568,9 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 	struct hdac_hdmi_port *hport = NULL;
 	struct snd_soc_component *component = hdmi->component;
 	int i;
-	hda_nid_t pin_nid;
-
-	if (!hdmi->drv_data->port_num) {
-		/* for legacy platforms */
-		pin_nid = port + 0x04;
-	} else if (port < hdmi->drv_data->port_num) {
-		/* get pin number from the pin2port mapping table */
-		pin_nid = hdmi->drv_data->port_map[port - 1];
-	} else {
-		dev_err(&hdev->dev, "Can't find the pin for port %d\n", port);
-		return;
-	}
+
+	/* Don't know how this mapping is derived */
+	hda_nid_t pin_nid = port + 0x04;
 
 	dev_dbg(&hdev->dev, "%s: for pin:%d port=%d\n", __func__,
 							pin_nid, pipe);
@@ -2025,18 +1988,12 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdev, int pcm_idx)
 	return port->eld.info.spk_alloc;
 }
 
-static struct hdac_hdmi_drv_data intel_icl_drv_data  = {
-	.vendor_nid = INTEL_VENDOR_NID_0x2,
-	.port_map = icl_pin2port_map,
-	.port_num = ARRAY_SIZE(icl_pin2port_map),
-};
-
 static struct hdac_hdmi_drv_data intel_glk_drv_data  = {
-	.vendor_nid = INTEL_VENDOR_NID_0xb,
+	.vendor_nid = INTEL_GLK_VENDOR_NID,
 };
 
 static struct hdac_hdmi_drv_data intel_drv_data  = {
-	.vendor_nid = INTEL_VENDOR_NID_0x8,
+	.vendor_nid = INTEL_VENDOR_NID,
 };
 
 static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
@@ -2216,8 +2173,6 @@ static const struct hda_device_id hdmi_list[] = {
 						   &intel_glk_drv_data),
 	HDA_CODEC_EXT_ENTRY(0x8086280d, 0x100000, "Geminilake HDMI",
 						   &intel_glk_drv_data),
-	HDA_CODEC_EXT_ENTRY(0x8086280f, 0x100000, "Icelake HDMI",
-						   &intel_icl_drv_data),
 	{}
 };
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
