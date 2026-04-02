Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4C8CC6B00
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2026 05:48:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DC4D601F8;
	Thu,  2 Apr 2026 07:48:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DC4D601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775108899;
	bh=KBnKji0CszdBpWJL08v+lSXZeCl0Z1wSsAgqTnOVXXI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Rjg5XcwTbqe3yQrEMkAiTYX4uR4amw9FGPJsnbcwlhNi46pZFAT3f6lSDd5sdwL8l
	 vu9A/H7NiAEMJbodOW8sxABkCQqgKmhd8SPOiQi62sNOAtXUpxKruWYuwERW4H1eZl
	 5tjZD991c9W+2Wk2YhESVgjV4481+KZje1sca8zI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A9C5F805FA; Thu,  2 Apr 2026 07:47:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D632EF805F3;
	Thu,  2 Apr 2026 07:47:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EAF32F80496; Thu,  2 Apr 2026 07:47:35 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26565F8014C
	for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2026 07:47:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26565F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=V3dd0ifm
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6325lORW12537819,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775108844; bh=gN+0NLzLR5/XaJ5py50wzAwzxCQXTjBvboMLM6FKxF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=V3dd0ifmVXreJqLczGKQiL38sjjAjxlUrfqo0IFx+d0jooG2W+qj5oQaDD6j2iQ+/
	 Q3OZzM0M/6Uu+VfTTeUlNnLuzjKM/bHmDX5bmTM4N4XdFhQnz4Mc2uWUsnbJdkpeW/
	 pCfij2avE3usNtWZSXRb5AlHhF6LSV/zz135Ch261z2m5wSQ/aDDIhq565dWBc8pKo
	 fxw929hOTvDW5gZm1DxTX0fUEMP/oeCIjLcZzERiRRBh72nVWNZeq0D7u8c5nYzuJs
	 NV9SozNcrAZ6vh7ppBJOX/SLH0b6unC13mU6aL1KxcdrZOGmgLFZSbHQW/GlcuJdJd
	 aE+4OfwzlcaoQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6325lORW12537819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 13:47:24 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 2 Apr 2026 13:47:24 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Thu, 2 Apr 2026 13:47:24 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH 1/2] ASoC: rt1320-sdw: kcontrol for brown-out feature update
Date: Thu, 2 Apr 2026 13:47:15 +0800
Message-ID: <20260402054716.1795350-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: P3OXDSKPR377FKCAA5UHGUKNGHULLJGJ
X-Message-ID-Hash: P3OXDSKPR377FKCAA5UHGUKNGHULLJGJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/P3OXDSKPR377FKCAA5UHGUKNGHULLJGJ/>
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
 sound/soc/codecs/rt1320-sdw.c | 45 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt1320-sdw.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 8bb7e8497c72..548454c7069e 100644
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
@@ -1015,11 +1016,13 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 	unsigned short l_advancegain, r_advancegain;
 	int ret;
 
+
 	/* Get advance gain/r0 */
 	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 6, &r0_data[0], sizeof(struct rt1320_datafixpoint));
 	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 7, &r0_data[1], sizeof(struct rt1320_datafixpoint));
 	l_advancegain = r0_data[0].advancegain;
 	r_advancegain = r0_data[1].advancegain;
+
 	dev_dbg(dev, "%s, LR advanceGain=0x%x 0x%x\n", __func__, l_advancegain, r_advancegain);
 
 	/* set R0 and enable protection by SetParameter id 6, 7 */
@@ -2486,6 +2489,44 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
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
@@ -2545,6 +2586,8 @@ static const struct snd_kcontrol_new rt1320_snd_controls[] = {
 		rt1320_r0_temperature_get, rt1320_r0_temperature_put),
 	SOC_SINGLE_EXT("RAE Update", SND_SOC_NOPM, 0, 1, 0,
 		rt1320_rae_update_get, rt1320_rae_update_put),
+	SOC_SINGLE_EXT("Brown Out Update", SND_SOC_NOPM, 0, 1, 0,
+		rt1320_brown_out_get, rt1320_brown_out_put),
 };
 
 static const struct snd_kcontrol_new rt1320_spk_l_dac =
@@ -2793,6 +2836,8 @@ static int rt1320_sdw_component_probe(struct snd_soc_component *component)
 		rt1320_r0_load(rt1320);
 	}
 
+	rt1320->brown_out = 1;
+
 	return 0;
 }
 
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

