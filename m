Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F81C77B7E
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Jun 2023 16:06:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECC34839;
	Thu,  1 Jun 2023 18:05:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECC34839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685635571;
	bh=sxsmSWqieY7uTweaVylgA+c+zNLN194RzyxmoPVSV8I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=QfGa4sbFVxMKX8jZSIpnbBmRmptNtgK7jTVSXBejhe5t/rDpjIBq6C9U+Yv0bGdqT
	 BDVlp1eyM2O4qYsBBD53t/MU/fkrLUn3J1l6CUskIGIxTgchjiX5qAoM9NOapuhrH6
	 Ck/8Mkt703XHhKes7dKUdcrmFAcy3uPvoDGvLesk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E366F805E9; Thu,  1 Jun 2023 18:02:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E54D9F805E7;
	Thu,  1 Jun 2023 18:02:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E55A6F8055B; Tue, 30 May 2023 18:33:18 +0200 (CEST)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by alsa1.perex.cz (Postfix) with ESMTP id 5884DF8042F
	for <alsa-devel@alsa-project.org>; Tue, 30 May 2023 18:32:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5884DF8042F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=onK1rnO+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZptMN
	5b1HFyj0M+tXHUCEbylco9ZmxRdPWPDQJlP/Bs=; b=onK1rnO+EYkJtYR+wNumM
	+ZgqUdwMyzLbsmWtYCmNVG3nZ1XyztXBsVgNrPMVJhjItx3f3IPh7nrCRZK6u/pm
	aS21qfzXVZVbpUg7E/Cp6WVGJCDFFfUBjzheq4xqQN6XnAnnuWW/EsxaxfgNL8dr
	yGT2BCDwmKQE0ro+axY4hI=
Received: from lizhe.. (unknown [120.245.132.246])
	by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id
 _____wBXj0cOJXZkGoMHBA--.32862S4;
	Wed, 31 May 2023 00:32:54 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	tanureal@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org
Cc: patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] dirvers/gpio: remove redundant reset gpio suffix
Date: Wed, 31 May 2023 00:32:10 +0800
Message-Id: <20230530163210.4324-1-sensor1010@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXj0cOJXZkGoMHBA--.32862S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kGF1kWrWUCF4xXr15CFg_yoWfJFX_Ga
	yF9a1UZ34jvFs29ry5uaySyw4vvFn3Ar4Skrn2kr1DA3W5Z3Z8tanFyrnxCFs5Wa97WFy8
	XFnF9r4YyFZ7tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKfHUJUUUUU==
X-Originating-IP: [120.245.132.246]
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBlxZ-q2I0ZKQeYAAAs9
X-MailFrom: sensor1010@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 5L7QQUOSV5IDKAMX2AQ7U4DHL4ZAI7UJ
X-Message-ID-Hash: 5L7QQUOSV5IDKAMX2AQ7U4DHL4ZAI7UJ
X-Mailman-Approved-At: Thu, 01 Jun 2023 16:02:27 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5L7QQUOSV5IDKAMX2AQ7U4DHL4ZAI7UJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

no need to add the suffix "gpio" or "gpios" after "reset", as they will
be automatically added, see of_find_gpio().

Signed-off-by: Lizhe <sensor1010@163.com>
---
 sound/soc/codecs/cs35l34.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l34.c b/sound/soc/codecs/cs35l34.c
index b3f98023e6a7..cbf0f2f4f9df 100644
--- a/sound/soc/codecs/cs35l34.c
+++ b/sound/soc/codecs/cs35l34.c
@@ -1061,7 +1061,7 @@ static int cs35l34_i2c_probe(struct i2c_client *i2c_client)
 		dev_err(&i2c_client->dev, "Failed to request IRQ: %d\n", ret);
 
 	cs35l34->reset_gpio = devm_gpiod_get_optional(&i2c_client->dev,
-				"reset-gpios", GPIOD_OUT_LOW);
+				"reset", GPIOD_OUT_LOW);
 	if (IS_ERR(cs35l34->reset_gpio)) {
 		ret = PTR_ERR(cs35l34->reset_gpio);
 		goto err_regulator;
-- 
2.34.1

