Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59055C6FD1D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 15:23:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B9F612EC;
	Wed, 15 Mar 2023 16:22:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B9F612EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678893790;
	bh=fgDecm64+2F7WtQICliUo5o+nkIKkgB3qYvC5L8d6fk=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aZm3wdbCLMSWsTYl7ozlbsKAPBxU3i5EXWrYgPxEpkQH4K3zn9RHtP6t8jay8p4KH
	 dFgfHkH4r5T/bww21rIXHUedzlEh7JPanHPWWAs2ylopFSpZQ54lIO0MnfhfdwUd1a
	 z7iwIBUIYLqwUIqtWoG3KY4WZEXkpU96x1fNGPis=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CC97F80677;
	Wed, 15 Mar 2023 16:11:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65EC1F80655; Wed, 15 Mar 2023 16:09:10 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B65BDF805AB
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 16:08:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B65BDF805AB
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjb-0007Zi-GK; Wed, 15 Mar 2023 16:08:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSja-004KYA-Nd; Wed, 15 Mar 2023 16:08:10 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjY-0057fN-IH; Wed, 15 Mar 2023 16:08:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 055/173] ASoC: codecs: rk817_codec: Convert to platform remove
 callback returning void
Date: Wed, 15 Mar 2023 16:05:47 +0100
Message-Id: <20230315150745.67084-56-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
References: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=fgDecm64+2F7WtQICliUo5o+nkIKkgB3qYvC5L8d6fk=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkEd3RaXRkKo4UIxwCWpz1OD3QXt9EN84rUJBiJ
 Pkee03pj5uJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBHd0QAKCRDB/BR4rcrs
 CYhaB/92CnQ/vXRqMNdOkyWpMz8Hr62899WD6UBXkGn1i9+50jXwsblOexWpBCRCSUg/4Nq5fYH
 xu8hOm5GzhseHaOh+uhDqsKJZY8JGPw4/uvlTIuxCY2fDYiKE72XxZIqLxHMs+bA4TQmKwPRf3T
 F1EW9S31ydd1BVtPKfxFoOHSS0ToL1R3Yga2h4X7LkRyJ/xl1ZmvmHhOeSG0BeJfTt6+Hk5NFcW
 IS1+SW+7njFvVRs5d24ZijSo1M0ZRAMxd/BZCIJSX877TpXHOPjLTFb0/nYaaho3AceDMybC5EH
 afgUNiU7lQP68S2+cawnWPeTeVZsV0KMV0dPvk7AOsXnNflF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: CMXITKFNOU7MFZ4ZVIF6OK2GTNCN26ZJ
X-Message-ID-Hash: CMXITKFNOU7MFZ4ZVIF6OK2GTNCN26ZJ
X-MailFrom: ukl@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, kernel@pengutronix.de
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CMXITKFNOU7MFZ4ZVIF6OK2GTNCN26ZJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 sound/soc/codecs/rk817_codec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rk817_codec.c b/sound/soc/codecs/rk817_codec.c
index 2a5b274bfc0f..d4da98469f8b 100644
--- a/sound/soc/codecs/rk817_codec.c
+++ b/sound/soc/codecs/rk817_codec.c
@@ -518,13 +518,11 @@ static int rk817_platform_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int rk817_platform_remove(struct platform_device *pdev)
+static void rk817_platform_remove(struct platform_device *pdev)
 {
 	struct rk817_codec_priv *rk817 = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(rk817->mclk);
-
-	return 0;
 }
 
 static struct platform_driver rk817_codec_driver = {
@@ -532,7 +530,7 @@ static struct platform_driver rk817_codec_driver = {
 		   .name = "rk817-codec",
 		   },
 	.probe = rk817_platform_probe,
-	.remove = rk817_platform_remove,
+	.remove_new = rk817_platform_remove,
 };
 
 module_platform_driver(rk817_codec_driver);
-- 
2.39.2

