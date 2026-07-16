Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D035C43458
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:16:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13D78601EB;
	Thu, 16 Jul 2026 08:16:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13D78601EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784182600;
	bh=wiursl9G7uSwxn8aLUJ53c6sAw9EnkR7IIqE/fo/+Js=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=u1tb0g6LWf9+3ia0IyIGwIAljTovut/9nZeMl3C29PwpAprrefdW35PuHoHiFZf8i
	 RGJNyM5O8Nk3wlyWRx6ibVsGM7IQ8k857dBVqMPZ0x4Syuu7cGB/+ZUvWLtMz9G7Fx
	 lvY6svt8D62+L7gCVdGHsn/khK668urr+2Kb/MAo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 531DEF805FF; Thu, 16 Jul 2026 08:16:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB42EF805F5;
	Thu, 16 Jul 2026 08:16:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E24F0F80527; Thu, 16 Jul 2026 08:15:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784182555;
	b=riZjsBml69gBSHUUAGMtOkPgsuOwRAsy00KjtRQhiTbi0ER6I1WYdkapcHIEf/A6FUsy
	 CyxnU+Fw/QP9dF5bToJps2ipxZEikGbWiz7B1Ycy9tb7q/t908OLRz6Q9B94M962Tw0DB
	 VlSpeFM2J/12aKWgTgdPYNrxNlJSQRBVTFh++PBVj6n0iUyzBIL7MCLcaMmvjj+76AzKH
	 riyKX16BIw8y76XsZPNvNq9nQsyg4CgUpHgwQRTiShumCtCN3AkauZBY8VDpxp9LP5AzM
	 cddZXqhyWvUMm7jobA8WpAiYoGvKf/ipJE1cCjN6uOWTE0IBE6ZsF+o0iaNyJlFK1pA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784182555;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wiursl9G7uSwxn8aLUJ53c6sAw9EnkR7IIqE/fo/+Js=;
	b=KFOC7sXRUMAotqji1sVZGoc5ZnFr+T1Vo9uGf1XA33Wtg9/+oTo6YzFlQ5eHi8/8X3x8
	 hL6WBmk7C9fyulsMimKxHigzCG9P74+oi9UrlUUPfERAz/YMzQtCzVpvQsDYQzmqU+w6f
	 XWkjtFxbMekUjdgrNc5xhRI+8FblFAXdD5TqobmZ8X/yy6ACoxXTEzKKhX9YVzISxF0mK
	 ylpoUunYm7EpXKBfw0AbbVb1m3QbEVDzBkbzj/iX2BD2eurhtIWD5Ov0k362kemxn8lvj
	 90IDXqMV1IrIc8kHza/KHuhSENar8r6v2IYuYUqkKP0wTCzyyFz+gxR6BmkiCA1EzXQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=BKCk5AJw;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7C12CF8051E
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2026 08:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C12CF8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=BKCk5AJw
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66G6FhtlE3434072,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784182543; bh=nyMf98TFH0bNWWeloNqxdcbkggrXKMaqMLygedrrxmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=BKCk5AJwgOdFJ1w0e0pMwWKOEsQlLdyDblCu3WJpAkM7T0+5OXQVUF29EzsFT3JJw
	 qfivNDkHkCbSXudmo8ZnF3JPX/5QF3sVxhxtkAia/arzsysvEJG/aWgcMj7enx9nQv
	 JycWY4TySNUZjeDdX7Eu9GT4FqP5fHn0bx2WNX9XJ/7/2xLkBWc1dXXi28iO4I1gx8
	 bMIcq8W8zn77TV/DS65cc/oO/n5hOWDg7wrF6pm2XsvaOh8tRpoxOXrIgsHr+irbAg
	 hlZOGGzm1c55HXqTWI50Y3FdYlg7QVfD1OtFI2SIcmz0fMoWivx1FOAcI0YARIdxmc
	 ACAbMFEgMwi8w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66G6FhtlE3434072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 14:15:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Jul 2026 14:15:43 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Jul 2026 14:15:42 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.2562.17 via Frontend Transport; Thu, 16 Jul 2026 14:15:41 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	<Trevor.Wu@mediatek.com>, Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt1320-sdw: Add settings to support more base clock
 frequency
Date: Thu, 16 Jul 2026 14:15:36 +0800
Message-ID: <20260716061536.1563252-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: DGWIBU4WTJQJ6XEHR5ME4GKMR4IY73UU
X-Message-ID-Hash: DGWIBU4WTJQJ6XEHR5ME4GKMR4IY73UU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DGWIBU4WTJQJ6XEHR5ME4GKMR4IY73UU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Add settings to support more base clock frequency on different platform.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 36 ++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/rt1320-sdw.h |  7 +++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index a30fb575918d..3a5eebcfefdd 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -836,6 +836,7 @@ static const struct reg_default rt1320_mbq_defaults[] = {
 static bool rt1320_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case 0x004d:
 	case 0xc000 ... 0xc086:
 	case 0xc400 ... 0xc409:
 	case 0xc480 ... 0xc48f:
@@ -946,6 +947,7 @@ static bool rt1320_readable_register(struct device *dev, unsigned int reg)
 static bool rt1320_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case 0x004d:
 	case 0xc000:
 	case 0xc003:
 	case 0xc081:
@@ -3383,6 +3385,37 @@ static int rt1320_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int rt1320_bus_config(struct sdw_slave *slave,
+				struct sdw_bus_params *params)
+{
+	struct  rt1320_sdw_priv *rt1320 = dev_get_drvdata(&slave->dev);
+	unsigned int clk_base;
+
+	regmap_read(rt1320->regmap, 0x004d, &clk_base);
+	dev_dbg(&rt1320->sdw_slave->dev, "%s clk_base=%x", __func__, clk_base);
+
+	switch (clk_base) {
+	case RT1320_CLK_FREQ_19_2_MHZ:
+	case RT1320_CLK_FREQ_24MHZ:
+		regmap_write(rt1320->regmap, 0xc600, 0x04);
+		regmap_write(rt1320->regmap, 0xc601, 0x83);
+		regmap_write(rt1320->regmap, 0xc602, 0x1f);
+		regmap_write(rt1320->regmap, 0xc603, 0x40);
+		break;
+	case RT1320_CLK_FREQ_24_576MHZ:
+	case RT1320_CLK_FREQ_22_5792MHZ:
+		regmap_write(rt1320->regmap, 0xc600, 0x07);
+		regmap_write(rt1320->regmap, 0xc601, 0x80);
+		regmap_write(rt1320->regmap, 0xc602, 0x0f);
+		regmap_write(rt1320->regmap, 0xc603, 0x40);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
@@ -3390,12 +3423,13 @@ static int rt1320_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
 static const struct sdw_slave_ops rt1320_slave_ops = {
 	.read_prop = rt1320_read_prop,
 	.update_status = rt1320_update_status,
+	.bus_config = rt1320_bus_config,
 };
 
 static int rt1320_sdw_component_probe(struct snd_soc_component *component)
 {
-	int ret;
 	struct rt1320_sdw_priv *rt1320 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	rt1320->component = component;
 
diff --git a/sound/soc/codecs/rt1320-sdw.h b/sound/soc/codecs/rt1320-sdw.h
index bc0f78e03529..df9ccdf92d36 100644
--- a/sound/soc/codecs/rt1320-sdw.h
+++ b/sound/soc/codecs/rt1320-sdw.h
@@ -175,6 +175,13 @@ enum rt1320_rw_type {
 	RT1320_PARAM_READ = 3,
 };
 
+enum {
+	RT1320_CLK_FREQ_19_2_MHZ = 1,
+	RT1320_CLK_FREQ_24MHZ = 2,
+	RT1320_CLK_FREQ_24_576MHZ = 3,
+	RT1320_CLK_FREQ_22_5792MHZ = 4,
+};
+
 struct rt1320_sdw_priv {
 	struct snd_soc_component *component;
 	struct regmap *regmap;
-- 
2.54.0

