Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C79FE98FB0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Apr 2026 06:02:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F812601EB;
	Thu,  9 Apr 2026 08:02:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F812601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775714537;
	bh=3BGQtntghszMVMdHU5N/zai4MZvuuLL6YF/eIoFsRLo=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=t0ZVEqeOTGu1mjEHimqhFeE9sdj3K9NoUTlGrxmUeg1wrM/2jB9RwbqUiif+69KYR
	 25iBk+6PT3gaCHjhS2vX7vmG+UZglAr+ONPplNiRkzgcDkWAakuh7zt8VMiofHaXzF
	 D23MnZzUcuQVudQuiuq5GKY4VdMCTZlWnQju3Ocw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3CA13F8060E; Thu,  9 Apr 2026 08:01:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6BF20F80610;
	Thu,  9 Apr 2026 08:01:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50D3AF80423; Thu,  9 Apr 2026 08:01:19 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CC80FF800BA
	for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2026 08:01:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC80FF800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=vEo1tmz5
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 639614Qw8498176,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775714464; bh=KLI5Vf88tyOZ9oK15XVlBjuSZX2Ts5Z64Fwcu6cNw1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vEo1tmz5NB9eytwgqQO1pghA+0BkwIozU5dzQZM8qjk7QFqfRNrNgtvkIEoKYORDL
	 bu5EHUc8XwWuxsYfDg65KKzgPW7bri8XwG0cazdFZ3gjdQNk+28IKygob45JmElfGB
	 cw1T6frdxJ17mMEN07rK1hEaCFlvPRreow0RVxVxgc3fCrUB/kvfVI50+zRioc2g6t
	 99CqaCoxc2IS/ovKf7MF2N9M1/YN2SXhp06bvg0VDpo2Te/OqzbIJzwJH681a30QkM
	 EVAJYODSOgG1letZw9FBKbeqHU3xAWGkvyzFqKoxR4RIXs3gkfhniOgv8hsJh9ILmz
	 oGKNELEjPeTKw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 639614Qw8498176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 14:01:04 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 9 Apr 2026 14:01:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 9 Apr 2026 14:01:04 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 9 Apr 2026 14:01:04 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v4 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Date: Thu, 9 Apr 2026 14:01:01 +0800
Message-ID: <20260409060102.4177554-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: ZJGFPZTUOO2UMTEAQ6XAB544DIZDXACS
X-Message-ID-Hash: ZJGFPZTUOO2UMTEAQ6XAB544DIZDXACS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZJGFPZTUOO2UMTEAQ6XAB544DIZDXACS/>
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
 sound/soc/codecs/rt1320-sdw.c | 42 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt1320-sdw.h |  1 +
 2 files changed, 43 insertions(+)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 8bb7e8497c72..168d2f391723 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -2486,6 +2486,45 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt1320_sdw_priv *rt1320 = snd_soc_component_get_drvdata(component);
+	int ret, changed = 0;
+
+	if (!rt1320->hw_init)
+		return 0;
+
+	ret = pm_runtime_resume(component->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
+	if (rt1320->brown_out != ucontrol->value.integer.value[0]) {
+		changed = 1;
+		rt1320->brown_out = ucontrol->value.integer.value[0];
+	}
+
+	if (rt1320->brown_out == 0)
+		regmap_write(rt1320->regmap, 0xdb03, 0x00);
+	else
+		regmap_write(rt1320->regmap, 0xdb03, 0xf0);
+
+
+	return changed;
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
 static int rt1320_r0_temperature_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -2545,6 +2584,8 @@ static const struct snd_kcontrol_new rt1320_snd_controls[] = {
 		rt1320_r0_temperature_get, rt1320_r0_temperature_put),
 	SOC_SINGLE_EXT("RAE Update", SND_SOC_NOPM, 0, 1, 0,
 		rt1320_rae_update_get, rt1320_rae_update_put),
+	SOC_SINGLE_EXT("Brown Out Switch", SND_SOC_NOPM, 0, 1, 0,
+		rt1320_brown_out_get, rt1320_brown_out_put),
 };
 
 static const struct snd_kcontrol_new rt1320_spk_l_dac =
@@ -2904,6 +2945,7 @@ static int rt1320_sdw_init(struct device *dev, struct regmap *regmap,
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

