Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E6BC61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 15:49:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B65BA1504;
	Wed, 15 Mar 2023 16:48:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B65BA1504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678895338;
	bh=5u2GVl8piAohwRn1rL0kfzv2Y+sIz9JntITmpaumick=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FGYC3FD+ZP08SZ/bUnkIAn/JhKmFLSth9kFz5mIiITCtpJsq8DRkKJ5ovBAxK26yM
	 FqMoqC4BYfYW4xNEW5y1K4uusCi1ukuZAy9dE97xa66VISwRwZp1evQU2+CNS48iDY
	 9PRK09QjWuwMu+Q51Yod80iQzBM3G43jnqtis6yI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98F86F896B4;
	Wed, 15 Mar 2023 16:16:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C213CF8056F; Wed, 15 Mar 2023 16:10:43 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EE0F4F8062D
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 16:08:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE0F4F8062D
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjz-0000Uq-Q3; Wed, 15 Mar 2023 16:08:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjv-004KfR-1A; Wed, 15 Mar 2023 16:08:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSju-0057lc-Bh; Wed, 15 Mar 2023 16:08:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH 152/173] ASoC: tegra: tegra210_amx: Convert to platform remove
 callback returning void
Date: Wed, 15 Mar 2023 16:07:24 +0100
Message-Id: <20230315150745.67084-153-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
References: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=5u2GVl8piAohwRn1rL0kfzv2Y+sIz9JntITmpaumick=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkEd78bGMRuXdt5uF7BigHIS3o6Iq0gguPn5XDM
 7XElpdHuG2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBHe/AAKCRDB/BR4rcrs
 CZjhB/4sADtTU7DD4lgMBqcfZ7qq6AytUW5Q++1VUp0/ShW90yjgl9uQstg6YB5coNDGAN9pH30
 tzLOX9SuwmwQveQTCPy43swqCSWFX8f2e4kVtmeotPWCE7hQOfd8QZLkamw5WJ8Q8DGS6jkZFfH
 95o+aouceerw6glVouxFBviip6zNtw+/gH2Jh/GK/F6plTedXuPl+RSsG1RIMbFANVOIR65wQd/
 UCAgtagABNikZjq52TIE2ABme+SmVDnaheaoJPip0mGLuZ3GYBsWLHi7oouAhfRJS7a2ec5+GKK
 0gRQ0iURGWPAM0c9cuMXyyl7aidR2Gzq56PAyJjxN06S0TVK
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: U7WIVFNAOGI3FAKQTHROJCJCXN6NTETZ
X-Message-ID-Hash: U7WIVFNAOGI3FAKQTHROJCJCXN6NTETZ
X-MailFrom: ukl@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
 kernel@pengutronix.de
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U7WIVFNAOGI3FAKQTHROJCJCXN6NTETZ/>
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
 sound/soc/tegra/tegra210_amx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra210_amx.c b/sound/soc/tegra/tegra210_amx.c
index d064cc67fea6..782a141b65c0 100644
--- a/sound/soc/tegra/tegra210_amx.c
+++ b/sound/soc/tegra/tegra210_amx.c
@@ -573,11 +573,9 @@ static int tegra210_amx_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int tegra210_amx_platform_remove(struct platform_device *pdev)
+static void tegra210_amx_platform_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct dev_pm_ops tegra210_amx_pm_ops = {
@@ -594,7 +592,7 @@ static struct platform_driver tegra210_amx_driver = {
 		.pm = &tegra210_amx_pm_ops,
 	},
 	.probe = tegra210_amx_platform_probe,
-	.remove = tegra210_amx_platform_remove,
+	.remove_new = tegra210_amx_platform_remove,
 };
 module_platform_driver(tegra210_amx_driver);
 
-- 
2.39.2

