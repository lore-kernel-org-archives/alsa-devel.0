Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998EFC61DA4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 15:50:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 934B21526;
	Wed, 15 Mar 2023 16:49:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 934B21526
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678895449;
	bh=mVXJOXDuFeTzes51+7d8MiUj7FG24ywPK9s9TnUFuFE=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qmcJ+Ka2CHqhhLtArFWAms3E6FR2pzixaDNokH3loTkzEGKiv2cFwF8wnMaTCGQ12
	 bbpt0GvGAJdKFqwPgO+PBDrWx6p8VKUQj7ZZvj5zu9+MQfAzIhAASQFxVLUF3s/aep
	 GCjtp1iJyNiBzX6s/9mQiXabW6lqvSJWEvY6pM4Y=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 94556F896EF;
	Wed, 15 Mar 2023 16:17:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B703FF8061D; Wed, 15 Mar 2023 16:10:49 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1C3C8F80621
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 16:08:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C3C8F80621
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjy-0000S4-MR; Wed, 15 Mar 2023 16:08:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSju-004KfA-AF; Wed, 15 Mar 2023 16:08:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjt-0057lK-G5; Wed, 15 Mar 2023 16:08:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 148/173] ASoC: tegra: tegra20_i2s: Convert to platform remove
 callback returning void
Date: Wed, 15 Mar 2023 16:07:20 +0100
Message-Id: <20230315150745.67084-149-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
References: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=mVXJOXDuFeTzes51+7d8MiUj7FG24ywPK9s9TnUFuFE=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkEd7wGLWDcJEc9f9QFtB88ZKPhX8oC95Q8ONrm
 6mMSQp6m5OJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBHe8AAKCRDB/BR4rcrs
 CdeMB/oCbCUkbSbsC9qZ580r3ckNyWaU1GnWiyxqNVS2smjGwDETQH9ZuaintIUCdrQ/pSi7ZnP
 erzZROF804dASfPo4qQQTDgxyDPp4kSr8YCOg8UEc8WD1qz0SlFq+ufNRy/bxAu0jEe95DJxp+7
 MUfZT5w8YkuPsxTuOHDCWAm22sxMaQJqevPiu/nvHkEW8GxNbJI87A4vTm3h1oZe5ytVBRLkPFG
 LT8klW+z5083Tne3yOAw5vuzfDqtPSaXQ8SFjK9Ozwtj0lXGD12KoPjPqRLwnVI0fJ0VwMa8FU9
 Ann9HGdCZFRcIRG+Ilz8TZS3ZBjHJlqA9S+SSXFuBvl8arjl
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: YSNGQB3PKIU6OZ24F36H5YZTUBNKZK55
X-Message-ID-Hash: YSNGQB3PKIU6OZ24F36H5YZTUBNKZK55
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YSNGQB3PKIU6OZ24F36H5YZTUBNKZK55/>
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
 sound/soc/tegra/tegra20_i2s.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/tegra/tegra20_i2s.c b/sound/soc/tegra/tegra20_i2s.c
index d37a9f2603e8..e1a0f50969c1 100644
--- a/sound/soc/tegra/tegra20_i2s.c
+++ b/sound/soc/tegra/tegra20_i2s.c
@@ -475,13 +475,11 @@ static int tegra20_i2s_platform_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra20_i2s_platform_remove(struct platform_device *pdev)
+static void tegra20_i2s_platform_remove(struct platform_device *pdev)
 {
 	tegra_pcm_platform_unregister(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id tegra20_i2s_of_match[] = {
@@ -503,7 +501,7 @@ static struct platform_driver tegra20_i2s_driver = {
 		.pm = &tegra20_i2s_pm_ops,
 	},
 	.probe = tegra20_i2s_platform_probe,
-	.remove = tegra20_i2s_platform_remove,
+	.remove_new = tegra20_i2s_platform_remove,
 };
 module_platform_driver(tegra20_i2s_driver);
 
-- 
2.39.2

