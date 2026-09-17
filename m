Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071A4C982D1
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:20:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F018601D5;
	Thu, 17 Sep 2026 15:20:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F018601D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789651216;
	bh=m7z4iYrvyRIXBOHftM0YQwiTtlslex3RouXTziZnr8U=;
	h=From:To:Cc:Subject:Date:References:List-Id:List-Archive:List-Help:
	 List-Owner:List-Post:List-Subscribe:List-Unsubscribe:From;
	b=m4r1YPjmb1jsCj9oQvLANyik3NhDBWYXiqLXpYMk+APnUHK4WdD15ubYyegiZFq62
	 ILd8HoIfpDN0ZcPewPFewfxaGi4jNuUXlOymn6vmvo61JdTDad8UqKxkjyTOwfHKaD
	 MfGP6IfbfJzg1jtfeF4ngigPfdGXbUCTnok/gOC8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A544F805F0; Thu, 17 Sep 2026 15:19:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10727F805F3;
	Thu, 17 Sep 2026 15:19:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0024F80537; Thu, 17 Sep 2026 15:19:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=124.83.188.32
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789651174;
	b=eJ4K3DhvzCCeT6oorQPWF5gR/L3rNj+em7FyfXAYKSm2kyMRRrouMIpfP1xAreaLIXVt
	 KppQXfv15OnlOgZvc8pcY7HHOCQSSxy71s4ba5IleBx2BQ6dqC69vPfA5dHB2snyb2q0I
	 yoI6/NoWb+VJXvC44EpLXrC88Nc3Rxi/fFz/dVdVLbL3lkimV/tY6Yjn2ONkGkLKbVShF
	 /5zgupoNNePz0n0IiSJSwyKMYuoEjfH+3De5nKUtmaZfsnWkxhzgyIW6EopxixHb04uJe
	 Da5dSVuRnC4hsIHjlblIFfiDnM0hNBNi8YB4TPTSqlPlJZJI2AtGcKzr141NtIpDc5g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789651174;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m7z4iYrvyRIXBOHftM0YQwiTtlslex3RouXTziZnr8U=;
	b=L59C+uW9tKZIqoNOC0zaFB/zdum3+eWAIVn+IrvZBqwyrbiL7FTd9tW87ConP0B9Wfd4
	 20+nltv/dfh9uSo/8nSxQaCe6J/tGows586geA17NjZIbZqYu2IQ4ZBtuceajl5iINcfC
	 yQY4yiKuQiGeQeXXOjtaFRlgYIrEwgITDDagswqywSbU/G4xlEhQ4MTsyZuBIqfWcf0hR
	 d33eJY9oohi1tHQbBIAHlMdc9OkYrgph+hYfgDB0EW6G3ziYUCQLVFjjcl85K/XaQlT0W
	 QeM+S8zWB6Dt08tzzwAdODON9ASBm6YKQXHKKgi3B44p6iay+XpakY4b4lfbiUu0f7g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=iw0Bwh48;
	arc=none smtp.remote-ip=124.83.188.32
Received: from omggw2010.mail.snz.yahoo.co.jp (omggw2010.mail.snz.yahoo.co.jp
 [124.83.188.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BB5EEF800BD
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 15:19:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB5EEF800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=yahoo.co.jp header.i=@yahoo.co.jp header.a=rsa-sha256
 header.s=yahoocojp-202506 header.b=iw0Bwh48
X-YMail-OSG: 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
X-Sonic-MF: seiji_adachi@yahoo.co.jp
Received: from sonicgw.mail.gze.yahoo.co.jp by
 sonicconh5105.mail.kks.ynwp.yahoo.co.jp with HTTP;
 Thu, 17 Sep 2026 13:19:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789651131;
	s=yahoocojp-202506; d=yahoo.co.jp;
	h=References:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From;
	bh=QykYE1mDUxsYwbS/JG1zjB7Q4m1yCL/Ihdi6XscmxlI=;
	b=iw0Bwh48tSZI8boTdvSsIC0kB8/Ye3jtc0oWMEJIDt4/X9XI/ZezDaIIAjU/Tluo
	FEUHi1V8w8p+i2wFmGzb1euqxh2y7fJK7Oii8Go5arkjOGWz7mi/A8fu+muRMkzthSS
	7rS8kzIYCmL46Ta7t0Srb1sc+adpFsLbQHwOLUNBS4DbPv4byvYI/gVIVaej2YAt1eP
	Au0wTAqBdJ70hPDVQWZvWmRBPwU/FfVqgvlAMJKgZA8kMwe8Dw3RRl8YY0SHoV1IUfw
	Zo3GYSuyi3XkaA/Or4bO97C1o0VuBEHMckvRELXuTUQ1a+T9aFa8pDfMFYzBbAI3K8e
	+tiAqGCBQQ==
Received: by smtphe5111.mail.kks.ynwp.yahoo.co.jp (YJ Hermes SMTP Server) with
 ESMTPA ID cba2b6234d693c145fc6c7e79b442736;
          Thu, 17 Sep 2026 22:19:20 +0900 (JST)
From: Seiji Adachi <seiji_adachi@yahoo.co.jp>
To: Vijendar.Mukunda@amd.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 Seiji Adachi <seiji_adachi@yahoo.co.jp>
Subject: [PATCH] ASoC: amd: yc: Add Lenovo ThinkPad E16 Gen 2 (21JN) to quirks
Date: Thu, 17 Sep 2026 22:18:51 +0900
Message-ID: <20260917131851.2122144-1-seiji_adachi@yahoo.co.jp>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260917131851.2122144-1-seiji_adachi.ref@yahoo.co.jp>
Message-ID-Hash: W34L2OYA7BD3QYZKSLNEG2YZQSGGNXKQ
X-Message-ID-Hash: W34L2OYA7BD3QYZKSLNEG2YZQSGGNXKQ
X-MailFrom: seiji_adachi@yahoo.co.jp
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W34L2OYA7BD3QYZKSLNEG2YZQSGGNXKQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Signed-off-by: Seiji Adachi <seiji_adachi@yahoo.co.jp>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 385fede6d..ea173bdab 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -248,6 +248,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21JN"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.47.3

