Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75D2C6FD1D
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Mar 2023 15:45:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9448214C7;
	Wed, 15 Mar 2023 16:44:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9448214C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678895135;
	bh=y/s+RRoA2IiAk/qyLVImOQ6TSqGIvVfLce0AoF6FbqQ=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nWT8un+K0bV9raJv7seRciY5joTEwU2CM4rGRDT8NF/4we3BWwu47sOfSJXtJ9uih
	 jdrJ+isNLUGqOKE2OIj0v1R5DVuh3/0wGdpkW69fKxwM6s2JP9ykQzw+vioqHzXfJt
	 m7bs/DbjCCyipS2++RIDkX7AgpVWeUucoOSbwPb0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3472F80551;
	Wed, 15 Mar 2023 16:15:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B82BEF80606; Wed, 15 Mar 2023 16:10:29 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D30CF8061B
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2023 16:08:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D30CF8061B
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSk2-0000d1-Ct; Wed, 15 Mar 2023 16:08:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjx-004KgE-Cz; Wed, 15 Mar 2023 16:08:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1pcSjw-0057mF-Hh; Wed, 15 Mar 2023 16:08:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 162/173] ASoC: ti: davinci-i2s: Convert to platform remove
 callback returning void
Date: Wed, 15 Mar 2023 16:07:34 +0100
Message-Id: <20230315150745.67084-163-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
References: <20230315150745.67084-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=y/s+RRoA2IiAk/qyLVImOQ6TSqGIvVfLce0AoF6FbqQ=;
 b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkEd8aELTIIycaswGYsemJwIzY2TVJCmiOeBpYm
 x6VAiawVTWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZBHfGgAKCRDB/BR4rcrs
 CTVoB/9adcFk9dtHDBrA7ZTOfzMQPXugAjad18hSdgxJzJSio1NLB5kSNBOFEmYJFYz78GHD2mg
 4jTHZU6Uw98WHXkCYZCuz9UOccubVIfuX5nTrbP4IJpFRwGQD0KhAmHUT8/jpXuAEhXWa05yTg7
 6WWWVDEEHwcVn88kfrk6Dt3zirhpQ6f+vPIfnj+A9AwNvx1OoXI208kg2Nc36RcfThu5f5CGik0
 UsM86EfaRRq2NutoitK+JRidweHRQAZiPuv29UEd2nmVlDjpfPSMEDWLecGnVmncxnDWl9A3mJF
 XawHK3Kk4wvfV4oUUopi1Hh1yLLy/hQziRZl11ErJiIQUIRF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: DBL6BOD4SO2K4NM57S4UKT544MYQXO5J
X-Message-ID-Hash: DBL6BOD4SO2K4NM57S4UKT544MYQXO5J
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DBL6BOD4SO2K4NM57S4UKT544MYQXO5J/>
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
 sound/soc/ti/davinci-i2s.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 3ccd0cfca008..97dd1634b6be 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -739,7 +739,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int davinci_i2s_remove(struct platform_device *pdev)
+static void davinci_i2s_remove(struct platform_device *pdev)
 {
 	struct davinci_mcbsp_dev *dev = dev_get_drvdata(&pdev->dev);
 
@@ -748,8 +748,6 @@ static int davinci_i2s_remove(struct platform_device *pdev)
 	clk_disable(dev->clk);
 	clk_put(dev->clk);
 	dev->clk = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id davinci_i2s_match[] __maybe_unused = {
@@ -760,7 +758,7 @@ MODULE_DEVICE_TABLE(of, davinci_i2s_match);
 
 static struct platform_driver davinci_mcbsp_driver = {
 	.probe		= davinci_i2s_probe,
-	.remove		= davinci_i2s_remove,
+	.remove_new	= davinci_i2s_remove,
 	.driver		= {
 		.name	= "davinci-mcbsp",
 		.of_match_table = of_match_ptr(davinci_i2s_match),
-- 
2.39.2

