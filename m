Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA7C54798
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:05:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6560786F;
	Thu,  7 Mar 2024 19:04:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6560786F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709834702;
	bh=yc3g+/Nd0Pmwxjkl5V0c/NkFhMJ9uLA4cRIf408SeNw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=FBbevI4KlpW4+42oNzFrdMJC7jq+7j77/KAK/VpnbvKNE/GcNCH2ukiLfQOfNO7LP
	 nh0aA47H1SRSaf0mqPH6jbfLlo6IluPVaTP3dcSEiZVbI8LnMhhkDFj+uBPZVH+ieI
	 YAxG8YG69LPyPsik00fKQqTD7WXhAy2O8MU4rvBQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FC6AF805AE; Thu,  7 Mar 2024 19:04:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F6ABF80563;
	Thu,  7 Mar 2024 19:04:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD093F8024E; Thu,  7 Mar 2024 19:04:26 +0100 (CET)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 16945F8014B
	for <alsa-devel@alsa-project.org>; Thu,  7 Mar 2024 19:04:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16945F8014B
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riI6D-00083p-Fl; Thu, 07 Mar 2024 19:04:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riI6C-004zVU-8k; Thu, 07 Mar 2024 19:04:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riI6C-001Sgr-0Z;
	Thu, 07 Mar 2024 19:04:08 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	kernel@pengutronix.de
Subject: [PATCH] soundwire: qcom: Convert to platform remove callback
 returning void
Date: Thu,  7 Mar 2024 19:03:59 +0100
Message-ID: <20240307180359.190008-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851;
 i=u.kleine-koenig@pengutronix.de; h=from:subject;
 bh=yc3g+/Nd0Pmwxjkl5V0c/NkFhMJ9uLA4cRIf408SeNw=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6gGPZNGepLlfgoCna5QMiHA9JERGJwnpgjMym
 Hlx2ao8oeuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeoBjwAKCRCPgPtYfRL+
 TjfjB/4zXDBVH77xtXV3ubd9f3ubktiED7cdyL+RSJsZQwDLU9+74pI5FA5WJoGsOQfvt0oNoFb
 X0q+dMB+83aaAIzA86WU90jisBQKoVbUqlFKHWXPHHpxqxBjezC5oCIwKcpVVR6cPGinU23bRQ3
 h3/+gxD9wtuG1+RtBMldZ7oNoLArZmosFc+06ZwaprkPaJucVN+NeXRxhRx8tRe24ihCs3HIzLg
 AdvMch1REn9kuP2uvDBRk+m1IgxqNN3ZpgTgDn52Oq1eI9n7uO04pqmCDvpM129gLO0NuOPC7TA
 14WYQGWpIjCX4biJyrtgjqS5zie5JzcA1SEwb56b/IZPSQr7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Message-ID-Hash: OUPQTVPDTBEQP5R2PTX5MLUT2Z5HZZQP
X-Message-ID-Hash: OUPQTVPDTBEQP5R2PTX5MLUT2Z5HZZQP
X-MailFrom: ukl@pengutronix.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OUPQTVPDTBEQP5R2PTX5MLUT2Z5HZZQP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soundwire/qcom.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 3c4d6debab1f..fb70afe64fcc 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1636,14 +1636,12 @@ static int qcom_swrm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int qcom_swrm_remove(struct platform_device *pdev)
+static void qcom_swrm_remove(struct platform_device *pdev)
 {
 	struct qcom_swrm_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
 
 	sdw_bus_master_delete(&ctrl->bus);
 	clk_disable_unprepare(ctrl->hclk);
-
-	return 0;
 }
 
 static int __maybe_unused swrm_runtime_resume(struct device *dev)
@@ -1769,7 +1767,7 @@ MODULE_DEVICE_TABLE(of, qcom_swrm_of_match);
 
 static struct platform_driver qcom_swrm_driver = {
 	.probe	= &qcom_swrm_probe,
-	.remove = &qcom_swrm_remove,
+	.remove_new = qcom_swrm_remove,
 	.driver = {
 		.name	= "qcom-soundwire",
 		.of_match_table = qcom_swrm_of_match,

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0

