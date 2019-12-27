Return-Path: <SRS0=/8xD=2R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F95C2D0C6
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 17:41:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0D421D7E
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Dec 2019 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qrDD2nX6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGYbuKlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D421D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A3651714;
	Fri, 27 Dec 2019 18:41:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A3651714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577468516;
	bh=sW8gPA828F1+uv0XTT5mcZyx4QZtf/sVrcVFOPNJILo=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qrDD2nX6RQUP+s8BLnsh+iwq8p8KNGp8V0Bw5NDYCDV8YTiyzVtgjH8J9i8VBD/M+
	 wdl2nh6aXo4WWEP/Lam13CYkO3JwKXRS/QxQlzuN+lBjGffr+GgLqP9JNzH21T0z9T
	 2N4wetVhEJBkMgphsljdqp/zMSSWBcwTsp1oJBe8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73F8DF80131;
	Fri, 27 Dec 2019 18:41:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6DF28F80132; Fri, 27 Dec 2019 18:41:04 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A36A6F800CD
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2019 18:41:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A36A6F800CD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bGYbuKlc"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC30120740;
 Fri, 27 Dec 2019 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577468458;
 bh=iWH0MFW5TIsBkDItbrtJZGgrfm8ntD5+Gb/OZCOoeX8=;
 h=From:To:Cc:Subject:Date:From;
 b=bGYbuKlc1zLBFKdxCDkoz1fwXmc2MrTmVmuJC4XsccDqSvz3L+ZvXibzDC0C+THHS
 HQTJTzGKmBpv/NepUQtpqUPWm2O8NtDy9PpvE59x27lpis0X4V2bmdhTOOhZmkXhFM
 idnfzI7QiaF5vPsYsl+TZD21vtf01F0eS0uN8hfs=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Fri, 27 Dec 2019 12:37:49 -0500
Message-Id: <20191227174055.4923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Shuming Fan <shumingf@realtek.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] [PATCH AUTOSEL 5.4 001/187] ASoC: rt5682: fix i2c
	arbitration lost issue
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Shuming Fan <shumingf@realtek.com>

[ Upstream commit bc094709de0192a756c6946a7c89c543243ae609 ]

This patch modified the HW initial setting to fix i2c arbitration lost issue.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20191125091940.11953-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index c50b75ce82e0..05e883a65d7a 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -72,6 +72,7 @@ struct rt5682_priv {
 static const struct reg_sequence patch_list[] = {
 	{RT5682_HP_IMP_SENS_CTRL_19, 0x1000},
 	{RT5682_DAC_ADC_DIG_VOL1, 0xa020},
+	{RT5682_I2C_CTRL, 0x000f},
 };
 
 static const struct reg_default rt5682_reg[] = {
@@ -2481,6 +2482,7 @@ static void rt5682_calibrate(struct rt5682_priv *rt5682)
 	mutex_lock(&rt5682->calibrate_mutex);
 
 	rt5682_reset(rt5682->regmap);
+	regmap_write(rt5682->regmap, RT5682_I2C_CTRL, 0x000f);
 	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xa2af);
 	usleep_range(15000, 20000);
 	regmap_write(rt5682->regmap, RT5682_PWR_ANLG_1, 0xf2af);
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
