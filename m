Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEFEC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Mar 2022 04:23:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A69591675;
	Mon, 28 Mar 2022 06:23:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A69591675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648441431;
	bh=bR5Et1UCoK6XQGshnW1K3UVXobUDHPnxS5FZXBoScgU=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nkM2EQ0nzO7CIjBOp62Rhek1SM5qPBrL9wXnntdAW6xtYynBOWYFoOrQuCcU1Slo/
	 lhMq7YCgWg6/Hmq/x9Vw+WSdQ8STI2+MlrdnykEF+I5mVd/jzuCH6POKXxWs08Fmgh
	 p/DhBP1OqL/ifB4ErDB6R0G6newl6eMJvo4MsoS8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7155BF80271;
	Mon, 28 Mar 2022 06:22:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3994FF8026D; Mon, 28 Mar 2022 06:22:25 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B96DF800FA
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2022 06:22:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B96DF800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com
 header.b="oUOAlh60"
Received: from localhost.localdomain (unknown [123.112.67.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id F33293F1B6; 
 Mon, 28 Mar 2022 04:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1648441337;
 bh=uR8Y6Vv3BDpXBjZE/HOWoWRGrzuJ5FIMsaRgymTkKmY=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=oUOAlh6042ZOPx21KsYOcLZmSg5S0WAf9drcGSsM9FBe/1+1XeANbSoDDVZKfLIgR
 BLFbub1kesI5dv7oG3eo3T+sn0FT65gJV42+hpV754/vaE3HAENmdkHiylGx/55C2o
 tsM8vBYbe3LJ8TT86hPy3gHbSD2/z9EgwSVGKdHaJqQZtajltRQpPvQ+mO7j1755Le
 2uOzZRK7lzqTlihc9ICNHDWTyvjzUKVTdwvXsov5xuUKokzWxXpUTjHh43g8GDw5E3
 HztbhIj6KBhxCfDxY2xhbSmmu4rbF+0fpMdkWzNA/NhF0tYO4ZEvP9cTH1F33desoI
 0NQJvT1Qvoj5g==
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org,
 patches@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
 tanureal@opensource.cirrus.com
Subject: [PATCH v2 1/2] ASoC: cs35l41: Add one more variable in the debug log
Date: Mon, 28 Mar 2022 12:22:09 +0800
Message-Id: <20220328042210.37660-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

otp_map[].size is a key variable to compute the value of otp_val and
to update the bit_offset, it is helpful to debug if could put it in
the debug log.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/soc/codecs/cs35l41-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l41-lib.c b/sound/soc/codecs/cs35l41-lib.c
index e5a56bcbb223..d0a480c40231 100644
--- a/sound/soc/codecs/cs35l41-lib.c
+++ b/sound/soc/codecs/cs35l41-lib.c
@@ -822,8 +822,8 @@ int cs35l41_otp_unpack(struct device *dev, struct regmap *regmap)
 	word_offset = otp_map_match->word_offset;
 
 	for (i = 0; i < otp_map_match->num_elements; i++) {
-		dev_dbg(dev, "bitoffset= %d, word_offset=%d, bit_sum mod 32=%d\n",
-			bit_offset, word_offset, bit_sum % 32);
+		dev_dbg(dev, "bitoffset= %d, word_offset=%d, bit_sum mod 32=%d otp_map[i].size = %d\n",
+			bit_offset, word_offset, bit_sum % 32, otp_map[i].size);
 		if (bit_offset + otp_map[i].size - 1 >= 32) {
 			otp_val = (otp_mem[word_offset] &
 					GENMASK(31, bit_offset)) >> bit_offset;
-- 
2.25.1

