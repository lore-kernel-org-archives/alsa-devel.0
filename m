Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FBFD35163
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:32:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39F05601A6;
	Wed,  1 Apr 2026 11:32:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39F05601A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775035951;
	bh=5S6QHrCx/Fzjv3lOkAi6TBvW7o6srVV+MMxG26wytew=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Yg70MM2FjyR8axfxMh37zkl4Fu9rUQWzGGBkRapAFjjywmysPmFgQ1YreWtbnkTRA
	 099rZhwGpb4CPRi/WMyJJKd6QwA+0NRVYSTPWV61m1WTdJOEqZmU+o6PbZrF6JOmFH
	 u+eaXp/4lOzBDNhd032dE+lFJ/3qhcJX9ylwsDvs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 987FBF805E5; Wed,  1 Apr 2026 11:31:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D741F805F2;
	Wed,  1 Apr 2026 11:31:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55130F80527; Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD2BEF80185
	for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2026 11:31:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD2BEF80185
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=qSMTnxA8
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6319VMNE0836723,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775035882; bh=eN1ayyksWZ0P+CbuYYb9/v0wgimahvFiRd8+X984N+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=qSMTnxA8TiR1IrW/eJKEoxePcQHHK1e/M3p88Cl2sV5LVyfQlNBRX0047h1gS8ylg
	 le9p0mYMKX9R6MVO341JqE642vvlQjGVFGo7MKCIIfMDaUUEzBhKXHsKn7/ibd9x6H
	 YyfKGDdXehcx2Uxr/rl4Qanyne1sSGMNZDXRZeXPphhr3vqUlngrO6cPprAcVFwgyG
	 aC2Kcl/r5jSdQaoJMqwJIDwD01bZENcby20wWdd2rAMT1zkZDsJYcSQoDKwyTKm6UF
	 WHhtKFqw0rTcn72Rr0tJEXUlBG2BjPZCKB15hRdykkF+SGL6yHAorwA1svUigOx1d6
	 4I6Uq8qvyg78g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6319VMNE0836723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 17:31:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 17:31:21 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 1 Apr 2026 17:31:10 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Wed, 1 Apr 2026 17:31:10 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <shumingf@realtek.com>,
        <derek.fang@realtek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt1320-sdw: kcontrol for brown-out feature switch
Date: Wed, 1 Apr 2026 17:31:07 +0800
Message-ID: <20260401093107.632673-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: 2KOP5Z4SJXPQGGTRGS7T3FJT6RGK2FE6
X-Message-ID-Hash: 2KOP5Z4SJXPQGGTRGS7T3FJT6RGK2FE6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2KOP5Z4SJXPQGGTRGS7T3FJT6RGK2FE6/>
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
 sound/soc/codecs/rt1320-sdw.c | 47 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rt1320-sdw.h |  1 +
 2 files changed, 48 insertions(+)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 8bb7e8497c72..40da3fea1c64 100644
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
@@ -2299,6 +2300,14 @@ static SOC_ENUM_SINGLE_DECL(rt1320_rx_data_ch_enum,
 	SDW_SDCA_CTL(FUNC_NUM_AMP, RT1320_SDCA_ENT_PPU21, RT1320_SDCA_CTL_POSTURE_NUMBER, 0), 0,
 	rt1320_rx_data_ch_select);
 
+static const char * const rt1320_brown_out_mode[] = {
+	"On",
+	"Off",
+};
+
+static SOC_ENUM_SINGLE_DECL(rt1320_brown_out_enum, 0, 0,
+	rt1320_brown_out_mode);
+
 static const DECLARE_TLV_DB_SCALE(out_vol_tlv, -6525, 75, 0);
 static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -1725, 75, 0);
 
@@ -2486,6 +2495,42 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
+	struct rt1320_sdw_priv *rt1320 = snd_soc_component_get_drvdata(component);
+	struct device *dev = &rt1320->sdw_slave->dev;
+	int ret, tmp;
+
+	ret = pm_runtime_resume(component->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
+	rt1320->brown_out = ucontrol->value.integer.value[0];
+	regcache_cache_bypass(rt1320->regmap, true);
+
+	if (rt1320->brown_out == 1)
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
@@ -2545,6 +2590,8 @@ static const struct snd_kcontrol_new rt1320_snd_controls[] = {
 		rt1320_r0_temperature_get, rt1320_r0_temperature_put),
 	SOC_SINGLE_EXT("RAE Update", SND_SOC_NOPM, 0, 1, 0,
 		rt1320_rae_update_get, rt1320_rae_update_put),
+	SOC_ENUM_EXT("Brown Out Switch", rt1320_brown_out_enum,
+		rt1320_brown_out_get, rt1320_brown_out_put),
 };
 
 static const struct snd_kcontrol_new rt1320_spk_l_dac =
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

