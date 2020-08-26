Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560E1C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:37:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC16D2080C
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A6OAjHq5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="of9yA3y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC16D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 468271782;
	Wed, 26 Aug 2020 18:36:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 468271782
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598459851;
	bh=eERNqPuV2Tb4YZcgNEQBp+g8TpguHYmJm+5Gq1gos44=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A6OAjHq5rTGui9/GhSKWJQxI+lCZLVeqV5R/9D0RnLjPoMv3dkpp4KZPLNExSYQyK
	 eKZPAGGY/kaAUFbN0TZyvFidRqUv5DIH0P1ZwwSqho9aY+/8CJx24MQ6dHdozFxP4E
	 iGKkh+HulWMVt1R6iys4B49lUNvKnK5DB5e4iFSU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CE7CF802E8;
	Wed, 26 Aug 2020 18:34:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9A137F802E9; Wed, 26 Aug 2020 18:34:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1F76EF802BC
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 18:34:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F76EF802BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="of9yA3y3"
Received: from localhost.localdomain (unknown [122.171.38.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BF73F2080C;
 Wed, 26 Aug 2020 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598459642;
 bh=eERNqPuV2Tb4YZcgNEQBp+g8TpguHYmJm+5Gq1gos44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=of9yA3y330u6kVdE837pcVIZLuvQytXpjQoFriOgQYaDQSeiG7lLc59QtqOuRxWDy
 cB+G4wl+rZK5OSQeefoOeH3rCpLwVLiy9VQQESX+8snMfIKGKklve9vvp7oqIy57jj
 69PZvtrIMxr63HCBpaMXu/2PWW51RwYRByFaGq00=
From: Vinod Koul <vkoul@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/5] ASoC: rt715: Fix return check for
 devm_regmap_init_sdw()
Date: Wed, 26 Aug 2020 22:03:39 +0530
Message-Id: <20200826163340.3249608-5-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826163340.3249608-1-vkoul@kernel.org>
References: <20200826163340.3249608-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Vinod Koul <vkoul@kernel.org>, Shuming Fan <shumingf@realtek.com>
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

devm_regmap_init_sdw() returns a valid pointer on success or ERR_PTR on
failure which should be checked with IS_ERR. Also use PTR_ERR for
returning error codes.

Reported-by: Takashi Iwai <tiwai@suse.de>
Fixes: d1ede0641b05 ("ASoC: rt715: add RT715 codec driver")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/rt715-sdw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index d11b23d6b240..68a36739f1b0 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -527,8 +527,8 @@ static int rt715_sdw_probe(struct sdw_slave *slave,
 
 	/* Regmap Initialization */
 	sdw_regmap = devm_regmap_init_sdw(slave, &rt715_sdw_regmap);
-	if (!sdw_regmap)
-		return -EINVAL;
+	if (IS_ERR(sdw_regmap))
+		return PTR_ERR(sdw_regmap);
 
 	regmap = devm_regmap_init(&slave->dev, NULL, &slave->dev,
 		&rt715_regmap);
-- 
2.26.2

