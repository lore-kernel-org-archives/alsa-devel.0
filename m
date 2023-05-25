Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB23C77B7A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 May 2023 16:29:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EF673E8;
	Thu, 25 May 2023 18:28:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EF673E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685032183;
	bh=moK5e4bfKuvbWIKCxqCnAKXWulDDEb4SfkpyjDKd0os=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ghpujp7hb8sVoUsZ/q7Bah64S5MWXavVNwOxGtZfGCj3/EhOVhYU0KhKPy6orsfL6
	 l1k891eMZTpQGuUNR7XLRSjF3EYEhNen3b6LSeQpMXNQ7OgD04zWNPAvLHbtcu0awk
	 92BXKFcAfJZm5dV5IPiGJ+3J9Zcj6b4Cr9UDyQxk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03746F805CA; Thu, 25 May 2023 18:27:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 36727F805C0;
	Thu, 25 May 2023 18:27:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C47FF80580; Thu, 25 May 2023 18:26:58 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6F9B8F80544
	for <alsa-devel@alsa-project.org>; Thu, 25 May 2023 18:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F9B8F80544
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=L0UQ2Ij+
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34PEEWVE026032;
	Thu, 25 May 2023 11:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=ZtRVanoa2UL9fx2mOjgnx7Kor2SKPiAisybX4sOubCs=;
 b=L0UQ2Ij+MgTxL/eRr6Wu+FpIiVGjB/Frukhrmd8GAdVoiYUW51OCHIfo+SZoZcgYyyMg
 PX3P6AHdl88ms1T+kJ3SOAA/7UwVvjOhjJj8tKQuTQ4zMgX3F+5TdoCNN7cBWhjSSPKW
 Bfxu4D+62pCZLyd075Lk75VIqS3RcHAyoj0mzevg/yegr0cOYhamKVR2jgwTbVFmej20
 mmOTBbcuoFKRFYC/ANU2OtgnFS+3Tkv+Atbf71H3fxZYZWHrK3LvXLQ4QDac8esaZsOa
 +g/BKGEBYa/zRfSCv2pUdbE+0KfJzxTtFHTxUcdL4umvz2YEEMiOKpLG5ZyEwUEOid8R mg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qptmm74vu-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 May 2023 11:26:27 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 25 May
 2023 11:26:25 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 11:26:25 -0500
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com
 [198.61.65.166])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 50A0511D4;
	Thu, 25 May 2023 16:26:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <tiwai@suse.com>, <broonie@kernel.org>, <perex@perex.cz>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer
	<simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 08/12] ASoC: cs35l56: Make common function for control port
 wait
Date: Thu, 25 May 2023 17:26:14 +0100
Message-ID: <20230525162618.20146-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525162618.20146-1-rf@opensource.cirrus.com>
References: <20230525162618.20146-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: t6vh7dXuvme4RVfdPJW_XKQP7DFIUpHM
X-Proofpoint-GUID: t6vh7dXuvme4RVfdPJW_XKQP7DFIUpHM
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: BFRS323SXM3BPNAPRWNGGRR4O4G63DFS
X-Message-ID-Hash: BFRS323SXM3BPNAPRWNGGRR4O4G63DFS
X-MailFrom: prvs=050971c6a2=rf@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Simon Trimmer <simont@opensource.cirrus.com>

Move the waits for CS35L56_CONTROL_PORT_READY_US into a common
function, and also allow a wider range of allowed wait times.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/sound/cs35l56.h           |  1 +
 sound/soc/codecs/cs35l56-shared.c | 16 ++++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 489a61f84325..ae9e8f55962a 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -275,6 +275,7 @@ extern const unsigned int cs35l56_tx_input_values[CS35L56_NUM_INPUT_SRC];
 void cs35l56_reread_firmware_registers(struct cs35l56_base *cs35l56_base);
 int cs35l56_mbox_send(struct cs35l56_base *cs35l56_base, unsigned int command);
 int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base);
+void cs35l56_wait_control_port_ready(void);
 void cs35l56_wait_min_reset_pulse(void);
 void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire);
 int cs35l56_irq_request(struct cs35l56_base *cs35l56_base, int irq);
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index e3b935bd9037..7e02d023338c 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -249,6 +249,13 @@ int cs35l56_wait_for_firmware_boot(struct cs35l56_base *cs35l56_base)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_wait_for_firmware_boot, SND_SOC_CS35L56_SHARED);
 
+void cs35l56_wait_control_port_ready(void)
+{
+	/* Wait for control port to be ready (datasheet tIRS). */
+	usleep_range(CS35L56_CONTROL_PORT_READY_US, 2 * CS35L56_CONTROL_PORT_READY_US);
+}
+EXPORT_SYMBOL_NS_GPL(cs35l56_wait_control_port_ready, SND_SOC_CS35L56_SHARED);
+
 void cs35l56_wait_min_reset_pulse(void)
 {
 	/* Satisfy minimum reset pulse width spec */
@@ -275,7 +282,7 @@ void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 	if (is_soundwire)
 		return;
 
-	usleep_range(CS35L56_CONTROL_PORT_READY_US, CS35L56_CONTROL_PORT_READY_US + 400);
+	cs35l56_wait_control_port_ready();
 	regcache_cache_only(cs35l56_base->regmap, false);
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_system_reset, SND_SOC_CS35L56_SHARED);
@@ -486,8 +493,7 @@ int cs35l56_runtime_resume_common(struct cs35l56_base *cs35l56_base, bool is_sou
 						cs35l56_hibernate_wake_seq,
 						ARRAY_SIZE(cs35l56_hibernate_wake_seq));
 
-		usleep_range(CS35L56_CONTROL_PORT_READY_US,
-			     CS35L56_CONTROL_PORT_READY_US + 400);
+		cs35l56_wait_control_port_ready();
 	}
 
 out_sync:
@@ -561,9 +567,7 @@ int cs35l56_hw_init(struct cs35l56_base *cs35l56_base)
 	if (!cs35l56_base->reset_gpio)
 		regmap_read(cs35l56_base->regmap, CS35L56_DSP_VIRTUAL1_MBOX_1, &devid);
 
-	/* Wait for control port to be ready (datasheet tIRS). */
-	usleep_range(CS35L56_CONTROL_PORT_READY_US,
-		     CS35L56_CONTROL_PORT_READY_US + 400);
+	cs35l56_wait_control_port_ready();
 
 	/*
 	 * The HALO_STATE register is in different locations on Ax and B0
-- 
2.30.2

