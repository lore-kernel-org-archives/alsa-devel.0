Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D21606A332
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Nov 2026 03:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=pW0WSvPK;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=R8eqJbUm
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33DBF60230;
	Wed,  4 Nov 2026 04:09:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33DBF60230
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793761775;
	bh=L45B9/LG1fbt2BxUOzBu50AhoSGjiOBpawQ2D7wrhYI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=pW0WSvPKUlKTp/MGlLOr3Ba4Me9LA87QVpaMSN1hI/fM8YHaqlWIqhqC4Jv83c7St
	 sKFhWU2UelikViLlP9EuDmfiiXbZtdekFZJ6djtu1I9uyFGsFkHg7Ueb3xr7do7VDB
	 7kXssgdHdxspXf5XnViK6BOm6T0SA/hbGpOCKDvw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 725F9F805FB; Wed,  4 Nov 2026 04:08:59 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CAC12F805FC;
	Wed,  4 Nov 2026 04:08:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1C5E4F805AA; Wed,  4 Nov 2026 04:08:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1793761729;
	b=Gf8/CMlCekWygkKF8iThWKkjGK8uznbTk2FrRSzR6dKq22WB/nRIyQc5UFv0+N8vuK+g
	 LT61b1CCIdIekxNbCOAnFBAvD3sQDBnIj5SFfNryE97UcI+wD2Lo1FnDI0zb95KhhGTVu
	 CgWUdXFdz36dcRWW3GiDOkJ0szrZu+WWJ5B7e5es10++V+vP69n6E7PGkjrv7F2nxqyAB
	 F2oxkuP1qbU2Tdy2c+zALfko2bqFlPJIrzx1bqhG0ck7F2vxDkzxns/MAtfj6XU5Xq7lW
	 seAQPEeT8mnvuvMXp52zzMt2ok9fnpbyqGtIC6q9zIq4ENlwIBTM6LWJt6ixLgbA3Aw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793761729;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=L45B9/LG1fbt2BxUOzBu50AhoSGjiOBpawQ2D7wrhYI=;
	b=iDqfjlF/WyuPUaBjJU8XdqVseTc7YTUsSTgKHVGioFAEjC9GCU7ge27eZglAtGj6c/Uz
	 DNr8ePU2q4YqM6gK1RVnN5JzHfzjsVqzwIeL7kqcw1BsNU1OVbDDlq4DfO72JWLEme/+q
	 tpf7QOOObiBzkTPzI2DSdaNDR76OM1XiBjELImRKxbOK6hou5GnLYVdZCkZ4HlYaT5ZgH
	 WnFx2Hwrs+US3/F61aQJDNOPs+gxbRS/vs+4DJSq3Qk3O6pkl0m0crt0xtPHPynuG7l8V
	 cEEgqISjZnlOAVV5MW5wvrjlOQRBoiDzF39JhDZXPiUdEc+D7+9a0DEnY8lFGfkCbQA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=R8eqJbUm;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E4C9FF8055B
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2026 04:08:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4C9FF8055B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=R8eqJbUm
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A438ZQ203644184,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793761715; bh=H+t4GTOPtCLl1egDjzPDcXerDpwFcdlE0ZiKZeCJhmY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=R8eqJbUmZ53Uw77Y1vlJFQVxXcPg59TYHSHr6OrMrzU76H8GHb05nwSSLvmk4vHr4
	 XCglUcWcY2rPrhefmegxOkSSKivkaDHdlxtTafc/YJQLkYvDCt09zBNFjcYuraGvL4
	 foMKAlEF8IFSW6rKB1aRgh67nxOPCZrQgdttc0eLQjUD3Fgf/M1DHDk4rWM1yxzRBh
	 3x6+V0Yli37d8MSvFLtKrKocNQhZq4D2OOVl6eVKTOFu+s1qTnrxYd/3RUep0Vg3zY
	 77trva80+7FHdA1MdPL736wo+6jT6aCo1RaHob2ofJ3qQWY/vGEhp3WMBEanFW3MxB
	 sAHAGuGwABwLA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A438ZQ203644184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 11:08:35 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 11:08:35 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:53:23 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 10:53:23 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt1320-sdw: Update the driver to support rt1321_va2
Date: Wed, 4 Nov 2026 10:53:21 +0800
Message-ID: <20261104025321.822219-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: MKHUNLDJOAIWB3VJIUEQ6GVLZ6EQT35B
X-Message-ID-Hash: MKHUNLDJOAIWB3VJIUEQ6GVLZ6EQT35B
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MKHUNLDJOAIWB3VJIUEQ6GVLZ6EQT35B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

RT1321 VA2 needs a different flow from VA0/VA1:

- Load the VA2 MCU patch code.
- Update the VA2 init settings and add the companion mode settings.
- Before R0 calibration and R0 load, switch to TV mode and disable
  phase sync/silence detection so the DSP FW serves GET/SET_PARAM.
- Take the VA2 advance gain from the AFX1 header of the DSP FW.
- Extend the readable/volatile range of the DSP status registers.
- Increase the BRA sections to 16 for the 14-section DSP FW package.
- Hold a runtime PM reference in the kcontrol put handlers to avoid
  runtime suspend in the middle of a long DSP access.

The VA2 MCU patch code is submitted to linux-firmware separately.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 698 +++++++++++++++++++++-------------
 sound/soc/codecs/rt1320-sdw.h |   8 +
 2 files changed, 432 insertions(+), 274 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index fa89db096651..a5866d6405c8 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -578,232 +578,246 @@ static const struct reg_sequence rt1321_va1_blind_write[] = {
 };
 
 static const struct reg_sequence rt1321_va2_blind_write[] = {
-	{ 0x0000c003, 0xf0 },
-	{ 0x0000c01b, 0xfc },
-	{ 0x0000c5c3, 0xf2 },
-	{ 0x0000c5c2, 0x00 },
-	{ 0x0000c5c1, 0x10 },
-	{ 0x0000c5c0, 0x04 },
-	{ 0x0000c5c7, 0x03 },
-	{ 0x0000c5c6, 0x10 },
-	{ 0x0000c526, 0x47 },
-	{ 0x0000c5c4, 0x12 },
-	{ 0x0000c5c5, 0x60 },
-	{ 0x0000c520, 0x10 },
-	{ 0x0000c521, 0x32 },
-	{ 0x0000c5c7, 0x00 },
-	{ 0x0000c5c8, 0x03 },
-	{ 0x0000c5d3, 0x08 },
-	{ 0x0000c5d2, 0x0a },
-	{ 0x0000c5d1, 0x49 },
-	{ 0x0000c5d0, 0x0f },
-	{ 0x0000c580, 0x10 },
-	{ 0x0000c581, 0x32 },
-	{ 0x0000c582, 0x01 },
-	{ 0x0000c682, 0x60 },
-	{ 0x0000c019, 0x10 },
-	{ 0x0000c5f0, 0x01 },
-	{ 0x0000c5f7, 0x22 },
-	{ 0x0000c5f6, 0x22 },
-	{ 0x0000c057, 0x51 },
-	{ 0x0000c054, 0x55 },
-	{ 0x0000c053, 0x55 },
-	{ 0x0000c052, 0x55 },
-	{ 0x0000c051, 0x01 },
-	{ 0x0000c050, 0x15 },
-	{ 0x0000c060, 0x99 },
-	{ 0x0000c030, 0x55 },
-	{ 0x0000c061, 0x55 },
-	{ 0x0000c063, 0x55 },
-	{ 0x0000c065, 0xa5 },
-	{ 0x0000c06b, 0x0a },
-	{ 0x0000ca05, 0xd6 },
-	{ 0x0000ca06, 0x11 },
-	{ 0x0000ca07, 0x1e },
-	{ 0x0000ca25, 0xd6 },
-	{ 0x0000ca26, 0x11 },
-	{ 0x0000ca27, 0x1e },
-	{ 0x0000cd00, 0x05 },
-	{ 0x0000cd81, 0x49 },
-	{ 0x0000cd82, 0x49 },
-	{ 0x0000c604, 0x40 },
-	{ 0x0000c609, 0x40 },
-	{ 0x0000c046, 0xf7 },
-	{ 0x0000c045, 0xff },
-	{ 0x0000c044, 0xff },
-	{ 0x0000c043, 0xff },
-	{ 0x0000c042, 0xff },
-	{ 0x0000c041, 0xff },
-	{ 0x0000c040, 0xff },
-	{ 0x0000c049, 0xff },
-	{ 0x0000c028, 0x3f },
-	{ 0x0000c020, 0x3f },
-	{ 0x0000c032, 0x13 },
-	{ 0x0000c033, 0x01 },
-	{ 0x0000cc10, 0x01 },
-	{ 0x0000dc20, 0x03 },
-	{ 0x0000de03, 0x05 },
-	{ 0x0000dc00, 0x00 },
-	{ 0x0000c700, 0xf0 },
-	{ 0x0000c701, 0x13 },
-	{ 0x0000c900, 0xc3 },
-	{ 0x0000c570, 0x08 },
-	{ 0x0000c086, 0x02 },
-	{ 0x0000c085, 0x7f },
-	{ 0x0000c084, 0x00 },
-	{ 0x0000c081, 0xff },
-	{ 0x0000f084, 0x0f },
-	{ 0x0000f083, 0xff },
-	{ 0x0000f082, 0xff },
-	{ 0x0000f081, 0xff },
-	{ 0x0000f080, 0xff },
-	{ 0x20003003, 0x3f },
+	{ 0x0000C570, 0x0A },
+	{ 0x0000D486, 0x80 },
+	{ 0x0000C040, 0x00 },
+	{ 0x0000C041, 0x00 },
+	{ 0x0000C042, 0x00 },
+	{ 0x0000C043, 0x00 },
+	{ 0x0000C044, 0xE0 },
+	{ 0x0000C045, 0x00 },
+	{ 0x0000C046, 0x00 },
+	{ 0x0000C054, 0x53 },
+	{ 0x0000C057, 0x55 },
+	{ 0x0000C081, 0xCA },
+	{ 0x0000C5C3, 0x02 },
+	{ 0x0000C5FB, 0x02 },
+	{ 0x0000C600, 0x04 },
+	{ 0x0000C601, 0x83 },
+	{ 0x0000C604, 0x30 },
+	{ 0x0000C609, 0x42 },
+	{ 0x0000CE44, 0x0C },
+	{ 0x0000CE1A, 0x88 },
+	{ 0x0000CF02, 0x00 },
+	{ 0x0000D470, 0x00 },
+	{ 0x0000D471, 0x00 },
+	{ 0x0000D487, 0x03 },
+	{ 0x0000D540, 0x00 },
+	{ 0x0000D73C, 0x00 },
+	{ 0x0000D73D, 0x00 },
+	{ 0x0000D73E, 0x00 },
+	{ 0x0000D73F, 0x00 },
+	{ 0x0000DE00, 0x2F },
+	{ 0x0000DE02, 0x0E },
+	{ 0x0000DE03, 0x01 },
+	{ 0x0000DE04, 0x00 },
+	{ 0x0000DE05, 0x00 },
+	{ 0x0000C019, 0x00 },
+	{ 0x0000C01A, 0x01 },
+	{ 0x0000C01B, 0xFC },
+	{ 0x0000C500, 0x00 },
+	{ 0x0000C680, 0x80 },
+	{ 0x0000C681, 0x08 },
+	{ 0x0000C500, 0x01 },
+	{ 0x0000C003, 0x20 },
+	{ 0x0000C003, 0xF0 },
+	{ 0x0000C01B, 0xFC },
+	{ 0x0000C5C3, 0xF2 },
+	{ 0x0000C5C2, 0x00 },
+	{ 0x0000C5C1, 0x10 },
+	{ 0x0000C5C0, 0x04 },
+	{ 0x0000C5C7, 0x03 },
+	{ 0x0000C5C6, 0x10 },
+	{ 0x0000C526, 0x47 },
+	{ 0x0000C5C4, 0x12 },
+	{ 0x0000C5C5, 0x60 },
+	{ 0x0000C520, 0x10 },
+	{ 0x0000C521, 0x32 },
+	{ 0x0000C5C7, 0x00 },
+	{ 0x0000C5C8, 0x03 },
+	{ 0x0000C5D3, 0x08 },
+	{ 0x0000C5D2, 0x0A },
+	{ 0x0000C5D1, 0x46 },
+	{ 0x0000C5D0, 0x0f },
+	{ 0x0000C580, 0x10 },
+	{ 0x0000C581, 0x32 },
+	{ 0x0000C582, 0x01 },
+	{ 0x0000C682, 0x60 },
+	{ 0x0000C019, 0x10 },
+	{ 0x0000C5F0, 0x01 },
+	{ 0x0000C5F7, 0x22 },
+	{ 0x0000C5F6, 0x22 },
+	{ 0x0000C057, 0x51 },
+	{ 0x0000C054, 0x55 },
+	{ 0x0000C053, 0x55 },
+	{ 0x0000C052, 0x55 },
+	{ 0x0000C051, 0x01 },
+	{ 0x0000C050, 0x15 },
+	{ 0x0000C060, 0x99 },
+	{ 0x0000C030, 0x55 },
+	{ 0x0000C061, 0x55 },
+	{ 0x0000C063, 0x55 },
+	{ 0x0000C065, 0xA5 },
+	{ 0x0000C06B, 0x0A },
+	{ 0x0000CA05, 0xD6 },
+	{ 0x0000CA06, 0x11 },
+	{ 0x0000CA07, 0x1E },
+	{ 0x0000CA25, 0xD6 },
+	{ 0x0000CA26, 0x11 },
+	{ 0x0000CA27, 0x1E },
+	{ 0x0000CD00, 0x05 },
+	{ 0x0000CD81, 0x49 },
+	{ 0x0000CD82, 0x49 },
+	{ 0x0000C604, 0x40 },
+	{ 0x0000C609, 0x40 },
+	{ 0x0000C046, 0xF7 },
+	{ 0x0000C045, 0xFF },
+	{ 0x0000C044, 0xFF },
+	{ 0x0000C043, 0xFF },
+	{ 0x0000C042, 0xFF },
+	{ 0x0000C041, 0xFF },
+	{ 0x0000C040, 0xFF },
+	{ 0x0000C049, 0xFF },
+	{ 0x0000C028, 0x3F },
+	{ 0x0000C020, 0x3F },
+	{ 0x0000C032, 0x13 },
+	{ 0x0000C033, 0x01 },
+	{ 0x0000CC10, 0x01 },
+	{ 0x0000DC20, 0x03 },
+	{ 0x0000DE03, 0x05 },
+	{ 0x0000DC00, 0x00 },
+	{ 0x0000C700, 0xF0 },
+	{ 0x0000C701, 0x13 },
+	{ 0x0000C900, 0xC3 },
+	{ 0x0000C570, 0x08 },
+	{ 0x0000C086, 0x02 },
+	{ 0x0000C085, 0x7F },
+	{ 0x0000C084, 0x00 },
+	{ 0x0000C081, 0xFF },
+	{ 0x0000F084, 0x0F },
+	{ 0x0000F083, 0xFF },
+	{ 0x0000F082, 0xFF },
+	{ 0x0000F081, 0xFF },
+	{ 0x0000F080, 0xFF },
+	{ 0x20003000, 0x00 },
+	{ 0x20003001, 0x10 },
+	{ 0x20005800, 0x00 },
+	{ 0x20009000, 0x00 },
+	{ 0x20003003, 0x3F },
+	{ 0x20009003, 0x3F },
 	{ 0x20005818, 0x81 },
 	{ 0x20009018, 0x81 },
-	{ 0x2000301c, 0x81 },
-	{ 0x0000c003, 0xc0 },
-	{ 0x0000c047, 0x80 },
-	{ 0x0000d541, 0x80 },
-	{ 0x0000d487, 0x0b },
-	{ 0x0000d487, 0x3b },
-	{ 0x0000d486, 0xc3 },
-	{ 0x0000d470, 0x89 },
-	{ 0x0000d471, 0x3a },
-	{ 0x0000d472, 0x3d },
-	{ 0x0000d474, 0x11 },
-	{ 0x0000d475, 0x32 },
-	{ 0x0000d476, 0x64 },
-	{ 0x0000d477, 0x10 },
-	{ 0x0000d478, 0xff },
-	{ 0x0000d479, 0x20 },
-	{ 0x0000d47a, 0x10 },
+	{ 0x2000301C, 0x81 },
+	{ 0x0000C003, 0xC0 },
+	{ 0x0000D541, 0x80 },
+	{ 0x0000D487, 0x0B },
+	{ 0x0000D487, 0x3B },
+	{ 0x0000D486, 0xC3 },
+	{ 0x0000D470, 0x89 },
+	{ 0x0000D471, 0x3A },
+	{ 0x0000D472, 0x7D },
+	{ 0x0000D473, 0x01 },
+	{ 0x0000D474, 0x11 },
+	{ 0x0000D475, 0x32 },
+	{ 0x0000D476, 0x64 },
+	{ 0x0000D477, 0x10 },
+	{ 0x0000D478, 0xFF },
+	{ 0x0000D479, 0x20 },
+	{ 0x0000D47A, 0x10 },
 	{ 0x10008000, 0x67 },
 	{ 0x10008001, 0x80 },
 	{ 0x10008002, 0x00 },
 	{ 0x10008003, 0x00 },
+	{ 0x0000D73C, 0xB7 },
+	{ 0x0000D73D, 0xD7 },
+	{ 0x0000D73E, 0x00 },
+	{ 0x0000D73F, 0x10 },
 	{ 0x1000cd56, 0x00 },
-	{ 0x0000d486, 0x43 },
-	{ 0x3fc2dfc3, 0x00 },
-	{ 0x3fc2dfc2, 0x00 },
-	{ 0x3fc2dfc1, 0x00 },
-	{ 0x3fc2dfc0, 0x03 },
-	{ 0x3fc2dfc7, 0x00 },
-	{ 0x3fc2dfc6, 0x00 },
-	{ 0x3fc2dfc5, 0x00 },
-	{ 0x3fc2dfc4, 0x01 },
-	{ 0x3fc2dfa3, 0x00 },
-	{ 0x3fc2dfa2, 0x00 },
-	{ 0x3fc2dfa1, 0x00 },
-	{ 0x3fc2dfa0, 0x00 },
-	{ 0x3fc2df80, 0x10 },
-	{ 0x3fc2df81, 0x20 },
-	{ 0x3fc2df82, 0x00 },
-	{ 0x3fc2df83, 0x00 },
-	{ 0x3fc2df84, 0x50 },
-	{ 0x3fc2df85, 0x19 },
-	{ 0x3fc2df86, 0x00 },
-	{ 0x3fc2df87, 0x00 },
-	{ 0x3fc2df88, 0x52 },
-	{ 0x3fc2df89, 0x23 },
-	{ 0x3fc2df8a, 0x00 },
-	{ 0x3fc2df8b, 0x00 },
-	{ 0x3fc2df8c, 0xe0 },
-	{ 0x3fc2df8d, 0x2e },
-	{ 0x3fc2df8e, 0x00 },
-	{ 0x3fc2df8f, 0x00 },
-	{ 0x3fc2df90, 0xe0 },
-	{ 0x3fc2df91, 0x2e },
-	{ 0x3fc2df92, 0x00 },
-	{ 0x3fc2df93, 0x00 },
-	{ 0x3fc2df94, 0x01 },
-	{ 0x3fc2df95, 0x08 },
-	{ 0x3fc2df96, 0x00 },
-	{ 0x3fc2df97, 0x00 },
-	{ 0x3fc2df40, 0x80 },
-	{ 0x3fc2df41, 0xbb },
-	{ 0x3fc2df42, 0x00 },
-	{ 0x3fc2df43, 0x00 },
-	{ 0x3fc2df44, 0xc0 },
-	{ 0x3fc2df45, 0x99 },
-	{ 0x3fc2df46, 0x01 },
-	{ 0x3fc2df47, 0x00 },
-	{ 0x3fc2df48, 0x00 },
-	{ 0x3fc2df49, 0x00 },
-	{ 0x3fc2df4a, 0x00 },
-	{ 0x3fc2df4b, 0x00 },
-	{ 0x3fc2df4c, 0x00 },
-	{ 0x3fc2df4d, 0x00 },
-	{ 0x3fc2df4e, 0x00 },
-	{ 0x3fc2df4f, 0x00 },
-	{ 0x3fc2df50, 0x01 },
-	{ 0x3fc2df51, 0x00 },
-	{ 0x3fc2df52, 0x00 },
-	{ 0x3fc2df53, 0x00 },
-	{ 0x3fc2df54, 0x01 },
-	{ 0x3fc2df55, 0x00 },
-	{ 0x3fc2df56, 0x00 },
-	{ 0x3fc2df57, 0x00 },
-	{ 0x3fc2df58, 0x00 },
-	{ 0x3fc2df59, 0x00 },
-	{ 0x3fc2df5a, 0x00 },
-	{ 0x3fc2df5b, 0x00 },
-	{ 0x3fc2df5c, 0x01 },
-	{ 0x3fc2df5d, 0x00 },
-	{ 0x3fc2df5e, 0x00 },
-	{ 0x3fc2df5f, 0x00 },
-	{ 0x3fc2df60, 0x00 },
-	{ 0x3fc2df61, 0x00 },
-	{ 0x3fc2df62, 0x00 },
-	{ 0x3fc2df63, 0x00 },
-	{ 0x3fc2df64, 0x00 },
-	{ 0x3fc2df65, 0x00 },
-	{ 0x3fc2df66, 0x00 },
-	{ 0x3fc2df67, 0x10 },
-	{ 0x3fc2df68, 0x01 },
-	{ 0x3fc2df69, 0x00 },
-	{ 0x3fc2df6a, 0x00 },
-	{ 0x3fc2df6b, 0x00 },
-	{ 0x3fc2df6c, 0x01 },
-	{ 0x3fc2df6d, 0x00 },
-	{ 0x3fc2df6e, 0x00 },
-	{ 0x3fc2df6f, 0x00 },
-	{ 0x3fc2df70, 0x04 },
-	{ 0x3fc2df71, 0x00 },
-	{ 0x3fc2df72, 0x00 },
-	{ 0x3fc2df73, 0x00 },
-	{ 0x3fc2df74, 0x01 },
-	{ 0x3fc2df75, 0x00 },
-	{ 0x3fc2df76, 0x00 },
-	{ 0x3fc2df77, 0x00 },
-	{ 0x1000db00, 0x04 },
-	{ 0x1000db01, 0x00 },
-	{ 0x1000db02, 0x10 },
-	{ 0x1000db03, 0x00 },
-	{ 0x1000db04, 0x00 },
-	{ 0x1000db05, 0x45 },
-	{ 0x1000db06, 0x0d },
-	{ 0x1000db07, 0x01 },
-	{ 0x1000db08, 0x00 },
-	{ 0x1000db09, 0x00 },
-	{ 0x1000db0a, 0xbf },
-	{ 0x1000db0b, 0x0b },
-	{ 0x1000db0c, 0x11 },
-	{ 0x1000db0d, 0x00 },
-	{ 0x1000db0e, 0x00 },
-	{ 0x1000db0f, 0x00 },
-	{ 0x1000db10, 0x2c },
-	{ 0x1000db11, 0xfa },
-	{ 0x1000db12, 0x00 },
-	{ 0x1000db13, 0x00 },
-	{ 0x1000db14, 0x09 },
-	{ 0x0000d540, 0x21 },
-	{ 0x0000d714, 0x17 },
-	{ 0x0000dd0b, 0x0d },
-	{ 0x0000dd0a, 0xff },
-	{ 0x0000dd09, 0x0d },
-	{ 0x0000dd08, 0xff },
-	{ 0x0000c5fb, 0x12 },
-	{ 0x0000c570, 0x08 },
+	{ 0x0000D541, 0x40 },
+	{ 0x0000D486, 0x43 },
+	{ 0x3FC2DFC0, 0x0B },
+	{ 0x3FC2DFC1, 0x00 },
+	{ 0x3FC2DFC2, 0x00 },
+	{ 0x3FC2DFC3, 0x00 },
+	{ 0x3FC2DFC4, 0x01 },
+	{ 0x3FC2DFC5, 0x00 },
+	{ 0x3FC2DFC6, 0x00 },
+	{ 0x3FC2DFC7, 0x00 },
+	{ 0x3FC2DFCC, 0x00 },
+	{ 0x3FC2DFCD, 0x00 },
+	{ 0x3FC2DFCE, 0x54 },
+	{ 0x3FC2DFCF, 0x05 },
+	{ 0x3FC2DFA0, 0x00 },
+	{ 0x3FC2DFA1, 0x00 },
+	{ 0x3FC2DFA2, 0x00 },
+	{ 0x3FC2DFA3, 0x00 },
+	{ 0x3FC2DFD0, 0x00 },
+	{ 0x3FC2DFD1, 0x00 },
+	{ 0x3FC2DFD2, 0x00 },
+	{ 0x3FC2DFD3, 0x00 },
+	{ 0x1000DB00, 0x07 },
+	{ 0x1000DB01, 0x00 },
+	{ 0x1000DB02, 0x10 },
+	{ 0x1000DB03, 0x00 },
+	{ 0x1000DB04, 0x00 },
+	{ 0x1000DB05, 0x45 },
+	{ 0x1000DB06, 0x0D },
+	{ 0x1000DB07, 0x01 },
+	{ 0x1000DB08, 0x00 },
+	{ 0x1000DB09, 0x00 },
+	{ 0x1000DB0A, 0xBF },
+	{ 0x1000DB0B, 0x0B },
+	{ 0x1000DB0C, 0x11 },
+	{ 0x1000DB0D, 0x00 },
+	{ 0x1000DB0E, 0x00 },
+	{ 0x1000DB0F, 0x00 },
+	{ 0x1000DB10, 0x2C },
+	{ 0x1000DB11, 0xFA },
+	{ 0x1000DB12, 0x00 },
+	{ 0x1000DB13, 0x00 },
+	{ 0x1000DB14, 0x09 },
+	{ 0x1000DB15, 0x00 },
+	{ 0x1000DB16, 0x0F },
+	{ 0x1000DB17, 0x00 },
+	{ 0x1000DB18, 0x00 },
+	{ 0x1000DB19, 0x80 },
+	{ 0x1000DB1A, 0x21 },
+	{ 0x1000DB1B, 0xFA },
+	{ 0x1000DB1C, 0x00 },
+	{ 0x1000DB1D, 0x00 },
+	{ 0x1000DB1E, 0x06 },
+	{ 0x1000DB1F, 0x23 },
+	{ 0x1000DB20, 0xFA },
+	{ 0x1000DB21, 0x00 },
+	{ 0x1000DB22, 0x00 },
+	{ 0x1000DB23, 0x0E },
+	{ 0x0000D540, 0x21 },
+	{ 0x0000C570, 0x08 },
+	{ 0x0000D714, 0x17 },
+	{ 0x0000C5FB, 0x52 },
+	{ 0x0000C5C3, 0xF2 },
+	{ 0x0000C5C8, 0x03 },
+	{ 0x0000DD08, 0xFF },
+	{ 0x0000DD09, 0x0D },
+	{ 0x0000DD0A, 0xFF },
+	{ 0x0000DD0B, 0x0D },
+	{ 0x0000C570, 0x08 },
+	{ 0x0000D471, 0x3B },
+	{ 0x0000DB00, 0x00 },
+	{ 0x0000DB01, 0x00 },
+	{ 0x0000DB02, 0x73 },
+	{ 0x0000DB03, 0x00 },
+	{ 0x0000DB04, 0x00 },
+	{ 0x0000DB05, 0x00 },
+	{ 0x0000DB06, 0x00 },
+	{ 0x0000DB07, 0x00 },
+	{ 0x0000DB08, 0x7F },
+	{ 0x0000DB09, 0x00 },
+	{ 0x0000DB1A, 0x00 },
+	{ 0x0000DB1B, 0x00 },
+	{ 0x0000DB19, 0x00 },
+	{ 0x0000C04C, 0xE2 },
+	{ 0x0000C068, 0x35 },
 };
 
 static const struct reg_default rt1320_reg_defaults[] = {
@@ -904,7 +918,7 @@ static bool rt1320_readable_register(struct device *dev, unsigned int reg)
 	case 0x20009000 ... 0x2000900f:
 	case 0x20009018:
 	case 0x20009040 ... 0x20009059:
-	case 0x3fc000c0 ... 0x3fc2dfc8:
+	case 0x3fc000c0 ... 0x3fc2dfcb:
 	case 0x3fe00000 ... 0x3fe36fff:
 	/* 0x40801508/0x40801809/0x4080180a/0x40801909/0x4080190a */
 	case SDW_SDCA_CTL(FUNC_NUM_MIC, RT1320_SDCA_ENT_PDE11, RT1320_SDCA_CTL_REQ_POWER_STATE, 0):
@@ -1013,9 +1027,9 @@ static bool rt1320_volatile_register(struct device *dev, unsigned int reg)
 	case 0x3fc2ab80 ... 0x3fc2ac4c:
 	case 0x3fc2b780:
 	case 0x3fc2bf80 ... 0x3fc2bf83:
-	case 0x3fc2bfc0 ... 0x3fc2bfc8:
+	case 0x3fc2bfc0 ... 0x3fc2bfcb:
 	case 0x3fc2d300 ... 0x3fc2d3cc:
-	case 0x3fc2dfc0 ... 0x3fc2dfc8:
+	case 0x3fc2dfc0 ... 0x3fc2dfcb:
 	case 0x3fe2e000 ... 0x3fe2e003:
 	case SDW_SDCA_CTL(FUNC_NUM_MIC, RT1320_SDCA_ENT_PDE11, RT1320_SDCA_CTL_ACTUAL_POWER_STATE, 0):
 	case SDW_SDCA_CTL(FUNC_NUM_AMP, RT1320_SDCA_ENT0, RT1320_SDCA_CTL_FUNC_STATUS, 0):
@@ -1270,7 +1284,7 @@ static void rt1320_pr_read(struct rt1320_sdw_priv *rt1320, unsigned int reg, uns
 static int rt1320_check_fw_ready(struct rt1320_sdw_priv *rt1320)
 {
 	struct device *dev = &rt1320->sdw_slave->dev;
-	unsigned int tmp, retry = 0;
+	unsigned int tmp, retry = 0, i;
 	unsigned int cmd_addr;
 
 	switch (rt1320->dev_id) {
@@ -1291,6 +1305,12 @@ static int rt1320_check_fw_ready(struct rt1320_sdw_priv *rt1320)
 		regmap_read(rt1320->regmap, cmd_addr, &tmp);
 		if (tmp == 0)
 			break;
+		else if (tmp != 0x1 && tmp != 0x2 && tmp != 0x3) {
+			dev_warn(dev, "%s abnormal val, tmp:%x", __func__, tmp);
+			for (i = 0; i < 8; i++)
+				regmap_write(rt1320->regmap, RT1321_FW_PARAM_ADDR + i, 0x00);
+			break;
+		}
 		usleep_range(1000, 1100);
 		retry++;
 	}
@@ -1459,35 +1479,53 @@ static int rt1320_fw_param_protocol(struct rt1320_sdw_priv *rt1320, enum rt1320_
 static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 {
 	struct device *dev = &rt1320->sdw_slave->dev;
-	struct rt1320_datafixpoint r0_data[2];
+	struct rt1320_datafixpoint r0_data[2] = {};
+	FwPara_Get_HwSwGain hwswgain = {};
 	unsigned short l_advancegain, r_advancegain;
-	FwPara_Get_HwSwGain audDriverDataHwSwGain = {0};
-	unsigned int HwAdvGain = 0;
-	int ret;
+	bool is_va2 = rt1320->dev_id == RT1321_DEV_ID &&
+		rt1320->version_id == RT1321_VA2;
+	int ret, i;
+	unsigned int reg_c5fb, reg_c560;
 
-	 /* Get new hardware advance gain by ID 1300 */
-	ret = rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 1300,
-		&audDriverDataHwSwGain, sizeof(audDriverDataHwSwGain));
-	if (ret == 0) {
-		HwAdvGain = audDriverDataHwSwGain.HwAdvGain;
-		dev_dbg(dev, "%s, HwAdvGain=%d\n", __func__, HwAdvGain);
-		dev_dbg(dev, "%s, HwBasGain=%d\n", __func__, audDriverDataHwSwGain.HwBasGain);
-		dev_dbg(dev, "%s, SwAdvGain=%d\n", __func__, audDriverDataHwSwGain.SwAdvGain);
-		dev_dbg(dev, "%s, SwBasGain=%d\n", __func__, audDriverDataHwSwGain.SwBasGain);
-	} else {
-		dev_dbg(dev, "%s: param 1300 not supported, ret=%d\n", __func__, ret);
+	if (is_va2) {
+		regmap_read(rt1320->regmap, 0xc5fb, &reg_c5fb);
+		regmap_write(rt1320->regmap, 0xc5fb, 0x00);
+		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x00);
+		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0x00);
+		for (i = 0; i < 200; i++) {
+			regmap_read(rt1320->regmap, RT1320_POWER_STATE, &reg_c560);
+			if (reg_c560 == RT1320_K_R0_STATE)
+				break;
+			usleep_range(10000, 15000);
+		}
+		dev_dbg(dev, "%s, RT1320_POWER_STATE=0x%x, i=%d\n", __func__,
+			reg_c560, i);
+		regmap_write(rt1320->regmap, 0xc570, 0x0b);
+		regmap_write(rt1320->regmap, 0xc5c4, 0x12);
 	}
 
 	/* Get advance gain/r0 */
-	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 6, &r0_data[0], sizeof(struct rt1320_datafixpoint));
-	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 7, &r0_data[1], sizeof(struct rt1320_datafixpoint));
+	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 6, &r0_data[0], sizeof(r0_data[0]));
+	rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 7, &r0_data[1], sizeof(r0_data[1]));
 
-	if (HwAdvGain != 0) {
-		l_advancegain = HwAdvGain & 0xffff;
-		r_advancegain = (HwAdvGain >> 16) & 0xffff;
+	if (is_va2) {
+		/* VA2: the advance gain comes from the AFX1 header */
+		l_advancegain = rt1320->l_adv_gain;
+		r_advancegain = rt1320->r_adv_gain;
 	} else {
-		l_advancegain = r0_data[0].advancegain;
-		r_advancegain = r0_data[1].advancegain;
+		/* Get new hardware advance gain by ID 1300 */
+		ret = rt1320_fw_param_protocol(rt1320, RT1320_GET_PARAM, 1300,
+					       &hwswgain, sizeof(hwswgain));
+		if (ret < 0)
+			dev_dbg(dev, "%s: get param 1300 failed, ret=%d\n", __func__, ret);
+
+		if (hwswgain.HwAdvGain) {
+			l_advancegain = hwswgain.HwAdvGain & 0xffff;
+			r_advancegain = hwswgain.HwAdvGain >> 16;
+		} else {
+			l_advancegain = r0_data[0].advancegain;
+			r_advancegain = r0_data[1].advancegain;
+		}
 	}
 	dev_dbg(dev, "%s, LR advanceGain=0x%x 0x%x\n", __func__, l_advancegain, r_advancegain);
 
@@ -1498,8 +1536,8 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 	r0_data[1].r0 = rt1320->r0_r_reg;
 	dev_dbg(dev, "%s, write LR r0=%d, %d\n", __func__, r0_data[0].r0, r0_data[1].r0);
 
-	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 6, &r0_data[0], sizeof(struct rt1320_datafixpoint));
-	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 7, &r0_data[1], sizeof(struct rt1320_datafixpoint));
+	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 6, &r0_data[0], sizeof(r0_data[0]));
+	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 7, &r0_data[1], sizeof(r0_data[1]));
 	ret = rt1320_check_fw_ready(rt1320);
 	if (ret < 0)
 		dev_err(dev, "%s: Failed to set FW param 6,7!\n", __func__);
@@ -1511,6 +1549,15 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 		regmap_write(rt1320->regmap, 0xdd08, (r_advancegain & 0xff));
 		dev_dbg(dev, "%s, set Advance mode gain\n", __func__);
 	}
+
+	if (is_va2) {
+		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0xe0);
+		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
+		regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);
+		regmap_write(rt1320->regmap, 0xc570, 0x08);
+		regmap_write(rt1320->regmap, 0xc5fb, reg_c5fb);
+		regmap_write(rt1320->regmap, 0xc5c4, 0x10);
+	}
 }
 
 static int rt1320_invrs_load(struct rt1320_sdw_priv *rt1320)
@@ -1619,7 +1666,7 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
 {
 	struct device *dev = &rt1320->sdw_slave->dev;
 	struct rt1320_datafixpoint audfixpoint[2];
-	unsigned int reg_c5fb, reg_c570, reg_cd00;
+	unsigned int reg_c5fb, reg_c570, reg_cd00, reg_c560;
 	unsigned int vol_reg[4];
 	unsigned long long l_meanr0, r_meanr0;
 	int l_re[5], r_re[5];
@@ -1627,7 +1674,9 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
 	unsigned long long factor = (1 << 27);
 	unsigned short l_advancegain, r_advancegain;
 	unsigned int delay_s = 7; /* delay seconds for the calibration */
-	int dspfw_status;
+	int dspfw_status, i;
+	bool is_va2 = rt1320->dev_id == RT1321_DEV_ID &&
+		rt1320->version_id == RT1321_VA2;
 
 	if (!rt1320->component)
 		return;
@@ -1660,6 +1709,30 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
 		goto _finish_;
 	}
 
+	if (is_va2) {
+		/* Switch to TV mode */
+		regmap_write(rt1320->regmap, 0xc5fb, 0x00);
+		regmap_write(rt1320->regmap, 0xcd00, 0xc5);
+		/* disable phase sync */
+		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x00);
+		/* through SRC */
+		regmap_write(rt1320->regmap, 0xc5c4, 0x12);
+		regmap_write(rt1320->regmap, 0xc570, 0x0b);
+
+		/* disable silence detection */
+		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0x00);
+		dev_dbg(dev, "%s, disable silence detection\n", __func__);
+
+		for (i = 0; i < 200; i++) {
+			regmap_read(rt1320->regmap, RT1320_POWER_STATE, &reg_c560);
+			if (reg_c560 == RT1320_K_R0_STATE)
+				break;
+			usleep_range(10000, 15000);
+		}
+		dev_dbg(dev, "%s, RT1320_POWER_STATE=0x%x, i=%d\n", __func__,
+			reg_c560, i);
+	}
+
 	/* fine tune pilot tone output */
 	ret = rt1320_pilot_tone_output(rt1320);
 	if (ret < 0) {
@@ -1667,18 +1740,23 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
 		goto _finish_;
 	}
 
-	if (rt1320->dev_id == RT1321_DEV_ID) {
-		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x00);
-		regmap_write(rt1320->regmap, 0xc5c4, 0x12);
-	}
+	if (is_va2) {
+		/* RsRatio should restore into DSP FW when FW was ready */
+		rt1320_invrs_load(rt1320);
+	} else {
+		if (rt1320->dev_id == RT1321_DEV_ID) {
+			regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x00);
+			regmap_write(rt1320->regmap, 0xc5c4, 0x12);
+		}
 
-	regmap_write(rt1320->regmap, 0xc5fb, 0x00);
-	regmap_write(rt1320->regmap, 0xc570, 0x0b);
-	regmap_write(rt1320->regmap, 0xcd00, 0xc5);
+		regmap_write(rt1320->regmap, 0xc5fb, 0x00);
+		regmap_write(rt1320->regmap, 0xc570, 0x0b);
+		regmap_write(rt1320->regmap, 0xcd00, 0xc5);
 
-	/* disable silence detection */
-	regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0x00);
-	dev_dbg(dev, "%s, disable silence detection\n", __func__);
+		/* disable silence detection */
+		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0x00);
+		dev_dbg(dev, "%s, disable silence detection\n", __func__);
+	}
 
 	ret = rt1320_check_power_state_ready(rt1320, RT1320_K_R0_STATE);
 	if (ret < 0) {
@@ -1735,6 +1813,10 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
 
 	if (rt1320->dev_id == RT1321_DEV_ID) {
 		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
+		if (is_va2) {
+			regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);
+			regmap_write(rt1320->regmap, 0xc570, reg_c570);
+		}
 		regmap_write(rt1320->regmap, 0xc5c4, 0x10);
 	}
 
@@ -1766,8 +1848,8 @@ static int rt1320_r0_cali_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
 		return ret;
 
 	rt1320->cali_done = false;
@@ -1778,6 +1860,9 @@ static int rt1320_r0_cali_put(struct snd_kcontrol *kcontrol,
 	}
 	snd_soc_dapm_mutex_unlock(dapm);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -1804,10 +1889,8 @@ static void rt1320_load_mcu_patch(struct rt1320_sdw_priv *rt1320)
 		max_addr = 0x10007fff;
 		break;
 	case RT1321_DEV_ID:
-		if (rt1320->version_id == RT1321_VA2)
-			return;
-
-		filename = RT1321_VA_MCU_PATCH;
+		filename = (rt1320->version_id != RT1321_VA2) ? RT1321_VA_MCU_PATCH :
+			RT1321_VA2_MCU_PATCH;
 		min_addr = 0x10008000;
 		max_addr = 0x10008fff;
 		break;
@@ -2088,6 +2171,7 @@ static int rt1320_rae_load(struct rt1320_sdw_priv *rt1320)
 		regmap_update_bits(rt1320->regmap, 0x2000301c, 0x01, 0x01);
 		/* Phase sync enable */
 		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
+		regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);
 		break;
 	}
 
@@ -2102,6 +2186,38 @@ static int rt1320_rae_load(struct rt1320_sdw_priv *rt1320)
 	return ret;
 }
 
+static void rt1320_companion_mode_patch(struct rt1320_sdw_priv *rt1320,
+	bool patch_ver)
+{
+	struct device *dev = &rt1320->sdw_slave->dev;
+	bool comp_mode_en = false;
+	unsigned int val;
+
+	if (patch_ver) {
+		regmap_read(rt1320->regmap, 0x3fc2dfc3, &val);
+		val &= 0x80;
+		comp_mode_en = (val == 0x80) ? true : false;
+		dev_dbg(dev, "%s: val:%x, comp_mode_en:%s\n", __func__,
+			val, comp_mode_en ? "True" : "False");
+
+		if (comp_mode_en) {
+			regmap_write(rt1320->regmap, 0xd472, 0xfd);
+			regmap_write(rt1320->regmap, 0x3FC2DFC3, 0x80);
+			regmap_write(rt1320->regmap, 0x3FC2DFC0, 0x0b);
+			regmap_write(rt1320->regmap, 0x3FC2DFCe, 0x54);
+			regmap_write(rt1320->regmap, 0x3FC2DFCf, 0x05);
+			regmap_write(rt1320->regmap, 0xc04c, 0x54);
+			regmap_write(rt1320->regmap, 0xc068, 0x35);
+		} else {
+			regmap_write(rt1320->regmap, 0xC5D0, 0x0f);
+			regmap_write(rt1320->regmap, 0x3FC2DFC0, 0x0b);
+			regmap_update_bits(rt1320->regmap, 0x3fc2dfc3, 0x80, 0x00);
+			regmap_write(rt1320->regmap, 0xc04c, 0xe2);
+			regmap_write(rt1320->regmap, 0xc068, 0x35);
+		}
+	}
+}
+
 static void rt1320_dspfw_load_code(struct rt1320_sdw_priv *rt1320)
 {
 struct rt1320_imageinfo {
@@ -2120,10 +2236,12 @@ struct rt1320_dspfwheader {
 	unsigned int val, i, fw_offset;
 	struct rt1320_dspfwheader *fwheader;
 	struct rt1320_imageinfo *ptr_img;
-	struct sdw_bpt_section sec[10];
+	struct sdw_bpt_section sec[16];
 	const struct firmware *fw __free(firmware) = NULL;
 	unsigned char *fw_data;
 	bool dev_fw_match = false;
+	bool is_va2 = rt1320->dev_id == RT1321_DEV_ID &&
+		rt1320->version_id == RT1321_VA2;
 	static const char hdr_sig[] = "AFX";
 	unsigned int hdr_size = 0;
 	const char *dmi_vendor, *dmi_product, *dmi_sku;
@@ -2197,6 +2315,17 @@ struct rt1320_dspfwheader {
 			else
 				hdr_size = 0;
 
+			if (hdr_size && ptr_img->addr == 0x3fc2a300) {
+				dev_dbg(dev, "%s, AFX1 hdr[0x20]=0x%08x (%*ph)\n", __func__,
+					get_unaligned_le32(fw_data + 0x20), 4, fw_data + 0x20);
+
+				rt1320->l_adv_gain = fw_data[0x20] | (fw_data[0x21] << 8);
+				rt1320->r_adv_gain = fw_data[0x22] | (fw_data[0x23] << 8);
+
+				dev_dbg(dev, "%s, l_adv_gain=0x%04x, r_adv_gain=0x%04x\n", __func__,
+					rt1320->l_adv_gain, rt1320->r_adv_gain);
+			}
+
 			sec[i].addr = ptr_img->addr;
 			sec[i].len = ptr_img->size - hdr_size;
 			sec[i].buf = fw_data + hdr_size;
@@ -2288,7 +2417,7 @@ struct rt1320_dspfwheader {
 		regmap_write(rt1320->regmap, 0x3fc2dfc8, 0x00);
 		/* enable handshake */
 		regmap_write(rt1320->regmap, 0x3fc2dfc4, 0x00);
-		regmap_write(rt1320->regmap, 0xd470, 0xad);
+		regmap_write(rt1320->regmap, 0xd470, 0x8d);
 		/* minimum phase settings */
 		regmap_write(rt1320->regmap, 0xc5c4, 0x10);
 		regmap_write(rt1320->regmap, 0x20003003, 0x31);
@@ -2298,12 +2427,16 @@ struct rt1320_dspfwheader {
 		break;
 	}
 
+	/* compaion mode patch */
+	rt1320_companion_mode_patch(rt1320, is_va2);
+
 	/* enable DSP FW */
 	regmap_write(rt1320->regmap, 0xc081, 0xfc);
 	regmap_update_bits(rt1320->regmap, 0xf01e, 0x1, 0x0);
 
 	/* RsRatio should restore into DSP FW when FW was ready */
-	rt1320_invrs_load(rt1320);
+	if (!is_va2)
+		rt1320_invrs_load(rt1320);
 
 	/* DSP clock switches to PLL */
 	regmap_write(rt1320->regmap, 0xc081, 0xfc);
@@ -2590,6 +2723,12 @@ static int rt1320_pde23_event(struct snd_soc_dapm_widget *w,
 	unsigned char ps0 = 0x0, ps3 = 0x3;
 
 	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (rt1320->dev_id == RT1321_DEV_ID && rt1320->version_id == RT1321_VA2) {
+			regmap_write(rt1320->regmap, 0xc04c, 0xe2);
+			regmap_write(rt1320->regmap, 0xc068, 0x35);
+		}
+		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_write(rt1320->regmap,
 			SDW_SDCA_CTL(FUNC_NUM_AMP, RT1320_SDCA_ENT_PDE23,
@@ -2962,7 +3101,7 @@ static int rt1320_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 		ucontrol->value.integer.value[1] == 0)
 		return -EINVAL;
 
-	ret = pm_runtime_resume(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0 && ret != -EACCES)
 		return ret;
 
@@ -2975,6 +3114,9 @@ static int rt1320_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 	}
 	snd_soc_dapm_mutex_unlock(dapm);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -3054,8 +3196,8 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
 		return ret;
 
 	if (snd_soc_dapm_get_bias_level(dapm) == SND_SOC_BIAS_OFF &&
@@ -3065,6 +3207,9 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
 	if (!ucontrol->value.integer.value[0])
 		rt1320->rae_update_done = false;
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -3078,7 +3223,7 @@ static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0 && ret != -EACCES)
 		return ret;
 
@@ -3092,6 +3237,8 @@ static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
 	else
 		regmap_write(rt1320->regmap, 0xdb03, 0xf0);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
 
 	return changed;
 }
@@ -3129,7 +3276,7 @@ static int rt1320_r0_temperature_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0 && ret != -EACCES)
 		return ret;
 
@@ -3139,6 +3286,9 @@ static int rt1320_r0_temperature_put(struct snd_kcontrol *kcontrol,
 		rt1320_t0_load(rt1320, ucontrol->value.integer.value[0], ucontrol->value.integer.value[1]);
 	snd_soc_dapm_mutex_unlock(dapm);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -3189,7 +3339,7 @@ static const struct snd_soc_dapm_widget rt1320_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("FU21", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("PDE 23", SND_SOC_NOPM, 0, 0,
 		rt1320_pde23_event,
-		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_SUPPLY("PDE 11", SND_SOC_NOPM, 0, 0,
 		rt1320_pde11_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_ADC("FU 113", NULL, SND_SOC_NOPM, 0, 0),
diff --git a/sound/soc/codecs/rt1320-sdw.h b/sound/soc/codecs/rt1320-sdw.h
index df9ccdf92d36..46a1604c75ed 100644
--- a/sound/soc/codecs/rt1320-sdw.h
+++ b/sound/soc/codecs/rt1320-sdw.h
@@ -12,6 +12,7 @@
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include <linux/soundwire/sdw_registers.h>
+#include <linux/unaligned.h>
 #include <sound/soc.h>
 #include "../../../drivers/soundwire/bus.h"
 
@@ -84,6 +85,11 @@
 #define RT1320_SDCA_RATE_96000HZ		0x0b
 #define RT1320_SDCA_RATE_192000HZ		0x0d
 
+/* DSP FW info */
+#define RT1320_AFX_HDR_SIZE			64
+#define RT1320_AFX_HDR_INFO_OFFSET		0x20
+#define RT1321_AFX1_ADDR			0x3fc2a300
+
 enum {
 	RT1320_AIF1,
 	RT1320_AIF2,
@@ -109,6 +115,7 @@ enum rt1321_version_id {
 #define RT1320_VAB_MCU_PATCH "realtek/rt1320/rt1320-patch-code-vab.bin"
 #define RT1320_VC_MCU_PATCH "realtek/rt1320/rt1320-patch-code-vc.bin"
 #define RT1321_VA_MCU_PATCH "realtek/rt1320/rt1321-patch-code-va.bin"
+#define RT1321_VA2_MCU_PATCH "realtek/rt1320/rt1321-patch-code-va2.bin"
 
 #define RT1320_FW_PARAM_ADDR 0x3fc2ab80
 #define RT1320_CMD_ID 0x3fc2ab81
@@ -207,6 +214,7 @@ struct rt1320_sdw_priv {
 	bool rae_update_done;
 	struct work_struct load_dspfw_work;
 	struct sdw_bpt_msg bra_msg;
+	unsigned short l_adv_gain, r_adv_gain;
 };
 
 #endif /* __RT1320_SDW_H__ */
-- 
2.55.0

