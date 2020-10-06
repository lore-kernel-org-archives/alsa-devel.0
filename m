Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24955C4363D
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:35:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9642083B
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mG/O4O4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9642083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DD921751;
	Tue,  6 Oct 2020 13:34:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DD921751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601984115;
	bh=ariFATIN/9mYSNH7qfw4o4ImbBwnPprJgxa/2183rHU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mG/O4O4f25+rdXbOQZEONri1B41YdtuR+5mY283/tkoAeai7xfrVdZ18km0bMf+36
	 c+jit0N5W8jjjca6B3Ut41F1YSE9hULefHYJ5g8y6nCS88ar0D5bxxxHDCz6x+/a7l
	 +FjBdVRKAV2GLeIq9jXtzlbiDimGtA75xrMnbZJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 967D7F80128;
	Tue,  6 Oct 2020 13:32:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FADFF80163; Tue,  6 Oct 2020 13:32:49 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D755CF80129
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 13:32:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D755CF80129
IronPort-SDR: 1UoDp1Cwq0eQKMV/5cUbjDi9Q/Vw8etdCDlByaDeVXEMgy5P+PgxHCQZGAsAqofg0P5i9CXu3H
 HY/EXPZxsp5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="163682591"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="163682591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 04:32:28 -0700
IronPort-SDR: v+0l1sB+6qIY7jurQz62JxRZzbHLLSqNxFBVP7P0MXMBi5tCJhEfLQgkwDUmULUL9O3nbaEQBs
 t071LAYuqkJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; d="scan'208";a="460759609"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga004.jf.intel.com with ESMTP; 06 Oct 2020 04:32:27 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [RFC PATCH 1/2] ALSA: hda - keep track of HDA core bus instance in
 acomp
Date: Tue,  6 Oct 2020 14:30:41 +0300
Message-Id: <20201006113042.471718-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201006113042.471718-1-kai.vehmanen@linux.intel.com>
References: <20201006113042.471718-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

In current HDA component implementation, HDA controller drivers
use snd_hdac_acomp_init() and pass it the HDA bus instance (hdac_bus).
When registration to component framework is done, the HDA controller
device instance 'hdac_bus->dev' is used.

In the component bind/unbind callbacks, only the device handle is passed
as context, and it is not possible to look up the HDA bus instance. Fix
this gap by adding a separate devres entry for the bus handle.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/hda_component.h |  5 +++++
 sound/hda/hdac_component.c    | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/sound/hda_component.h b/include/sound/hda_component.h
index d4804c72d959..476cc4e2083c 100644
--- a/include/sound/hda_component.h
+++ b/include/sound/hda_component.h
@@ -25,6 +25,7 @@ int snd_hdac_acomp_init(struct hdac_bus *bus,
 int snd_hdac_acomp_exit(struct hdac_bus *bus);
 int snd_hdac_acomp_register_notifier(struct hdac_bus *bus,
 				    const struct drm_audio_component_audio_ops *ops);
+struct hdac_bus *snd_hdac_acomp_get_bus(struct device *dev);
 #else
 static inline int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 {
@@ -62,6 +63,10 @@ static inline int snd_hdac_acomp_register_notifier(struct hdac_bus *bus,
 {
 	return -ENODEV;
 }
+static struct hdac_bus *snd_hdac_acomp_get_bus(struct device *dev)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __SOUND_HDA_COMPONENT_H */
diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index 89126c6fd216..d9d2675982f0 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -19,6 +19,29 @@ static struct drm_audio_component *hdac_get_acomp(struct device *dev)
 	return devres_find(dev, hdac_acomp_release, NULL, NULL);
 }
 
+static void hdac_acomp_bus_release(struct device *dev, void *res)
+{
+}
+
+/**
+ * snd_hdac_acomp_get_bus - Get HDA core bus instance
+ * @dev: device
+ *
+ * If audio component registration has been done, this function
+ * will return the matching HDA core bus. Returns NULL otherwise.
+ */
+struct hdac_bus *snd_hdac_acomp_get_bus(struct device *dev)
+{
+	struct drm_audio_component *acomp = hdac_get_acomp(dev);
+	struct hdac_bus **bus =
+		devres_find(dev, hdac_acomp_bus_release, NULL, NULL);
+	if (!acomp || !*bus)
+		return NULL;
+
+	return *bus;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_acomp_get_bus);
+
 /**
  * snd_hdac_set_codec_wakeup - Enable / disable HDMI/DP codec wakeup
  * @bus: HDA core bus
@@ -286,6 +309,7 @@ int snd_hdac_acomp_init(struct hdac_bus *bus,
 	struct component_match *match = NULL;
 	struct device *dev = bus->dev;
 	struct drm_audio_component *acomp;
+	struct hdac_bus **bus_ptr;
 	int ret;
 
 	if (WARN_ON(hdac_get_acomp(dev)))
@@ -299,6 +323,14 @@ int snd_hdac_acomp_init(struct hdac_bus *bus,
 	bus->audio_component = acomp;
 	devres_add(dev, acomp);
 
+	bus_ptr = devres_alloc(hdac_acomp_bus_release, sizeof(*bus_ptr), GFP_KERNEL);
+	if (!bus_ptr) {
+		ret = -ENOMEM;
+		goto out_err_busptr;
+	}
+	*bus_ptr = bus;
+	devres_add(dev, bus_ptr);
+
 	component_match_add_typed(dev, &match, match_master, bus);
 	ret = component_master_add_with_match(dev, &hdac_component_master_ops,
 					      match);
@@ -308,6 +340,8 @@ int snd_hdac_acomp_init(struct hdac_bus *bus,
 	return 0;
 
 out_err:
+	devres_destroy(dev, hdac_acomp_bus_release, NULL, NULL);
+out_err_busptr:
 	bus->audio_component = NULL;
 	devres_destroy(dev, hdac_acomp_release, NULL, NULL);
 	dev_info(dev, "failed to add audio component master (%d)\n", ret);
-- 
2.28.0

