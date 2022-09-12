Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9C3ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Sep 2022 11:56:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0348E1652;
	Mon, 12 Sep 2022 13:55:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0348E1652
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1662983761;
	bh=Isw3WeiwK5MJY5kZmvbChAaUyaoDGysjOw0jH+aOHPE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WYYy691ZdPJ/9T/baPlaS0d1VHu1SpRmQg7TzxNgXkQApzOWu6pdASSJ65+wGsSEJ
	 WuqdvQlLQL3OnvpqcAS8kthlgWZ+P6xi/P1Oz1t6+6B8PuL0IQZb4XAZTzzb51SEGa
	 KwqDN1yum8d8bJCNkit81iyyEqzP+cD6Wejg5des=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AADEF804AC;
	Mon, 12 Sep 2022 13:55:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A547F804E7; Mon, 12 Sep 2022 13:55:09 +0200 (CEST)
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 06EBFF80095
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2022 13:54:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06EBFF80095
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
 by maillog.nuvoton.com (Postfix) with ESMTP id A192A1C81187;
 Mon, 12 Sep 2022 19:54:52 +0800 (CST)
Received: from NTHCCAS03.nuvoton.com (10.1.20.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 12 Sep
 2022 19:54:52 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS03.nuvoton.com
 (10.1.20.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1847.3; Mon, 12 Sep
 2022 19:54:52 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 12 Sep 2022 19:54:52 +0800
From: David Lin <CTLIN0@nuvoton.com>
To: <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: nau8825: Add ADCOUT IO drive strength control
Date: Mon, 12 Sep 2022 19:54:27 +0800
Message-ID: <20220912115427.710417-1-CTLIN0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, ctlin0.linux@gmail.com, WTLI@nuvoton.com,
 SJLIN0@nuvoton.com, KCHSU0@nuvoton.com, lgirdwood@gmail.com,
 YHCHuang@nuvoton.com, David Lin <CTLIN0@nuvoton.com>
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

Add a property to control the driving of ADCOUT.

Signed-off-by: David Lin <CTLIN0@nuvoton.com>
---
 sound/soc/codecs/nau8825.c | 6 ++++++
 sound/soc/codecs/nau8825.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 8213273f501e..c41ac7b9217b 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1983,6 +1983,10 @@ static void nau8825_init_regs(struct nau8825 *nau8825)
 	/* Disable short Frame Sync detection logic */
 	regmap_update_bits(regmap, NAU8825_REG_LEFT_TIME_SLOT,
 		NAU8825_DIS_FS_SHORT_DET, NAU8825_DIS_FS_SHORT_DET);
+	/* ADCDAT IO drive strength control */
+	regmap_update_bits(regmap, NAU8825_REG_CHARGE_PUMP,
+			   NAU8825_ADCOUT_DS_MASK,
+			   nau8825->adcout_ds << NAU8825_ADCOUT_DS_SFT);
 }
 
 static const struct regmap_config nau8825_regmap_config = {
@@ -2521,6 +2525,7 @@ static void nau8825_print_device_properties(struct nau8825 *nau8825)
 			nau8825->jack_eject_debounce);
 	dev_dbg(dev, "crosstalk-enable:     %d\n",
 			nau8825->xtalk_enable);
+	dev_dbg(dev, "adcout-drive-str:     %d\n", nau8825->adcout_ds);
 }
 
 static int nau8825_read_device_properties(struct device *dev,
@@ -2587,6 +2592,7 @@ static int nau8825_read_device_properties(struct device *dev,
 		nau8825->jack_eject_debounce = 0;
 	nau8825->xtalk_enable = device_property_read_bool(dev,
 		"nuvoton,crosstalk-enable");
+	nau8825->adcout_ds = device_property_read_bool(dev, "nuvoton,adcout-drive-str");
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
 	if (PTR_ERR(nau8825->mclk) == -EPROBE_DEFER) {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 887bbff03ec6..6d112b6145df 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -418,6 +418,8 @@
 #define NAU8825_POWERUP_HP_DRV_L	(1 << 0)
 
 /* CHARGE_PUMP (0x80) */
+#define NAU8825_ADCOUT_DS_SFT	12
+#define NAU8825_ADCOUT_DS_MASK	(1 << NAU8825_ADCOUT_DS_SFT)
 #define NAU8825_JAMNODCLOW	(1 << 10)
 #define NAU8825_POWER_DOWN_DACR	(1 << 9)
 #define NAU8825_POWER_DOWN_DACL	(1 << 8)
@@ -477,6 +479,7 @@ struct nau8825 {
 	int imp_rms[NAU8825_XTALK_IMM];
 	int xtalk_enable;
 	bool xtalk_baktab_initialized; /* True if initialized. */
+	bool adcout_ds;
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_component *component,
-- 
2.25.1

