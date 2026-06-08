Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B4BCD8C9D
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:31:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E680560253;
	Mon,  8 Jun 2026 13:31:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E680560253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780918309;
	bh=Gvf2FB/62al6MAXAH/yyj8tJrfqQJwKPUfaveLcQGb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nc6Y377xRzN2Gj+cjnuR7rE5vuh7JEAZfdzyDLy32OvWgY3C6DaS29q6eDnTKXrRb
	 o3T8KvhKWz36iSgU1j6/tN7fjvOH+X4DkbKmpIH6GVaU9NFX7rj3sb8mIjwqRn7s/m
	 rO3GVKZMBwUNFD7dtg6nZTb2qoSZq/SBmDRYAjUo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83D7CF806A5; Mon,  8 Jun 2026 13:30:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 376ADF806A3;
	Mon,  8 Jun 2026 13:30:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67DCBF80571; Mon,  8 Jun 2026 10:35:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=61.135.153.177
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780907754;
	b=idY9FTfbJ7f6iKaBUFS33bo7+lEirX9Z+iLcBEngL63B4j19aNCeLlcr7SW2UojCUFt/
	 QMtAHjFuUgAUH/NaonCFtv/coNxQURElg3lyUrt/eCTNkjPErPVA4Bp+YTAVHurT8evxW
	 te3lZDp+KnMN1T0pJd0+R3vvLU8sFjHVD1msP/K1EcCDzDeSxA2pPru0VSC0TUYsR+Icz
	 pgBpEbj/QaRs6O9tPYRZQlehBkEQh6+uw9CIRDwVt1p3II14v8jLWJR88SOjvsMTZnslH
	 2DP7OzxyVhNYdfoBwVoOWnpzkkkQQgj8WyRIZRrNSXY4wleQ7g4OaeMF5OdDX45SOMA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780907754;
	h=From:To:Subject:Date:Message-Id;
	bh=Gvf2FB/62al6MAXAH/yyj8tJrfqQJwKPUfaveLcQGb4=;
	b=Wjql8POJWOFiKVnKI8g+XD7QdlDHi54Sb9muSBnBlMmCNIzuvFyf/nIIkoUbd0uyZlh/
	 HuYBcHL2LeCmVer0oo20xz+LtgkQYRWBAND+YxFVIf5u6qa8lGgERhguZLAFLfdMqYZg6
	 3IRzVNhXlzKHglhw9f4NXPrT4i50yDs1I3DCJ7ruq3wR4a8qNE3A+GjfF/WU39RT6rohm
	 CiAROBUl3Z7vvuH1yNjDdaqJ5fqmZh7uY1/7NM1chNRBQtzkuYZcDnxt5m59y+UD7ji+/
	 gH2TXlUm7+T+zgzpp/1GkfDV7mRIVZzMdtkGB4+VossVqhTzfFLsG5IP5fgSxgtNksQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=61.135.153.177
Received: from smtp153-177.sina.com.cn (smtp153-177.sina.com.cn
 [61.135.153.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01BCDF80301
	for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2026 10:35:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01BCDF80301
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.38) with ESMTP
	id 6A267EDF00000BB8; Mon, 8 Jun 2026 16:35:49 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 107109EA907043CA9C1FDC3B15178E21
X-SMAIL-UIID: 107109EA907043CA9C1FDC3B15178E21-20260608-163549
From: Michael Zhang <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v0 5/7] ASoC: codecs: ES8389: Add private members related to
 HPF
Date: Mon,  8 Jun 2026 16:35:38 +0800
Message-Id: <20260608083540.12581-6-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260608083540.12581-1-zhangyi@everest-semi.com>
References: <20260608083540.12581-1-zhangyi@everest-semi.com>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: F6KDN3IRZIEWIWUKPWGNEZZ2VNT2EFOH
X-Message-ID-Hash: F6KDN3IRZIEWIWUKPWGNEZZ2VNT2EFOH
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:30:12 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F6KDN3IRZIEWIWUKPWGNEZZ2VNT2EFOH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Yi <zhangyi@everest-semi.com>

Add private members related to HPF.
And defines ES8389_HPF_DEFAULT

Signed-off-by: Zhang Yi <zhangyi@everest-semi.com>
---
 sound/soc/codecs/es8389.c | 18 ++++++++++++++++--
 sound/soc/codecs/es8389.h |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/es8389.c b/sound/soc/codecs/es8389.c
index ad016c255c77..743cfca2a6ab 100644
--- a/sound/soc/codecs/es8389.c
+++ b/sound/soc/codecs/es8389.c
@@ -36,6 +36,8 @@ struct	es8389_private {
 	unsigned int sysclk;
 	int mastermode;
 
+	u8 hpfl;
+	u8 hpfr;
 	u8 mclk_src;
 	u8 vddd;
 	int version;
@@ -742,8 +744,8 @@ static int es8389_mute(struct snd_soc_dai *dai, int mute, int direction)
 			regmap_update_bits(es8389->regmap, ES8389_DAC_FORMAT_MUTE,
 						0x03, 0x00);
 		} else {
-			regmap_update_bits(es8389->regmap, ES8389_ADC_HPF1, 0x0f, 0x0a);
-			regmap_update_bits(es8389->regmap, ES8389_ADC_HPF2, 0x0f, 0x0a);
+			regmap_update_bits(es8389->regmap, ES8389_ADC_HPF1, 0x0f, es8389->hpfl);
+			regmap_update_bits(es8389->regmap, ES8389_ADC_HPF2, 0x0f, es8389->hpfr);
 			regmap_update_bits(es8389->regmap, ES8389_ADC_FORMAT_MUTE,
 						0x03, 0x00);
 		}
@@ -905,6 +907,18 @@ static int es8389_probe(struct snd_soc_component *component)
 		es8389->mclk_src = ES8389_MCLK_SOURCE;
 	}
 
+	ret = device_property_read_u8(component->dev, "everest,hpfl", &es8389->hpfl);
+	if (ret != 0) {
+		dev_dbg(component->dev, "hpfl return %d", ret);
+		es8389->hpfl = ES8389_HPF_DEFAULT;
+	}
+
+	ret = device_property_read_u8(component->dev, "everest,hpfr", &es8389->hpfr);
+	if (ret != 0) {
+		dev_dbg(component->dev, "hpfr return %d", ret);
+		es8389->hpfr = ES8389_HPF_DEFAULT;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(es8389_core_supplies); i++)
 		es8389->core_supply[i].supply = es8389_core_supplies[i];
 	ret = devm_regulator_bulk_get(component->dev, ARRAY_SIZE(es8389_core_supplies), es8389->core_supply);
diff --git a/sound/soc/codecs/es8389.h b/sound/soc/codecs/es8389.h
index 13ce241774dc..197e6f7b27e9 100644
--- a/sound/soc/codecs/es8389.h
+++ b/sound/soc/codecs/es8389.h
@@ -105,6 +105,7 @@
 
 #define ES8389_MIC_SEL_MASK           (7 << 4)
 #define ES8389_MIC_DEFAULT            (1 << 4)
+#define ES8389_HPF_DEFAULT            (0x0A << 0)
 
 #define ES8389_MASTER_MODE_EN         (1 << 0)
 
-- 
2.54.0.windows.1

