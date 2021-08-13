Return-Path: <SRS0=Pedv=NE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE17C432BE
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:15:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7D1610EA
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Aug 2021 15:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D7D1610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C7BB18A8;
	Fri, 13 Aug 2021 17:14:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C7BB18A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628867740;
	bh=kgwem+pyZrBdeMnaL4BE8e29VIH9+T9w89AWQ8Lbyj8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AQrybLLlJT5sbm1AHI1pLZDPLZ6Qcags71DNYKvUKq+Xw2+BZnBZflpb5mWHR72JG
	 Rkj8qw99wEKnKxP5XNpAt4Ax9GbWuisajMFwAFJyypP8f3VLsLiNLfvQCi771l9SbV
	 N+jyfpq1HSxz8M9ePH8g9cBNdKsuvOD14wPdY6AY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36B7DF804AE;
	Fri, 13 Aug 2021 17:12:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A87F9F804DA; Fri, 13 Aug 2021 17:12:55 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03123F804B0
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 17:11:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03123F804B0
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="215301905"
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="215301905"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,319,1620716400"; d="scan'208";a="422888871"
Received: from mchatter-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.54.162])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2021 08:11:33 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 8/8] ASoC: Intel: boards: use software node API in Atom
 boards
Date: Fri, 13 Aug 2021 10:11:16 -0500
Message-Id: <20210813151116.23931-9-pierre-louis.bossart@linux.intel.com>
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The function device_add_properties() is going to be removed.
Replacing it with software node API equivalents.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_es8316.c | 16 +++++++++++++---
 sound/soc/intel/boards/bytcr_rt5640.c  | 18 +++++++++++++++---
 sound/soc/intel/boards/bytcr_rt5651.c  | 23 ++++++++++++++++++-----
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index f3919baaad08..055248f104b2 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -462,6 +462,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	const struct dmi_system_id *dmi_id;
 	struct device *dev = &pdev->dev;
 	struct snd_soc_acpi_mach *mach;
+	struct fwnode_handle *fwnode;
 	const char *platform_name;
 	struct acpi_device *adev;
 	struct device *codec_dev;
@@ -548,7 +549,16 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("everest,jack-detect-inverted");
 
 	if (cnt) {
-		ret = device_add_properties(codec_dev, props);
+		fwnode = fwnode_create_software_node(props, NULL);
+		if (IS_ERR(fwnode)) {
+			put_device(codec_dev);
+			return PTR_ERR(fwnode);
+		}
+
+		ret = device_add_software_node(codec_dev, to_software_node(fwnode));
+
+		fwnode_handle_put(fwnode);
+
 		if (ret) {
 			put_device(codec_dev);
 			return ret;
@@ -615,7 +625,7 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
 	return 0;
 
 err_put_codec:
-	device_remove_properties(priv->codec_dev);
+	device_remove_software_node(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return ret;
 }
@@ -626,7 +636,7 @@ static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
 
 	gpiod_put(priv->speaker_en_gpio);
-	device_remove_properties(priv->codec_dev);
+	device_remove_software_node(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return 0;
 }
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 41fd56d42103..fecccff76caf 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -974,7 +974,9 @@ static int byt_rt5640_add_codec_device_props(struct device *i2c_dev,
 					     struct byt_rt5640_private *priv)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
+	struct fwnode_handle *fwnode;
 	int cnt = 0;
+	int ret;
 
 	switch (BYT_RT5640_MAP(byt_rt5640_quirk)) {
 	case BYT_RT5640_DMIC1_MAP:
@@ -1014,7 +1016,17 @@ static int byt_rt5640_add_codec_device_props(struct device *i2c_dev,
 	if (byt_rt5640_quirk & BYT_RT5640_JD_NOT_INV)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
 
-	return device_add_properties(i2c_dev, props);
+	fwnode = fwnode_create_software_node(props, NULL);
+	if (IS_ERR(fwnode)) {
+		/* put_device() is handled in caller */
+		return PTR_ERR(fwnode);
+	}
+
+	ret = device_add_software_node(i2c_dev, to_software_node(fwnode));
+
+	fwnode_handle_put(fwnode);
+
+	return ret;
 }
 
 static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
@@ -1584,7 +1596,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	return ret_val;
 
 err:
-	device_remove_properties(priv->codec_dev);
+	device_remove_software_node(priv->codec_dev);
 err_device:
 	put_device(priv->codec_dev);
 	return ret_val;
@@ -1595,7 +1607,7 @@ static int snd_byt_rt5640_mc_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct byt_rt5640_private *priv = snd_soc_card_get_drvdata(card);
 
-	device_remove_properties(priv->codec_dev);
+	device_remove_software_node(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return 0;
 }
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index cc1505e53b4f..e94c9124d4f4 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -528,10 +528,13 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
  * Note this MUST be called before snd_soc_register_card(), so that the props
  * are in place before the codec component driver's probe function parses them.
  */
-static int byt_rt5651_add_codec_device_props(struct device *i2c_dev)
+static int byt_rt5651_add_codec_device_props(struct device *i2c_dev,
+					     struct byt_rt5651_private *priv)
 {
 	struct property_entry props[MAX_NO_PROPS] = {};
+	struct fwnode_handle *fwnode;
 	int cnt = 0;
+	int ret;
 
 	props[cnt++] = PROPERTY_ENTRY_U32("realtek,jack-detect-source",
 				BYT_RT5651_JDSRC(byt_rt5651_quirk));
@@ -548,7 +551,17 @@ static int byt_rt5651_add_codec_device_props(struct device *i2c_dev)
 	if (byt_rt5651_quirk & BYT_RT5651_JD_NOT_INV)
 		props[cnt++] = PROPERTY_ENTRY_BOOL("realtek,jack-detect-not-inverted");
 
-	return device_add_properties(i2c_dev, props);
+	fwnode = fwnode_create_software_node(props, NULL);
+	if (IS_ERR(fwnode)) {
+		/* put_device(i2c_dev) is handled in caller */
+		return PTR_ERR(fwnode);
+	}
+
+	ret = device_add_software_node(i2c_dev, to_software_node(fwnode));
+
+	fwnode_handle_put(fwnode);
+
+	return ret;
 }
 
 static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
@@ -995,7 +1008,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	}
 
 	/* Must be called before register_card, also see declaration comment. */
-	ret_val = byt_rt5651_add_codec_device_props(codec_dev);
+	ret_val = byt_rt5651_add_codec_device_props(codec_dev, priv);
 	if (ret_val)
 		goto err_device;
 
@@ -1125,7 +1138,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	return ret_val;
 
 err:
-	device_remove_properties(priv->codec_dev);
+	device_remove_software_node(priv->codec_dev);
 err_device:
 	put_device(priv->codec_dev);
 	return ret_val;
@@ -1136,7 +1149,7 @@ static int snd_byt_rt5651_mc_remove(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	struct byt_rt5651_private *priv = snd_soc_card_get_drvdata(card);
 
-	device_remove_properties(priv->codec_dev);
+	device_remove_software_node(priv->codec_dev);
 	put_device(priv->codec_dev);
 	return 0;
 }
-- 
2.25.1

