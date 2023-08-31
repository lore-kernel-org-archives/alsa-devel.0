Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08A0C83F3D
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Aug 2023 20:16:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B17DD83A;
	Thu, 31 Aug 2023 22:15:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B17DD83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693512983;
	bh=mgGBp9AJozPyFlR0iA0AzRuc4wrFzZCfKvTkD+cYUgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O8carhFz4RzIwwfdI2cl9DnRtcsftqCRT+dTQ+V/4RAPP9a/ULZrRBdfHCadJ4tzO
	 cL/XsI55PWgqo6Xgbwmv2fIGf4/GyD1p9wu3uuS0YGT9f7r2LyRuIUvpW1tBMiTgty
	 KjycIZBjSaasuKU9GdOPbapeMtTSskvCJsodDCf8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 232C0F80563; Thu, 31 Aug 2023 22:14:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4836EF8055A;
	Thu, 31 Aug 2023 22:14:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1F87F8023B; Thu, 31 Aug 2023 22:14:47 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DAF1F80155
	for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2023 22:14:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DAF1F80155
X-IronPort-AV: E=Sophos;i="6.02,217,1688396400";
   d="scan'208";a="174633935"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2023 05:14:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.179])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 577D34005B44;
	Fri,  1 Sep 2023 05:14:36 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ASoC: wm8580: Simplify probe()
Date: Thu, 31 Aug 2023 21:14:28 +0100
Message-Id: <20230831201429.94554-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230831201429.94554-1-biju.das.jz@bp.renesas.com>
References: <20230831201429.94554-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YI7D4G467RNBKN3ENAQZY5ECYZNEMPNN
X-Message-ID-Hash: YI7D4G467RNBKN3ENAQZY5ECYZNEMPNN
X-MailFrom: biju.das.jz@bp.renesas.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YI7D4G467RNBKN3ENAQZY5ECYZNEMPNN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Simplify probe() by replacing of_match_device->i2c_get_match_data()
and extend matching support for ID table.

While at it, remove comma in the terminator entry and simplify probe()
by replacing dev_err()->dev_err_probe().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2->v3:
 * Added Rb tag from Andy.
 * Restored OF table postion and moved in patch#2
v1->v2:
 * Added Ack from Charles Keepax.
 * Removed comma in the terminator entry.
 * Restored original error code -EINVAL
---
 sound/soc/codecs/wm8580.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6d22f7d40ec2..826c39ec4a1e 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -997,7 +997,6 @@ MODULE_DEVICE_TABLE(of, wm8580_of_match);
 
 static int wm8580_i2c_probe(struct i2c_client *i2c)
 {
-	const struct of_device_id *of_id;
 	struct wm8580_priv *wm8580;
 	int ret, i;
 
@@ -1022,14 +1021,9 @@ static int wm8580_i2c_probe(struct i2c_client *i2c)
 
 	i2c_set_clientdata(i2c, wm8580);
 
-	of_id = of_match_device(wm8580_of_match, &i2c->dev);
-	if (of_id)
-		wm8580->drvdata = of_id->data;
-
-	if (!wm8580->drvdata) {
-		dev_err(&i2c->dev, "failed to find driver data\n");
-		return -EINVAL;
-	}
+	wm8580->drvdata = i2c_get_match_data(i2c);
+	if (!wm8580->drvdata)
+		return dev_err_probe(&i2c->dev, -EINVAL, "failed to find driver data\n");
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_wm8580, wm8580_dai, ARRAY_SIZE(wm8580_dai));
-- 
2.25.1

