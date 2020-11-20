Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3778AC2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:27:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623DD22269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RYRdUuk0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAZ1G5N8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623DD22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5D3117CE;
	Fri, 20 Nov 2020 17:26:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5D3117CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889619;
	bh=3c6rCQg3s9pP9r49SYDWD3DSdrQ2njFVAGckFzgPq0Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYRdUuk08GmaaWKQuC+PwFu4cmRqq9R/pabS6tRe1S+/r+x95LONjv808Q66nhLox
	 h4y2Djh9KC05mzXfybjg23L7Jo7upn2+0BRqwueg35cUX3HLPP4ikaruFm9YeWhr2v
	 vn/O/PACahNU2eM2vVVPqH4eQaBHJQiIPdSIQmZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86715F8056F;
	Fri, 20 Nov 2020 17:19:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97840F80570; Fri, 20 Nov 2020 17:19:02 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 478ACF80568
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:19:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 478ACF80568
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JAZ1G5N8"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1F8B424101;
 Fri, 20 Nov 2020 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889138;
 bh=3c6rCQg3s9pP9r49SYDWD3DSdrQ2njFVAGckFzgPq0Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JAZ1G5N81Oe+yFCRXPExwNod7fyv8UdQ5BnXF/hb6vtDoy4WiKPcmabg3cvAMkX5A
 sksR0NgAKXKvXIu6JnpK4PmV6u4/CH6wk2MQMVv67+xVOugf8S1cDENgzfXlZGCoe6
 gc//ovme0YL6yVdZOS7tKiuBq4+MEQrX2FUVpDbo=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 21/38] ASoC: max98095: skip of_device_id table when !CONFIG_OF
Date: Fri, 20 Nov 2020 17:16:35 +0100
Message-Id: <20201120161653.445521-21-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
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

The driver can match by multiple methods.  Its of_device_id table is
referenced via of_match_ptr() so it will be unused for !CONFIG_OF
builds:

  sound/soc/codecs/max98095.c:2151:34: warning: ‘max98095_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/codecs/max98095.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98095.c b/sound/soc/codecs/max98095.c
index 9bdc6392382a..736cd70be725 100644
--- a/sound/soc/codecs/max98095.c
+++ b/sound/soc/codecs/max98095.c
@@ -2148,11 +2148,13 @@ static const struct i2c_device_id max98095_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max98095_i2c_id);
 
+#ifdef CONFIG_OF
 static const struct of_device_id max98095_of_match[] = {
 	{ .compatible = "maxim,max98095", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98095_of_match);
+#endif
 
 static struct i2c_driver max98095_i2c_driver = {
 	.driver = {
-- 
2.25.1

