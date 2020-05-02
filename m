Return-Path: <SRS0=TVyu=6S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBF4C3A5A9
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:23:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089AA206E6
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2020 10:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iy9j59Gu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wcdl4Zu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089AA206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4CEFE16E3;
	Mon,  4 May 2020 12:22:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4CEFE16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588587801;
	bh=gfo0+53nZKqY2J8lkt8Dedhyctwf66+BUftOGRVc4vA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iy9j59GuDtIHgG7P1ljxoSpKKbWZTNfSDnQcTCFe0RZoGIDY26FfqQfl/fnzdmAU6
	 1ROSa48XTX/kMxw6UG59vKOiOVOOHm+ubfPlxlJ4F0QvKwjZw3ThrX9cypexppCDAV
	 Xn01nrxNofzcx5+XpV9j/w4kDCVq0iDBl9MNQXr8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CFEEF8026F;
	Mon,  4 May 2020 12:21:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27FF5F801F7; Sat,  2 May 2020 16:26:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D5A8F80087
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2020 16:26:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D5A8F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Wcdl4Zu8"
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6E2621835;
 Sat,  2 May 2020 14:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588429609;
 bh=gfo0+53nZKqY2J8lkt8Dedhyctwf66+BUftOGRVc4vA=;
 h=From:To:Cc:Subject:Date:From;
 b=Wcdl4Zu8Xe1B1O2RTQI8v0aI66PyZSi1nmiDTcuJ8nWK7NgaEsR3LsirhAxLWoSQy
 maAx7jvV8ExDAXp+ckA1cBePnheG+U3raL0F4bRmSdLVgF9a0tAW5Vjl/VRl/On+P2
 mw00w/HGZDarPGlQ+lL1smIuYY6IceH06RZOH9G0=
From: Wolfram Sang <wsa@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: codecs: max9768: update contact email
Date: Sat,  2 May 2020 16:26:46 +0200
Message-Id: <20200502142646.19033-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 May 2020 12:21:36 +0200
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Wolfram Sang <wsa@kernel.org>,
 Mark Brown <broonie@kernel.org>, kernel@pengutronix.de
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

The 'pengutronix' address is defunct for years. Use the proper contact
address.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---
 sound/soc/codecs/max9768.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index d0737db5868a..39dda1b03b3d 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -220,6 +220,6 @@ static struct i2c_driver max9768_i2c_driver = {
 };
 module_i2c_driver(max9768_i2c_driver);
 
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("ASoC MAX9768 amplifier driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1

