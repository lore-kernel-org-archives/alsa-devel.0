Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE03C30658
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jul 2024 21:55:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7BD21549;
	Tue,  2 Jul 2024 23:54:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7BD21549
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719957299;
	bh=wtpmY7jbHLqaod6kPJD79ZoXCdRnLkrdjOGoR8rPK/A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=iqXeqlWJFvRKPLbOL5zXPDmZFcSIB2wJvOOdU72GzSO9DpypewiEftxPraXBzqQhy
	 gvgoPBA/skp3KYEo/BdETDTHFjrtZoVrvD36XmW63jaa1Du0VUFJ5Y/dgCNBkrN90j
	 yvjvK2CpX8tTcKn+QcDmG4HIeDR3Rx8wGNixQBfQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DAEBAF8025E; Tue,  2 Jul 2024 23:54:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 70437F805B4;
	Tue,  2 Jul 2024 23:54:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98060F8025E; Tue,  2 Jul 2024 23:54:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3AA7CF800FE
	for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2024 23:54:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AA7CF800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BBQxZx52
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DEE416204D;
	Tue,  2 Jul 2024 21:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1BBC116B1;
	Tue,  2 Jul 2024 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719957251;
	bh=wtpmY7jbHLqaod6kPJD79ZoXCdRnLkrdjOGoR8rPK/A=;
	h=From:To:Cc:Subject:Date:From;
	b=BBQxZx528FOCjH9Fcb22+wc/ah4DmulinHU+0BCmJGTtzJTNX8s5Kck4hl908QxX6
	 bgEVbtJn1FhtjCLGP9OZZt8KSaqtCymMkAEU0dXRnXeagg64cZABVGys/6uZwTABhk
	 r2+f81JsEGv8OaXAkh6Gj0fl/W1/jCehIexP9OCvLbel89Uhc2MTcr25sKtOvScHC8
	 7K9eKWPG3EzG3XfrIUSgm2gT7baNrn2UASTjylCun9PWUzIUQI1+dxEIJgJK2p1qhF
	 wJ/LiQm8xGyqliIXZIweBNd38JdE7W435lQ3IN9mhFunQxhUtk4uex4n99rY8SHYLu
	 69Lr5EBHT5F4w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tas2781: Use of_property_read_reg()
Date: Tue,  2 Jul 2024 15:54:01 -0600
Message-ID: <20240702215402.839673-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6MQPCXMIHXVKX2J2VOAS5GXXORPMIAKH
X-Message-ID-Hash: 6MQPCXMIHXVKX2J2VOAS5GXXORPMIAKH
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6MQPCXMIHXVKX2J2VOAS5GXXORPMIAKH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Replace the open-coded parsing of "reg" with of_property_read_reg().
The #ifdef is also easily replaced with IS_ENABLED().

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 sound/soc/codecs/tas2781-i2c.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index 9350972dfefe..746e6964bfb3 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
@@ -622,33 +623,20 @@ static void tasdevice_parse_dt(struct tasdevice_priv *tas_priv)
 
 		tas_priv->irq_info.irq_gpio =
 			acpi_dev_gpio_irq_get(ACPI_COMPANION(&client->dev), 0);
-	} else {
+	} else if (IS_ENABLED(CONFIG_OF)) {
 		struct device_node *np = tas_priv->dev->of_node;
-#ifdef CONFIG_OF
-		const __be32 *reg, *reg_end;
-		int len, sw, aw;
-
-		aw = of_n_addr_cells(np);
-		sw = of_n_size_cells(np);
-		if (sw == 0) {
-			reg = (const __be32 *)of_get_property(np,
-				"reg", &len);
-			reg_end = reg + len/sizeof(*reg);
-			ndev = 0;
-			do {
-				dev_addrs[ndev] = of_read_number(reg, aw);
-				reg += aw;
-				ndev++;
-			} while (reg < reg_end);
-		} else {
-			ndev = 1;
-			dev_addrs[0] = client->addr;
+		u64 addr;
+
+		for (i = 0; i < TASDEVICE_MAX_CHANNELS; i++) {
+			if (of_property_read_reg(np, i, &addr, NULL))
+				break;
+			dev_addrs[ndev++] = addr;
 		}
-#else
+
+		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
+	} else {
 		ndev = 1;
 		dev_addrs[0] = client->addr;
-#endif
-		tas_priv->irq_info.irq_gpio = of_irq_get(np, 0);
 	}
 	tas_priv->ndev = ndev;
 	for (i = 0; i < ndev; i++)
-- 
2.43.0

