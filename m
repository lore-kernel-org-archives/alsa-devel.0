Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35683C4338F
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:14:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6830F610FE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6830F610FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BB741897;
	Fri, 13 Aug 2021 17:13:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BB741897
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628867686;
	bh=h9Rh4fDyRvUSzlXu/0AngfOk4XMqyWlL6Ksu6nUTAxI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Giw4+OGEpbH5mR0utGH9AVw9LNh/NYV/QNS+j2aSsiVYdlREZ47K94tIQhyEP2J+v
	 x8U6HGNJYRsriAeDK96KJ+kQFVd/3reOn5UachhxEW+daM6HakB7WjCSrWyF3djscy
	 225Wbz2zfSiM2opqsfLgZveh2jVzjtLdfHEGPImQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFD7BF804F3;
	Fri, 13 Aug 2021 17:11:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD176F804E7; Fri, 13 Aug 2021 17:11:49 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03924F8032D
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 17:11:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03924F8032D
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="215301886"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="215301886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="422888867"
Received: from mchatter-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.54.162])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:31 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 5/8] ASoC: Intel: sof_sdw_rt711*: keep codec device
 reference until remove
Date: Fri, 13 Aug 2021 10:11:13 -0500
Message-Id: <20210813151116.23931-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813151116.23931-1-pierre-louis.bossart@linux.intel.com>
References: <20210813151116.23931-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, broonie@kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

Follow the example of Intel Atom drivers and keep a reference to the
headset codec until the properties are removed.

There is no guarantee that the module for the codec driver is loaded
before the machine driver probe, the use of the deferred probe
mechanism is required.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw_rt711.c      | 44 +++++++++------------
 sound/soc/intel/boards/sof_sdw_rt711_sdca.c | 43 +++++++++-----------
 2 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw_rt711.c b/sound/soc/intel/boards/sof_sdw_rt711.c
index 8a6a17fe676e..510301e09b09 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711.c
@@ -21,25 +21,15 @@
  * Note this MUST be called before snd_soc_register_card(), so that the props
  * are in place before the codec component driver's probe function parses them.
  */
-static int rt711_add_codec_device_props(const char *sdw_dev_name)
+static int rt711_add_codec_device_props(struct device *sdw_dev)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
-	struct device *sdw_dev;
-	int ret;
-
-	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL, sdw_dev_name);
-	if (!sdw_dev)
-		return -EPROBE_DEFER;
 
-	if (SOF_RT711_JDSRC(sof_sdw_quirk)) {
-		props[0] = PROPERTY_ENTRY_U32("realtek,jd-src",
-					      SOF_RT711_JDSRC(sof_sdw_quirk));
-	}
-
-	ret = device_add_properties(sdw_dev, props);
-	put_device(sdw_dev);
+	if (!SOF_RT711_JDSRC(sof_sdw_quirk))
+		return 0;
+	props[0] = PROPERTY_ENTRY_U32("realtek,jd-src", SOF_RT711_JDSRC(sof_sdw_quirk));
 
-	return ret;
+	return device_add_properties(sdw_dev, props);
 }
 
 static const struct snd_soc_dapm_widget rt711_widgets[] = {
@@ -137,15 +127,10 @@ static int rt711_rtd_init(struct snd_soc_pcm_runtime *rtd)
 
 int sof_sdw_rt711_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link)
 {
-	struct device *sdw_dev;
-
-	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL,
-					  dai_link->codecs[0].name);
-	if (!sdw_dev)
-		return -EINVAL;
+	struct mc_private *ctx = snd_soc_card_get_drvdata(card);
 
-	device_remove_properties(sdw_dev);
-	put_device(sdw_dev);
+	device_remove_properties(ctx->headset_codec_dev);
+	put_device(ctx->headset_codec_dev);
 
 	return 0;
 }
@@ -156,6 +141,8 @@ int sof_sdw_rt711_init(struct snd_soc_card *card,
 		       struct sof_sdw_codec_info *info,
 		       bool playback)
 {
+	struct mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct device *sdw_dev;
 	int ret;
 
 	/*
@@ -165,9 +152,16 @@ int sof_sdw_rt711_init(struct snd_soc_card *card,
 	if (!playback)
 		return 0;
 
-	ret = rt711_add_codec_device_props(dai_links->codecs[0].name);
-	if (ret < 0)
+	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL, dai_links->codecs[0].name);
+	if (!sdw_dev)
+		return -EPROBE_DEFER;
+
+	ret = rt711_add_codec_device_props(sdw_dev);
+	if (ret < 0) {
+		put_device(sdw_dev);
 		return ret;
+	}
+	ctx->headset_codec_dev = sdw_dev;
 
 	dai_links->init = rt711_rtd_init;
 
diff --git a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
index 1ae66f266c6c..94af40e2beb0 100644
--- a/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
+++ b/sound/soc/intel/boards/sof_sdw_rt711_sdca.c
@@ -21,25 +21,16 @@
  * Note this MUST be called before snd_soc_register_card(), so that the props
  * are in place before the codec component driver's probe function parses them.
  */
-static int rt711_sdca_add_codec_device_props(const char *sdw_dev_name)
+static int rt711_sdca_add_codec_device_props(struct device *sdw_dev)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
-	struct device *sdw_dev;
-	int ret;
-
-	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL, sdw_dev_name);
-	if (!sdw_dev)
-		return -EPROBE_DEFER;
 
-	if (SOF_RT711_JDSRC(sof_sdw_quirk)) {
-		props[0] = PROPERTY_ENTRY_U32("realtek,jd-src",
-					      SOF_RT711_JDSRC(sof_sdw_quirk));
-	}
+	if (!SOF_RT711_JDSRC(sof_sdw_quirk))
+		return 0;
 
-	ret = device_add_properties(sdw_dev, props);
-	put_device(sdw_dev);
+	props[0] = PROPERTY_ENTRY_U32("realtek,jd-src", SOF_RT711_JDSRC(sof_sdw_quirk));
 
-	return ret;
+	return device_add_properties(sdw_dev, props);
 }
 
 static const struct snd_soc_dapm_widget rt711_sdca_widgets[] = {
@@ -137,15 +128,10 @@ static int rt711_sdca_rtd_init(struct snd_soc_pcm_runtime *rtd)
 
 int sof_sdw_rt711_sdca_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_link)
 {
-	struct device *sdw_dev;
-
-	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL,
-					  dai_link->codecs[0].name);
-	if (!sdw_dev)
-		return -EINVAL;
+	struct mc_private *ctx = snd_soc_card_get_drvdata(card);
 
-	device_remove_properties(sdw_dev);
-	put_device(sdw_dev);
+	device_remove_properties(ctx->headset_codec_dev);
+	put_device(ctx->headset_codec_dev);
 
 	return 0;
 }
@@ -156,6 +142,8 @@ int sof_sdw_rt711_sdca_init(struct snd_soc_card *card,
 			    struct sof_sdw_codec_info *info,
 			    bool playback)
 {
+	struct mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct device *sdw_dev;
 	int ret;
 
 	/*
@@ -165,9 +153,16 @@ int sof_sdw_rt711_sdca_init(struct snd_soc_card *card,
 	if (!playback)
 		return 0;
 
-	ret = rt711_sdca_add_codec_device_props(dai_links->codecs[0].name);
-	if (ret < 0)
+	sdw_dev = bus_find_device_by_name(&sdw_bus_type, NULL, dai_links->codecs[0].name);
+	if (!sdw_dev)
+		return -EPROBE_DEFER;
+
+	ret = rt711_sdca_add_codec_device_props(sdw_dev);
+	if (ret < 0) {
+		put_device(sdw_dev);
 		return ret;
+	}
+	ctx->headset_codec_dev = sdw_dev;
 
 	dai_links->init = rt711_sdca_rtd_init;
 
-- 
2.25.1

