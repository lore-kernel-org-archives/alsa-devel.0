Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9CCC61DD3
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:38:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39000601D0;
	Tue,  1 Sep 2026 11:38:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39000601D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788255533;
	bh=DvzPj6aNhkWMeTNrCeMVZ+XBfNBxU6Uyz+P0kXStCSI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=u/mH+hOkkyTIqb23Nh334n+zGvP/AaUiJxPPBZliqR4CarfzD+kUgXUYnG37Sec7d
	 nFokB1IBzNkgSopk+iA/LtFeZK1HbBvNuSDRyYdclaZElpYR2a6zmYdQ5lh4rnCtys
	 h0XXF35ognEAHaG/sV63Ii4YCxnuMgn02yGB5j/8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F476F805EF; Tue,  1 Sep 2026 11:38:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A00DF80601;
	Tue,  1 Sep 2026 11:38:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60DD7F804CC; Tue,  1 Sep 2026 11:38:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788255486;
	b=KrD/Qp/nT3ylZnGAcUYSnHU3EcBRNrggWAqF5EkKijwgyj6x8VVytO6OYuUjvV0pM+2d
	 zqWEHDT+W0wT6nepdj0v75ggSbm3Lh/DzTyfkioNnbsPA6KOCJKAqXcrWO6V5grREsb/f
	 L6WWQGW/EUYZnz/bIcTo4tFQaAmdsFtDm8r6mwdrkYA6MYcj/sSm4Fe/bTKKgzpqrq7Tl
	 hk6nIQQw9+z1T6RuftG6Mu+kRoTz40NyFmSEYEuqZPLuEMCOEbhjNbOSnSwl6ZYAVD3NL
	 TZWwbxb7v7A4sHrbFjvGMjJQnsySRcsR3Zra2ZVpyAWrfYeQG5FY0KSGo/xkjLJYmgw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788255486;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DvzPj6aNhkWMeTNrCeMVZ+XBfNBxU6Uyz+P0kXStCSI=;
	b=S/uU2zFTKCRj+dXkg7gXaehhOAxdPZlas5o6mw4x4U4VefQvZBrKoeYakS0Q5Ik3VmAP
	 TNXM1hp80Cebnu8XqBGQZLPXy2FR1d1lQrZCIYOkbKsUzr99uRBivJn/iO7FPUP4fQv5u
	 ZOourbX3SRqnoF5MKoHMWUjYVGXUeabb1bDMVCuOOGIZVx2FTqi8G+c88R6ocJzGiDG1U
	 xWs/6IBlFuJHSlJOpiTZ3xivdubGPU9/Aromi2paOdrDUkSoiwXlZBb1P/iusvvS7qk8l
	 ITcBLoO9R13r3VZlwHd/NqCzYxykqRl+zzEyCxd9thuHyt9kMYgShNQgaSmESu6izTA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b="Hec/V9Bn";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9CC43F80071
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 11:38:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CC43F80071
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=Hec/V9Bn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6819brD831591002,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788255473; bh=cFuEiTvbGSbGI2hR6tfQRTQoH/Pcc5RRh5Gl68dW0xM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Hec/V9BnfJZWZakoHIl1ItUhwjaudZZtyaCBVBuDP6FhAkeFn2dE9cFbCfhGcmTp+
	 VKyjNx9pioLeKA/KYVTwWqDJ9svln7ws9Nwm7W2tgDOdAR7aBVkP8H1oDBm0scSPMq
	 5ShTKhKojyxOg1z3h01lg3WhkZi8Arz1qqveV+IX++gwnh5oQi0mBZhk8hDeTy/agT
	 KqO6Gghx+r7voMrrBvmCPKuFEHIV/dKytFuDPBPTX3PsPi9d34hrEtnGc3hBNjpcxw
	 aZoxwoBWKbDcBlgxFx5wTw2hLs8XXxWCj5OHHtbMrECK42crV6srkJJiUJvDhTQjyr
	 2rLyMaXY06hAg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6819brD831591002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 1 Sep 2026 17:37:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 1 Sep 2026 17:37:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 1 Sep 2026 17:37:53 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Tue, 1 Sep 2026 17:37:53 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
	<oder_chiou@realtek.com>, <shumingf@realtek.com>, <derek.fang@realtek.com>,
	Jack Yu <jack.yu@realtek.com>
Subject: [PATCH] ASoC: rt721-sdca: Adjust latency control to fix no-sound
 issue
Date: Tue, 1 Sep 2026 17:37:51 +0800
Message-ID: <20260901093751.2962786-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: R6ZCS7CTHVK3OJXZKYT2YPBHWJZDYSIE
X-Message-ID-Hash: R6ZCS7CTHVK3OJXZKYT2YPBHWJZDYSIE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R6ZCS7CTHVK3OJXZKYT2YPBHWJZDYSIE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Jack Yu <jack.yu@realtek.com>

Adjust latency control in speaker preset to fix no-sound issue.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt721-sdca.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index 159c35d19dba..b1c3dc060c24 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -206,6 +206,7 @@ static void rt721_sdca_amp_preset(struct rt721_sdca_priv *rt721)
 	regmap_write(rt721->regmap,
 		SDW_SDCA_CTL(FUNC_NUM_AMP, RT721_SDCA_ENT_FU55,
 			RT721_SDCA_CTL_FU_MUTE, CH_02), 0x00);
+	regmap_write(rt721->regmap, 0x2f5d, 0x1);
 }
 
 static void rt721_sdca_jack_preset(struct rt721_sdca_priv *rt721)
-- 
2.54.0

