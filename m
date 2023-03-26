Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788C7C6FD1C
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Mar 2023 12:45:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 615CCDF3;
	Sun, 26 Mar 2023 14:44:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 615CCDF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679834711;
	bh=NQp5qoPgBStpeaTB9I/gHoi1QzXt72mOR41wnzSi/4c=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=oPzHP8BFj3ULRb6/mvOBNhIoaSCh60Lm6rIroveptgt7tIeTfV1zuvz6KpAJIEx5a
	 pCHI5exFfnFEMliv9UEdwRridyw0HQjKsT+nKmtu7KYMbRbYHMkb1kJy9NioreYR0O
	 97qH+4HVusdE8rCcverunfBFqetSDAH08+Rjb5jM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C73CF8021D;
	Sun, 26 Mar 2023 14:43:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0E93F80272; Sun, 26 Mar 2023 14:43:50 +0200 (CEST)
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr
 [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3CFADF8021D
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2023 14:43:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CFADF8021D
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id gPimpclLpV6zQgPimpzJp6; Sun, 26 Mar 2023 14:43:42 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Mar 2023 14:43:42 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jerome Brunet <jbrunet@baylibre.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ASoC: meson: Use the devm_clk_get_optional() helper
Date: Sun, 26 Mar 2023 14:43:38 +0200
Message-Id: 
 <8dab942d6ce47657a9c038295959be80bb2ee09e.1679834598.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Q3X6V4MIEVI4TB5OIKD6235Z2ELSR3MS
X-Message-ID-Hash: Q3X6V4MIEVI4TB5OIKD6235Z2ELSR3MS
X-MailFrom: christophe.jaillet@wanadoo.fr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q3X6V4MIEVI4TB5OIKD6235Z2ELSR3MS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use devm_clk_get_optional() instead of hand writing it.
This saves some loC and improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/meson/axg-tdm-interface.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 7624aafe9009..5e5e4c56d505 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -496,7 +496,7 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct snd_soc_dai_driver *dai_drv;
 	struct axg_tdm_iface *iface;
-	int ret, i;
+	int i;
 
 	iface = devm_kzalloc(dev, sizeof(*iface), GFP_KERNEL);
 	if (!iface)
@@ -533,14 +533,9 @@ static int axg_tdm_iface_probe(struct platform_device *pdev)
 	 * At this point, ignore the error if mclk is missing. We'll
 	 * throw an error if the cpu dai is master and mclk is missing
 	 */
-	iface->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(iface->mclk)) {
-		ret = PTR_ERR(iface->mclk);
-		if (ret == -ENOENT)
-			iface->mclk = NULL;
-		else
-			return dev_err_probe(dev, ret, "failed to get mclk\n");
-	}
+	iface->mclk = devm_clk_get_optional(dev, "mclk");
+	if (IS_ERR(iface->mclk))
+		return dev_err_probe(dev, PTR_ERR(iface->mclk), "failed to get mclk\n");
 
 	return devm_snd_soc_register_component(dev,
 					&axg_tdm_iface_component_drv, dai_drv,
-- 
2.34.1

