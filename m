Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC5AC4332F
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Dec 2022 20:55:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BD8D189B;
	Mon, 12 Dec 2022 21:54:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BD8D189B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670878512;
	bh=kmbH38QRa3+b5F/hqNln5EMhDm/bZDOy+G5nawnWi5s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=ohUHt9eSFy1wiKFEybFSQ+PSLP1ZgpwpFmfXN8vZdj4NjYxJ44Qp3F2LsTgK3hm3p
	 ZcgABYj6CyhVPNdqSHG6521cO8tDmWrUykSmVSb8B63CnbZh2tBa1tr2VUTyvvu3KJ
	 MGpf4KoESZ+TWuGbv7ekk8KTuTqRLKmx5uup547o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2E0EF8042F;
	Mon, 12 Dec 2022 21:54:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A943F8042F; Mon, 12 Dec 2022 21:54:21 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E6D6F800F8
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2022 21:54:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E6D6F800F8
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1p4poT-00015w-DB; Mon, 12 Dec 2022 21:54:13 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1p4poS-004649-0X; Mon, 12 Dec 2022 21:54:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1p4poR-004ahj-Oc; Mon, 12 Dec 2022 21:54:11 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 05/15] ASoC: 88pm860x: Drop empty platform remove function
Date: Mon, 12 Dec 2022 21:53:56 +0100
Message-Id: <20221212205406.3771071-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212205406.3771071-1-u.kleine-koenig@pengutronix.de>
References: <20221212205406.3771071-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=kmbH38QRa3+b5F/hqNln5EMhDm/bZDOy+G5nawnWi5s=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl5TIcNp7ouWocyQmnRubIeiGad9RkV/9BTDE/+KU
 C8eg3MqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5eUyAAKCRDB/BR4rcrsCTO5B/
 9lYyd7z/rWDzhNF45OdxZ0Vu+7wgQVc5vALApB7gj/oR2pgTVxGsBVz8HK//P9sHIcU4piA4d3kX6o
 u8BFxrBAJDIp7A8VhPcUTp/AvjzoMdUx5G4Hwz+Ci+wm2rKJX7/wbu7MW860SyEvh5Ukssz7gmXgBF
 ZFSB8p5mX9yJg0eRn8WYFCS60F6WxQQSxzHzqviPUW1YcUoI87F2VMPlM1GCh131OyP383xvchNtqr
 JFgljH0B4M4lY1uMnjSrgoQ6JDY8iU3xe3OuZZcjhbXPbHMPuGjEqnGNJZ6E3yH848I/VyPdRmvDRK
 xA8sivroqMFZrlYymM382cj0LkZi+n
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
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 Takashi Iwai <tiwai@suse.com>, kernel@pengutronix.de
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 sound/soc/codecs/88pm860x-codec.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index fc65283031cd..3574c68e0dda 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1386,17 +1386,11 @@ static int pm860x_codec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pm860x_codec_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static struct platform_driver pm860x_codec_driver = {
 	.driver	= {
 		.name	= "88pm860x-codec",
 	},
 	.probe	= pm860x_codec_probe,
-	.remove	= pm860x_codec_remove,
 };
 
 module_platform_driver(pm860x_codec_driver);
-- 
2.38.1

