Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A519C9830D
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2026 02:06:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF9B4601E2;
	Thu, 24 Sep 2026 04:05:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF9B4601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790215569;
	bh=wIGzAJdFl+9sCrm4XhMQb7bTdxsdCyWk2X5KgQTMfLk=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BmFYVfJtLXTfKzu3oTeO6ALSCJ4qV8uHx3U1uFAhWWGbm8LqV41BzAfGrzthrIi7Z
	 0hKNbldkuDVxc/qP+ZRBJKsAYOZuEY7TuZ3EyRgKAaLloTtngX+e92s/I/rLqcAV2e
	 VNR+K6/OaW9LWE0K1OcaAZ1dGZJz7Y4EqjhjyKH8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF240F805F5; Thu, 24 Sep 2026 04:05:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B88BF805FB;
	Thu, 24 Sep 2026 04:05:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED7DFF8049C; Thu, 24 Sep 2026 04:05:26 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790215525;
	b=TDzFdku/hunxVKMOrHWjQUi4oHd5pDVvuZFc0rHKbHmQMZbWrc2mkhPFMUrpqMiBQErv
	 pcTr9Jh7hDLJNha6uC4fWo8BrnZGa/NZD+2aAvFIaefmssatOrO8nxlRsspQbF+NA/h4Z
	 Xpp4n6Z3xlTCeEWPnVI4TwzsWPhJ4GyQ1sX7YS4CP8WqkzOk2U1GatbGofoma3ECmgyxH
	 CtRBdwu4rUKA+1OHJlW1zJHy7URnHfQuUGaZv6XHJDOXUBa+Ld2kP8BvBrBm1MCECwF3X
	 g4HPrjiii3yq7h03a7QW9DoElecwFv4nQNVgLerGmvRNA+Ibg3rtrZ0KOQODPjfVO7A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790215525;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wIGzAJdFl+9sCrm4XhMQb7bTdxsdCyWk2X5KgQTMfLk=;
	b=pwPydocWLRKPCtTrQ02I9mLyPfXu7wxWcToaQ14TvUNmhFc/Mh4AI7P9YPcVDy0oY33o
	 PS3+EHsHuGdo0B9AOxddXqEjgFVPsDXiH4ONFVQW18smVKkuIsvwqOc8HgNo3VE+acwDx
	 QPQI3BGfQnT+svkvp1/H2hdC4Tf1c9yD9imKAlZpU/HRY0VYWoG6nAdoE2LptDZF8Ue1Q
	 1WcxfadV5FvT+3vbSTKRepp+5pIG5sKiH8oDpR2J4J+LScOTUB6UdNXxXxQ1mPa1iyOGZ
	 uOwqLws4wT3zVHv8AazqH+tF4jxq2Zq0+RcDAu2NH4XHRzWjI6mBe+//GH9EKM/v9gA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=ZKJ0ALGw;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E72B4F801F5
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 04:05:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E72B4F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=ZKJ0ALGw
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68O25CO40805316,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790215513; bh=CQ8YWhQQcMRI84TK5wgSPkfkl7/tiBIsJTCa7jBpsv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZKJ0ALGwMVUfW/+ctRqXxS5aoFU2CzwEJZBfnmLfO8WeqGrWY/HhesGyy1/AC5K+P
	 Ff2b2gOgOq+nfo23HVgL2pZrN+1zNlCBJGmGJ1CU44uUi8U3oX4q8wJY+wfZaqwkVo
	 MK8SSZ5uqLJFEis2vKLir8bvvLCvrbgXaU1L8IJax6hi4IoeH2vl4s3wT4MYrWvT6R
	 L0xt7qUBBht6egzu234OEcqTykAHLnqG7SBjalIeHUxlBs8TQXN2yqI7w3yag6+I+M
	 Jg0BM1FflV3PNHNBnfTh43wk0z5/6oW918+vCtzPopsZPbKyoBaTTGsJjvYx1LjUhY
	 AfJ52+TYap0wA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68O25CO40805316
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Sep 2026 10:05:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 24 Sep 2026 10:05:12 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 24 Sep 2026 10:05:12 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v2] ASoC: rt1320: make SRAM registers readable to stop being
 cached
Date: Thu, 24 Sep 2026 10:05:10 +0800
Message-ID: <20260924020510.3551163-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: IPYMSJ4PGKCH47PLEUXSELTDB27Z5USQ
X-Message-ID-Hash: IPYMSJ4PGKCH47PLEUXSELTDB27Z5USQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IPYMSJ4PGKCH47PLEUXSELTDB27Z5USQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

rt1320_volatile_register() marks the SRAM ranges 0x10000000-0x10008fff
and 0x1000c000-0x1000dfff as volatile, but regmap only honors that flag
for a readable register and these ranges were missing from
 rt1320_readable_register(). They were therefore cached at probe and
replayed over SoundWire on every runtime resume, delaying the
first PCM open after autosuspend by about a second.

Make the ranges readable so the volatile flag takes effect and the SRAM
is no longer cached. Exclude 0x1000d000-0x1000d7ff from both callbacks,
since rt1320_rae_load() deliberately caches that tuning-tool window.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index b13622e54ae0..fa89db096651 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -890,8 +890,9 @@ static bool rt1320_readable_register(struct device *dev, unsigned int reg)
 	case 0xf01e:
 	case 0xf717 ... 0xf719:
 	case 0xf720 ... 0xf723:
-	case 0x1000cd91 ... 0x1000cd96:
-	case RT1321_PATCH_MAIN_VER ... RT1321_PATCH_BETA_VER:
+	case 0x10000000 ... 0x10008fff:
+	case 0x1000c000 ... 0x1000cfff:
+	case 0x1000d800 ... 0x1000dfff:
 	case 0x1000f008:
 	case 0x1000f021:
 	case 0x20003000 ... 0x2000300f:
@@ -996,7 +997,8 @@ static bool rt1320_volatile_register(struct device *dev, unsigned int reg)
 	case 0xf717 ... 0xf719:
 	case 0xf720 ... 0xf723:
 	case 0x10000000 ... 0x10008fff:
-	case 0x1000c000 ... 0x1000dfff:
+	case 0x1000c000 ... 0x1000cfff:
+	case 0x1000d800 ... 0x1000dfff:
 	case 0x1000f008:
 	case 0x1000f021:
 	case 0x2000300e ... 0x2000300f:
-- 
2.55.0

