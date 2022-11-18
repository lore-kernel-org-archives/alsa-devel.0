Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C97C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Nov 2022 22:49:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D60216A5;
	Fri, 18 Nov 2022 23:48:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D60216A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668811779;
	bh=TszLQfDQqibZspZkYwbI4ynVv8NCIIwefuZQtqz5PR4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mUAuqDcDUH1DCqSBu0yNKbcsWZwPctKbO+Q8z8KOjMsxgZ5SoWr7R7S8PJYpHkNa1
	 jsYPyur8csfpFc5CgNtClEy1zmAvIrzBSyuSLXZ8TcFBPMy5xAot4jRe8Q0iPrBI1t
	 v760K92EzDs08a6Yj41XbR00usX6ZVEAUd6gFXVE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BE77EF80549;
	Fri, 18 Nov 2022 23:48:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D46FAF800FD; Fri, 18 Nov 2022 23:48:33 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11A48F800FD
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2022 23:48:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11A48F800FD
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1owA9n-0005X2-23; Fri, 18 Nov 2022 23:48:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1owA9k-0058tz-Id; Fri, 18 Nov 2022 23:48:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1owA9j-0000Vq-CG; Fri, 18 Nov 2022 23:48:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Angel Iglesias <ang.iglesiasg@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Grant Likely <grant.likely@linaro.org>, Wolfram Sang <wsa@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 =?utf-8?q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Crt Mori <cmo@melexis.com>, =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 600/606] ALSA: ppc: keywest: Convert to i2c's .probe_new()
Date: Fri, 18 Nov 2022 23:45:34 +0100
Message-Id: <20221118224540.619276-601-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118224540.619276-1-uwe@kleine-koenig.org>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-i2c@vger.kernel.org, kernel@pengutronix.de,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 sound/ppc/keywest.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
index 80e5108157ef..0c4f43963c75 100644
--- a/sound/ppc/keywest.c
+++ b/sound/ppc/keywest.c
@@ -16,8 +16,7 @@
 static struct pmac_keywest *keywest_ctx;
 static bool keywest_probed;
 
-static int keywest_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+static int keywest_probe(struct i2c_client *client)
 {
 	keywest_probed = true;
 	/* If instantiated via i2c-powermac, we still need to set the client */
@@ -91,7 +90,7 @@ static struct i2c_driver keywest_driver = {
 	.driver = {
 		.name = "PMac Keywest Audio",
 	},
-	.probe = keywest_probe,
+	.probe_new = keywest_probe,
 	.remove = keywest_remove,
 	.id_table = keywest_i2c_id,
 };
-- 
2.38.1

