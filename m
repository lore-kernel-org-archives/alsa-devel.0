Return-Path: <SRS0=kjsd=JP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB359C433ED
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:49:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10389610E9
	for <alsa-devel@archiver.kernel.org>; Sun, 18 Apr 2021 13:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10389610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 648891694;
	Sun, 18 Apr 2021 15:48:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 648891694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618753771;
	bh=ZI5QQ/bbj3QBa/D0oJ4bsx8wq8DGJ1ndYzD2xNPE/WU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=da/l5163I+JPZRnccRLLfseHY1FuqYtznEXOqoCOQeR+MppGwV9NKFvQ3FwotpQV0
	 Ujsa1wNI/ce6FW/528sfJV6Wh91tvuF3oKbP4wo30xPl3zGmZWbb3K39HsGxLn9/8S
	 4qVIBc27b1H+g4Uz3HHjj+uH7jcbVA4yKIwAOUUA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EABDF80275;
	Sun, 18 Apr 2021 15:47:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22312F80430; Sun, 18 Apr 2021 15:47:57 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA709F80275
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 15:47:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA709F80275
Received: by mail-qk1-f172.google.com with SMTP id t17so5012451qkg.4
 for <alsa-devel@alsa-project.org>; Sun, 18 Apr 2021 06:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lp/9/DD1lUyADLZD2qHRRtq0jLfJJ3OREWhew5pzIJE=;
 b=pXtD5UAjFEBY4ryK5U58dQ18yoBwtcnptmk2QeCOS0ZrAGXyV2MhJwdJdjf3+UBSaS
 i3MmkVyhGZXDqiJ8fSGYE5SICvbdrnHvyDMHJiDYMkU8XxUIy/RXIfCLrHWzRQW6ROoR
 Rwkd7bN54jz6wwjKh62LNupqCEM7j8OTevNWML1mK/6ZxTTlQKrHq70jLcIDWXd1DoVm
 vO1Xh/4ILIM4/+8FtDgK+uQBY/V6knNuWJUsmwE90ohFTvVNXx+Jd2vy04R9I2k1wCoW
 EHh6rQ57ss8kjLyzfIaJA4njuJZlm4Jceh0MMO6mgO4HmrRmI8t6nJqjtVBITrPjyzdl
 j3eg==
X-Gm-Message-State: AOAM533iuVETI3qn6Mml/UNAh6e6/Jh7XFxqgqtk5bInYAbAggGK8wSm
 fQFJpZHeVjd/e6/MACWqBlQ=
X-Google-Smtp-Source: ABdhPJxj39YC97UG4tTrm0WxuPSKMt9mlC1rvrOoafcPbTP7DUt1Y9v7NxedgXOLs5UX+e8I/t20BA==
X-Received: by 2002:a37:a206:: with SMTP id l6mr7883768qke.5.1618753624457;
 Sun, 18 Apr 2021 06:47:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:5b5f::f3be:e978])
 by smtp.gmail.com with ESMTPSA id p23sm3927937qtl.8.2021.04.18.06.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Apr 2021 06:47:04 -0700 (PDT)
From: David Ward <david.ward@gatech.edu>
To: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: [PATCH 5/5] ASoC: rt286: Generalize support for ALC3263 codec
Date: Sun, 18 Apr 2021 09:46:58 -0400
Message-Id: <20210418134658.4333-6-david.ward@gatech.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210418134658.4333-1-david.ward@gatech.edu>
References: <20210418134658.4333-1-david.ward@gatech.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Shuming Fan <shumingf@realtek.com>, alsa-devel@alsa-project.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mario Limonciello <mario_limonciello@dell.com>
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

The ALC3263 codec on the XPS 13 9343 is also found on the Latitude 13 7350
and Venue 11 Pro 7140. They require the same handling for the combo jack to
work with a headset: GPIO pin 6 must be set.

The HDA driver always sets this pin on the ALC3263, which it distinguishes
by the codec vendor/device ID 0x10ec0288 and PCI subsystem vendor ID 0x1028
(Dell). The ASoC driver does not use PCI, so adapt this check to use DMI to
determine if Dell is the system vendor.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=150601
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205961
Signed-off-by: David Ward <david.ward@gatech.edu>
---
 sound/soc/codecs/rt286.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 45e4a48ef5bf..802f4851c3df 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1125,12 +1125,11 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 	{ }
 };
 
-static const struct dmi_system_id dmi_dell_dino[] = {
+static const struct dmi_system_id dmi_dell[] = {
 	{
-		.ident = "Dell Dino",
+		.ident = "Dell",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343")
 		}
 	},
 	{ }
@@ -1141,7 +1140,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 {
 	struct rt286_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt286_priv *rt286;
-	int i, ret, val;
+	int i, ret, vendor_id;
 
 	rt286 = devm_kzalloc(&i2c->dev,	sizeof(*rt286),
 				GFP_KERNEL);
@@ -1157,14 +1156,15 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	}
 
 	ret = regmap_read(rt286->regmap,
-		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
+		RT286_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &vendor_id);
 	if (ret != 0) {
 		dev_err(&i2c->dev, "I2C error %d\n", ret);
 		return ret;
 	}
-	if (val != RT286_VENDOR_ID && val != RT288_VENDOR_ID) {
+	if (vendor_id != RT286_VENDOR_ID && vendor_id != RT288_VENDOR_ID) {
 		dev_err(&i2c->dev,
-			"Device with ID register %#x is not rt286\n", val);
+			"Device with ID register %#x is not rt286\n",
+			vendor_id);
 		return -ENODEV;
 	}
 
@@ -1188,8 +1188,8 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	if (pdata)
 		rt286->pdata = *pdata;
 
-	if (dmi_check_system(force_combo_jack_table) ||
-		dmi_check_system(dmi_dell_dino))
+	if ((vendor_id == RT288_VENDOR_ID && dmi_check_system(dmi_dell)) ||
+		dmi_check_system(force_combo_jack_table))
 		rt286->pdata.cbj_en = true;
 
 	regmap_write(rt286->regmap, RT286_SET_AUDIO_POWER, AC_PWRST_D3);
@@ -1228,7 +1228,7 @@ static int rt286_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL3, 0xf777, 0x4737);
 	regmap_update_bits(rt286->regmap, RT286_DEPOP_CTRL4, 0x00ff, 0x003f);
 
-	if (dmi_check_system(dmi_dell_dino)) {
+	if (vendor_id == RT288_VENDOR_ID && dmi_check_system(dmi_dell)) {
 		regmap_update_bits(rt286->regmap,
 			RT286_SET_GPIO_MASK, 0x40, 0x40);
 		regmap_update_bits(rt286->regmap,
-- 
2.31.1

