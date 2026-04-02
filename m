Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C6DCC6B00
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2026 06:47:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DC756020B;
	Thu,  2 Apr 2026 08:47:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DC756020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775112438;
	bh=x0D0CB/hDBU5zUUlcpmiUTdAXX2QeIl3eurBUo6XjNg=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jwM22TEa3ttfwZQ0HCBcXHxwjFGZ0N4VDKQ4b0x+Oe5x9YQO7a9HUheBpXSRZcNMz
	 qr9GFuoEId+Vz09Uxr6pJDmMKK0rDILNMrBgwfyA688tPLpjkOI4q4t8MwbGCAws//
	 RCRSJ/VyzLP8Mox6PAFQjGNJPLwgEDNNm+ADvgss=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25A35F8060F; Thu,  2 Apr 2026 08:46:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BEA32F80601;
	Thu,  2 Apr 2026 08:46:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF25DF80496; Thu,  2 Apr 2026 08:46:20 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1EBAF8015B
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 08:46:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1EBAF8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=uOq/KQGg
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6326k4ZE12623308,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775112364; bh=9AATBQoZEwYw7ldQ2TrtW1lz1GmMP161409QeTGaU5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=uOq/KQGgLVX3Ica82FgvwD+qCBOddlsGjZCe2qQj7h+6ZAbx0jfxN6wHM5mhmFr7l
	 FRLYYY8O1YBb6Jim4YtigYq+0w/RPgYUkUuOVAmn/k+f30Xq0p6VZ5QNV7HcJwWR3Q
	 nO3PYSrIFvpim7SHnEedD9rtKd/Asikr90GStnQfA17fm5UE6WMACSj8v1PbDBbXVx
	 DeoceCPsfILuIFjVAlQSBEBaf5T6eB4FyemQ98rmCm/P9oGG8RPo/Bad6mv0WHSM1Z
	 AiOMM8lLCdyIQUx2M17FfTIl9OKRECRET6ban79l/m/MOg8I3R2514dqiWnYgVp/Fl
	 wigD7d5USmgsw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6326k4ZE12623308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 14:46:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 14:46:04 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 2 Apr 2026 14:46:04 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v2 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature
 update
Date: Thu, 2 Apr 2026 14:46:00 +0800
Message-ID: <20260402064601.1799013-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: ONI6AOA6J73NBBYK3NQJM4VCBD223MPR
X-Message-ID-Hash: ONI6AOA6J73NBBYK3NQJM4VCBD223MPR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ONI6AOA6J73NBBYK3NQJM4VCBD223MPR/>
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
index 8bb7e8497c72..a76d3212d741 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -577,6 +577,7 @@ static bool rt1320_volatile_register(struct device *dev, unsigned int reg)
 	case 0xd530:
 	case 0xd540 ... 0xd541:
 	case 0xd543:
+	case 0xdb00 ... 0xdb03:
 	case 0xdb58 ... 0xdb5f:
 	case 0xdb60 ... 0xdb63:
 	case 0xdb68 ... 0xdb69:
@@ -2486,6 +2487,44 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
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
+	regcache_cache_bypass(rt1320->regmap, true);
+
+	if (rt1320->brown_out == 0)
+		regmap_write(rt1320->regmap, 0xdb03, 0x00);
+	else
+		regmap_write(rt1320->regmap, 0xdb03, 0xf0);
+
+	regcache_cache_bypass(rt1320->regmap, false);
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
 static int rt1320_r0_temperature_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
@@ -2545,6 +2584,8 @@ static const struct snd_kcontrol_new rt1320_snd_controls[] = {
 		rt1320_r0_temperature_get, rt1320_r0_temperature_put),
 	SOC_SINGLE_EXT("RAE Update", SND_SOC_NOPM, 0, 1, 0,
 		rt1320_rae_update_get, rt1320_rae_update_put),
+	SOC_SINGLE_EXT("Brown Out Update", SND_SOC_NOPM, 0, 1, 0,
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

