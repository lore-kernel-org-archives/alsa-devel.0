Return-Path: <SRS0=4hHz=GM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5278C433DB
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Jan 2021 21:11:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54981235FC
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Jan 2021 21:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54981235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 136531713;
	Sat,  9 Jan 2021 22:02:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 136531713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610226215;
	bh=9PvtPhIlfMHntU/0h3GrQGOfLrOJv5XASKT2qQuwklM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l5upNdeJQ4G/Jkk+9/R7lzj9gqMRI0HaumqrD4xa4/uFVTETf2OoBa/QZo30B2tn0
	 dhysDUMiBjKxswWhQGUSE2ubTluC7K6R75QhVVQW3ZhLQ/uA09rFbOMVMIyOs5BvNt
	 dfeBpYe9i1s8A7aCqJBmkg8/JFmXvQjZPTrt3xrY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FF54F80271;
	Sat,  9 Jan 2021 22:01:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FC1EF80271; Sat,  9 Jan 2021 22:01:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 322F8F801F5
 for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2021 22:01:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 322F8F801F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="cgOiMUB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610226088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sS9B04P629NGs1CYa09Ybbr+h9euo70qcVag9QYra1A=;
 b=cgOiMUB8jkYlfyqR/uj1JZ2Iyzi+Dkjzehs+G8mhuOKtqwU0zPh408oxI20YrORwHda+Vv
 7lzERaHBTpLQswYzqjzWoh3A/P5+i9NmygIG96fqiq8zAXXRnQETxLan1TjvY5uSCNm7mw
 wJBQv//OGOenuqA6YT0Lir0e4FJX7JM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Q4bynLTmNtu4DSXC1w7Iww-1; Sat, 09 Jan 2021 16:01:26 -0500
X-MC-Unique: Q4bynLTmNtu4DSXC1w7Iww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E0C5107ACE4;
 Sat,  9 Jan 2021 21:01:25 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E7C760C4D;
 Sat,  9 Jan 2021 21:01:23 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/3] ASoC: Intel: bytcr_rt5640: Add new BYT_RT5640_NO_SPEAKERS
 quirk-flag
Date: Sat,  9 Jan 2021 22:01:17 +0100
Message-Id: <20210109210119.159032-2-hdegoede@redhat.com>
In-Reply-To: <20210109210119.159032-1-hdegoede@redhat.com>
References: <20210109210119.159032-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Cc: Rasmus Porsager <rasmus@beat.dk>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org
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

Some devices, like mini PCs/media/top-set boxes do not have any speakers
at all, an example of the is the Mele PCG03 Mini PC.

Add a new BYT_RT5640_NO_SPEAKERS quirk-flag which when sets does not add
speaker routes and modifies the components and the (optional) long_name
strings to reflect that there are no speakers.

Cc: Rasmus Porsager <rasmus@beat.dk>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 5520d7c80019..dce2df30d4c5 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -71,6 +71,7 @@ enum {
 #define BYT_RT5640_SSP0_AIF2		BIT(21)
 #define BYT_RT5640_MCLK_EN		BIT(22)
 #define BYT_RT5640_MCLK_25MHZ		BIT(23)
+#define BYT_RT5640_NO_SPEAKERS		BIT(24)
 
 #define BYTCR_INPUT_DEFAULTS				\
 	(BYT_RT5640_IN3_MAP |				\
@@ -132,6 +133,8 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk JD_NOT_INV enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER)
 		dev_info(dev, "quirk MONO_SPEAKER enabled\n");
+	if (byt_rt5640_quirk & BYT_RT5640_NO_SPEAKERS)
+		dev_info(dev, "quirk NO_SPEAKERS enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_DIFF_MIC)
 		dev_info(dev, "quirk DIFF_MIC enabled\n");
 	if (byt_rt5640_quirk & BYT_RT5640_SSP0_AIF1) {
@@ -946,7 +949,7 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 		ret = snd_soc_dapm_add_routes(&card->dapm,
 					byt_rt5640_mono_spk_map,
 					ARRAY_SIZE(byt_rt5640_mono_spk_map));
-	} else {
+	} else if (!(byt_rt5640_quirk & BYT_RT5640_NO_SPEAKERS)) {
 		ret = snd_soc_dapm_add_routes(&card->dapm,
 					byt_rt5640_stereo_spk_map,
 					ARRAY_SIZE(byt_rt5640_stereo_spk_map));
@@ -1188,6 +1191,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	static const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3" };
+	__maybe_unused const char *spk_type;
 	const struct dmi_system_id *dmi_id;
 	struct byt_rt5640_private *priv;
 	struct snd_soc_acpi_mach *mach;
@@ -1196,7 +1200,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	bool sof_parent;
 	int ret_val = 0;
 	int dai_index = 0;
-	int i;
+	int i, cfg_spk;
 
 	is_bytcr = false;
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -1335,16 +1339,24 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (byt_rt5640_quirk & BYT_RT5640_NO_SPEAKERS) {
+		cfg_spk = 0;
+		spk_type = "none";
+	} else if (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) {
+		cfg_spk = 1;
+		spk_type = "mono";
+	} else {
+		cfg_spk = 2;
+		spk_type = "stereo";
+	}
+
 	snprintf(byt_rt5640_components, sizeof(byt_rt5640_components),
-		 "cfg-spk:%s cfg-mic:%s",
-		 (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) ? "1" : "2",
+		 "cfg-spk:%d cfg-mic:%s", cfg_spk,
 		 map_name[BYT_RT5640_MAP(byt_rt5640_quirk)]);
 	byt_rt5640_card.components = byt_rt5640_components;
 #if !IS_ENABLED(CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES)
 	snprintf(byt_rt5640_long_name, sizeof(byt_rt5640_long_name),
-		 "bytcr-rt5640-%s-spk-%s-mic",
-		 (byt_rt5640_quirk & BYT_RT5640_MONO_SPEAKER) ?
-			"mono" : "stereo",
+		 "bytcr-rt5640-%s-spk-%s-mic", spk_type,
 		 map_name[BYT_RT5640_MAP(byt_rt5640_quirk)]);
 	byt_rt5640_card.long_name = byt_rt5640_long_name;
 #endif
-- 
2.28.0

