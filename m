Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B94C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Nov 2022 22:50:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76E6D16CA;
	Fri, 18 Nov 2022 23:49:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76E6D16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668811817;
	bh=4vJ++rg+GYk86BelVa+XPXsjX6o2VZwgRsjH43id3nM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C6eZOvCem4prFEeTjg5DkKFhsRt8fZF4f5i8PMI9Qzi4CssCuqQQaqNU+EhKlWX+U
	 JTP0uq5IX8hQzKjBBE6R8nofULl4hg4lb1z3Dk16cBos+H93wl7hph76dhN9hcWM+1
	 E19jNsFSr5G8lTRi35/U8+ktL3V6W63qI7MmV7vo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1C9EF80568;
	Fri, 18 Nov 2022 23:48:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBC00F80568; Fri, 18 Nov 2022 23:48:38 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A474F8055A
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2022 23:48:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A474F8055A
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <ukl@pengutronix.de>)
 id 1owA9q-0005XH-RW; Fri, 18 Nov 2022 23:48:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1owA9k-0058u1-Jt; Fri, 18 Nov 2022 23:48:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <ukl@pengutronix.de>)
 id 1owA9k-0000W4-27; Fri, 18 Nov 2022 23:48:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Angel Iglesias <ang.iglesiasg@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Grant Likely <grant.likely@linaro.org>, Wolfram Sang <wsa@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Raphael-Xu <13691752556@139.com>,
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 604/606] ASoC: codecs: tas2780: Convert to i2c's .probe_new()
Date: Fri, 18 Nov 2022 23:45:38 +0100
Message-Id: <20221118224540.619276-605-uwe@kleine-koenig.org>
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
 sound/soc/codecs/tas2780.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tas2780.c b/sound/soc/codecs/tas2780.c
index afdf0c863aa1..09e7ada1bca4 100644
--- a/sound/soc/codecs/tas2780.c
+++ b/sound/soc/codecs/tas2780.c
@@ -591,8 +591,7 @@ static int tas2780_parse_dt(struct device *dev, struct tas2780_priv *tas2780)
 	return 0;
 }
 
-static int tas2780_i2c_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static int tas2780_i2c_probe(struct i2c_client *client)
 {
 	struct tas2780_priv *tas2780;
 	int result;
@@ -646,7 +645,7 @@ static struct i2c_driver tas2780_i2c_driver = {
 		.name   = "tas2780",
 		.of_match_table = of_match_ptr(tas2780_of_match),
 	},
-	.probe  = tas2780_i2c_probe,
+	.probe_new  = tas2780_i2c_probe,
 	.id_table   = tas2780_i2c_id,
 };
 module_i2c_driver(tas2780_i2c_driver);
-- 
2.38.1

