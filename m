Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9528BC982E1
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:29:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DA09601F9;
	Mon, 21 Sep 2026 09:29:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DA09601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789975783;
	bh=YY2H1qHj9px+R+XhuEtjJZlUBjtMfwL8k9kHhjvFwkQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TO3aAokCKpH8lflPh1T2AXQCTjjxKlih8JQkVXiQAyf9Malalrh0o25PK4AA/ZIW/
	 hVf623wCB2BxfT56q9/NJI8A8MLSY8O2tP9HT1eYOftDiWdpYBMxx0gI6zYtZ+ju8i
	 muzlMH8pdO0HBsPeKqXizjCf0VcjoqKUU7lh4iz8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D65E8F805F9; Mon, 21 Sep 2026 09:29:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D32A8F805F4;
	Mon, 21 Sep 2026 09:29:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43A9CF804F3; Mon, 21 Sep 2026 09:29:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789975741;
	b=I9dzkG+se/+TspToXW4NMbU24fVRZ7KVuZXcKkMZNbDlCljQFLbkoIMYh06fbV8W6OT+
	 lpNnSQZzRmBp1fxXqLj9jEu54TJMGLFFQcgAUVPvPbb90SyhKnJoF9gGg+LYaC7k6DccR
	 fhzM5YTGIeJt+4b9IG5n9Qg9Fo7k1MajmCbgxGSFqpzNYisbsvGCxs4YeKK6fa0JTwY00
	 FNgzvyingeRBXqlvdTfYDBJgJCQ9fpURkRK2EvuYv91x3nqwHlOG/iWE7lGz6P9GQMuRt
	 xjOrYhLnMo06qpnRNBOXuagwx2lZeNpVV278CN7zQtdTJtnwqi5inFihSSk+Dpo3ZZQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789975741;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YY2H1qHj9px+R+XhuEtjJZlUBjtMfwL8k9kHhjvFwkQ=;
	b=ZZgumVDNvzw/nJiDT06AUb3S1ChGc2nEHX3wLijS83hV8mNfVIuELjKf3f7VeOUrrp1B
	 sbcS9jTooWUwV4eNFnxs0x+sW8j0w8MwgkrBd/X0cZfgd4bg6avwKNRht2whhhoZLbkTN
	 dzTIXbqzpDL7jHrNguyeUHrtWdvNvOQr4EE07K+phc5fnXbmax3onwqIfBSXf1MTSRNo0
	 ju+ASvGMsnOM9P+i+89aqKt8gzPy1xUGJCwzzt5NpKgL0DXrgWRKIMGSAR3nDKNkL8Ucc
	 zU+sj7eS5/Lqq1hcR/cm938lFsb9YNgGuZeRMbJP2jUQa8eJ8S6ztSAgybhp661oXqQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=wSE874hy;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D0D1DF800FA
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 09:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0D1DF800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=wSE874hy
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68L7SotyE2356588,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1789975731; bh=eLhFTBhOyecvmWJ6K7QsDfa+TXXiyyitzWHJEBZyjXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=wSE874hytu7M9rqYxb8tJPBlbV2QvyO75+RpPfmYMDJ8u78TZE4rIgTKG5RRE0k2y
	 jYXUx6DaMpxORv1j7Rt6DlM/aceOElDFixEX9WfHTpky30cM9MucN7hY1xlF64kNjr
	 eZb9b0v3Puu9CzMUlA7E/vio/cvcuoecX6sh52XZeadZ6KmC2Z5DaRQPKvLtAjKo/q
	 juXpAJWzlFU0Zsg3A0fKQCG2mikJr1sTC8SS2LdC/qwvoCqihsDd+3XwlR6vOReNB+
	 m5mRjUbjmM2iQQEJSad72gp9mlkH0/QcPrx3KRNxzRrm2KB9ocj127cae1H9jVUO+J
	 GKB1lKi47dGrw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68L7SotyE2356588
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 21 Sep 2026 15:28:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 15:28:50 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Mon, 21 Sep 2026 15:28:50 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt1320: make SRAM registers readable to stop being
 cached
Date: Mon, 21 Sep 2026 15:28:47 +0800
Message-ID: <20260921072847.2929865-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: YKMG6ZC2MSILFPDZEDUYRHJPA7NUJ3A7
X-Message-ID-Hash: YKMG6ZC2MSILFPDZEDUYRHJPA7NUJ3A7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YKMG6ZC2MSILFPDZEDUYRHJPA7NUJ3A7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

rt1320_volatile_register() lists the SRAM ranges 0x10000000-0x10008fff
and 0x1000c000-0x1000dfff as volatile, so they should never be cached.
But regmap only honors the volatile flag for a readable register, and
these ranges were missing from rt1320_readable_register().
They were therefore cached at probe and
replayed over SoundWire on every runtime resume, delaying the first
PCM open after autosuspend by about a second.

Add the two ranges to rt1320_readable_register() so the volatile flag
takes effect and the SRAM is no longer cached or replayed.
The removed lines are already covered by the
 new 0x1000c000-0x1000dfff range, so no register loses readability.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1320-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index b13622e54ae0..6863c5ec9428 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -890,8 +890,8 @@ static bool rt1320_readable_register(struct device *dev, unsigned int reg)
 	case 0xf01e:
 	case 0xf717 ... 0xf719:
 	case 0xf720 ... 0xf723:
-	case 0x1000cd91 ... 0x1000cd96:
-	case RT1321_PATCH_MAIN_VER ... RT1321_PATCH_BETA_VER:
+	case 0x10000000 ... 0x10008fff:
+	case 0x1000c000 ... 0x1000dfff:
 	case 0x1000f008:
 	case 0x1000f021:
 	case 0x20003000 ... 0x2000300f:
-- 
2.54.0

