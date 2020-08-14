Return-Path: <SRS0=GNy4=BY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2025BC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:40:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E5B20716
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QPWC+Cnw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E5B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C16C166F;
	Fri, 14 Aug 2020 11:39:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C16C166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597398030;
	bh=MLmGWvXVGcWAAjXcF/fRGE7PyQTQCWSrUYEDQsX13Js=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPWC+CnwYkKoyiYQZu+zSiQ6PW8ruFdqAMB2id2FfgZFWmW9OyVBJ874ADIAHxkhU
	 Oi9BkMarPm6wM1PAA7dfm07CCFtyxu3/pEU9eK15y5lEp3+wfdN5Tny8U96DnCcwQi
	 mbmp6JjlG0jT6Na/7ADPtW/IciYV/nSyJtJB+KSo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 15B7FF8022D;
	Fri, 14 Aug 2020 11:38:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1ABDAF8022B; Fri, 14 Aug 2020 11:38:14 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E79FF80146
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2020 11:38:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E79FF80146
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 10F5D2011EB;
 Fri, 14 Aug 2020 11:38:03 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A7DAF2000BB;
 Fri, 14 Aug 2020 11:37:59 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2E206402C9;
 Fri, 14 Aug 2020 11:37:55 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] ASoC: ak4458: Add regulator support
Date: Fri, 14 Aug 2020 17:32:41 +0800
Message-Id: <1597397561-2426-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597397561-2426-1-git-send-email-shengjiu.wang@nxp.com>
References: <1597397561-2426-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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

"AVDD" is for analog power supply,  "DVDD" is for digital power
supply, they can improve the power management.

As the regulator is enabled in pm runtime resume, which is
behind the component driver probe, so accessing registers in
component driver probe will fail. Fix this issue by enabling
regcache_cache_only after pm_runtime_enable.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/ak4458.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4458.c b/sound/soc/codecs/ak4458.c
index cbe3c782e0ca..763e6839428f 100644
--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -12,6 +12,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/initval.h>
 #include <sound/pcm_params.h>
@@ -21,6 +22,12 @@
 
 #include "ak4458.h"
 
+#define AK4458_NUM_SUPPLIES 2
+static const char *ak4458_supply_names[AK4458_NUM_SUPPLIES] = {
+	"DVDD",
+	"AVDD",
+};
+
 struct ak4458_drvdata {
 	struct snd_soc_dai_driver *dai_drv;
 	const struct snd_soc_component_driver *comp_drv;
@@ -28,6 +35,7 @@ struct ak4458_drvdata {
 
 /* AK4458 Codec Private Data */
 struct ak4458_priv {
+	struct regulator_bulk_data supplies[AK4458_NUM_SUPPLIES];
 	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpiod;
@@ -587,12 +595,22 @@ static int __maybe_unused ak4458_runtime_suspend(struct device *dev)
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 0);
 
+	regulator_bulk_disable(ARRAY_SIZE(ak4458->supplies),
+			       ak4458->supplies);
 	return 0;
 }
 
 static int __maybe_unused ak4458_runtime_resume(struct device *dev)
 {
 	struct ak4458_priv *ak4458 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(ak4458->supplies),
+				    ak4458->supplies);
+	if (ret != 0) {
+		dev_err(ak4458->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
 
 	if (ak4458->mute_gpiod)
 		gpiod_set_value_cansleep(ak4458->mute_gpiod, 1);
@@ -667,7 +685,7 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 {
 	struct ak4458_priv *ak4458;
 	const struct ak4458_drvdata *drvdata;
-	int ret;
+	int ret, i;
 
 	ak4458 = devm_kzalloc(&i2c->dev, sizeof(*ak4458), GFP_KERNEL);
 	if (!ak4458)
@@ -692,6 +710,16 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	if (IS_ERR(ak4458->mute_gpiod))
 		return PTR_ERR(ak4458->mute_gpiod);
 
+	for (i = 0; i < ARRAY_SIZE(ak4458->supplies); i++)
+		ak4458->supplies[i].supply = ak4458_supply_names[i];
+
+	ret = devm_regulator_bulk_get(ak4458->dev, ARRAY_SIZE(ak4458->supplies),
+				      ak4458->supplies);
+	if (ret != 0) {
+		dev_err(ak4458->dev, "Failed to request supplies: %d\n", ret);
+		return ret;
+	}
+
 	ret = devm_snd_soc_register_component(ak4458->dev, drvdata->comp_drv,
 					      drvdata->dai_drv, 1);
 	if (ret < 0) {
@@ -700,6 +728,7 @@ static int ak4458_i2c_probe(struct i2c_client *i2c)
 	}
 
 	pm_runtime_enable(&i2c->dev);
+	regcache_cache_only(ak4458->regmap, true);
 
 	return 0;
 }
-- 
2.27.0

