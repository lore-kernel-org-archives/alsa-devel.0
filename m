Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D260C19F29
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Aug 2022 05:46:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9594CD8;
	Sat,  6 Aug 2022 07:45:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9594CD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659764807;
	bh=EjKofStVW4/K1RtKJLb9IY89xa1yrv7hCiqRnGj5LLg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gExDGecUqok915IzAj2xa9i81O420Z72xV/wz9orYD0RIiur1uBWtQQ/gPUcsR2cO
	 eVaOlayRhiP36IMORaHcN+6WUPXPJFt9fXFioolCEn6ej1uFL0Pii+3qflCs9XJPGS
	 iZcGyscgFNDHcFkxvPPmCnEkqbBFTACUyxzKx4V4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20E36F80153;
	Sat,  6 Aug 2022 07:45:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90BA4F80155; Sat,  6 Aug 2022 07:45:55 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr
 [80.12.242.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7A63F80104
 for <alsa-devel@alsa-project.org>; Sat,  6 Aug 2022 07:45:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7A63F80104
Received: from pop-os.home ([90.11.190.129]) by smtp.orange.fr with ESMTPA
 id KCdBo07tSUoLVKCdBon1QS; Sat, 06 Aug 2022 07:45:51 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 06 Aug 2022 07:45:51 +0200
X-ME-IP: 90.11.190.129
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ASoC: sam9g20_wm8731: Simplify some error message
Date: Sat,  6 Aug 2022 07:45:48 +0200
Message-Id: <fb959b3bda689aa47e1fbe9948de957b77530b24.1659764734.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

dev_err_probe() already prints the error code in a human readable way, so
there is no need to duplicate it as a numerical value at the end of the
message.

Fixes: 29f4078f777f ("ASoC: sam9g20_wm8731: Use dev_err_probe() for snd_soc_register_card()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/atmel/sam9g20_wm8731.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
index 4d25fb61c652..1430642c8433 100644
--- a/sound/soc/atmel/sam9g20_wm8731.c
+++ b/sound/soc/atmel/sam9g20_wm8731.c
@@ -172,7 +172,7 @@ static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
 	ret = snd_soc_register_card(card);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret,
-			      "snd_soc_register_card() failed: %d\n", ret);
+			      "snd_soc_register_card() failed\n");
 		goto err;
 	}
 
-- 
2.34.1

