Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF18DC79FB7
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:42:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6894602BB;
	Wed,  9 Sep 2026 15:41:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6894602BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788961329;
	bh=4ioxSVu29nQizZw2gwRUmxCUlnFwBRNdSeEsQZ8v38k=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GVS1iodCpfcFlnIzEbwG5pD6yow3hkmgVOiflxaEvVpWbQXwXb5txcgWjDTd474DE
	 cEMLBRnrHgx3Vv6QBsv8x6cp56YEKsUNQJgoXZo97qymyLyJI30kkKCrBoacoBLSNc
	 tjvnmT/dtndM+YhnMuLkNgu4cpFDq1aMwTeBvEiE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B153EF80603; Wed,  9 Sep 2026 10:55:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C5F6F805F9;
	Wed,  9 Sep 2026 10:55:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08B02F805BE; Wed,  9 Sep 2026 10:55:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788944110;
	b=A65Jm5fHINqa1OEhCD3Rql0cenDa1LisTm09XCE7f+HMbfC1DEvBO5NIxi+iOy4ica8F
	 ljWo1Z8J95gEYJ9hMo9FmzYu1Sj2yuu9YinQgEUsD9NWqkheJM32UL+aQBVp9Z4gSsvX4
	 uW2JPpNFpGOYK3Jm1TWJnGTTbOFvbQArK6aahFSdqjw40mzWoj049ODz34FO+gGQCGo04
	 nC+iohVx9lipOOTW5v4ri0S3mqapn3zmRKkGcKA9xkymKcGdtgwjMkXtTcEyZaDMOlD9Y
	 wKSCxrje8cM7YAVD6wDhtwu+0fYJeYB5onDqwiI8rCQfiJDQK8O0iquV1mig+Cz08uw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788944110;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4ioxSVu29nQizZw2gwRUmxCUlnFwBRNdSeEsQZ8v38k=;
	b=Qrhl8enpEY/KiStEWsP6Niq1dcXkep2DvKBkFVSmHVaKaYRBh3v0VKdsrCDd9eSJXFmm
	 PHkXvtD3iTRn3SSY8FRjjmFUVe2+evekENf77so7cMGOgfgGMD761yFrC+uc6Ngx95bVr
	 WLFSqo/qZfmYrmPZ45fYRoQa/SQSLHcAKDEbFxFL6xhGX9aU24dGEox+9bvxw6bwu0kOU
	 h6G1gco8lsjJQokOz/UOoyuOQXhgTYqmJBRr2eVoh0zYRMlkw75/yQLnfYpddt8lNsx+j
	 bPSGOQhl4v6WCL+LNYuapA43+bVzJdHh3sNB5Bb6m9Q+dkRkORL5n1i8EGYQYlWM+lQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=vS1ju3q1;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 246F5F8055C
	for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2026 10:55:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 246F5F8055C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=vS1ju3q1
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6898st2M3415592,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788944096; bh=k0ZqGjOY5Io+1fyy12CIAXXzhHyrPA22Bq6Ppw087nU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vS1ju3q1nmrOWsc32aB300fBM7PFzxifeMUgAoFhJTIwWClf16ELFyVVtiwXwEI4J
	 m7HWtzlFwQhifGEeFqrYpCJkJNH2vi6ZxlghvTm1NyuUsrrP6Ua6SReNLoAjkhBA4g
	 gIfsESOOPQET2FtpJ/zdcb+2j2V7GwZsFLgxYUAuiYbdIqMKaUhSHsyV13VLali7YX
	 /BjfDimSJaE1ABwtdBORN+D9HsIPfUzseWHDtqJGMnFEUAnPF28IO85r9uBZ+NXGbV
	 Al/gjXM/qOVFlTHdG8T3dYtmE8c01/gXyuILu1iGIrca1MnyKd/UFxG+avDZrmcT12
	 rN4s/S++2SoNg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6898st2M3415592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 16:54:56 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 9 Sep 2026 16:54:54 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Wed, 9 Sep 2026 16:54:53 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	<Trevor.Wu@mediatek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v2] ASoC: rt712-sdca: reconfigure PLL2 to fix calibration
 time-out
Date: Wed, 9 Sep 2026 16:54:49 +0800
Message-ID: <20260909085449.862350-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: BCD7PCPDE76K7U455KFNRJELPLR4AUBR
X-Message-ID-Hash: BCD7PCPDE76K7U455KFNRJELPLR4AUBR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BCD7PCPDE76K7U455KFNRJELPLR4AUBR/>
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
 sound/soc/codecs/rt712-sdca.c     | 86 +++++++++++++++++++++++++++++--
 sound/soc/codecs/rt712-sdca.h     | 18 +++++++
 3 files changed, 109 insertions(+), 3 deletions(-)

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
index eda87eb9ab66..38052cb19790 100644
--- a/sound/soc/codecs/rt712-sdca.c
+++ b/sound/soc/codecs/rt712-sdca.c
@@ -73,14 +73,57 @@ static int rt712_sdca_index_update_bits(struct rt712_sdca_priv *rt712,
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
 
@@ -109,8 +152,35 @@ static int rt712_sdca_calibration(struct rt712_sdca_priv *rt712)
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
@@ -1759,9 +1829,13 @@ static void rt712_sdca_va_io_init(struct rt712_sdca_priv *rt712)
 
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
@@ -1773,6 +1847,12 @@ static void rt712_sdca_vb_io_init(struct rt712_sdca_priv *rt712)
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

