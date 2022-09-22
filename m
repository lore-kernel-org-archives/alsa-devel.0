Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D042C54EE9
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Sep 2022 19:46:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 463FA41;
	Thu, 22 Sep 2022 21:45:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 463FA41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663875958;
	bh=uE6idgas+t6xkPxdwp3yoHqgPrLlLyzDzKErVe/SgV8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m//y+5eyX++LSmpiLdC+3RedNxw8aRnLI5ddqcf4fBic90zU2m6COJTPAuxE/pVHo
	 p2HgNfyso3n7tfQq5xs3ODFFiCPOGPv6vVUKegl/2Xf6cQP6XlReaiZt6881MI6ZQj
	 LfOlikcR9YS9xFJBcdbAerGHu7zJ+hq15/NrRdU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BEF71F80256;
	Thu, 22 Sep 2022 21:45:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31A73F8027B; Thu, 22 Sep 2022 21:45:06 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr
 [80.12.242.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B767EF8020D
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2022 21:45:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B767EF8020D
Received: from pop-os.home ([90.11.190.129]) by smtp.orange.fr with ESMTPA
 id bS84oQyft94embS84oAvYz; Thu, 22 Sep 2022 21:45:02 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 22 Sep 2022 21:45:02 +0200
X-ME-IP: 90.11.190.129
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Support Opensource <support.opensource@diasemi.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7219: Fix an error handling path in
 da7219_register_dai_clks()
Date: Thu, 22 Sep 2022 21:44:57 +0200
Message-Id: <e4acceab57a0d9e477a8d5890a45c5309e553e7c.1663875789.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
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

If clk_hw_register() fails, the corresponding clk should not be
unregistered.

To handle errors from loops, clean up partial iterations before doing the
goto.  So add a clk_hw_unregister().
Then use a while (--i >= 0) loop in the unwind section.

Fixes: 78013a1cf297 ("ASoC: da7219: Fix clock handling around codec level probe")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
See https://lore.kernel.org/all/4fdde55198294a07f04933f7cef937fcb654c901.1624425670.git.christophe.jaillet@wanadoo.fr/
for an incomplete patch sent last year and Dan's comment on it.
---
 sound/soc/codecs/da7219.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 50ecf30e6136..4746c8700451 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -2196,6 +2196,7 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 			dai_clk_lookup = clkdev_hw_create(dai_clk_hw, init.name,
 							  "%s", dev_name(dev));
 			if (!dai_clk_lookup) {
+				clk_hw_unregister(dai_clk_hw);
 				ret = -ENOMEM;
 				goto err;
 			} else {
@@ -2217,12 +2218,12 @@ static int da7219_register_dai_clks(struct snd_soc_component *component)
 	return 0;
 
 err:
-	do {
+	while (--i >= 0) {
 		if (da7219->dai_clks_lookup[i])
 			clkdev_drop(da7219->dai_clks_lookup[i]);
 
 		clk_hw_unregister(&da7219->dai_clks_hw[i]);
-	} while (i-- > 0);
+	}
 
 	if (np)
 		kfree(da7219->clk_hw_data);
-- 
2.34.1

