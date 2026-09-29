Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B434CA5FA1
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:18:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11ADA601E6;
	Tue, 29 Sep 2026 13:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11ADA601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790680700;
	bh=496BUFJ7uyxBszeY8YQ+BwB/b2S8ztjZvsPitaat9dk=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=I5Qddey8rMhdMWLa49Sw6cplAHpUC/Tpnng/55AsJlv92THeaYGNCjY6P/qCxWXYG
	 piQRytDvqFVVffOJNEnMuBZMvMdfYxSehTpLU6YR61AoEj3+Wk9ycpbxX26yaIm1ZN
	 ZYopyKRu4Ld28dk2nPc9/1J04Pb9O8WHKKBMUk/Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5ACB2F80600; Tue, 29 Sep 2026 13:17:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BEBC0F80600;
	Tue, 29 Sep 2026 13:17:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70E4CF8055C; Tue, 29 Sep 2026 13:17:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790680656;
	b=C7bL56zigqLOl9EJwpzWkuo7WE2Ax8/tidYogwLul8KXpqX56qtEnglK4SqWZcB+Do/1
	 u7UIrscY5zotUW2u40f4QvYgqtK9k1v5Z4I59LquaToYvk75u3ORCUUHtFU2APGmHrF97
	 9F960jCIYrt2PR+UqVDv0iGKmKRmll1fDDaJsHncYP+xrG7jV7E+RfjJ12i7glMnjVY+/
	 vwcMR5AU2MGcjcwnwL4mMA8t/tqqHQnZr9emmo6Mko3xyrvIxI3CfDULzIEK8TuQZrHRs
	 df3UbeuAiGcBuM3rxMOcFAAu3jOfJ0tIcyOYcvB442zhHEjtU4xOBXaS4Ch+F7ecRLw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790680656;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=496BUFJ7uyxBszeY8YQ+BwB/b2S8ztjZvsPitaat9dk=;
	b=JgCY8Xki35XzopZ/SzcyRxL1hHMwuuBeJ5Kq6cjyelOPhmE0xGJoUeT9xa9rhfymvXu1
	 XzLOVHV5FtW7yTAgG9/HfcdJf5h9JyYTRuRd8i89OPgRWCvA8jczEGsxjMXzRA/TLGkbO
	 TP4UkikpPdT5mLeN/Y+zdR1MfKdltiI4CxSDxAdNdm+54FFgACmOQ3VrPjE826cjcbEW2
	 76ea10gtVuRPQPTQSwjq9LuZoCIMKL5lD3WTX+14eE1KdZuOKcx6/5TqWSJu4mcrMe2Ch
	 L30fSf6a/bAoC4OgjppkDCdHbEk+vqjhHvrr7wzRFKCl63vWwu1UV0ye/JDBU1YaTVg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=vv5jGsXT;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C1E6CF80448
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2026 13:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1E6CF80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=vv5jGsXT
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68TBHQzbC1236497,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790680646; bh=iMXB32/OaAFHKn0raM9FerIYYuWAXZNVzrZNvCX3FXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=vv5jGsXTuFRanQk3+lLZ3nAAYTGLJ227p8IGwNXgfhCnh2ltsv8dcn5kdV7FQbi+E
	 tXFswSYj5x98Y0X+MPSqaOE2rkT3Qfa6eUpFou5JdllclYo8X5GpTN9Yhc7gpoyfB2
	 sNv9lo+sCCtxJC2MP0oZ7qPVHK98F2ppp9wf9jhitG38uelJZOvnc6tapY2hUao8hM
	 3SChFVJQi5stBBRrvGdL+dADGti4V1FDSkIYQH4O3nRBEgqg3w28vdsabxYFs2njtZ
	 B3OV44VKqC9uk1liBoY51sBGxV5T2sGMw8CQy6p6HYyoQP5ybRTgtUHc5coS5+OcJo
	 RLyxxRkf7wBPQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68TBHQzbC1236497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 19:17:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 19:17:11 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Tue, 29 Sep 2026 19:17:11 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt721-sdca: Adjust blindwrite flow to fix type
 detection issue
Date: Tue, 29 Sep 2026 19:17:09 +0800
Message-ID: <20260929111709.398548-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: 4QINTHXM6E3L5ZQTO255ZKQG3SXPQAJD
X-Message-ID-Hash: 4QINTHXM6E3L5ZQTO255ZKQG3SXPQAJD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4QINTHXM6E3L5ZQTO255ZKQG3SXPQAJD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Original blindwrite flow fail to support nokia type detection,
but it's works normally in iphone type detection.
We adjust the register settings to support both type detection.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt721-sdca-sdw.c |  40 ++++-
 sound/soc/codecs/rt721-sdca-sdw.h |   8 +
 sound/soc/codecs/rt721-sdca.c     | 285 ++++++++++++++++++++++++++----
 sound/soc/codecs/rt721-sdca.h     |  27 +++
 4 files changed, 324 insertions(+), 36 deletions(-)

diff --git a/sound/soc/codecs/rt721-sdca-sdw.c b/sound/soc/codecs/rt721-sdca-sdw.c
index a8c7b42898db..7ab7b4ae801f 100644
--- a/sound/soc/codecs/rt721-sdca-sdw.c
+++ b/sound/soc/codecs/rt721-sdca-sdw.c
@@ -76,9 +76,16 @@ static bool rt721_sdca_mbq_readable_register(struct device *dev, unsigned int re
 {
 	switch (reg) {
 	case 0x0900004 ... 0x0900009:
+	case 0x0910000:
+	case 0x0910001:
+	case 0x0910002:
+	case 0x0910003:
+	case 0x0910202:
 	case 0x0a00005:
 	case 0x0c00005:
 	case 0x0d00014:
+	case 0x0f00004:
+	case 0x0f00005:
 	case 0x0310100:
 	case 0x2000000 ... 0x2000003:
 	case 0x2000013:
@@ -87,18 +94,25 @@ static bool rt721_sdca_mbq_readable_register(struct device *dev, unsigned int re
 	case 0x200003c:
 	case 0x2000046:
 	case 0x5810000:
+	case 0x5810033:
 	case 0x5810036:
 	case 0x5810037:
 	case 0x5810038:
 	case 0x5810039:
+	case 0x581003a:
+	case 0x581003b:
 	case 0x5810100:
-	case 0x5b10018:
-	case 0x5b10019:
+	case 0x5b10000 ... 0x5b10026:
+	case 0x5b10100 ... 0x5b10103:
+	case 0x5f00010:
+	case 0x5f00043:
 	case 0x5f00045:
 	case 0x5f00048:
 	case 0x6100000:
+	case 0x6100002:
 	case 0x6100005:
 	case 0x6100006:
+	case 0x6100007:
 	case 0x610000d:
 	case 0x6100010:
 	case 0x6100011:
@@ -152,6 +166,7 @@ static bool rt721_sdca_mbq_volatile_register(struct device *dev, unsigned int re
 	case 0x0a00005:
 	case 0x0c00005:
 	case 0x0d00014:
+	case 0x0f00004:
 	case 0x2000000:
 	case 0x200000d:
 	case 0x2000019:
@@ -168,9 +183,11 @@ static bool rt721_sdca_mbq_volatile_register(struct device *dev, unsigned int re
 	case 0x5810037:
 	case 0x5810038:
 	case 0x5810039:
+	case 0x581003a:
+	case 0x581003b:
 	case 0x5810100:
-	case 0x5b10018:
-	case 0x5b10019:
+	case 0x5b10000 ... 0x5b10016:
+	case 0x5b10018 ... 0x5b10026:
 	case 0x6100006:
 		return true;
 	default:
@@ -318,6 +335,11 @@ static int rt721_sdca_interrupt_callback(struct sdw_slave *slave,
 	int count = 0, retry = 3;
 	unsigned int sdca_cascade, scp_sdca_stat1, scp_sdca_stat2 = 0;
 
+	if (rt721->imp_sensing_ongoing && rt721->wf_id == RT721_S)
+		dev_info(&slave->dev,
+			"%s: IRQ arrived DURING impedance sensing\n",
+			__func__);
+
 	if (cancel_delayed_work_sync(&rt721->jack_detect_work)) {
 		dev_warn(&slave->dev, "%s the pending delayed_work was cancelled", __func__);
 		/* avoid the HID owner doesn't change to device */
@@ -395,9 +417,15 @@ static int rt721_sdca_interrupt_callback(struct sdw_slave *slave,
 	ret = sdw_read_no_pm(rt721->slave, SDW_SCP_SDCA_INT1);
 	ret = sdw_read_no_pm(rt721->slave, SDW_SCP_SDCA_INT2);
 
-	if (status->sdca_cascade && !rt721->disable_irq)
+	if (status->sdca_cascade && !rt721->disable_irq) {
+		unsigned int delay_ms = 280;
+
+		if (rt721->imp_sensing_ongoing && rt721->wf_id == RT721_S)
+			delay_ms = 800;
+
 		mod_delayed_work(system_power_efficient_wq,
-			&rt721->jack_detect_work, msecs_to_jiffies(280));
+			&rt721->jack_detect_work, msecs_to_jiffies(delay_ms));
+	}
 
 	mutex_unlock(&rt721->disable_irq_lock);
 
diff --git a/sound/soc/codecs/rt721-sdca-sdw.h b/sound/soc/codecs/rt721-sdca-sdw.h
index 13d6227f3392..0f8a7e58499f 100644
--- a/sound/soc/codecs/rt721-sdca-sdw.h
+++ b/sound/soc/codecs/rt721-sdca-sdw.h
@@ -80,18 +80,26 @@ static const struct reg_default rt721_sdca_reg_defaults[] = {
 };
 
 static const struct reg_default rt721_sdca_mbq_defaults[] = {
+	{ 0x0900006, 0xe000 },
 	{ 0x0900007, 0xc004 },
+	{ 0x0910000, 0x00a1 },
+	{ 0x0910001, 0x1256 },
+	{ 0x0910002, 0x0000 },
+	{ 0x0910003, 0x0000 },
+	{ 0x0c00005, 0xf140 },
 	{ 0x2000001, 0x0000 },
 	{ 0x2000002, 0x0000 },
 	{ 0x2000003, 0x0000 },
 	{ 0x2000013, 0x8001 },
 	{ 0x200003c, 0x0000 },
 	{ 0x2000046, 0x3400 },
+	{ 0x5b10017, 0x1b07 },
 	{ 0x5f00044, 0x6040 },
 	{ 0x5f00045, 0x3333 },
 	{ 0x5f00048, 0x0000 },
 	{ 0x6100005, 0x0005 },
 	{ 0x6100006, 0x0000 },
+	{ 0x6100007, 0x0007 },
 	{ 0x610000d, 0x0051 },
 	{ 0x6100010, 0x0180 },
 	{ 0x6100011, 0x0000 },
diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index ef003c93f533..8d315ca3448d 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -27,11 +27,68 @@
 #include "rt721-sdca.h"
 #include "rt-sdw-common.h"
 
+static void rt721_impedance_sensing(struct rt721_sdca_priv *rt721)
+{
+	unsigned int read_imp;
+	int i, loop_cnt = 25;
+	unsigned long cal_T;
+	bool spk = false;
+
+	rt721->imp_sensing_ongoing = true;
+
+	rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
+			RT721_HDA_LEGACY_UAJ_CTL, 0x0048, 0x0000);
+	rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL4, 0x0003, 0x0003);
+
+	cal_T = jiffies + msecs_to_jiffies(100);
+
+	for (i = 0; i < loop_cnt; i++) {
+		regmap_read(rt721->mbq_regmap, RT721_IMP_SEN_CTRL13, &read_imp);
+		read_imp = (read_imp >> 12) & 0xf;
+		dev_dbg(&rt721->slave->dev, "%s, loop:%d, read_imp=0x%x\n",
+			__func__, i, read_imp);
+
+		if (read_imp == 0x6 || read_imp == 0x7 ||
+			read_imp == 0x8 || read_imp == 0x9) {
+			spk = true;
+			break;
+		}
+
+		if (read_imp != 0 || i == loop_cnt - 1 ||
+			time_after(jiffies, cal_T))
+			break;
+
+		usleep_range(20000, 21000);
+	}
+
+	if (spk) {
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_CBJ_CTRL,
+			RT721_CBJ_A0_GAT_CTRL1, 0x8c00, 0x8c00);
+		usleep_range(50000, 51000);
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_CBJ_CTRL,
+			RT721_CBJ_A0_GAT_CTRL1, 0x8000, 0x0000);
+	} else {
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_CBJ_CTRL,
+			RT721_CBJ_A0_GAT_CTRL1, 0x8c00, 0x8000);
+		usleep_range(50000, 51000);
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_CBJ_CTRL,
+			RT721_CBJ_A0_GAT_CTRL1, 0x8000, 0x0000);
+	}
+
+	rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
+			RT721_HDA_LEGACY_UAJ_CTL, 0x0048, 0x0048);
+	rt721->int_cnt = 1;
+}
+
 static void rt721_sdca_jack_detect_handler(struct work_struct *work)
 {
 	struct rt721_sdca_priv *rt721 =
 		container_of(work, struct rt721_sdca_priv, jack_detect_work.work);
+	unsigned int sta_mode = 0;
 	int btn_type = 0;
+	int retry, retry_loop = 40;
+	int real_JD;
 
 	if (!rt721->hs_jack)
 		return;
@@ -39,12 +96,92 @@ static void rt721_sdca_jack_detect_handler(struct work_struct *work)
 	if (!rt721->component->card || !rt721->component->card->instantiated)
 		return;
 
-	/* SDW_SCP_SDCA_INT_SDCA_6 is used for jack detection */
-	if (rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) {
-		rt721->jack_type = rt_sdca_headset_detect(rt721->regmap,
-							RT721_SDCA_ENT_GE49);
-		if (rt721->jack_type < 0)
+	if (rt721->wf_id == RT721_S) {
+		if (rt721->imp_sensing_ongoing) {
+			dev_dbg(&rt721->slave->dev,
+				"SKIP, imp_sensing_ongoing\n");
+			return;
+		}
+
+		rt_sdca_index_read(rt721->mbq_regmap, RT721_JD_CTRL,
+			RT721_JD_1PIN_GAT_STA1, &real_JD);
+		real_JD &= 0x1;
+		if (real_JD == 0x0)
+			rt721->imp_sensing_done = false;
+
+		if ((rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) &&
+			!(rt721->scp_sdca_stat2 & SDW_SCP_SDCA_INT_SDCA_8) &&
+			real_JD == 0x1 && rt721->int_cnt == 0 &&
+			!rt721->imp_sensing_done && rt721->jack_type != 0) {
+			dev_info(&rt721->slave->dev,
+				"%s: resume with jack present, reuse jack_type=%d\n",
+				__func__, rt721->jack_type);
+			rt721->imp_sensing_done = true;
+			rt721->last_real_JD = real_JD;
+			snd_soc_jack_report(rt721->hs_jack, rt721->jack_type,
+				SND_JACK_HEADSET |
+				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+				SND_JACK_BTN_2 | SND_JACK_BTN_3);
+			return;
+		}
+
+		if ((rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) &&
+			!(rt721->scp_sdca_stat2 & SDW_SCP_SDCA_INT_SDCA_8) &&
+			real_JD == rt721->last_real_JD && real_JD == 0x1 &&
+			rt721->int_cnt == 0 && rt721->imp_sensing_done &&
+			rt721->jack_type != 0) {
+			dev_info(&rt721->slave->dev,
+				"%s: state settled (JD=%d), skip redetect\n",
+				__func__, real_JD);
+			rt721->last_real_JD = real_JD;
 			return;
+		}
+		rt721->last_real_JD = real_JD;
+
+		if ((rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) &&
+			!(rt721->scp_sdca_stat2 & SDW_SCP_SDCA_INT_SDCA_8) &&
+			rt721->int_cnt == 0 && real_JD == 0x1 &&
+			!rt721->imp_sensing_done) {
+			dev_info(&rt721->slave->dev,
+				"%s: BRANCH impedance_sensing (SDCA_0 set, fresh pass)\n",
+				__func__);
+			rt721->imp_sensing_done = true;
+			rt721_impedance_sensing(rt721);
+			rt721->imp_sensing_ongoing = false;
+			return;
+		}
+
+		/* SDW_SCP_SDCA_INT_SDCA_0 is used for jack detection */
+		if ((rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) &&
+			(rt721->int_cnt == 1 || real_JD == 0x0)) {
+			if (real_JD == 0x1) {
+				for (retry = 0; retry < retry_loop; retry++) {
+					regmap_read(rt721->regmap,
+						SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC,
+							RT721_SDCA_ENT_GE49,
+							RT721_SDCA_CTL_DETECTED_MODE, 0),
+						&sta_mode);
+					if (sta_mode)
+						break;
+					usleep_range(20000, 21000);
+				}
+				dev_dbg(&rt721->slave->dev,
+					"%s: detected_mode settled=0x%x, %d retries\n",
+					__func__, sta_mode, retry);
+			}
+			rt721->jack_type = rt_sdca_headset_detect(rt721->regmap,
+								RT721_SDCA_ENT_GE49);
+			rt721->int_cnt = 0;
+			if (rt721->jack_type < 0)
+				return;
+		}
+	} else {
+		if (rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) {
+			rt721->jack_type = rt_sdca_headset_detect(rt721->regmap,
+							RT721_SDCA_ENT_GE49);
+			if (rt721->jack_type < 0)
+				return;
+		}
 	}
 
 	/* SDW_SCP_SDCA_INT_SDCA_8 is used for button detection */
@@ -253,6 +390,9 @@ static void rt721_sdca_amp_preset(struct rt721_sdca_priv *rt721)
 
 static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 {
+	unsigned int calib_val, calib_val2, calib_tmp = 0, calib_tmp2 = 0;
+	unsigned int i, calib_loop = 10;
+	unsigned int wait_calib_loop = 10;
 	unsigned int jack_func_status;
 	struct device *dev = &rt721->slave->dev;
 
@@ -268,6 +408,10 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 			RT721_VREF1_HV_CTRL1, 0xe000);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
 			RT721_MISC_POWER_CTL31, 0x8007);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CBJ_CTRL,
+			RT721_CBJ_A0_GAT_CTRL1, 0xae05);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
+			RT721_UAJ_TOP_TCON13, 0x6048);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
 			RT721_GE_REL_CTRL1, 0x8011);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
@@ -279,37 +423,30 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
 			RT721_UMP_HID_CTRL5, 0x0c12);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_JD_CTRL,
-			RT721_JD_1PIN_GAT_CTRL2, 0xc002);
+			RT721_JD_1PIN_GAT_CTRL2, 0xc004);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_RC_CALIB_CTRL,
 			RT721_RC_CALIB_CTRL0, 0x0b00);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_RC_CALIB_CTRL,
 			RT721_RC_CALIB_CTRL0, 0x0b40);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
-			RT721_UAJ_TOP_TCON14, 0x3333);
-		regmap_write(rt721->mbq_regmap, 0x5810035, 0x0036);
-		regmap_write(rt721->mbq_regmap, 0x5810030, 0xee00);
-		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
-			RT721_HP_AMP_2CH_CAL1, 0x0140);
-		regmap_write(rt721->mbq_regmap, 0x5810000, 0x0021);
-		regmap_write(rt721->mbq_regmap, 0x5810000, 0x8021);
+			RT721_UAJ_TOP_TCON14, 0x333b);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
 			RT721_HP_AMP_2CH_CAL18, 0x5522);
-		regmap_write(rt721->mbq_regmap, 0x5b10007, 0x2000);
-		regmap_write(rt721->mbq_regmap, 0x5B10017, 0x1b0f);
-		rt_sdca_index_write(rt721->mbq_regmap, RT721_CBJ_CTRL,
-			RT721_CBJ_A0_GAT_CTRL1, 0x2205);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
-			RT721_HP_AMP_2CH_CAL4, 0xa105);
+			RT721_HP_AMP_2CH_CAL1, 0x4540);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL4, 0xa107);
+		regmap_write(rt721->mbq_regmap, 0x5B10017, 0x180f);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL27, 0x4400);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
-			RT721_UAJ_TOP_TCON14, 0x3b33);
+			RT721_UAJ_TOP_TCON14, 0x3b3b);
 		regmap_write(rt721->mbq_regmap, 0x310400, 0x3043);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
-			RT721_UAJ_TOP_TCON14, 0x3f33);
-		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
-			RT721_UAJ_TOP_TCON13, 0x6048);
+			RT721_UAJ_TOP_TCON14, 0x3f3b);
 		regmap_write(rt721->mbq_regmap, 0x310401, 0x3000);
 		regmap_write(rt721->mbq_regmap, 0x310402, 0x1b00);
-		regmap_write(rt721->mbq_regmap, 0x310300, 0x000f);
+		regmap_write(rt721->mbq_regmap, 0x310300, 0x000c);
 		regmap_write(rt721->mbq_regmap, 0x310301, 0x3000);
 		regmap_write(rt721->mbq_regmap, 0x310302, 0x1b00);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
@@ -322,6 +459,12 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 			RT721_MBIAS_LV_CTRL2, 0x6677);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_ANA_POW_PART,
 			RT721_VREF2_LV_CTRL1, 0x7600);
+		regmap_write(rt721->mbq_regmap, 0x0910000, 0x00a1);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
+			RT721_UAJ_TOP_TCON13, 0x6048);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_BOOST_CTRL,
+			RT721_BST_4CH_TOP_GATING_CTRL1, 0x002a);
+
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
 			RT721_ENT_FLOAT_CTL2, 0x1234);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
@@ -330,13 +473,93 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 			RT721_ENT_FLOAT_CTL1, 0x4040);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
 			RT721_ENT_FLOAT_CTL4, 0x1201);
-		rt_sdca_index_write(rt721->mbq_regmap, RT721_BOOST_CTRL,
-			RT721_BST_4CH_TOP_GATING_CTRL1, 0x002a);
-		regmap_write(rt721->regmap, 0x2f58, 0x07);
-		regmap_write(rt721->regmap, 0x2f51, 0x00);
-		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
-			RT721_MISC_CTL, 0x0004);
-		/* clear flag */
+		regmap_write(rt721->regmap, 0x2f58, 0x01);
+		regmap_write(rt721->regmap, 0x2f59, 0x01);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
+			RT721_UAJ_TOP_TCON13, 0x6040);
+		regmap_write(rt721->mbq_regmap, 0x0910001, 0x1256);
+		regmap_write(rt721->mbq_regmap, 0x0910002, 0x0000);
+		regmap_write(rt721->mbq_regmap, 0x0910003, 0x0000);
+		regmap_write(rt721->mbq_regmap, 0x0910004, 0x7788);
+		regmap_update_bits(rt721->mbq_regmap, RT721_ADC_BIAS_CTRL3,
+			0x0004, 0x0004);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_MIC_BIAS_CTRL,
+			RT721_MIC_BIAS_TOP_CTRL2, 0xcc04);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CHARGE_PUMP_CTRL,
+			RT721_CHGPMP_GAT_CTRL1, 0x0000);
+		for (i = 0; i < wait_calib_loop; i++) {
+			regmap_read(rt721->mbq_regmap, 0x0581003a, &calib_val);
+			regmap_read(rt721->mbq_regmap, 0x0581003b, &calib_val2);
+			calib_val &= 0x1f;
+			calib_val2 &= 0xffff;
+			if (calib_val == 0 || calib_val2 == 0 || calib_val != calib_tmp ||
+				calib_val2 != calib_tmp2) {
+				dev_dbg(&rt721->slave->dev, "%s: Keep calibration\n", __func__);
+				usleep_range(10000, 11000);
+			} else {
+				dev_dbg(&rt721->slave->dev, "%s: Calibration done\n", __func__);
+				break;
+			}
+			calib_tmp = calib_val;
+			calib_tmp2 = calib_val2;
+		}
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL2, 0xd000);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
+			RT721_UAJ_TOP_TCON_ANY, 0xc820);
+			rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+				RT721_HP_AMP_2CH_CAL1, 0x0540);
+		regmap_write(rt721->mbq_regmap, 0x5810030, 0xee00);
+		regmap_write(rt721->mbq_regmap, 0x5810033, 0x6000);
+		regmap_write(rt721->mbq_regmap, 0x5810035, 0x0036);
+		regmap_write(rt721->mbq_regmap, 0x5810000, 0x0020);
+		regmap_write(rt721->mbq_regmap, 0x5810000, 0x0021);
+		regmap_write(rt721->mbq_regmap, 0x5810000, 0x8021);
+		for (i = 0; i < calib_loop; i++) {
+			regmap_read(rt721->mbq_regmap, 0x0581003a, &calib_val);
+			regmap_read(rt721->mbq_regmap, 0x0581003b, &calib_val2);
+			calib_val &= 0x1f;
+			calib_val2 &= 0xffff;
+			if (calib_val == 0 || calib_val2 == 0 || calib_val != calib_tmp ||
+				calib_val2 != calib_tmp2) {
+				dev_dbg(&rt721->slave->dev, "%s: Keep calibration\n", __func__);
+				usleep_range(10000, 11000);
+			} else {
+				dev_dbg(&rt721->slave->dev, "%s: Calibration done\n", __func__);
+				break;
+			}
+			calib_tmp = calib_val;
+			calib_tmp2 = calib_val2;
+		}
+
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL1, 0x4540);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CBJ_CTRL,
+			RT721_CBJ_A0_GAT_CTRL1, 0x2e05);
+		regmap_write(rt721->regmap, 0x40400188, 0x0);
+		regmap_write(rt721->regmap, 0x40400688, 0x0);
+		regmap_update_bits(rt721->regmap, 0x2f51, BIT(6), 0);
+		regmap_update_bits(rt721->regmap, 0x2f51, BIT(5), 0);
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
+			RT721_MISC_CTL, BIT(1), 0);
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
+			RT721_MISC_CTL, BIT(0), 0);
+		regmap_update_bits(rt721->regmap, 0x2f51, BIT(4), 0);
+		regmap_update_bits(rt721->regmap, 0x2f51, BIT(3), 0);
+		regmap_update_bits(rt721->regmap, 0x2f51, BIT(2), 0);
+		regmap_update_bits(rt721->regmap, 0x2f51, BIT(1), 0);
+		regmap_update_bits(rt721->regmap, 0x2f51, BIT(0), 0);
+
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
+			RT721_HDA_LEGACY_UAJ_CTL, 0x1c00, 0x0000);
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_JD_CTRL,
+			RT721_JD_1PIN_GAT_CTRL1, 0xc000, 0xc000);
+		regmap_update_bits(rt721->mbq_regmap, RT721_IMP_SEN_CTRL11,
+			0x001c, 0x0004);
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_JD_CTRL,
+			RT721_JD_1PIN_GAT_CTRL2, 0x0007, 0x0004);
+		rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_CBJ_CTRL,
+			RT721_CBJ_A0_GAT_CTRL1, 0x000f, 0x0003);
 		regmap_write(rt721->regmap,
 			SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT721_SDCA_ENT0,
 			RT721_SDCA_CTL_FUNC_STATUS, 0), FUNCTION_NEEDS_INITIALIZATION);
@@ -1704,6 +1927,8 @@ int rt721_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	int val;
 
 	rt721->disable_irq = false;
+	rt721->imp_sensing_done = false;
+	rt721->last_real_JD = -1;
 
 	if (rt721->hw_init)
 		return 0;
diff --git a/sound/soc/codecs/rt721-sdca.h b/sound/soc/codecs/rt721-sdca.h
index 16cf40cd88de..cc3bce0ba517 100644
--- a/sound/soc/codecs/rt721-sdca.h
+++ b/sound/soc/codecs/rt721-sdca.h
@@ -29,6 +29,10 @@ struct  rt721_sdca_priv {
 	/* For Headset jack & Headphone */
 	unsigned int scp_sdca_stat1;
 	unsigned int scp_sdca_stat2;
+	unsigned int int_cnt;
+	bool imp_sensing_ongoing;
+	bool imp_sensing_done;
+	int last_real_JD;
 	struct snd_soc_jack *hs_jack;
 	struct delayed_work jack_detect_work;
 	struct delayed_work jack_btn_check_work;
@@ -54,8 +58,10 @@ struct rt721_sdca_dmic_kctrl_priv {
 /* NID */
 #define RT721_ANA_POW_PART			0x01
 #define RT721_DAC_CTRL				0x04
+#define RT721_MIC_BIAS_CTRL			0x08
 #define RT721_JD_CTRL				0x09
 #define RT721_CBJ_CTRL				0x0a
+#define RT721_CHARGE_PUMP_CTRL		0x0b
 #define RT721_CAP_PORT_CTRL			0x0c
 #define RT721_CLASD_AMP_CTRL			0x0d
 #define RT721_BOOST_CTRL			0x0f
@@ -81,17 +87,28 @@ struct rt721_sdca_dmic_kctrl_priv {
 #define RT721_DAC_2CH_CTRL3			0x02
 #define RT721_DAC_2CH_CTRL4			0x03
 
+/* Index (NID:08h) */
+#define RT721_MIC_BIAS_TOP_CTRL2		0x02
+
 /* Index (NID:09h) */
+#define RT721_JD_1PIN_TOP_CTRL3			0x04
+#define RT721_JD_1PIN_GAT_CTRL1			0x06
 #define RT721_JD_1PIN_GAT_CTRL2			0x07
+#define RT721_JD_1PIN_GAT_STA1			0x09
 
 /* Index (NID:0ah) */
 #define RT721_CBJ_A0_GAT_CTRL1			0x04
 #define RT721_CBJ_A0_GAT_CTRL2			0x05
 
+/* Index (NID:0bh) */
+#define RT721_CHGPMP_GAT_CTRL1			0x01
+
 /* Index (NID:0Ch) */
 #define RT721_HP_AMP_2CH_CAL1			0x05
+#define RT721_HP_AMP_2CH_CAL2			0x06
 #define RT721_HP_AMP_2CH_CAL4			0x08
 #define RT721_HP_AMP_2CH_CAL18			0x1b
+#define RT721_HP_AMP_2CH_CAL27			0x24
 
 /* Index (NID:0dh) */
 #define RT721_CLASD_AMP_2CH_CAL			0x14
@@ -129,10 +146,13 @@ struct rt721_sdca_dmic_kctrl_priv {
 
 /* Index (NID:5fh) */
 #define RT721_MISC_POWER_CTL0			0x00
+#define RT721_MISC_POWER_CTL10			0x10
 #define RT721_MISC_POWER_CTL31			0x31
+#define RT721_UAJ_TOP_TCON12			0x43
 #define RT721_UAJ_TOP_TCON13			0x44
 #define RT721_UAJ_TOP_TCON14			0x45
 #define RT721_UAJ_TOP_TCON17			0x48
+#define RT721_UAJ_TOP_TCON_ANY			0x70
 
 /* Index (NID:61h) */
 #define RT721_HDA_LEGACY_MUX_CTL0		0x00
@@ -181,6 +201,13 @@ struct rt721_sdca_dmic_kctrl_priv {
 #define RT721_BUF_ADDR_HID1			0x44030000
 #define RT721_BUF_ADDR_HID2			0x44030020
 
+/* Impedance Sensing Control */
+#define RT721_IMP_SEN_CTRL11		0x5b10017
+#define RT721_IMP_SEN_CTRL13		0x5b1001b
+
+/* ADC Bias Control 3 */
+#define RT721_ADC_BIAS_CTRL3		0x0910202
+
 /* RT721 SDCA Control - function number */
 #define FUNC_NUM_JACK_CODEC			0x01
 #define FUNC_NUM_MIC_ARRAY			0x02
-- 
2.55.0

