Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DE7CA5FC4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Oct 2026 02:48:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9CAB860271;
	Thu,  1 Oct 2026 04:47:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9CAB860271
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790822882;
	bh=6PHQ3zaRVGKTcTBD2o6rXhJex1Q36j/3c2FC71gb/Tg=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=s/3b6ekJKCcEWS9gIfBTdBFmSeV9HvesLLck6Wr0g2JZDBWWXQlHu8DfwIB0WQvhD
	 sixUm/4BbvWcqyX0bCoE8NIo/bKr+KJTvNJf8Vq/x1Itxsw2VNaEFYF74axfNJvXtS
	 wyWPzgaOYQoVD4BrtkgurSZsjEx71WBBaFbmlvMQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EFD38F805F8; Thu,  1 Oct 2026 04:47:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 26310F805F7;
	Thu,  1 Oct 2026 04:47:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3D0D2F8057F; Thu,  1 Oct 2026 04:47:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790822835;
	b=c4qlNpqnnZrKgg9jpfFFvKhwl8Qk+TqiKhTz8l4WDixkr3ncgGcCQ7LL7pPEHw/w3zBt
	 RTWd+sLHh45FMy9S/XyOMEs3PCullUViytfdQ9Q42285e4mY/NZZLTThf/gLrlne1I4qi
	 NooY6MiY3M32tkpqmB0LxzUl21wxu++rOVpCkYZfR+0f6E7pnRDJTgSPvEGZymvReYELP
	 2LWmZ5HF+u9hMyGasihp4As0G7+eRjHXGmIo8APtb1VJcOngiEgXMPIGEsMWwWe+v1JzB
	 fYKtK+h5z94syHFPDWaIfNPoRsEZ0yrVFxvcvPWUhpgFQOlfwZ2x0l1L45EX4+4B3Kw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790822835;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6PHQ3zaRVGKTcTBD2o6rXhJex1Q36j/3c2FC71gb/Tg=;
	b=GVq86vGPX93qluFPBHYp0OGq5GyTYyuBLOYiak6hndoQfux+o6bU18/6sCJqRYDsFEnv
	 t9AKyT6jbG11Uw5+DF4WlHkcBK1Wvn6liDqXr4zqtY0g/jV0h+K6W6pESqhAmq/Cz6j10
	 3zvdH1ylfl1VHM6X6dDaj8lsmx16JH8ezXyOe0q9rNDmZ8DIbIy/eqmEDONaK9k/TWPj5
	 uZTTLBieG+YLUHkQpEuzIx1j3ThJz9icIxMQjNGQJPknNoY/RS9e6eZrw2DVOj84jsrF+
	 6cWbQ8TmELbgpA4PHKqMZhp2Svs3zjS7Nm3TPtIF/t08K3NsyGtXfzt9SVx/izW7z3A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=dUDAKBtr;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0F212F8011B
	for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2026 04:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F212F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=dUDAKBtr
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6912l2jxD2586688,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790822822; bh=1jcXIa2ZFJU1OefiWOSVSyR1FuN0K3OsaRT6aqS4Dmo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=dUDAKBtrAfAYDaIIuGNJ2FFRiRZeAS+MlkYEYeJaaBwxe3BI0ji/aeyImmrBHRIQC
	 EAHe13N3PToXZBqouszTO35TDfaIM4dnA5/g2UBpm/JoHiwn3TXEgXSFwDV4JfPD/g
	 lztjHr4IfihNhIknWAvr6sqoVfCKQ/DG2m/RQr1FmIX6UpYilDyjBOSl9vZZPyCCgF
	 KWSOWWtBN1sQ3FiZtYVLoaI/hXPZdw98deYX9d1tqZwTMeFjBHisNdf0NZ7fP9qwmQ
	 cFcGQDooI0TumvUDrkCTiz0xdIbDVEm/d+vmuZaPoerzWmghxb2ivW5mN+f0U5B29b
	 +v62eVg50ptuA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6912l2jxD2586688
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Oct 2026 10:47:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:47:03 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 10:47:02 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 10:47:02 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v2] ASoC: rt721-sdca: Adjust blindwrite flow to fix type
 detection issue
Date: Thu, 1 Oct 2026 10:46:57 +0800
Message-ID: <20261001024657.739186-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: 7FPFWPLRWWLWM3IRF34NL6C2WTEVJKQX
X-Message-ID-Hash: 7FPFWPLRWWLWM3IRF34NL6C2WTEVJKQX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7FPFWPLRWWLWM3IRF34NL6C2WTEVJKQX/>
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
 sound/soc/codecs/rt721-sdca-sdw.c |  40 +++-
 sound/soc/codecs/rt721-sdca-sdw.h |   7 +
 sound/soc/codecs/rt721-sdca.c     | 359 +++++++++++++++++++++++++++---
 sound/soc/codecs/rt721-sdca.h     |  27 +++
 4 files changed, 390 insertions(+), 43 deletions(-)

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
index 13d6227f3392..fe04a3726334 100644
--- a/sound/soc/codecs/rt721-sdca-sdw.h
+++ b/sound/soc/codecs/rt721-sdca-sdw.h
@@ -80,18 +80,25 @@ static const struct reg_default rt721_sdca_reg_defaults[] = {
 };
 
 static const struct reg_default rt721_sdca_mbq_defaults[] = {
+	{ 0x0900006, 0xe000 },
 	{ 0x0900007, 0xc004 },
+	{ 0x0910000, 0x00a1 },
+	{ 0x0910001, 0x1256 },
+	{ 0x0910002, 0x0000 },
+	{ 0x0910003, 0x0000 },
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
index ef003c93f533..5fc0aa991914 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -27,11 +27,86 @@
 #include "rt721-sdca.h"
 #include "rt-sdw-common.h"
 
+static void rt721_uaj_power_on(struct rt721_sdca_priv *rt721)
+{
+	rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
+		RT721_MISC_POWER_CTL10, 0xfcb5, 0xfcb5);
+	rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
+		RT721_UAJ_TOP_TCON12, 0xc000, 0x4000);
+}
+
+static void rt721_impedance_sensing(struct rt721_sdca_priv *rt721)
+{
+	unsigned int read_imp;
+	int i, loop_cnt = 25;
+	unsigned long cal_T;
+	bool spk = false;
+
+	rt721->imp_sensing_ongoing = true;
+
+	rt721_uaj_power_on(rt721);
+
+	rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
+			RT721_HDA_LEGACY_UAJ_CTL, 0x0048, 0x0000);
+	rt_sdca_index_update_bits(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL4, 0x0003, 0x0003);
+
+	cal_T = jiffies + msecs_to_jiffies(200);
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
+static void rt721_sdca_jack_reset_state(struct rt721_sdca_priv *rt721)
+{
+	rt721->jack_type = 0;
+	rt721->imp_sensing_done = false;
+	rt721->last_real_JD = 0;
+	rt721->int_cnt = 0;
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
@@ -39,12 +114,132 @@ static void rt721_sdca_jack_detect_handler(struct work_struct *work)
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
+			rt_sdca_index_read(rt721->mbq_regmap, RT721_JD_CTRL,
+				RT721_JD_1PIN_GAT_STA1, &real_JD);
+			real_JD &= 0x1;
+		if (real_JD == 0x0)
+			rt721_sdca_jack_reset_state(rt721);
+
+		if ((rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) &&
+			!(rt721->scp_sdca_stat2 & SDW_SCP_SDCA_INT_SDCA_8) &&
+			real_JD == 0x1 && rt721->int_cnt == 0 &&
+			!rt721->imp_sensing_done && rt721->jack_type != 0) {
+			unsigned int cur_mode = 0;
+			int cur_type = -1;
+
+			for (retry = 0; retry < retry_loop; retry++) {
+				regmap_read(rt721->regmap,
+					SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC,
+						RT721_SDCA_ENT_GE49,
+						RT721_SDCA_CTL_DETECTED_MODE, 0),
+					&cur_mode);
+				if (cur_mode)
+					break;
+				usleep_range(20000, 21000);
+			}
+
+			switch (cur_mode) {
+			case 0x03:
+				cur_type = SND_JACK_HEADPHONE;
+				break;
+			case 0x05:
+				cur_type = SND_JACK_HEADSET;
+				break;
+			default:
+				cur_type = -1;
+				break;
+			}
+
+			dev_info(&rt721->slave->dev,
+				"%s: resume check, cur_mode=0x%x cur_type=%d retained jack_type=%d\n",
+				__func__, cur_mode, cur_type, rt721->jack_type);
+
+			if (cur_mode != 0 && cur_type == rt721->jack_type) {
+				dev_info(&rt721->slave->dev,
+					"%s: resume with same jack, reuse jack_type=%d\n",
+					__func__, rt721->jack_type);
+				rt721->imp_sensing_done = true;
+				rt721->last_real_JD = real_JD;
+				snd_soc_jack_report(rt721->hs_jack, rt721->jack_type,
+					SND_JACK_HEADSET |
+					SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+					SND_JACK_BTN_2 | SND_JACK_BTN_3);
+				return;
+			}
+
+			dev_info(&rt721->slave->dev,
+				"%s: resume jack changed/unsettled, redetect\n", __func__);
+			rt721->jack_type = 0;
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
+		dev_info(&rt721->slave->dev,
+			"%s: handler run stat1=0x%x stat2=0x%x (SDCA_8=%d)\n",
+			__func__, rt721->scp_sdca_stat1, rt721->scp_sdca_stat2,
+			!!(rt721->scp_sdca_stat2 & SDW_SCP_SDCA_INT_SDCA_8));
+	} else {
+		if (rt721->scp_sdca_stat1 & SDW_SCP_SDCA_INT_SDCA_0) {
+			rt721->jack_type = rt_sdca_headset_detect(rt721->regmap,
+							RT721_SDCA_ENT_GE49);
+			if (rt721->jack_type < 0)
+				return;
+		}
 	}
 
 	/* SDW_SCP_SDCA_INT_SDCA_8 is used for button detection */
@@ -114,8 +309,12 @@ static void rt721_sdca_btn_check_handler(struct work_struct *work)
 		/* Report ID for HID1 */
 		if (buf[0] == 0x11)
 			btn_type = rt_sdca_btn_type(&buf[1]);
-	} else
-		rt721->jack_type = 0;
+	} else {
+		if (rt721->wf_id == RT721_S)
+			rt721_sdca_jack_reset_state(rt721);
+		else
+			rt721->jack_type = 0;
+	}
 
 	dev_dbg(&rt721->slave->dev, "%s, btn_type=0x%x\n",	__func__, btn_type);
 	snd_soc_jack_report(rt721->hs_jack, rt721->jack_type | btn_type,
@@ -217,11 +416,6 @@ static void rt721_sdca_amp_preset(struct rt721_sdca_priv *rt721)
 			RT721_VREF1_HV_CTRL1, 0xe000);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
 			RT721_MISC_POWER_CTL31, 0x8007);
-		if (rt721->wf_id == RT721_S) {
-			regmap_write(rt721->mbq_regmap, 0x5810000, 0x6420);
-			regmap_write(rt721->mbq_regmap, 0x5810000, 0x6421);
-			regmap_write(rt721->mbq_regmap, 0x5810000, 0xe421);
-		}
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_HDA_SDCA_FLOAT,
 			RT721_CH_FLOAT_CTL6, 0x5561);
 		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_REG,
@@ -253,6 +447,9 @@ static void rt721_sdca_amp_preset(struct rt721_sdca_priv *rt721)
 
 static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
 {
+	unsigned int calib_val, calib_val2, calib_tmp = 0, calib_tmp2 = 0;
+	unsigned int i, calib_loop = 10;
+	unsigned int wait_calib_loop = 10;
 	unsigned int jack_func_status;
 	struct device *dev = &rt721->slave->dev;
 
@@ -268,6 +465,10 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
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
@@ -279,37 +480,30 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
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
@@ -322,6 +516,12 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
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
@@ -330,16 +530,99 @@ static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
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
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_JD_CTRL,
+			RT721_JD_1PIN_TOP_CTRL3, 0x7788);
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
+
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL2, 0xd000);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_VENDOR_ANA_CTL,
+			RT721_UAJ_TOP_TCON_ANY, 0xc820);
+		rt_sdca_index_write(rt721->mbq_regmap, RT721_CAP_PORT_CTRL,
+			RT721_HP_AMP_2CH_CAL1, 0x0540);
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
+		msleep(500);
 	}
 }
 
@@ -1704,6 +1987,8 @@ int rt721_sdca_io_init(struct device *dev, struct sdw_slave *slave)
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

