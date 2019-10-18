Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD6ECA9EA0
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089E621852
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YkVtrsAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089E621852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3CE71677;
	Fri, 18 Oct 2019 17:44:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3CE71677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571413501;
	bh=rRAxC5hmo1QPLC0FHNO3o/NTlBPG1j3UWMShBS1CYWk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YkVtrsASSY3K+FCj3mWzLIw420np7Vyh5KfKi3GcksDDiU4+s+WVYJ1fZ074sEOE1
	 BfuknJ1OCYT406cFlP2/WiwpU3mmYGhmxBCOakiUJ0lUpNWU4SARqI+TSpnAkIy46O
	 im2zqP3m55CqR/qeilXz++xX2MKjl15AZtJwr188=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52C76F80612;
	Fri, 18 Oct 2019 17:42:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 22953F800F3; Fri, 18 Oct 2019 17:42:29 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BE36F800F3
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 17:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BE36F800F3
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MG9Xu-1iFzgL1eRQ-00GVSz; Fri, 18 Oct 2019 17:42:25 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 18 Oct 2019 17:41:31 +0200
Message-Id: <20191018154201.1276638-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:E20XgLKSQLAmPv/Au++8EwmYOgk3y+XACbUkV3LAih2e2Yj07KM
 g05RSY7gyHzJgD4iIfT7YhtgXiu1Lr1vuBtrh6M2wc4pYSmoYCowFNc0qD0m8AOU38V+L2J
 1uw4hDqzNqscLb3ouObtwnShsY39wQ2qTmK85xQMDWFl/iuUo8Unpvdft1lD9W1dGmdH1RY
 Tz3ENzPk5SnnU/9zsKF2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sa9VA/rH7Rw=:tUTpmnZ1ACTEs7/I4CO+z/
 JcGaLN/vw2kDyaS+WvNVr89diurJqlTwzePy8dNm1SH21cdmG1ncV7vX16jJLqZr/a1JfMqCm
 OqsU9LNZrNd2oE2cFaoz1wFzK9XosYLFmQ8sOpE0UTPjF+76H2d+8kzd9h9scBkf5p61N/Asx
 erZU7ZdoSEU+/JL8LflFBP4wChaLjJLp73Rff5I24hvqQC1sWHa6RgRX5xAOedrfHuW9yhasm
 tYPsiN+QsuXgWZIi+UgJOiHH8qvaSUDzhDP9qWh7kw+wm78B6QVz9ipH+h8k3dFnfaFYSrh+G
 FaPBTEyVa9Z+mvL+chhfa4/SzgaLx+XS+ZQhNxxAXg2r+B6xd18a4nFk4bux/Uhm0xqOXczJu
 EFrEkZNA2xFfvmNIGeuyYg/5UHlic66vyoLfnYwuP8f23wi/tTJCPMUEms43ggCrx3G6ON0wr
 b59aB8CvmuDTAF65622N2WD6oZqJBz9amgm0V5MuiT+MQPN9LYfqws5kx8tIx0E9IwyDJmXOZ
 Gj4ZVdA6lx2uQRTp2V9qqMo+vzaqqcABlgjOdS6aQqVEakqWN9xjexkFOYYFqbzgGkLOdsC80
 zthA0EGldK9IKGoixKU1rXVAFU0dvxvbv6V4tWAGO20+o5Wt4NeSIieFFbDVX6PzLTiMzijWl
 GYOpBL4BzXt4Bdu8WeB4jMKiyQKWtjTmdzCBqLemKz+3mvnkC97/hscZhRcfj16DKW38TTEJz
 ClYctnIUkkXqWF3chUrPpZAiIyahgaR3QFnbNhUQeGw23H6n4QuaDx+Ff/jwsAyF2CjMBUGNI
 x+9DU9vHCheyMnAcWabolXltjGzjYlmTmj/ygdMt0uY3NWfscFit9ossaMY+rUMyTicgZs4P3
 kidBS57Dl4kQ8A4of0KQ==
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 16/46] ARM: pxa: tosa: use gpio descriptor for
	audio
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The audio driver should not use a hardwired gpio number
from the header. Change it to use a lookup table.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/tosa.c | 12 ++++++++++++
 sound/soc/pxa/tosa.c     | 16 +++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 264b5b6ed13b..9a7f1e42adac 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -859,6 +859,17 @@ static struct platform_device wm9712_device = {
 	.id	= -1,
 };
 
+static struct gpiod_lookup_table tosa_audio_gpio_table = {
+	.dev_id = "tosa-audio",
+	.table = {
+		GPIO_LOOKUP("tc6393xb",
+			    TOSA_GPIO_L_MUTE - TOSA_TC6393XB_GPIO_BASE,
+			    "l-mute", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+
 static struct platform_device tosa_audio_device = {
 	.name	= "tosa-audio",
 	.id	= -1,
@@ -916,6 +927,7 @@ static void __init tosa_init(void)
 	PMCR = 0x01;
 
 	gpiod_add_lookup_table(&tosa_mci_gpio_table);
+	gpiod_add_lookup_table(&tosa_audio_gpio_table);
 	pxa_set_mci_info(&tosa_mci_platform_data);
 	pxa_set_ficp_info(&tosa_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 81ee1bcf4c44..d671cf3d44ed 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -16,14 +16,13 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
 #include <asm/mach-types.h>
-#include <mach/tosa.h>
 #include <linux/platform_data/asoc-pxa.h>
 
 #define TOSA_HP        0
@@ -35,6 +34,7 @@
 
 static int tosa_jack_func;
 static int tosa_spk_func;
+static struct gpio_desc *l_mute_gpio;
 
 static void tosa_ext_control(struct snd_soc_dapm_context *dapm)
 {
@@ -128,7 +128,7 @@ static int tosa_set_spk(struct snd_kcontrol *kcontrol,
 static int tosa_hp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
-	gpio_set_value(TOSA_GPIO_L_MUTE, SND_SOC_DAPM_EVENT_ON(event) ? 1 : 0);
+	gpiod_set_value(l_mute_gpio, SND_SOC_DAPM_EVENT_ON(event) ? 1 : 0);
 	return 0;
 }
 
@@ -222,25 +222,23 @@ static int tosa_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &tosa;
 	int ret;
 
-	ret = gpio_request_one(TOSA_GPIO_L_MUTE, GPIOF_OUT_INIT_LOW,
-			       "Headphone Jack");
+	l_mute_gpio = devm_gpiod_get(&pdev->dev, "l-mute", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(l_mute_gpio);
 	if (ret)
 		return ret;
 
 	card->dev = &pdev->dev;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
-		gpio_free(TOSA_GPIO_L_MUTE);
-	}
+
 	return ret;
 }
 
 static int tosa_remove(struct platform_device *pdev)
 {
-	gpio_free(TOSA_GPIO_L_MUTE);
 	return 0;
 }
 
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
