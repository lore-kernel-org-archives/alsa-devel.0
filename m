Return-Path: <SRS0=sqcX=LR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12287C4743C
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 05:23:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D949C610A0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Jun 2021 05:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D949C610A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32DCC84C;
	Wed, 23 Jun 2021 07:22:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32DCC84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624425826;
	bh=yoLif/yP9lIOVVEQqz7EMshN93Q7EMOC+aTw32O9oaI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ozvHf6IxtOkQTBGiM0L23cn36p151UJvbB846iX6Kh29YDoalTBdGmmX/KUdsn0DN
	 hsDQBDvyRxLPxtnV6WK5kxMKpCqvF0eeH5CofOLUBBnwjRFq854nCtdxMQgRuFf2+5
	 TeNiyOXxPLwN3Oj5QaTzIaqXg59z/ArqzRBermEM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B32EF8016B;
	Wed, 23 Jun 2021 07:22:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 758CFF8016D; Wed, 23 Jun 2021 07:22:53 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp11.smtpout.orange.fr
 [80.12.242.133])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA2ADF80137
 for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2021 07:22:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA2ADF80137
Received: from localhost.localdomain ([86.243.172.93]) by mwinf5d90 with ME
 id LVNn2500B21Fzsu03VNneq; Wed, 23 Jun 2021 07:22:48 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Jun 2021 07:22:48 +0200
X-ME-IP: 86.243.172.93
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: support.opensource@diasemi.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, Adam.Thomson.Opensource@diasemi.com
Subject: [PATCH] ASoC: da7219: Fix an out-of-bound read in an error handling
 path
Date: Wed, 23 Jun 2021 07:22:45 +0200
Message-Id: <4fdde55198294a07f04933f7cef937fcb654c901.1624425670.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

If 'of_clk_add_hw_provider()' fails, the previous 'for' loop will have
run completely and 'i' is know to be 'DA7219_DAI_NUM_CLKS'.

In such a case, there will be an out-of-bounds access when using
'da7219->dai_clks_lookup[i]' and '&da7219->dai_clks_hw[i]'.

To avoid that, add a new label, 'err_free_all', which set the expected
value of 'i' in such a case.

Fixes: 78013a1cf297 ("ASoC: da7219: Fix clock handling around codec level probe")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/da7219.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 13009d08b09a..1e8b491d1fd3 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2204,12 +2204,14 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 					     da7219->clk_hw_data);
 		if (ret) {
 			dev_err(dev, "Failed to register clock provider\n");
-			goto err;
+			goto err_free_all;
 		}
 	}
 
 	return 0;
 
+err_free_all:
+	i = DA7219_DAI_NUM_CLKS - 1;
 err:
 	do {
 		if (da7219->dai_clks_lookup[i])
-- 
2.30.2

