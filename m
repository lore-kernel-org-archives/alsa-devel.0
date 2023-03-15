Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCD9C61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 15:16:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B50031293;
	Wed, 15 Mar 2023 16:16:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B50031293
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678893414;
	bh=ZqPcBpT6AG7fJEruwPxAEVtTcDfzHeT5Wu2jqDmeTr8=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OSTZaUxzLArGDNHs/M7sQZ/Xx6fUXR3NVIy8O2SxeRPqFkij8H7e2W9I2A58v/Lpc
	 MNR+Wj23MoNiM+m1b6pGX2NE9tSIzwEjugDRzLDBN6zCggtilei0+Wrsqu5wI/cow7
	 5h9tVzC+WEqTS3rDWZPwyFpAkYzPuNBty+aQvk+c=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FB91F805EF;
	Wed, 15 Mar 2023 16:10:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F7AFF80621; Wed, 15 Mar 2023 16:08:46 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60C06F80563
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 16:08:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60C06F80563
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjW-0007PF-1a; Wed, 15 Mar 2023 16:08:06 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjV-004KWI-BM; Wed, 15 Mar 2023 16:08:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjU-0057e4-3N; Wed, 15 Mar 2023 16:08:04 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 035/173] ASoC: au1x: i2sc: Convert to platform remove callback
 returning void
Date: Wed, 15 Mar 2023 16:05:27 +0100
Message-Id: <20230315150745.67084-36-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
References: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=ZqPcBpT6AG7fJEruwPxAEVtTcDfzHeT5Wu2jqDmeTr8=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkEd2Szl4or8lT3GOjpWSIghf2c8yBjCuGoFoj/
 YEJJkBmfW+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBHdkgAKCRDB/BR4rcrs
 CcSPB/4tze8YdHp+I10S5v3Cc18gwpTAs5S5JegXECs53b1/epn1R+5ZdYq4tYWVQ8cRFq7BtCD
 gKAUvS3JxiPd+B6r8t6ch97ZBWPwxq/LxBj+uXZqf+FnuAp9/ZKnX1ENFizCld8FzG6k9qr904M
 mItRyrRKtgyGWb50tIMlvWrFHhZCAyVSLH5jHp0ypbHd+VRkCPcyMD2EaWy+5Nnt26rPsTliH46
 97FwBKVMaZn322g87QyxzM6nEu1rdM4UejkHmiNfGu6gBmzz32Aba2SbucSEOyN3clml+YrQhrF
 /DzeQI9rVnt9WN1eai74q8p3VlfNbQRj/MhwgLkumJ4NrZQY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: W6YH2Y3WUXW3PZ3QX4MU3ALYCVX54E3D
X-Message-ID-Hash: W6YH2Y3WUXW3PZ3QX4MU3ALYCVX54E3D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W6YH2Y3WUXW3PZ3QX4MU3ALYCVX54E3D/>
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
 sound/soc/au1x/i2sc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index b15c8baa9ee4..064406080d72 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -270,15 +270,13 @@ static int au1xi2s_drvprobe(struct platform_device *pdev)
 					  &au1xi2s_dai_driver, 1);
 }
 
-static int au1xi2s_drvremove(struct platform_device *pdev)
+static void au1xi2s_drvremove(struct platform_device *pdev)
 {
 	struct au1xpsc_audio_data *ctx = platform_get_drvdata(pdev);
 
 	snd_soc_unregister_component(&pdev->dev);
 
 	WR(ctx, I2S_ENABLE, EN_D);	/* clock off, disable */
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -315,7 +313,7 @@ static struct platform_driver au1xi2s_driver = {
 		.pm	= AU1XI2SC_PMOPS,
 	},
 	.probe		= au1xi2s_drvprobe,
-	.remove		= au1xi2s_drvremove,
+	.remove_new	= au1xi2s_drvremove,
 };
 
 module_platform_driver(au1xi2s_driver);
-- 
2.39.2

