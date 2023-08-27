Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7770CC83F10
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Aug 2023 10:22:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8900DDEC;
	Sun, 27 Aug 2023 12:22:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8900DDEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693131775;
	bh=rPQmfAZiR4tYlbSVxAVEZSXstTwAnk0aLa4s4FCZqLk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=PrU32mcyFTCqhrwHfTF6PsQhuJh+DrGio2SRZcXeHM9KtsF3S8sLXVEFyj1iiqMCC
	 RwRhGSCXksw1/UGazEe0AhrJt6nAylXndHQiKS8ytrm4JoONJnubqMcKhWJj8leDt1
	 OdyO0Ax2KrVsK9guSjlp5K44HCcr7+3jBxYL2pgM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C5C8F800D1; Sun, 27 Aug 2023 12:21:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BF7FBF80158;
	Sun, 27 Aug 2023 12:21:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AC4E0F80158; Sun, 27 Aug 2023 12:21:31 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C2DFF800D1
	for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2023 12:21:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C2DFF800D1
X-IronPort-AV: E=Sophos;i="6.02,205,1688396400";
   d="scan'208";a="177797768"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Aug 2023 19:21:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.26])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 374124048F23;
	Sun, 27 Aug 2023 19:21:15 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] ASoC: wm8580: Simplify probe()
Date: Sun, 27 Aug 2023 11:21:14 +0100
Message-Id: <20230827102114.55863-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: N7S2BC3HVRJRUJZ7KSWVIAIB7DKCA6HZ
X-Message-ID-Hash: N7S2BC3HVRJRUJZ7KSWVIAIB7DKCA6HZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N7S2BC3HVRJRUJZ7KSWVIAIB7DKCA6HZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Simplify probe() by replacing of_match_device->i2c_get_match_data() and
extend matching support for ID table.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Note:
 This patch is only compile tested.
---
 sound/soc/codecs/wm8580.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 6d22f7d40ec2..6bddeecfd665 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -988,16 +988,8 @@ static const struct wm8580_driver_data wm8581_data = {
 	.num_dacs = 4,
 };
 
-static const struct of_device_id wm8580_of_match[] = {
-	{ .compatible = "wlf,wm8580", .data = &wm8580_data },
-	{ .compatible = "wlf,wm8581", .data = &wm8581_data },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, wm8580_of_match);
-
 static int wm8580_i2c_probe(struct i2c_client *i2c)
 {
-	const struct of_device_id *of_id;
 	struct wm8580_priv *wm8580;
 	int ret, i;
 
@@ -1022,14 +1014,9 @@ static int wm8580_i2c_probe(struct i2c_client *i2c)
 
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
+		return dev_err_probe(&i2c->dev, -ENODEV, "failed to find driver data\n");
 
 	ret = devm_snd_soc_register_component(&i2c->dev,
 			&soc_component_dev_wm8580, wm8580_dai, ARRAY_SIZE(wm8580_dai));
@@ -1037,6 +1024,13 @@ static int wm8580_i2c_probe(struct i2c_client *i2c)
 	return ret;
 }
 
+static const struct of_device_id wm8580_of_match[] = {
+	{ .compatible = "wlf,wm8580", .data = &wm8580_data },
+	{ .compatible = "wlf,wm8581", .data = &wm8581_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, wm8580_of_match);
+
 static const struct i2c_device_id wm8580_i2c_id[] = {
 	{ "wm8580", (kernel_ulong_t)&wm8580_data },
 	{ "wm8581", (kernel_ulong_t)&wm8581_data },
-- 
2.25.1

