Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC17606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=qyTFKgNj;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=TGzsIiWq
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACC68601E2;
	Mon,  9 Nov 2026 09:59:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACC68601E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794214789;
	bh=K3a1PxwCD3y3g5xMmKXFgFdJNzE0saLrvj4HETfE2wg=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qyTFKgNjKu9M1x9OLtkRMg2/7CcKK22vDfZY2Jpf0+WF/U4YwGi8+YKDblK1tjF14
	 XTnSH+k0Nr3s1o//HEAeMwGrB9JHRClDarDvpjbE+4HnoC+otdl3VxXOHJJPbr/RC3
	 8a/8BMDziyY+px7OWrUIMjyJXEXB5akOlRl21C1o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ECE6FF805F8; Mon,  9 Nov 2026 09:59:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 62151F805FA;
	Mon,  9 Nov 2026 09:59:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CBBEF805C7; Mon,  9 Nov 2026 09:59:08 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794214743;
	b=PvgpDKOhSkjBKo6+IaX8niETLu6WfGuVakXlFMoEq3Q2pgO68tm76DOk6MNd7B56DmVd
	 92bDbtSP5A4LTm/OQidvHBIPuGagm+JUJ9MGWUWWij8m9XTETii7VzAHQN0rj4exrVJHJ
	 /XYPZQuWKp67r4xlA3kZQMjsVWGUBqC1gxT1aDZIL4nEXMAWWZL1WdFd07QrpyBGTJFbC
	 m+mg4fdAsOQWNN9izFfMYT/qZO1xwdTKjmQY7fsX/+egmfuRvg6pxwxYio+I6N8f53mYR
	 YlIHG1UA7f4juO4NGOSiehF7tlXsa95eET8g1H1GPPv/tW8BkipahYnY1+qdFh6ihTQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794214743;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=K3a1PxwCD3y3g5xMmKXFgFdJNzE0saLrvj4HETfE2wg=;
	b=hDVIoTBckbUY/dGxbpaykc2rRvo1Au3OA6bDkCOxa44rfCHfZdq3h4zD1CWzbtRuVmWA
	 D6eaNh8/mB+dQNcvwOgswP+wE6QHC5bS/9NgDVM1VyBH2V31TrQ6xDM1YZJmdRjYJA3ms
	 CTx2uGo1YuzIq48lcN63l23okKE8pkA+z5xliZNA/01jaK9Y3cuDtYy/oPYBmG7R8kgex
	 xsp3PnbUSbaM3rGn43Y3Ka6s0ySAPH6ddkQI+spO9p2HtgI+YxgKSUncGsHCUDR9jnzIn
	 pdn3P/+MXNbP1kpyHV+OSi2e9QdsZyYI9W1HAbrKxxEGtMiM/FisJQSCHc+W+ZBOQ+w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=TGzsIiWq;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA920F805B0
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 09:59:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA920F805B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=TGzsIiWq
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A98wtbqF077330,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794214736; bh=XwQyCSpxiAwrkgHD397EblYRQhM7hyaY5QwVcrZ4Yfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TGzsIiWq6tQp6ej0Fp2HW9QrJyhZrSRo6JidPJq8zbhrhZyk0CSKhb7dLNzRTF3Ub
	 Jwg3aaBpV4Vmw41j/uOzfr4mnjVR5QTS7iD1Vy+M5M8AzEZclJ2YWdGiZTek8XgVML
	 aw67+INqS/9PCVxXJv16mW/Ys3Rca+XENIC/RvDrwP6tbenXoPLX+/8Gws07JHhkIb
	 51R8VnCbscyWDWbwYp+aq4PwICrdlQ1M8x7CI9xz3aMG9mhYxZYV06OhdEX1gYqRAP
	 xVoig9VteR0lTTTVFBLpUQIM/97lx1rb53GkMTcpUMb1XgBsKtKiaSpZX3SFC89E9I
	 0dFwLAizHfK0g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A98wtbqF077330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 16:58:55 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 16:58:56 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 16:58:55 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>
Subject: [PATCH v3] ASoC: rt1320-sdw: Update the driver to support rt1321_va2
Date: Mon, 9 Nov 2026 16:58:52 +0800
Message-ID: <20261109085852.3952421-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: AY57Q2CTAXCJH2BDDDEAAMT5MBOIJ6WH
X-Message-ID-Hash: AY57Q2CTAXCJH2BDDDEAAMT5MBOIJ6WH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AY57Q2CTAXCJH2BDDDEAAMT5MBOIJ6WH/>
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
 sound/soc/codecs/rt1320-sdw.c | 506 ++++++++++++++++++++++------------
 sound/soc/codecs/rt1320-sdw.h |  17 ++
 2 files changed, 354 insertions(+), 169 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index fa89db096651..6f41e83def7d 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -578,6 +578,48 @@ static const struct reg_sequence rt1321_va1_blind_write[] = {
 };
 
 static const struct reg_sequence rt1321_va2_blind_write[] = {
+	{ 0x0000c570, 0x0a },
+	{ 0x0000d486, 0x80 },
+	{ 0x0000c040, 0x00 },
+	{ 0x0000c041, 0x00 },
+	{ 0x0000c042, 0x00 },
+	{ 0x0000c043, 0x00 },
+	{ 0x0000c044, 0xe0 },
+	{ 0x0000c045, 0x00 },
+	{ 0x0000c046, 0x00 },
+	{ 0x0000c054, 0x53 },
+	{ 0x0000c057, 0x55 },
+	{ 0x0000c081, 0xca },
+	{ 0x0000c5c3, 0x02 },
+	{ 0x0000c5fb, 0x02 },
+	{ 0x0000c600, 0x04 },
+	{ 0x0000c601, 0x83 },
+	{ 0x0000c604, 0x30 },
+	{ 0x0000c609, 0x42 },
+	{ 0x0000ce44, 0x0c },
+	{ 0x0000ce1a, 0x88 },
+	{ 0x0000cf02, 0x00 },
+	{ 0x0000d470, 0x00 },
+	{ 0x0000d471, 0x00 },
+	{ 0x0000d487, 0x03 },
+	{ 0x0000d540, 0x00 },
+	{ 0x0000d73c, 0x00 },
+	{ 0x0000d73d, 0x00 },
+	{ 0x0000d73e, 0x00 },
+	{ 0x0000d73f, 0x00 },
+	{ 0x0000de00, 0x2f },
+	{ 0x0000de02, 0x0e },
+	{ 0x0000de03, 0x01 },
+	{ 0x0000de04, 0x00 },
+	{ 0x0000de05, 0x00 },
+	{ 0x0000c019, 0x00 },
+	{ 0x0000c01a, 0x01 },
+	{ 0x0000c01b, 0xfc },
+	{ 0x0000c500, 0x00 },
+	{ 0x0000c680, 0x80 },
+	{ 0x0000c681, 0x08 },
+	{ 0x0000c500, 0x01 },
+	{ 0x0000c003, 0x20 },
 	{ 0x0000c003, 0xf0 },
 	{ 0x0000c01b, 0xfc },
 	{ 0x0000c5c3, 0xf2 },
@@ -595,7 +637,7 @@ static const struct reg_sequence rt1321_va2_blind_write[] = {
 	{ 0x0000c5c8, 0x03 },
 	{ 0x0000c5d3, 0x08 },
 	{ 0x0000c5d2, 0x0a },
-	{ 0x0000c5d1, 0x49 },
+	{ 0x0000c5d1, 0x46 },
 	{ 0x0000c5d0, 0x0f },
 	{ 0x0000c580, 0x10 },
 	{ 0x0000c581, 0x32 },
@@ -657,19 +699,24 @@ static const struct reg_sequence rt1321_va2_blind_write[] = {
 	{ 0x0000f082, 0xff },
 	{ 0x0000f081, 0xff },
 	{ 0x0000f080, 0xff },
+	{ 0x20003000, 0x00 },
+	{ 0x20003001, 0x10 },
+	{ 0x20005800, 0x00 },
+	{ 0x20009000, 0x00 },
 	{ 0x20003003, 0x3f },
+	{ 0x20009003, 0x3f },
 	{ 0x20005818, 0x81 },
 	{ 0x20009018, 0x81 },
 	{ 0x2000301c, 0x81 },
 	{ 0x0000c003, 0xc0 },
-	{ 0x0000c047, 0x80 },
 	{ 0x0000d541, 0x80 },
 	{ 0x0000d487, 0x0b },
 	{ 0x0000d487, 0x3b },
 	{ 0x0000d486, 0xc3 },
 	{ 0x0000d470, 0x89 },
 	{ 0x0000d471, 0x3a },
-	{ 0x0000d472, 0x3d },
+	{ 0x0000d472, 0x7d },
+	{ 0x0000d473, 0x01 },
 	{ 0x0000d474, 0x11 },
 	{ 0x0000d475, 0x32 },
 	{ 0x0000d476, 0x64 },
@@ -681,101 +728,34 @@ static const struct reg_sequence rt1321_va2_blind_write[] = {
 	{ 0x10008001, 0x80 },
 	{ 0x10008002, 0x00 },
 	{ 0x10008003, 0x00 },
+	{ 0x0000d73c, 0xb7 },
+	{ 0x0000d73d, 0xd7 },
+	{ 0x0000d73e, 0x00 },
+	{ 0x0000d73f, 0x10 },
 	{ 0x1000cd56, 0x00 },
+	{ 0x0000d541, 0x40 },
 	{ 0x0000d486, 0x43 },
-	{ 0x3fc2dfc3, 0x00 },
-	{ 0x3fc2dfc2, 0x00 },
+	{ 0x3fc2dfc0, 0x0b },
 	{ 0x3fc2dfc1, 0x00 },
-	{ 0x3fc2dfc0, 0x03 },
-	{ 0x3fc2dfc7, 0x00 },
-	{ 0x3fc2dfc6, 0x00 },
-	{ 0x3fc2dfc5, 0x00 },
+	{ 0x3fc2dfc2, 0x00 },
+	{ 0x3fc2dfc3, 0x00 },
 	{ 0x3fc2dfc4, 0x01 },
-	{ 0x3fc2dfa3, 0x00 },
-	{ 0x3fc2dfa2, 0x00 },
-	{ 0x3fc2dfa1, 0x00 },
+	{ 0x3fc2dfc5, 0x00 },
+	{ 0x3fc2dfc6, 0x00 },
+	{ 0x3fc2dfc7, 0x00 },
+	{ 0x3fc2dfcc, 0x00 },
+	{ 0x3fc2dfcd, 0x00 },
+	{ 0x3fc2dfce, 0x54 },
+	{ 0x3fc2dfcf, 0x05 },
 	{ 0x3fc2dfa0, 0x00 },
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
+	{ 0x3fc2dfa1, 0x00 },
+	{ 0x3fc2dfa2, 0x00 },
+	{ 0x3fc2dfa3, 0x00 },
+	{ 0x3fc2dfd0, 0x00 },
+	{ 0x3fc2dfd1, 0x00 },
+	{ 0x3fc2dfd2, 0x00 },
+	{ 0x3fc2dfd3, 0x00 },
+	{ 0x1000db00, 0x07 },
 	{ 0x1000db01, 0x00 },
 	{ 0x1000db02, 0x10 },
 	{ 0x1000db03, 0x00 },
@@ -796,14 +776,48 @@ static const struct reg_sequence rt1321_va2_blind_write[] = {
 	{ 0x1000db12, 0x00 },
 	{ 0x1000db13, 0x00 },
 	{ 0x1000db14, 0x09 },
+	{ 0x1000db15, 0x00 },
+	{ 0x1000db16, 0x0f },
+	{ 0x1000db17, 0x00 },
+	{ 0x1000db18, 0x00 },
+	{ 0x1000db19, 0x80 },
+	{ 0x1000db1a, 0x21 },
+	{ 0x1000db1b, 0xfa },
+	{ 0x1000db1c, 0x00 },
+	{ 0x1000db1d, 0x00 },
+	{ 0x1000db1e, 0x06 },
+	{ 0x1000db1f, 0x23 },
+	{ 0x1000db20, 0xfa },
+	{ 0x1000db21, 0x00 },
+	{ 0x1000db22, 0x00 },
+	{ 0x1000db23, 0x0e },
 	{ 0x0000d540, 0x21 },
+	{ 0x0000c570, 0x08 },
 	{ 0x0000d714, 0x17 },
-	{ 0x0000dd0b, 0x0d },
-	{ 0x0000dd0a, 0xff },
-	{ 0x0000dd09, 0x0d },
+	{ 0x0000c5fb, 0x52 },
+	{ 0x0000c5c3, 0xf2 },
+	{ 0x0000c5c8, 0x03 },
 	{ 0x0000dd08, 0xff },
-	{ 0x0000c5fb, 0x12 },
+	{ 0x0000dd09, 0x0d },
+	{ 0x0000dd0a, 0xff },
+	{ 0x0000dd0b, 0x0d },
 	{ 0x0000c570, 0x08 },
+	{ 0x0000d471, 0x3b },
+	{ 0x0000db00, 0x00 },
+	{ 0x0000db01, 0x00 },
+	{ 0x0000db02, 0x73 },
+	{ 0x0000db03, 0x00 },
+	{ 0x0000db04, 0x00 },
+	{ 0x0000db05, 0x00 },
+	{ 0x0000db06, 0x00 },
+	{ 0x0000db07, 0x00 },
+	{ 0x0000db08, 0x7f },
+	{ 0x0000db09, 0x00 },
+	{ 0x0000db1a, 0x00 },
+	{ 0x0000db1b, 0x00 },
+	{ 0x0000db19, 0x00 },
+	{ 0x0000c04c, 0xe2 },
+	{ 0x0000c068, 0x35 },
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
@@ -1270,7 +1284,9 @@ static void rt1320_pr_read(struct rt1320_sdw_priv *rt1320, unsigned int reg, uns
 static int rt1320_check_fw_ready(struct rt1320_sdw_priv *rt1320)
 {
 	struct device *dev = &rt1320->sdw_slave->dev;
-	unsigned int tmp, retry = 0;
+	bool is_va2 = rt1320->dev_id == RT1321_DEV_ID &&
+		rt1320->version_id == RT1321_VA2;
+	unsigned int tmp, retry = 0, i;
 	unsigned int cmd_addr;
 
 	switch (rt1320->dev_id) {
@@ -1289,8 +1305,16 @@ static int rt1320_check_fw_ready(struct rt1320_sdw_priv *rt1320)
 	/* check the value of cmd_addr becomes to zero */
 	while (retry < 500) {
 		regmap_read(rt1320->regmap, cmd_addr, &tmp);
-		if (tmp == 0)
+		if (tmp == RT1320_FW_READY)
 			break;
+
+		if (is_va2 && tmp > RT1320_GET_POOLSIZE) {
+			dev_warn(dev, "%s: invalid cmd id 0x%x, clear the command area\n",
+				 __func__, tmp);
+			for (i = 0; i < RT1320_FW_CMD_HDR_SIZE; i++)
+				regmap_write(rt1320->regmap, RT1321_FW_PARAM_ADDR + i, 0x00);
+			return 0;
+		}
 		usleep_range(1000, 1100);
 		retry++;
 	}
@@ -1338,21 +1362,24 @@ static int rt1320_dspfw_status(struct rt1320_sdw_priv *rt1320)
 	return 0;
 }
 
-static int rt1320_check_power_state_ready(struct rt1320_sdw_priv *rt1320, enum rt1320_power_state ps)
+static int rt1320_poll_power_state(struct rt1320_sdw_priv *rt1320,
+				   enum rt1320_power_state ps,
+				   unsigned int retries,
+				   unsigned int sleep_us)
 {
 	struct device *dev = &rt1320->sdw_slave->dev;
 	unsigned int retry = 0, tmp;
 
 	pm_runtime_mark_last_busy(dev);
-	while (retry < 200) {
+	while (retry < retries) {
 		regmap_read(rt1320->regmap, RT1320_POWER_STATE, &tmp);
 		dev_dbg(dev, "%s, RT1320_POWER_STATE=0x%x\n", __func__, tmp);
 		if (tmp >= ps)
 			break;
-		usleep_range(1000, 1500);
+		usleep_range(sleep_us, sleep_us + sleep_us / 2);
 		retry++;
 	}
-	if (retry == 200) {
+	if (retry == retries) {
 		dev_warn(dev, "%s FW Power State is NOT ready!", __func__);
 		return -ETIMEDOUT;
 	}
@@ -1360,6 +1387,13 @@ static int rt1320_check_power_state_ready(struct rt1320_sdw_priv *rt1320, enum r
 	return 0;
 }
 
+static int rt1320_check_power_state_ready(struct rt1320_sdw_priv *rt1320,
+					  enum rt1320_power_state ps)
+{
+	return rt1320_poll_power_state(rt1320, ps, RT1320_PS_RETRY,
+				       RT1320_PS_SLEEP_US);
+}
+
 static int rt1320_process_fw_param(struct rt1320_sdw_priv *rt1320, unsigned char *buf, unsigned int buf_size)
 {
 	struct device *dev = &rt1320->sdw_slave->dev;
@@ -1456,38 +1490,56 @@ static int rt1320_fw_param_protocol(struct rt1320_sdw_priv *rt1320, enum rt1320_
 	return ret;
 }
 
-static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
+static int rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 {
 	struct device *dev = &rt1320->sdw_slave->dev;
-	struct rt1320_datafixpoint r0_data[2];
+	struct rt1320_datafixpoint r0_data[2] = {};
+	FwPara_Get_HwSwGain hwswgain = {};
 	unsigned short l_advancegain, r_advancegain;
-	FwPara_Get_HwSwGain audDriverDataHwSwGain = {0};
-	unsigned int HwAdvGain = 0;
+	bool is_va2 = rt1320->dev_id == RT1321_DEV_ID &&
+		rt1320->version_id == RT1321_VA2;
+	unsigned int reg_c5fb = 0, reg_c570 = 0;
 	int ret;
 
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
+		regmap_read(rt1320->regmap, 0xc570, &reg_c570);
+		regmap_write(rt1320->regmap, 0xc5fb, 0x00);
+		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x00);
+		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0x00);
+
+		ret = rt1320_poll_power_state(rt1320, RT1320_K_R0_STATE,
+					      RT1320_PS_RETRY,
+					      RT1321_VA2_PS_SLEEP_US);
+		if (ret < 0)
+			goto _restore_;
+
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
 
@@ -1498,8 +1550,8 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 	r0_data[1].r0 = rt1320->r0_r_reg;
 	dev_dbg(dev, "%s, write LR r0=%d, %d\n", __func__, r0_data[0].r0, r0_data[1].r0);
 
-	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 6, &r0_data[0], sizeof(struct rt1320_datafixpoint));
-	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 7, &r0_data[1], sizeof(struct rt1320_datafixpoint));
+	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 6, &r0_data[0], sizeof(r0_data[0]));
+	rt1320_fw_param_protocol(rt1320, RT1320_SET_PARAM, 7, &r0_data[1], sizeof(r0_data[1]));
 	ret = rt1320_check_fw_ready(rt1320);
 	if (ret < 0)
 		dev_err(dev, "%s: Failed to set FW param 6,7!\n", __func__);
@@ -1511,6 +1563,18 @@ static void rt1320_set_advancemode(struct rt1320_sdw_priv *rt1320)
 		regmap_write(rt1320->regmap, 0xdd08, (r_advancegain & 0xff));
 		dev_dbg(dev, "%s, set Advance mode gain\n", __func__);
 	}
+
+_restore_:
+	if (is_va2) {
+		regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0xe0);
+		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
+		regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);
+		regmap_write(rt1320->regmap, 0xc570, reg_c570);
+		regmap_write(rt1320->regmap, 0xc5fb, reg_c5fb);
+		regmap_write(rt1320->regmap, 0xc5c4, 0x10);
+	}
+
+	return ret;
 }
 
 static int rt1320_invrs_load(struct rt1320_sdw_priv *rt1320)
@@ -1628,6 +1692,8 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
 	unsigned short l_advancegain, r_advancegain;
 	unsigned int delay_s = 7; /* delay seconds for the calibration */
 	int dspfw_status;
+	bool is_va2 = rt1320->dev_id == RT1321_DEV_ID &&
+		rt1320->version_id == RT1321_VA2;
 
 	if (!rt1320->component)
 		return;
@@ -1660,6 +1726,29 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
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
+		ret = rt1320_poll_power_state(rt1320, RT1320_K_R0_STATE,
+					      RT1320_PS_RETRY,
+					      RT1321_VA2_PS_SLEEP_US);
+		if (ret < 0) {
+			dev_dbg(dev, "%s, check class D status before k r0\n", __func__);
+			goto _finish_;
+		}
+	}
+
 	/* fine tune pilot tone output */
 	ret = rt1320_pilot_tone_output(rt1320);
 	if (ret < 0) {
@@ -1667,18 +1756,23 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
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
@@ -1715,26 +1809,27 @@ static void rt1320_calibrate(struct rt1320_sdw_priv *rt1320)
 	dev_dbg(dev, "%s, LR advanceGain=0x%x, 0x%x\n", __func__, l_advancegain, r_advancegain);
 	dev_dbg(dev, "%s, LR invrs=0x%x, 0x%x\n", __func__, audfixpoint[0].invrs, audfixpoint[1].invrs);
 
-	/* enable silence detection */
-	regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0xe0);
-	dev_dbg(dev, "%s, enable silence detection\n", __func__);
-
-	regmap_write(rt1320->regmap, 0xc5fb, reg_c5fb);
-	regmap_write(rt1320->regmap, 0xc570, reg_c570);
-	regmap_write(rt1320->regmap, 0xcd00, reg_cd00);
-
 	rt1320->r0_l_reg = l_re[4];
 	rt1320->r0_r_reg = r_re[4];
 	rt1320->cali_done = true;
 	rt1320_calc_r0(rt1320);
 
 _finish_:
+	regmap_update_bits(rt1320->regmap, 0xc044, 0xe0, 0xe0);
+	regmap_write(rt1320->regmap, 0xc5fb, reg_c5fb);
+	regmap_write(rt1320->regmap, 0xc570, reg_c570);
+	regmap_write(rt1320->regmap, 0xcd00, reg_cd00);
+
 	regmap_write(rt1320->regmap,
 		SDW_SDCA_CTL(FUNC_NUM_AMP, RT1320_SDCA_ENT_PDE23, RT1320_SDCA_CTL_REQ_POWER_STATE, 0), 0x03);
 	rt1320_pde_transition_delay(rt1320, FUNC_NUM_AMP, RT1320_SDCA_ENT_PDE23, 0x03);
 
 	if (rt1320->dev_id == RT1321_DEV_ID) {
 		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
+		if (is_va2) {
+			regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);
+			regmap_write(rt1320->regmap, 0xc570, reg_c570);
+		}
 		regmap_write(rt1320->regmap, 0xc5c4, 0x10);
 	}
 
@@ -1766,8 +1861,8 @@ static int rt1320_r0_cali_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
 		return ret;
 
 	rt1320->cali_done = false;
@@ -1778,6 +1873,9 @@ static int rt1320_r0_cali_put(struct snd_kcontrol *kcontrol,
 	}
 	snd_soc_dapm_mutex_unlock(dapm);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -1804,10 +1902,8 @@ static void rt1320_load_mcu_patch(struct rt1320_sdw_priv *rt1320)
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
@@ -2088,6 +2184,8 @@ static int rt1320_rae_load(struct rt1320_sdw_priv *rt1320)
 		regmap_update_bits(rt1320->regmap, 0x2000301c, 0x01, 0x01);
 		/* Phase sync enable */
 		regmap_update_bits(rt1320->regmap, 0xc047, 0x80, 0x80);
+		if (rt1320->version_id == RT1321_VA2)
+			regmap_update_bits(rt1320->regmap, 0xd53b, 0x40, 0x40);
 		break;
 	}
 
@@ -2102,6 +2200,40 @@ static int rt1320_rae_load(struct rt1320_sdw_priv *rt1320)
 	return ret;
 }
 
+static void rt1320_companion_mode_set(struct rt1320_sdw_priv *rt1320)
+{
+	regmap_write(rt1320->regmap, 0xc04c, rt1320->comp_mode_en ? 0x54 : 0xe2);
+	regmap_write(rt1320->regmap, 0xc068, 0x35);
+}
+
+static void rt1320_companion_mode_patch(struct rt1320_sdw_priv *rt1320,
+	bool patch_ver)
+{
+	struct device *dev = &rt1320->sdw_slave->dev;
+	unsigned int val;
+
+	if (!patch_ver)
+		return;
+
+	regmap_read(rt1320->regmap, 0x3fc2dfc3, &val);
+	rt1320->comp_mode_en = !!(val & 0x80);
+	dev_dbg(dev, "%s: val:%x, comp_mode_en:%d\n", __func__,
+		val, rt1320->comp_mode_en);
+
+	if (rt1320->comp_mode_en) {
+		regmap_write(rt1320->regmap, 0xd472, 0xfd);
+		regmap_write(rt1320->regmap, 0x3fc2dfc3, 0x80);
+		regmap_write(rt1320->regmap, 0x3fc2dfc0, 0x0b);
+		regmap_write(rt1320->regmap, 0x3fc2dfce, 0x54);
+		regmap_write(rt1320->regmap, 0x3fc2dfcf, 0x05);
+	} else {
+		regmap_write(rt1320->regmap, 0xc5d0, 0x0f);
+		regmap_write(rt1320->regmap, 0x3fc2dfc0, 0x0b);
+		regmap_update_bits(rt1320->regmap, 0x3fc2dfc3, 0x80, 0x00);
+	}
+	rt1320_companion_mode_set(rt1320);
+}
+
 static void rt1320_dspfw_load_code(struct rt1320_sdw_priv *rt1320)
 {
 struct rt1320_imageinfo {
@@ -2120,10 +2252,12 @@ struct rt1320_dspfwheader {
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
@@ -2193,10 +2327,25 @@ struct rt1320_dspfwheader {
 
 			/* The binary file has a header of 64 bytes */
 			if (memcmp(fw_data, hdr_sig, sizeof(hdr_sig)) == 0)
-				hdr_size = 64;
+				hdr_size = RT1320_AFX_HDR_SIZE;
 			else
 				hdr_size = 0;
 
+			if (hdr_size && ptr_img->addr == RT1321_AFX1_ADDR) {
+				dev_dbg(dev, "%s, AFX1 hdr[0x%x]=0x%08x (%*ph)\n", __func__,
+					RT1320_AFX_HDR_INFO_OFFSET,
+					get_unaligned_le32(fw_data + RT1320_AFX_HDR_INFO_OFFSET),
+					4, fw_data + RT1320_AFX_HDR_INFO_OFFSET);
+
+				rt1320->l_adv_gain = fw_data[RT1320_AFX_HDR_INFO_OFFSET] |
+					(fw_data[RT1320_AFX_HDR_INFO_OFFSET + 1] << 8);
+				rt1320->r_adv_gain = fw_data[RT1320_AFX_HDR_INFO_OFFSET + 2] |
+					(fw_data[RT1320_AFX_HDR_INFO_OFFSET + 3] << 8);
+
+				dev_dbg(dev, "%s, l_adv_gain=0x%04x, r_adv_gain=0x%04x\n", __func__,
+					rt1320->l_adv_gain, rt1320->r_adv_gain);
+			}
+
 			sec[i].addr = ptr_img->addr;
 			sec[i].len = ptr_img->size - hdr_size;
 			sec[i].buf = fw_data + hdr_size;
@@ -2288,7 +2437,7 @@ struct rt1320_dspfwheader {
 		regmap_write(rt1320->regmap, 0x3fc2dfc8, 0x00);
 		/* enable handshake */
 		regmap_write(rt1320->regmap, 0x3fc2dfc4, 0x00);
-		regmap_write(rt1320->regmap, 0xd470, 0xad);
+		regmap_write(rt1320->regmap, 0xd470, 0x8d);
 		/* minimum phase settings */
 		regmap_write(rt1320->regmap, 0xc5c4, 0x10);
 		regmap_write(rt1320->regmap, 0x20003003, 0x31);
@@ -2298,12 +2447,16 @@ struct rt1320_dspfwheader {
 		break;
 	}
 
+	/* companion mode patch */
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
@@ -2590,6 +2743,10 @@ static int rt1320_pde23_event(struct snd_soc_dapm_widget *w,
 	unsigned char ps0 = 0x0, ps3 = 0x3;
 
 	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		if (rt1320->dev_id == RT1321_DEV_ID && rt1320->version_id == RT1321_VA2)
+			rt1320_companion_mode_set(rt1320);
+		break;
 	case SND_SOC_DAPM_POST_PMU:
 		regmap_write(rt1320->regmap,
 			SDW_SDCA_CTL(FUNC_NUM_AMP, RT1320_SDCA_ENT_PDE23,
@@ -2925,7 +3082,7 @@ static int rt1320_r0_load(struct rt1320_sdw_priv *rt1320)
 		goto _timeout_;
 	}
 
-	rt1320_set_advancemode(rt1320);
+	ret = rt1320_set_advancemode(rt1320);
 
 _timeout_:
 	regmap_write(rt1320->regmap,
@@ -2962,8 +3119,8 @@ static int rt1320_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 		ucontrol->value.integer.value[1] == 0)
 		return -EINVAL;
 
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
 		return ret;
 
 	snd_soc_dapm_mutex_lock(dapm);
@@ -2975,6 +3132,9 @@ static int rt1320_r0_load_mode_put(struct snd_kcontrol *kcontrol,
 	}
 	snd_soc_dapm_mutex_unlock(dapm);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -3018,7 +3178,7 @@ static int rt1320_dspfw_load_put(struct snd_kcontrol *kcontrol,
 		return 0;
 
 	ret = pm_runtime_resume_and_get(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	if (ret < 0)
 		return ret;
 
 	if (snd_soc_dapm_get_bias_level(dapm) == SND_SOC_BIAS_OFF &&
@@ -3054,8 +3214,8 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
 		return ret;
 
 	if (snd_soc_dapm_get_bias_level(dapm) == SND_SOC_BIAS_OFF &&
@@ -3065,6 +3225,9 @@ static int rt1320_rae_update_put(struct snd_kcontrol *kcontrol,
 	if (!ucontrol->value.integer.value[0])
 		rt1320->rae_update_done = false;
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -3078,8 +3241,8 @@ static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
 		return ret;
 
 	if (rt1320->brown_out != ucontrol->value.integer.value[0]) {
@@ -3092,6 +3255,8 @@ static int rt1320_brown_out_put(struct snd_kcontrol *kcontrol,
 	else
 		regmap_write(rt1320->regmap, 0xdb03, 0xf0);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
 
 	return changed;
 }
@@ -3129,8 +3294,8 @@ static int rt1320_r0_temperature_put(struct snd_kcontrol *kcontrol,
 	if (!rt1320->hw_init)
 		return 0;
 
-	ret = pm_runtime_resume(component->dev);
-	if (ret < 0 && ret != -EACCES)
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0)
 		return ret;
 
 	snd_soc_dapm_mutex_lock(dapm);
@@ -3139,6 +3304,9 @@ static int rt1320_r0_temperature_put(struct snd_kcontrol *kcontrol,
 		rt1320_t0_load(rt1320, ucontrol->value.integer.value[0], ucontrol->value.integer.value[1]);
 	snd_soc_dapm_mutex_unlock(dapm);
 
+	pm_runtime_mark_last_busy(component->dev);
+	pm_runtime_put_autosuspend(component->dev);
+
 	return 0;
 }
 
@@ -3189,7 +3357,7 @@ static const struct snd_soc_dapm_widget rt1320_dapm_widgets[] = {
 	SND_SOC_DAPM_PGA("FU21", SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("PDE 23", SND_SOC_NOPM, 0, 0,
 		rt1320_pde23_event,
-		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_SUPPLY("PDE 11", SND_SOC_NOPM, 0, 0,
 		rt1320_pde11_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
 	SND_SOC_DAPM_ADC("FU 113", NULL, SND_SOC_NOPM, 0, 0),
diff --git a/sound/soc/codecs/rt1320-sdw.h b/sound/soc/codecs/rt1320-sdw.h
index df9ccdf92d36..99f8ba6462a4 100644
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
@@ -120,6 +127,9 @@ enum rt1321_version_id {
 #define RT1321_CMD_PARAM_ADDR 0x3fc2d310
 #define RT1321_DSPFW_STATUS_ADDR 0x3fc2dfc4
 
+/* moudleid + commandtype + reserved1 + commandlength */
+#define RT1320_FW_CMD_HDR_SIZE 8
+
 /* FW parameter id 6, 7 */
 struct rt1320_datafixpoint {
 	int silencedetect;
@@ -168,6 +178,11 @@ enum rt1320_power_state {
 	RT1320_K_R0_STATE = 0x1b,
 };
 
+/* polling of RT1320_POWER_STATE */
+#define RT1320_PS_RETRY			200
+#define RT1320_PS_SLEEP_US		1000
+#define RT1321_VA2_PS_SLEEP_US		10000
+
 enum rt1320_rw_type {
 	RT1320_BRA_WRITE = 0,
 	RT1320_BRA_READ = 1,
@@ -207,6 +222,8 @@ struct rt1320_sdw_priv {
 	bool rae_update_done;
 	struct work_struct load_dspfw_work;
 	struct sdw_bpt_msg bra_msg;
+	unsigned short l_adv_gain, r_adv_gain;
+	bool comp_mode_en;
 };
 
 #endif /* __RT1320_SDW_H__ */
-- 
2.55.0

