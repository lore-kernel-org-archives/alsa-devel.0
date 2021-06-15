Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC3C48BDF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:51:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C07614A7
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 15:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C07614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 809D6169E;
	Tue, 15 Jun 2021 17:50:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 809D6169E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623772289;
	bh=t09JVjnirc/tT6RKQHIthuXYKpJL3aQ83GPx+34JfW8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b13WEA4JjwQ7rZ+AveWzcsICLgbG6lApaLulj+q76zg8bmXA8UdV0+aAYaKcXyR4s
	 RkXdqJHtWLu42zq2bOEKaJaUUVxQSmxE2b8Dta8MkSmAWNo9WmwMmmF0lGoET8dagC
	 y3vueQIyzhWQ/fTkWt9TePHBRrY2QCwlmr9u1cJY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76E86F804FB;
	Tue, 15 Jun 2021 17:48:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2471F804FB; Tue, 15 Jun 2021 17:48:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4391CF804DF
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 17:48:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4391CF804DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U5qPmPGX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B047615A0;
 Tue, 15 Jun 2021 15:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623772129;
 bh=t09JVjnirc/tT6RKQHIthuXYKpJL3aQ83GPx+34JfW8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U5qPmPGXRzyyiRSNbEfm7YlxQAyxZxWcan3mVFHKRiFfzHSTgun4npsZKGeIbB4ox
 Tz00YENllnsCEmbh68Nwmfsq6G4QzVP6f0UcjAatjIEO3WADYsctSnDsCDhbFUIotT
 7wlSAmAlCOvqTNyW7Pq11RGyhPBDRK/ZsmVhEoycLCp9jvzJOw9xTWMR4qvubUibio
 bX4Z2zpdRQoHW2oM/oS4EW4mRvNtk1bPPB0VNb8r2/lmOH58ydzYp26Weg6IR8HASP
 iOHyXAbjBAThMww8y0KhMg1UEsMPyHbs9KGdfjSD9f/liBWs3U/dTsl7fGGCsFRAuY
 fN6+A6uWhweHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 20/33] ASoC: rt5682: Fix the fast discharge for
 headset unplugging in soundwire mode
Date: Tue, 15 Jun 2021 11:48:11 -0400
Message-Id: <20210615154824.62044-20-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615154824.62044-1-sashal@kernel.org>
References: <20210615154824.62044-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

From: Oder Chiou <oder_chiou@realtek.com>

[ Upstream commit 49783c6f4a4f49836b5a109ae0daf2f90b0d7713 ]

Based on ("5a15cd7fce20b1fd4aece6a0240e2b58cd6a225d"), the setting also
should be set in soundwire mode.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Link: https://lore.kernel.org/r/20210604063150.29925-1-oder_chiou@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5682-sdw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index b49f1e16125d..d1dd7f720ba4 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -462,7 +462,8 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 
 	regmap_update_bits(rt5682->regmap, RT5682_CBJ_CTRL_2,
 		RT5682_EXT_JD_SRC, RT5682_EXT_JD_SRC_MANUAL);
-	regmap_write(rt5682->regmap, RT5682_CBJ_CTRL_1, 0xd042);
+	regmap_write(rt5682->regmap, RT5682_CBJ_CTRL_1, 0xd142);
+	regmap_update_bits(rt5682->regmap, RT5682_CBJ_CTRL_5, 0x0700, 0x0600);
 	regmap_update_bits(rt5682->regmap, RT5682_CBJ_CTRL_3,
 		RT5682_CBJ_IN_BUF_EN, RT5682_CBJ_IN_BUF_EN);
 	regmap_update_bits(rt5682->regmap, RT5682_SAR_IL_CMD_1,
-- 
2.30.2

