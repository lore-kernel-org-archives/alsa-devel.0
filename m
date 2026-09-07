Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB5DC79F9E
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:42:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 71CE1601EF;
	Mon,  7 Sep 2026 08:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 71CE1601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788763333;
	bh=cUQg26Y7BfphM87C572AjqXJX1dvaT22BFvC+fey/LA=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=H/hySvAlNnnLpDCggO5NVYlKektnWeGnnX4F9bO9iH+GqBP2dAoe3sCehMVa/2DgH
	 lK/Zu9TBXnlvE+wSd2Ics3errx5JGcGmdMeGQAL2qbA8zZGYwXpdkXlpLUwO91ycDx
	 lhpS5wqE+JJzG960POD1CrxuaQ2qBYmxYgYY2tY8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22BADF805F2; Mon,  7 Sep 2026 08:41:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F9F9F80600;
	Mon,  7 Sep 2026 08:41:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76977F80571; Mon,  7 Sep 2026 08:41:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788763287;
	b=ML2LcqGab28964fzOMuJNE4Vy47gyWC6IQBCCTQInptIn9dR5+mBC/ad4mJu59lH6mJF
	 +akBS9+hqee58YX7LFo6wZe/KZI+R3X4y+xfcP4dpjFdDTutR8GKxCV21ubsRJ7EqREFm
	 l6dYMg5zWLeipoufgopAMFezJ7pyCb/U8eTi1Qq+R93GzsqRNgHx8cu1bQAJo1yku3oqL
	 z96l8V+XBjws7IwMco3XFJ9KGm6tSI3COi0un1fS1TIP4s/7awAnQRjfQnccMcYIzCukO
	 SU1Ng8Sn7TNzP3kccBCei2ATAsoGY7wZ38zKF0WWaRcC32M6+OgiXlA792GND3ixPlg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788763287;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=cUQg26Y7BfphM87C572AjqXJX1dvaT22BFvC+fey/LA=;
	b=ihZcppGuImVq8dIMIBOuCClr8nSDlUXKYVThY8zXsMkI9SI6yOolVPqVm8IiPWTJxXlG
	 HfIcKukA3qHAIrI7v8wD7MeyBU2qIYJOTCx3YvN9VnUhnMUeJuvtkoWl5zQV5A7pOzSsI
	 LRgWiVQ90OhNJQQmEqPfzRiyhzxL+psTjPjQDPLUxv77Of7oki3ak3Kh5N5rWQCqS8gQR
	 xjgwsGKIBHNe8SJIqWbCpAMoytp5qmlIPIVAFlUdjRrFoiLMGh9hmV980f9Qq4dRcTuW0
	 MoHL3LaWc0OwNwtPAanEItoay7SEK3WkfWHCTs8voEftnGkGStE9ct9T9GfyGMZ4g0Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=j+PcXa3K;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E53CF800BD
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 08:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E53CF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=j+PcXa3K
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6876fHprD2576928,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788763277; bh=0+fVx+ue3rFKtHpj7grkEinMFSJLXAx79V2QIZvLu4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=j+PcXa3Kqx7jczd+AwqL9RIUm1zTUkn2Bz9BHdQVMxUW+96r8jbc3dUSD1OSadXJF
	 aU3UrnhVsQUVvnMpybhSe2OLca9vqaQACBpWwFwm83p4WRYeq4svFFqprDCPaBoHY/
	 dhtQHUBs8mxYowD6w544zUCwNRHrolJ/lZdiN8rq1L1euc9lFEO5AyP4FVnJUm4Ao9
	 yOPh4KgVS0ntljbqK9yGzUXe5ieUOYsLLdvl404yD0LCMc7rUst26+plDniJ4ofN87
	 lqZN/jPrpPpi5A9ecARmlH858beV9JUG38par+36IXMyOtL5zdLrXV2Afv/0NkUIOl
	 3NQwm2ZS4MqGg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6876fHprD2576928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 7 Sep 2026 14:41:17 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 7 Sep 2026 14:41:17 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Mon, 7 Sep 2026 14:41:17 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	<Trevor.Wu@mediatek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt712-sdca: reconfigure PLL2 to fix calibration
 time-out
Date: Mon, 7 Sep 2026 14:41:14 +0800
Message-ID: <20260907064114.435697-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: 3KCK5VRV7AJTGLTFPLKDGKCZEU5FM7OO
X-Message-ID-Hash: 3KCK5VRV7AJTGLTFPLKDGKCZEU5FM7OO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3KCK5VRV7AJTGLTFPLKDGKCZEU5FM7OO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Add pll2 reconfiguration sequence in order to fix calibration
time-out issue and to support 24.576MHz MCLK on specific platforms.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt712-sdca-sdw.c |  8 +++
 sound/soc/codecs/rt712-sdca.c     | 88 +++++++++++++++++++++++++++++--
 sound/soc/codecs/rt712-sdca.h     | 18 +++++++
 3 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-sdw.c b/sound/soc/codecs/rt712-sdca-sdw.c
index c50e74e20a88..edba0367d9ce 100644
--- a/sound/soc/codecs/rt712-sdca-sdw.c
+++ b/sound/soc/codecs/rt712-sdca-sdw.c
@@ -18,12 +18,16 @@
 static bool rt712_sdca_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case 0x004d:
 	case 0x201a ... 0x201f:
 	case 0x2029 ... 0x202a:
 	case 0x202d ... 0x2034:
 	case 0x2230 ... 0x2232:
 	case 0x2f01 ... 0x2f0a:
 	case 0x2f35 ... 0x2f36:
+	case 0x2f3a:
+	case 0x2f3d:
+	case 0x2f41:
 	case 0x2f50:
 	case 0x2f54:
 	case 0x2f58 ... 0x2f5d:
@@ -48,6 +52,7 @@ static bool rt712_sdca_readable_register(struct device *dev, unsigned int reg)
 static bool rt712_sdca_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case 0x004d:
 	case 0x201b:
 	case 0x201c:
 	case 0x201d:
@@ -56,6 +61,9 @@ static bool rt712_sdca_volatile_register(struct device *dev, unsigned int reg)
 	case 0x2230:
 	case 0x2f01:
 	case 0x2f35:
+	case 0x2f3a:
+	case 0x2f3d:
+	case 0x2f41:
 	case 0x320c:
 	case SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT_GE49, RT712_SDCA_CTL_DETECTED_MODE, 0):
 	case SDW_SDCA_CTL(FUNC_NUM_HID, RT712_SDCA_ENT_HID01, RT712_SDCA_CTL_HIDTX_CURRENT_OWNER, 0) ...
diff --git a/sound/soc/codecs/rt712-sdca.c b/sound/soc/codecs/rt712-sdca.c
index eda87eb9ab66..a18899649829 100644
--- a/sound/soc/codecs/rt712-sdca.c
+++ b/sound/soc/codecs/rt712-sdca.c
@@ -73,14 +73,59 @@ static int rt712_sdca_index_update_bits(struct rt712_sdca_priv *rt712,
 	return rt712_sdca_index_write(rt712, nid, reg, tmp);
 }
 
+static void rt712_sdca_clk_patch(struct rt712_sdca_priv *rt712)
+{
+	rt712_sdca_index_write(rt712, RT712_VENDOR_REG, 0x65, 0x0000);
+	regmap_write(rt712->regmap, RT712_SDW_ROOT_CLK, 0x03);
+	usleep_range(1000, 1100);
+	regmap_write(rt712->regmap, RT712_SDW_ROOT_CLK, 0x02);
+	usleep_range(1000, 1100);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF2, 0x0080, 0x0000);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF2, 0x001f, 0x0017);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF3, 0x0010, 0x0000);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF1, 0x0081, 0x0001);
+	regmap_write(rt712->regmap, RT712_SDW_ROOT_CLK, 0x03);
+	usleep_range(1000, 1100);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF1, 0x0081, 0x0081);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF2, 0x0080, 0x0080);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF2, 0x001f, 0x0000);
+	regmap_update_bits(rt712->regmap, RT712_PLL2_CONF3, 0x0010, 0x0010);
+	usleep_range(1000, 1100);
+	rt712_sdca_index_write(rt712, RT712_VENDOR_REG, 0x65, 0x0081);
+}
+
+static void rt712_sdca_clk_patch2(struct rt712_sdca_priv *rt712)
+{
+	rt712_sdca_index_update_bits(rt712, RT712_VENDOR_REG, 0x49, 0x0800,
+		0x0000);
+	rt712_sdca_index_update_bits(rt712, RT712_VENDOR_REG, 0x49, 0xf000,
+		0x0000);
+	rt712_sdca_index_write(rt712, RT712_VENDOR_REG, 0x65, 0x0000);
+	rt712_sdca_index_update_bits(rt712, RT712_VENDOR_ANALOG_CTL, 0x0c, 0xc000,
+		0xc000);
+	rt712_sdca_index_update_bits(rt712, RT712_VENDOR_ANALOG_CTL, 0x00, 0xc000,
+		0xc000);
+	regmap_write(rt712->regmap, RT712_SDW_SCALE_CLK0, 0x03);
+	regmap_write(rt712->regmap, RT712_SDW_SCALE_CLK1, 0x03);
+	rt712_sdca_index_write(rt712, RT712_VENDOR_REG, 0x65, 0x0081);
+	regmap_write(rt712->regmap, RT712_SDW_ROOT_CLK, 0x02);
+	usleep_range(1000, 1100);
+	regmap_write(rt712->regmap, RT712_SDW_ROOT_CLK, 0x03);
+	usleep_range(1000, 1100);
+	rt712_sdca_index_write(rt712, RT712_VENDOR_REG, 0x65, 0x0000);
+}
+
 static int rt712_sdca_calibration(struct rt712_sdca_priv *rt712)
 {
 	unsigned int val, loop_rc = 0, loop_dc = 0;
 	struct device *dev;
 	struct regmap *regmap = rt712->regmap;
+	unsigned int clk_base;
 	int chk_cnt = 100;
 	int ret = 0;
 
+	regmap_read(rt712->regmap, RT712_SDW_ROOT_CLK, &clk_base);
+
 	mutex_lock(&rt712->calibrate_mutex);
 	dev = regmap_get_device(regmap);
 
@@ -109,8 +154,35 @@ static int rt712_sdca_calibration(struct rt712_sdca_priv *rt712)
 		if (ret < 0)
 			goto _cali_fail_;
 	}
-	if (loop_dc == chk_cnt)
-		dev_err(dev, "%s, calibration time-out!\n", __func__);
+
+	if (loop_dc == chk_cnt) {
+		if (clk_base == RT712_CLK_FREQ_24_576MHZ) {
+			rt712_sdca_clk_patch(rt712);
+			rt712_sdca_clk_patch2(rt712);
+		}
+		rt712_sdca_index_write(rt712, RT712_VENDOR_REG, RT712_FSM_CTL, 0x4100);
+		rt712_sdca_index_write(rt712, RT712_VENDOR_CALI,
+			RT712_DAC_DC_CALI_CTL1, 0x7883);
+		rt712_sdca_index_write(rt712, RT712_VENDOR_CALI,
+			RT712_DAC_DC_CALI_CTL1, 0xf893);
+		rt712_sdca_index_read(rt712, RT712_VENDOR_CALI,
+			RT712_DAC_DC_CALI_CTL1, &val);
+
+		for (loop_dc = 0; loop_dc < chk_cnt &&
+			(val & RT712_DAC_DC_CALI_TRIGGER); loop_dc++) {
+			usleep_range(10000, 11000);
+			ret = rt712_sdca_index_read(rt712, RT712_VENDOR_CALI,
+					RT712_DAC_DC_CALI_CTL1, &val);
+
+			if (ret < 0)
+				goto _cali_fail_;
+		}
+
+		if (loop_dc == chk_cnt)
+			dev_err(dev, "%s, calibration time-out!\n", __func__);
+		else
+			dev_dbg(dev, "%s, calibration success!\n", __func__);
+	}
 
 	if (loop_dc == chk_cnt || loop_rc == chk_cnt)
 		ret = -ETIMEDOUT;
@@ -1759,9 +1831,13 @@ static void rt712_sdca_va_io_init(struct rt712_sdca_priv *rt712)
 
 static void rt712_sdca_vb_io_init(struct rt712_sdca_priv *rt712)
 {
-	int ret = 0;
 	unsigned int jack_func_status, mic_func_status, amp_func_status;
 	struct device *dev = &rt712->slave->dev;
+	unsigned int clk_base;
+	int ret = 0;
+
+	regmap_read(rt712->regmap, RT712_SDW_ROOT_CLK, &clk_base);
+	dev_dbg(dev, "%s clk_base=%x", __func__, clk_base);
 
 	regmap_read(rt712->regmap,
 		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT712_SDCA_ENT0, RT712_SDCA_CTL_FUNC_STATUS, 0), &jack_func_status);
@@ -1773,6 +1849,12 @@ static void rt712_sdca_vb_io_init(struct rt712_sdca_priv *rt712)
 		__func__, jack_func_status, mic_func_status, amp_func_status);
 
 	rt712_sdca_index_write(rt712, RT712_VENDOR_REG, RT712_JD_CTL3, 0x7778);
+
+	if (clk_base == RT712_CLK_FREQ_24_576MHZ) {
+		rt712_sdca_clk_patch(rt712);
+		rt712_sdca_clk_patch2(rt712);
+	}
+
 	/* DMIC */
 	if ((mic_func_status & FUNCTION_NEEDS_INITIALIZATION) || (!rt712->first_hw_init)) {
 		rt712_sdca_index_write(rt712, RT712_VENDOR_HDA_CTL, RT712_DMIC2_FU_IT_FLOAT_CTL, 0x1526);
diff --git a/sound/soc/codecs/rt712-sdca.h b/sound/soc/codecs/rt712-sdca.h
index 46740281a5c1..6229fe341bb5 100644
--- a/sound/soc/codecs/rt712-sdca.h
+++ b/sound/soc/codecs/rt712-sdca.h
@@ -162,6 +162,16 @@ struct rt712_dmic_kctrl_priv {
 #define RT712_EAPD_HIGH				0x2
 #define RT712_EAPD_LOW				0x0
 
+/* SDW clock root frequency */
+#define RT712_SDW_ROOT_CLK		0x004d
+#define RT712_SDW_SCALE_CLK0		0x0062
+#define RT712_SDW_SCALE_CLK1		0x0072
+
+/* PLL2 config */
+#define RT712_PLL2_CONF1		0x2f3a
+#define RT712_PLL2_CONF2		0x2f3d
+#define RT712_PLL2_CONF3		0x2f41
+
 /* RC Calibration register */
 #define RT712_RC_CAL			0x3201
 
@@ -254,6 +264,14 @@ enum rt712_sdca_version {
 	RT712_VB,
 };
 
+enum {
+	RT712_CLK_FREQ_19_2_MHZ = 1,
+	RT712_CLK_FREQ_24MHZ = 2,
+	RT712_CLK_FREQ_24_576MHZ = 3,
+	RT712_CLK_FREQ_22_5792MHZ = 4,
+};
+
+
 int rt712_sdca_io_init(struct device *dev, struct sdw_slave *slave);
 int rt712_sdca_init(struct device *dev, struct regmap *regmap,
 			struct regmap *mbq_regmap, struct sdw_slave *slave);
-- 
2.54.0

