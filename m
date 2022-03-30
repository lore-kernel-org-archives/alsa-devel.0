Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD6C4167E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Mar 2022 12:06:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7C601A9D;
	Wed, 30 Mar 2022 14:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7C601A9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1648641977;
	bh=xuMHwDoy2pnbluLgrMeqacfG3BmboDGHsHgK8ULMcZw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QatfZ9b/izUKAQ45iKGLkRfRjssnxT5f4HLztWVO+f28ekZewWVAvX0sW9Vb0D1hp
	 GB1FOHQ4rgATF5hjoJAhx/vZSpErrEKDUVRNOEN6mRMctmUpRJ3DVEQGmriCP/LT46
	 cTb3EW0j5m9Beqz3a/ePhuyAuBJJXsjk2CsS2Zfo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44F76F805B0;
	Wed, 30 Mar 2022 13:53:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C991EF805B0; Wed, 30 Mar 2022 13:53:43 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5089F8057A
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2022 13:53:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5089F8057A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hDjp4e4X"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8CB75B81C25;
 Wed, 30 Mar 2022 11:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573E0C340EE;
 Wed, 30 Mar 2022 11:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648641216;
 bh=xuMHwDoy2pnbluLgrMeqacfG3BmboDGHsHgK8ULMcZw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hDjp4e4X9m3QoPmS7iUl/pQ5FATadxoRAkB/W7nnnVKTqqlysmtT14ePZPjHh9zNF
 2RnFEaC53g/Odh2eTYbokXh7JU2uufAhWyysVexJBCVMTuK4xZZFo1hcQgXWBBEya7
 I0KKwEZxoZPe35dxVLM3HELCfzE43J8R4B2vzzgjx56CsVfFX0tv/jmAwobhJ/qnej
 lOs474bAB17fTwomILJlUiZra2uh47dytBZqKvQaHAUIiBiUoOUSfD0CrzKg/LSJW2
 PeCbJz8lqn4a8mTSxK8W1vBdyqNPE+Nak6/LVRKZ0+E6X4PKAc6NakXV6G719V03yD
 uE/061V57Ut7w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/22] ASoC: ak4642: Use
 of_device_get_match_data()
Date: Wed, 30 Mar 2022 07:53:03 -0400
Message-Id: <20220330115303.1672616-22-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330115303.1672616-1-sashal@kernel.org>
References: <20220330115303.1672616-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Zeal Robot <zealci@zte.com.cn>, tiwai@suse.com, lgirdwood@gmail.com,
 Minghao Chi <chi.minghao@zte.com.cn>, Mark Brown <broonie@kernel.org>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

[ Upstream commit 835ca59799f5c60b4b54bdc7aa785c99552f63e4 ]

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Link: https://lore.kernel.org/r/20220315023226.2118354-1-chi.minghao@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ak4613.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index c1181a20714d..f508e8bdef3b 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -642,15 +642,10 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 	struct ak4613_priv *priv;
 
 	regmap_cfg = NULL;
-	if (np) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(ak4613_of_match, dev);
-		if (of_id)
-			regmap_cfg = of_id->data;
-	} else {
+	if (np)
+		regmap_cfg = of_device_get_match_data(dev);
+	else
 		regmap_cfg = (const struct regmap_config *)id->driver_data;
-	}
 
 	if (!regmap_cfg)
 		return -EINVAL;
-- 
2.34.1

