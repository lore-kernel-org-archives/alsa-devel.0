Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B9CFD5F6C
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:38:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3585C601FE;
	Wed,  8 Apr 2026 07:38:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3585C601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775626693;
	bh=sKQqM4z7PQzEwKzhogMmiy3CqCx9bZDCoYBtFHrLaaA=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XbBot3+xIJAm+vKIgFfPzTP5cHv39GPk2pYCw91lM0K0AT/w4EfCa6lXvpJbBJHZo
	 irGMFIpzWcxDyEzpSxj4AA07jMbDJuOsM8ZbqywiKl7AeltioozrfTKKMf4iUd5dEx
	 HKKPLaw6fb8axU/KzqGV/5QQNUPSvwGPmilOdbNE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0458F805ED; Wed,  8 Apr 2026 07:37:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C033DF805F2;
	Wed,  8 Apr 2026 07:37:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 258A1F80557; Wed,  8 Apr 2026 07:37:30 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 03150F8024C
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 07:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03150F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=Nufah0O7
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6385bIBs92591542,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775626638; bh=VFPXRuUbu6zBi80I7F8m3mSz+YOurF2xBWErVMZgzAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Nufah0O7yfAVzLWj4O5GgP2a4bTapHgM50VgNO3L9PmpeGc7FavNUklpQ8lpIGVBl
	 12kTl6IdEWdkRd0LznIj+jL5JKRyI4ub5WXnU3XXlpd+/go/XxZv9zp3usw7sKzbpn
	 89jbfWjP+h8XbDoSm9XIaf88JTDT0vX4JrUVEQXn/jc2yEX73ZlsSlFLkj1SiNf5ZN
	 9YTS1oMt9ACW13QAaWniutmB4vIikzhDIeuxSWFMRmxgudewRJ53JO4yRYMT/hdMw5
	 ucCK6TdeJo21+VDHrnq1uoZUkJMwXRWFRV/9VGYS966T3ZANWjA9exmONW7WsQqVQJ
	 QA3mJRM5b7RTA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6385bIBs92591542
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 13:37:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 8 Apr 2026 13:37:19 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 8 Apr 2026 13:37:19 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v3 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Date: Wed, 8 Apr 2026 13:37:15 +0800
Message-ID: <20260408053716.3757937-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: HX4UEXVO5TZBSEDOSK2N22BNM3WIEXD3
X-Message-ID-Hash: HX4UEXVO5TZBSEDOSK2N22BNM3WIEXD3
X-MailFrom: jack.yu@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HX4UEXVO5TZBSEDOSK2N22BNM3WIEXD3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Create a kcontrol to enable or disable brown-out dynamically.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 40 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt1320-sdw.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 8bb7e8497c72..84e8768f7881 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -2486,6 +2486,43 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt1320_sdw_priv *rt1320 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	if (!rt1320->hw_init)
+		return 0;
+
+	ret = pm_runtime_resume(component->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
+	rt1320->brown_out = ucontrol->value.integer.value[0];
+
+	if (rt1320->brown_out == 0)
+		regmap_write(rt1320->regmap, 0xdb03, 0x00);
+	else
+		regmap_write(rt1320->regmap, 0xdb03, 0xf0);
+
+
+	return 0;
+}
+
+static int rt1320_brown_out_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt1320_sdw_priv *rt1320 = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = rt1320->brown_out;
+
+	return 0;
+}
+
+
 static int rt1320_r0_temperature_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -2545,6 +2582,8 @@ static const struct snd_kcontrol_new rt1320_snd_controls[] = {
 		rt1320_r0_temperature_get, rt1320_r0_temperature_put),
 	SOC_SINGLE_EXT("RAE Update", SND_SOC_NOPM, 0, 1, 0,
 		rt1320_rae_update_get, rt1320_rae_update_put),
+	SOC_SINGLE_EXT("Brown Out Switch", SND_SOC_NOPM, 0, 1, 0,
+		rt1320_brown_out_get, rt1320_brown_out_put),
 };
 
 static const struct snd_kcontrol_new rt1320_spk_l_dac =
@@ -2904,6 +2943,7 @@ static int rt1320_sdw_init(struct device *dev, struct regmap *regmap,
 	rt1320->fu_dapm_mute = true;
 	rt1320->fu_mixer_mute[0] = rt1320->fu_mixer_mute[1] =
 		rt1320->fu_mixer_mute[2] = rt1320->fu_mixer_mute[3] = true;
+	rt1320->brown_out = 1;
 
 	INIT_WORK(&rt1320->load_dspfw_work, rt1320_load_dspfw_work);
 
diff --git a/sound/soc/codecs/rt1320-sdw.h b/sound/soc/codecs/rt1320-sdw.h
index 5a9f496dd848..4a1d3fc4c8ee 100644
--- a/sound/soc/codecs/rt1320-sdw.h
+++ b/sound/soc/codecs/rt1320-sdw.h
@@ -159,6 +159,7 @@ struct rt1320_sdw_priv {
 	bool hw_init;
 	bool first_hw_init;
 	int version_id;
+	int brown_out;
 	unsigned int dev_id;
 	bool fu_dapm_mute;
 	bool fu_mixer_mute[4];
-- 
2.53.0

