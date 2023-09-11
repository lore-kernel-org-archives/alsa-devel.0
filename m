Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CDFEE57DF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Sep 2023 11:18:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABF66820;
	Mon, 11 Sep 2023 13:17:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABF66820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694431087;
	bh=O0faahUdqQERokNfZ+EUmG8INIrHP3lcwn9a1BQUUMs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=ZaeqrDBfljI6K0nxRd9Ora3MAlhrd0xxZ+UgMrtYla8XJMSLOPSfN/JmGbcJXaA+z
	 kqJ8/Cesz0UczJ4jIgbWS/QrPLjJ2BG06f1kmkm4lToQ+D1bJMZbAoGBIGYZDIHlSa
	 vpZSaNDQwR6WgGmIr+qBuh05H5SijrmXM6VdNfvI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 66A33F801F5; Mon, 11 Sep 2023 13:16:49 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 112EFF800AA;
	Mon, 11 Sep 2023 13:16:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D7D7F80425; Mon, 11 Sep 2023 13:16:44 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7006AF800AA
	for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2023 13:16:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7006AF800AA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L0cVj2Wu
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id A37BECE1262;
	Mon, 11 Sep 2023 11:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC056C433C8;
	Mon, 11 Sep 2023 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694430989;
	bh=O0faahUdqQERokNfZ+EUmG8INIrHP3lcwn9a1BQUUMs=;
	h=From:To:Cc:Subject:Date:From;
	b=L0cVj2WuHg3B0CGXWNUxoqjjcW+4HTa8vGmAffD5C/SBv14TyYtmaiHFR2LJPgEWM
	 YidFmDOaYt+Q9OXh/CsuBLaUD5G/hzRtUg2s/djnySLcSQApiSITicoZxMfB51alYP
	 TNDj4QBdYh2B8QaXRmklgjVw40dgr2D1uuYqgkqwzHJAaY1RzTHAMHh7YKSevIoI4+
	 pYXVgMMJbydnMb75aWwpkdxuwRcJ9Q40GcjPDaRoNzr0EQfZFJnCAFdzpfkKTGiOE9
	 6V09P1HI9YK25UcHxQ1OyQM5HSIhajT+pxtML0Pz4/ll5SEPP8r87HknPg18/YfbG4
	 4qq2U1QXku48g==
From: Arnd Bergmann <arnd@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: cs42l43: use modern PM macro helpers
Date: Mon, 11 Sep 2023 13:16:15 +0200
Message-Id: <20230911111623.705640-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: C65KSMXEYHW6AJGVPVXQOPYSEBLMMS3D
X-Message-ID-Hash: C65KSMXEYHW6AJGVPVXQOPYSEBLMMS3D
X-MailFrom: arnd@kernel.org
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C65KSMXEYHW6AJGVPVXQOPYSEBLMMS3D/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Arnd Bergmann <arnd@arndb.de>

The old SET_SYSTEM_SLEEP_PM_OPS/SET_RUNTIME_PM_OPS macros required enclosing
the function definitions in an #ifdef or marking them __maybe_unused:

drivers/mfd/cs42l43.c:1138:12: error: 'cs42l43_runtime_resume' defined but not used [-Werror=unused-function]
 1138 | static int cs42l43_runtime_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1124:12: error: 'cs42l43_runtime_suspend' defined but not used [-Werror=unused-function]
 1124 | static int cs42l43_runtime_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1106:12: error: 'cs42l43_resume' defined but not used [-Werror=unused-function]
 1106 | static int cs42l43_resume(struct device *dev)
      |            ^~~~~~~~~~~~~~
drivers/mfd/cs42l43.c:1076:12: error: 'cs42l43_suspend' defined but not used [-Werror=unused-function]
 1076 | static int cs42l43_suspend(struct device *dev)
      |            ^~~~~~~~~~~~~~~

Use the modern replacements to avoid the warnings without those annotations.

Fixes: ace6d14481386 ("mfd: cs42l43: Add support for cs42l43 core driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/cs42l43.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index 37b23e9bae823..7b6d07cbe6fc6 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
 }
 
 EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
-	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
-	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
+	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
 };
 
 MODULE_DESCRIPTION("CS42L43 Core Driver");
-- 
2.39.2

