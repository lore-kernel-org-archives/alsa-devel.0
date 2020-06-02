Return-Path: <SRS0=S7Ib=7P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96526C433DF
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:14:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF1920757
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="O20Pf8C1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rReqGolW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF1920757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A76431682;
	Tue,  2 Jun 2020 15:14:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A76431682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591103696;
	bh=N2rWJsd3Hrt539rhQym5n5TKuHdZJkU7tBoFXjyCrNs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O20Pf8C1d4F6/YVCISJ6YN4OpuL2VfJj55izsdick15e0NZw48jRgpmGATqOGnb2y
	 ktEBIK/vX5dDwgHJLdmJWJjq89600E1yGtiVUj8CVEnen8LMkOJmEmsLK2VKF8NVx7
	 M3FikvZMKhxuvjBBqhogz31QLv+GsCUtjr/yO8rY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 372E0F802BC;
	Tue,  2 Jun 2020 15:10:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 494EBF8026F; Tue,  2 Jun 2020 07:22:26 +0200 (CEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98567F8013D
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2020 07:22:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98567F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="rReqGolW"
Received: by mail-pg1-x543.google.com with SMTP id o6so4566506pgh.2
 for <alsa-devel@alsa-project.org>; Mon, 01 Jun 2020 22:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WY3St8+SWf4wEhHBKrMkn8Xlor+pIsruZlmu3rGaWJM=;
 b=rReqGolWqaYRssGVPmbgXDPyNeTnW9d4LfMU0X1S/fS6VCVWJcVZnq3sZGxb3KVPFR
 Af+fHDcVv6SIxKMqjblRi0tA8HxbMEwJrvY2mPyq866BfRif+03bBv6muDFOeXESXZhf
 FLy7Y2q9psRzKWrUtXW6c5QSNqWrrZoBmptnS4gHRqn1ClCKLmkYgVCyUQAA8Y/XVV9q
 5MNZ2U3+uEJ5uIkctOaaAR9RIR2xqsPw40ebW9RYtOt4J5okgnAsdwCjvivKOpOcnCQy
 Gkmf6ClTr647LkRdPUM5Bgga63FfSno+KHkLRmH7V4W3f+gjlsd++8ST3hfiiyixsEl7
 CPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WY3St8+SWf4wEhHBKrMkn8Xlor+pIsruZlmu3rGaWJM=;
 b=bY8HyPR5oruU4TZGzQDu2nvHmxorl5bZWJ2BNUhSkxYSZ/pyO+/xBnonIoBuFO8YGg
 20dCsADNW1Dzr9kcH/LM88rN4C7JEnt4z13RJIP0qIe4Jk9nOja4yQ4pSfsbWrCxX8Jv
 jGoSc1Z0PMgFP8ehVeOnAgNWvheP5clsWuiSS/uixtdCmtK+7xIdLyD0shlRtDFTSVBn
 Nh8ouFzVhpBZg/i3TFcgYnPDynHNnvUGrzh0wA+mWysX7NyQ24xBCGB7jNYgi00KLaK+
 eGn4Rw3NtijcnJ8V5GnPOlXa4yG78rGdJLXaQg2r0iYVv+T7ZgFmzubtWU9AwyEMgqyr
 5lFw==
X-Gm-Message-State: AOAM5301faz1CuSwA53rVGYK5KNVahaS6QMiZBYiElWByMsklOo6xaru
 7QLIJgTYxoedGS5xwRYzoVU=
X-Google-Smtp-Source: ABdhPJw/uZAxw/xGEynFE19YqUSgqA6mgBmdHzhCB//p+E/r9QBgWC0X99sSYkRQWUWKWqRRBHGJzQ==
X-Received: by 2002:a63:3347:: with SMTP id z68mr23499297pgz.61.1591075339674; 
 Mon, 01 Jun 2020 22:22:19 -0700 (PDT)
Received: from cvds-vagarw7.iind.intel.com ([192.55.55.41])
 by smtp.googlemail.com with ESMTPSA id f18sm1004764pga.75.2020.06.01.22.22.09
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 22:22:19 -0700 (PDT)
From: Vaibhav Agarwal <vaibhav.sr@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
 Mark Greer <mgreer@animalcreek.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [RESEND PATCH v1 4/6] staging: greybus: audio: Resolve compilation
 error in topology parser
Date: Tue,  2 Jun 2020 10:51:13 +0530
Message-Id: <6131fec4cf9e18dbf70fa7f992de9d588299ee18.1591040859.git.vaibhav.sr@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1591040859.git.vaibhav.sr@gmail.com>
References: <cover.1591040859.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jun 2020 15:10:44 +0200
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Vaibhav Agarwal <vaibhav.sr@gmail.com>, linux-kernel@vger.kernel.org,
 greybus-dev@lists.linaro.org
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

Fix compilation errors for GB Audio topology parser code with recent
kernel versions.

Signed-off-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
---
 drivers/staging/greybus/audio_topology.c | 130 +++++++++++------------
 1 file changed, 61 insertions(+), 69 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 4ac30accf226..7d5e87341a5c 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -5,8 +5,8 @@
  * Copyright 2015-2016 Linaro Ltd.
  */
 
+#include <linux/greybus.h>
 #include "audio_codec.h"
-#include "greybus_protocols.h"
 
 #define GBAUDIO_INVALID_ID	0xFF
 
@@ -165,15 +165,15 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_info *info;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct gbaudio_codec_info *gbcodec = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(comp->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	data = (struct gbaudio_ctl_pvt *)kcontrol->private_value;
 	info = (struct gb_audio_ctl_elem_info *)data->info;
 
 	if (!info) {
-		dev_err(codec->dev, "NULL info for %s\n", uinfo->id.name);
+		dev_err(comp->dev, "NULL info for %s\n", uinfo->id.name);
 		return -EINVAL;
 	}
 
@@ -193,7 +193,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 		uinfo->value.enumerated.items = max;
 		if (uinfo->value.enumerated.item > max - 1)
 			uinfo->value.enumerated.item = max - 1;
-		module = find_gb_module(gbcodec, kcontrol->id.name);
+		module = find_gb_module(gb, kcontrol->id.name);
 		if (!module)
 			return -EINVAL;
 		name = gbaudio_map_controlid(module, data->ctl_id,
@@ -201,7 +201,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 		strlcpy(uinfo->value.enumerated.name, name, NAME_SIZE);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid type: %d for %s:kcontrol\n",
+		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
 			info->type, kcontrol->id.name);
 		break;
 	}
@@ -216,11 +216,11 @@ static int gbcodec_mixer_ctl_get(struct snd_kcontrol *kcontrol,
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(comp->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -239,7 +239,7 @@ static int gbcodec_mixer_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -262,7 +262,7 @@ static int gbcodec_mixer_ctl_get(struct snd_kcontrol *kcontrol,
 				le32_to_cpu(gbvalue.value.enumerated_item[1]);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid type: %d for %s:kcontrol\n",
+		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
 			info->type, kcontrol->id.name);
 		ret = -EINVAL;
 		break;
@@ -278,11 +278,11 @@ static int gbcodec_mixer_ctl_put(struct snd_kcontrol *kcontrol,
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(comp->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -309,7 +309,7 @@ static int gbcodec_mixer_ctl_put(struct snd_kcontrol *kcontrol,
 				cpu_to_le32(ucontrol->value.enumerated.item[1]);
 		break;
 	default:
-		dev_err(codec->dev, "Invalid type: %d for %s:kcontrol\n",
+		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
 			info->type, kcontrol->id.name);
 		ret = -EINVAL;
 		break;
@@ -328,7 +328,7 @@ static int gbcodec_mixer_ctl_put(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 	}
 
@@ -352,11 +352,7 @@ static int gbcodec_mixer_dapm_ctl_info(struct snd_kcontrol *kcontrol,
 	int platform_max, platform_min;
 	struct gbaudio_ctl_pvt *data;
 	struct gb_audio_ctl_elem_info *info;
-	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	data = (struct gbaudio_ctl_pvt *)kcontrol->private_value;
 	info = (struct gb_audio_ctl_elem_info *)data->info;
 
@@ -387,11 +383,11 @@ static int gbcodec_mixer_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	struct gbaudio_module_info *module;
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(codec_dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -415,7 +411,7 @@ static int gbcodec_mixer_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -429,7 +425,7 @@ static int gbcodec_mixer_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
-	int ret, wi, max, connect;
+	int ret, wi, max;
 	unsigned int mask, val;
 	struct gb_audio_ctl_elem_info *info;
 	struct gbaudio_ctl_pvt *data;
@@ -437,11 +433,12 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	struct gbaudio_module_info *module;
 	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
+	struct snd_soc_dapm_update *update = NULL;
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
+	dev_dbg(codec_dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
 	module = find_gb_module(gb, kcontrol->id.name);
 	if (!module)
 		return -EINVAL;
@@ -458,17 +455,13 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	max = le32_to_cpu(info->value.integer.max);
 	mask = (1 << fls(max)) - 1;
 	val = ucontrol->value.integer.value[0] & mask;
-	connect = !!val;
 
 	/* update ucontrol */
 	if (gbvalue.value.integer_value[0] != val) {
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
 			widget = wlist->widgets[wi];
-
-			widget->value = val;
-			widget->dapm->update = NULL;
-			snd_soc_dapm_mixer_update_power(widget, kcontrol,
-							connect);
+			snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol,
+							val, update);
 		}
 		gbvalue.value.integer_value[0] =
 			cpu_to_le32(ucontrol->value.integer.value[0]);
@@ -484,7 +477,7 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		gb_pm_runtime_put_autosuspend(bundle);
 
 		if (ret) {
-			dev_err_ratelimited(codec->dev,
+			dev_err_ratelimited(codec_dev,
 					    "%d:Error in %s for %s\n", ret,
 					    __func__, kcontrol->id.name);
 			return ret;
@@ -553,11 +546,11 @@ static int gbcodec_enum_ctl_get(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	int ret, ctl_id;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
 	struct gb_bundle *bundle;
 
 	module = find_gb_module(gb, kcontrol->id.name);
@@ -580,7 +573,7 @@ static int gbcodec_enum_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -598,11 +591,11 @@ static int gbcodec_enum_ctl_put(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_value *ucontrol)
 {
 	int ret, ctl_id;
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_component *comp = snd_soc_kcontrol_component(kcontrol);
+	struct gbaudio_codec_info *gb = snd_soc_component_get_drvdata(comp);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
 	struct gb_bundle *bundle;
 
 	module = find_gb_module(gb, kcontrol->id.name);
@@ -613,13 +606,13 @@ static int gbcodec_enum_ctl_put(struct snd_kcontrol *kcontrol,
 	if (ctl_id < 0)
 		return -EINVAL;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] > e->items - 1)
 		return -EINVAL;
 	gbvalue.value.enumerated_item[0] =
 		cpu_to_le32(ucontrol->value.enumerated.item[0]);
 
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] > e->items - 1)
 			return -EINVAL;
 		gbvalue.value.enumerated_item[1] =
 			cpu_to_le32(ucontrol->value.enumerated.item[1]);
@@ -637,8 +630,8 @@ static int gbcodec_enum_ctl_put(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
-				    __func__, kcontrol->id.name);
+		dev_err_ratelimited(comp->dev, "%d:Error in %s for %s\n",
+				    ret, __func__, kcontrol->id.name);
 	}
 
 	return ret;
@@ -659,13 +652,13 @@ static int gbaudio_tplg_create_enum_kctl(struct gbaudio_module_info *gb,
 	gb_enum = &ctl->info.value.enumerated;
 
 	/* since count=1, and reg is dummy */
-	gbe->max = le32_to_cpu(gb_enum->items);
+	gbe->items = le32_to_cpu(gb_enum->items);
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
 
 	/* debug enum info */
-	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->max,
+	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
 		le16_to_cpu(gb_enum->names_length));
-	for (i = 0; i < gbe->max; i++)
+	for (i = 0; i < gbe->items; i++)
 		dev_dbg(gb->dev, "src[%d]: %s\n", i, gbe->texts[i]);
 
 	*kctl = (struct snd_kcontrol_new)
@@ -720,8 +713,8 @@ static int gbcodec_enum_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct gbaudio_module_info *module;
 	struct gb_audio_ctl_elem_value gbvalue;
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_bundle *bundle;
 
@@ -745,7 +738,7 @@ static int gbcodec_enum_dapm_ctl_get(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -768,12 +761,13 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
 	struct gb_audio_ctl_elem_value gbvalue;
 	struct gbaudio_module_info *module;
-	struct snd_soc_codec *codec = widget->codec;
-	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = widget->dapm->dev;
+	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct gb_bundle *bundle;
+	struct snd_soc_dapm_update *update = NULL;
 
-	if (ucontrol->value.enumerated.item[0] > e->max - 1)
+	if (ucontrol->value.enumerated.item[0] > e->items - 1)
 		return -EINVAL;
 
 	module = find_gb_module(gb, kcontrol->id.name);
@@ -797,7 +791,7 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	gb_pm_runtime_put_autosuspend(bundle);
 
 	if (ret) {
-		dev_err_ratelimited(codec->dev, "%d:Error in %s for %s\n", ret,
+		dev_err_ratelimited(codec_dev, "%d:Error in %s for %s\n", ret,
 				    __func__, kcontrol->id.name);
 		return ret;
 	}
@@ -814,7 +808,7 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 	}
 
 	if (e->shift_l != e->shift_r) {
-		if (ucontrol->value.enumerated.item[1] > e->max - 1)
+		if (ucontrol->value.enumerated.item[1] > e->items - 1)
 			return -EINVAL;
 		val |= ucontrol->value.enumerated.item[1] << e->shift_r;
 		mask |= e->mask << e->shift_r;
@@ -837,16 +831,14 @@ static int gbcodec_enum_dapm_ctl_put(struct snd_kcontrol *kcontrol,
 		gb_pm_runtime_put_autosuspend(bundle);
 
 		if (ret) {
-			dev_err_ratelimited(codec->dev,
+			dev_err_ratelimited(codec_dev,
 					    "%d:Error in %s for %s\n", ret,
 					    __func__, kcontrol->id.name);
 		}
 		for (wi = 0; wi < wlist->num_widgets; wi++) {
 			widget = wlist->widgets[wi];
-
-			widget->value = val;
-			widget->dapm->update = NULL;
-			snd_soc_dapm_mux_update_power(widget, kcontrol, mux, e);
+			snd_soc_dapm_mux_update_power(widget->dapm, kcontrol,
+						      val, e, update);
 		}
 	}
 
@@ -868,13 +860,13 @@ static int gbaudio_tplg_create_enum_ctl(struct gbaudio_module_info *gb,
 	gb_enum = &ctl->info.value.enumerated;
 
 	/* since count=1, and reg is dummy */
-	gbe->max = le32_to_cpu(gb_enum->items);
+	gbe->items = le32_to_cpu(gb_enum->items);
 	gbe->texts = gb_generate_enum_strings(gb, gb_enum);
 
 	/* debug enum info */
-	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->max,
+	dev_dbg(gb->dev, "Max:%d, name_length:%d\n", gbe->items,
 		le16_to_cpu(gb_enum->names_length));
-	for (i = 0; i < gbe->max; i++)
+	for (i = 0; i < gbe->items; i++)
 		dev_dbg(gb->dev, "src[%d]: %s\n", i, gbe->texts[i]);
 
 	*kctl = (struct snd_kcontrol_new)
@@ -935,12 +927,12 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
 {
 	int wid;
 	int ret;
-	struct snd_soc_codec *codec = w->codec;
-	struct gbaudio_codec_info *gbcodec = snd_soc_codec_get_drvdata(codec);
+	struct device *codec_dev = w->dapm->dev;
+	struct gbaudio_codec_info *gbcodec = dev_get_drvdata(codec_dev);
 	struct gbaudio_module_info *module;
 	struct gb_bundle *bundle;
 
-	dev_dbg(codec->dev, "%s %s %d\n", __func__, w->name, event);
+	dev_dbg(codec_dev, "%s %s %d\n", __func__, w->name, event);
 
 	/* Find relevant module */
 	module = find_gb_module(gbcodec, w->name);
@@ -950,7 +942,7 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
 	/* map name to widget id */
 	wid = gbaudio_map_widgetname(module, w->name);
 	if (wid < 0) {
-		dev_err(codec->dev, "Invalid widget name:%s\n", w->name);
+		dev_err(codec_dev, "Invalid widget name:%s\n", w->name);
 		return -EINVAL;
 	}
 
@@ -973,7 +965,7 @@ static int gbaudio_widget_event(struct snd_soc_dapm_widget *w,
 		break;
 	}
 	if (ret)
-		dev_err_ratelimited(codec->dev,
+		dev_err_ratelimited(codec_dev,
 				    "%d: widget, event:%d failed:%d\n", wid,
 				    event, ret);
 
-- 
2.26.2

