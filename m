Return-Path: <SRS0=ofI3=IX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD0BC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:38:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1C561A0A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Mar 2021 11:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1C561A0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6118C16F3;
	Thu, 25 Mar 2021 12:37:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6118C16F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616672329;
	bh=hTaUs/AFJ1IfhtHqzUxdrQe0xhEMM47KW9UwRqj7Lo8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YGlW1fP/+JXElafoWQeT+N6SVFiHeaIKr2tWtvGlsuTt9wW1wRFOvQaIk6SrcvPu4
	 zBCqRpJjTc6A02YD5a0+yWk5yxklmdY3FuL1Tlvxkt0z6sAyTeTHiS6/yfrbxWs1nK
	 cIUBWNOXkdRJzScv5atDvO8pE/162M4R5HQpED5g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F92FF805B5;
	Thu, 25 Mar 2021 12:27:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0550F8059F; Thu, 25 Mar 2021 12:27:21 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AF89F80564
 for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2021 12:27:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AF89F80564
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TNJOKsFV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12B3A61A72;
 Thu, 25 Mar 2021 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616671628;
 bh=hTaUs/AFJ1IfhtHqzUxdrQe0xhEMM47KW9UwRqj7Lo8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TNJOKsFVRtOsLcb0M8VoRg4ktxG8O4JC0GYPY7ftqXcJFl4QxygFPRlSCx9OfTj3i
 XKZk2kykhvZTDQ0u9yKmx7rce+3AUi6MrA2ZFoiWAucPula5La9LMApI10s0oyXbpE
 ZjrVRNubNoDbsEMVHNkDvT1h0IKEXWk39+2Nro6OYMoy/d17kUe4UCkOg4Ek3Z5mO4
 5i/GOhAvkMnM8a8vpuAjuAQ+XNmDBGzOhvgONzgblOPo+i06lcGswLkdvklejQSfxI
 ZAmdMO8hnTB5O6kxttOE1Bsv/w3uif1flvCfzPPMuyyrjAlFBrwV2hUBBIWFo13fx2
 vQlAt3kJxtlnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/24] ASoC: cs42l42: Always wait at least 3ms
 after reset
Date: Thu, 25 Mar 2021 07:26:39 -0400
Message-Id: <20210325112651.1927828-13-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325112651.1927828-1-sashal@kernel.org>
References: <20210325112651.1927828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Lucas Tanure <tanureal@opensource.cirrus.com>
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

From: Lucas Tanure <tanureal@opensource.cirrus.com>

[ Upstream commit 19325cfea04446bc79b36bffd4978af15f46a00e ]

This delay is part of the power-up sequence defined in the datasheet.
A runtime_resume is a power-up so must also include the delay.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20210305173442.195740-6-tanureal@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l42.c | 3 ++-
 sound/soc/codecs/cs42l42.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 95930018a1a4..dcd2acb2c3ce 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1796,7 +1796,7 @@ static int cs42l42_i2c_probe(struct i2c_client *i2c_client,
 		dev_dbg(&i2c_client->dev, "Found reset GPIO\n");
 		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	}
-	mdelay(3);
+	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
 	/* Request IRQ */
 	ret = devm_request_threaded_irq(&i2c_client->dev,
@@ -1921,6 +1921,7 @@ static int cs42l42_runtime_resume(struct device *dev)
 	}
 
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
+	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
 
 	regcache_cache_only(cs42l42->regmap, false);
 	regcache_sync(cs42l42->regmap);
diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 9b017b76828a..866d7c873e3c 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -740,6 +740,7 @@
 #define CS42L42_FRAC2_VAL(val)	(((val) & 0xff0000) >> 16)
 
 #define CS42L42_NUM_SUPPLIES	5
+#define CS42L42_BOOT_TIME_US	3000
 
 static const char *const cs42l42_supply_names[CS42L42_NUM_SUPPLIES] = {
 	"VA",
-- 
2.30.1

