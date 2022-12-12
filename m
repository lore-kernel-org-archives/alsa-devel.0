Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E0CC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Dec 2022 20:58:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2DCFD2A1D;
	Mon, 12 Dec 2022 21:57:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2DCFD2A1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670878706;
	bh=1P9Fp1T+JLANLJiYZAhttGbmhm5vgLGVF+aqQ85CKaM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=OofHIPW/AMhiaN8yaW0TNLQ1TldZf1ZS/+lcTrQWuGxtkc2illHJhXzvaSEQc7EPC
	 ClP2Ku/NaQcVJxkqA4mH5ov9lWqR5MT6ZRt7MCY7kboJmq9hEupgB1aM4ssvY8b5IL
	 Q4usMF+G2tl8d/48cA5i938PTeib8YyGWQ8CfUy0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8409EF805A8;
	Mon, 12 Dec 2022 21:54:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 864F5F80589; Mon, 12 Dec 2022 21:54:33 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA126F80587
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2022 21:54:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA126F80587
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1p4poX-0001F2-9U; Mon, 12 Dec 2022 21:54:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1p4poV-00464u-JA; Mon, 12 Dec 2022 21:54:16 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1p4poV-004aiF-6q; Mon, 12 Dec 2022 21:54:15 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 13/15] ASoC: pxa: e750_wm9705: Drop empty platform remove
 function
Date: Mon, 12 Dec 2022 21:54:04 +0100
Message-Id: <20221212205406.3771071-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212205406.3771071-1-u.kleine-koenig@pengutronix.de>
References: <20221212205406.3771071-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=1P9Fp1T+JLANLJiYZAhttGbmhm5vgLGVF+aqQ85CKaM=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl5Ti2esMWMI3IywScHKY9y3a+N/j17TrnKsARYO4
 FFx9K1iJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5eU4gAKCRDB/BR4rcrsCaaSB/
 9xi+Hue+4vIsZ8CvfwyPfKg3yDW51E0wZYgFUzWpANxYW/FkURs6kgzWSb5S6YzMcokDcJygkdgBfO
 DDrg0ecMfuAuwwGvK2TfGhUUk07qreTxLaVt3QnjWCNRbZ3mpxOMb5YNW/Gwxx+CAlvPfyBQG31WgL
 Rec9hQf95s7X5WeNEMVJnALIv2FiQf8ALCqtpXpV8iJJeT5Yt2jJ12ZJyoQjwRaqzeYIY0iB4vT/29
 9TAujYrBNVP629gP9Fetc8MXWV/ThcPrZ02c7pHZJOfgHJ2OM1mHE9aHUQG3ewi6DfviEW0g20+x0K
 mEqI+SeU2krZ1RidvQb180bQXRW0z3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 kernel@pengutronix.de, Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 sound/soc/pxa/e750_wm9705.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 7a1e0d8bfd11..60b22d4f92a7 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -124,18 +124,12 @@ static int e750_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int e750_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver e750_driver = {
 	.driver		= {
 		.name	= "e750-audio",
 		.pm     = &snd_soc_pm_ops,
 	},
 	.probe		= e750_probe,
-	.remove		= e750_remove,
 };
 
 module_platform_driver(e750_driver);
-- 
2.38.1

