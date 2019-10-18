Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AAECA9EA9
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BB3222CC
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kiCLVUNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BB3222CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C323166E;
	Fri, 18 Oct 2019 17:43:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C323166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571413455;
	bh=Hc10EGReCfcCNuUdFWoQ5QnASqGk78AjodMQQim1S3s=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kiCLVUNandxSVmsItJPcv7s44Cd2c4utkC3VCJJd4tnTayHCqga5hkn8cm9htEnRI
	 OSmRKG2saGOdzWRCbxADtWMGDtByfJdbkot72OCf2+NBiZ1BePlw0LXV5DJERHBW+A
	 Vms1s79HJy7Tj+4Ib3b/Z+59rVgSC7bfuJk2Uod0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F52CF805FF;
	Fri, 18 Oct 2019 17:42:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03127F805FC; Fri, 18 Oct 2019 17:42:29 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A769F80362
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 17:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A769F80362
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N63JO-1hx5qr2yfg-016PlV; Fri, 18 Oct 2019 17:42:25 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 18 Oct 2019 17:41:32 +0200
Message-Id: <20191018154201.1276638-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:p9ZrRDHwCnKDBluK8hkqbIJa9HiEsmbCOZpQY8Mh+exqEux633r
 DZRxCBw9sMWxqdqgBGczIR+z7mwPWtziPTHrh12OtwvaLaf2RNlYqcykLvTJi0KcVSxmGoh
 rhj/qwo8gxEs8NxXN1DaJ0HzXd/AAzxvGUB/pGCGkLmNB2XbDIvGNWbDS4qHtyEL8WYXkJU
 uocSZU2bYNFxoP37Nc7Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WAOOIPnScUM=:9Eaw5bkBpyAoqkstz5gVM4
 E7/ZdztdXyDuWYH4h4FLGsUr4tPlBUW+LVP2JZcezjI71bxVYKQ+lCLxC6qhN+fGahELtAmIR
 cOzf2qkP++9ojwfonDfU9PCp4GsIYw30OY4s12K23FSgo5yuOHz3wqbfoogZwPWQUYqRnEvju
 z5tE1dAHFEaQs0c8RFlFNwxzLj6NIrFk/StaumS8C+gb+5L0ElpljtFSMDNT3ZnXA2WhaN4p5
 9U3xVZvQ5DwRoGPtSh0exjBsmkmVNKG7Mpci41hFnQdD/apiizlXXDqJyI60YiKqlVXdC4QSP
 fYtmEXbjteMmh9E2TFJhrbJjeOS2818VyK1WpZ2dijPUvaVOqJzolVHBZyN6o61UiaXYKUgpJ
 EWhwpkITNOXDEM3gwSqtmetTIqJ12M1sFD0sda+PdnhvM1GOurMU8FpVE7KQ9Toar8ZRCcVRu
 23UrtofaXJbiFvEPvEJ4ZY0WjNy5AvHOQ8+7xckLWW7CQaeFQhPcw/YcB8k/qrVFcTXYK5HeB
 bdPYGBnwyZ5EeFaQJaDZrjVntsnRxid/TNUXCbNGZORhnneKJoEqaDBSlpsVmAclYh9OfzS+z
 QBYJAtBfLUT/qNqdn57tqcoEOnD1bQG28r3Aw+nJmtF74JxB5xZTRCm9dD/1yut9tEUh6xJUf
 ToH28uYuVJ6/2JpxBaPj/akU+2z+sdtY1hqVwkkpd4HiJOOAi/AfyU4gmjQ3jL+urB4pGeMoH
 8m1kRo8ZSsvvAd/1jfFmXlEjWxeUBuQFOn1jzQhdqpk2D7rkeZeYMCc2uUaz6c56vy7Uir130
 b7NBIxHqnWHusuHFIIaJgO8ruFFOoc/ELslpzy7Yf5QutDJAN733oFp/1WwXgBXuITvJmyNcE
 Vd5/RLwxLiSuzIGkuf5A==
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 17/46] ARM: pxa: poodle: use platform data for
	poodle asoc driver
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

The poodle audio driver shows its age by using a custom
gpio api for the "locomo" support chip.

In a perfect world, this would get converted to use gpiolib
and a gpio lookup table.

As the world is not perfect, just pass all the required data
in a custom platform_data structure. to avoid the globally
visible mach/poodle.h header.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/poodle.c                    | 30 ++++++++----
 arch/arm/mach-pxa/{include/mach => }/poodle.h |  4 +-
 include/linux/platform_data/asoc-poodle.h     | 16 ++++++
 sound/soc/pxa/poodle.c                        | 49 ++++++++++---------
 4 files changed, 63 insertions(+), 36 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/poodle.h (97%)
 create mode 100644 include/linux/platform_data/asoc-poodle.h

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 8dd791ee49bf..7709fe026c33 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -39,11 +39,13 @@
 #include <asm/mach/irq.h>
 
 #include "pxa25x.h"
-#include <linux/platform_data/mmc-pxamci.h>
 #include "udc.h"
+#include "poodle.h"
+
+#include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/irda-pxaficp.h>
-#include <mach/poodle.h>
 #include <linux/platform_data/video-pxafb.h>
+#include <linux/platform_data/asoc-poodle.h>
 
 #include <asm/hardware/scoop.h>
 #include <asm/hardware/locomo.h>
@@ -155,12 +157,6 @@ static struct scoop_pcmcia_config poodle_pcmcia_config = {
 
 EXPORT_SYMBOL(poodle_scoop_device);
 
-
-static struct platform_device poodle_audio_device = {
-	.name	= "poodle-audio",
-	.id	= -1,
-};
-
 /* LoCoMo device */
 static struct resource locomo_resources[] = {
 	[0] = {
@@ -179,7 +175,7 @@ static struct locomo_platform_data locomo_info = {
 	.irq_base	= IRQ_BOARD_START,
 };
 
-struct platform_device poodle_locomo_device = {
+static struct platform_device poodle_locomo_device = {
 	.name		= "locomo",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(locomo_resources),
@@ -189,7 +185,21 @@ struct platform_device poodle_locomo_device = {
 	},
 };
 
-EXPORT_SYMBOL(poodle_locomo_device);
+static struct poodle_audio_platform_data poodle_audio_pdata = {
+	.locomo_dev	= &poodle_locomo_device.dev,
+
+	.gpio_amp_on   	= POODLE_LOCOMO_GPIO_AMP_ON,
+	.gpio_mute_l   	= POODLE_LOCOMO_GPIO_MUTE_L,
+	.gpio_mute_r   	= POODLE_LOCOMO_GPIO_MUTE_R,
+	.gpio_232vcc_on	= POODLE_LOCOMO_GPIO_232VCC_ON,
+	.gpio_jk_b     	= POODLE_LOCOMO_GPIO_JK_B,
+};
+
+static struct platform_device poodle_audio_device = {
+	.name	= "poodle-audio",
+	.id	= -1,
+	.dev.platform_data = &poodle_audio_pdata,
+};
 
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
 static struct pxa2xx_spi_controller poodle_spi_info = {
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/poodle.h
similarity index 97%
rename from arch/arm/mach-pxa/include/mach/poodle.h
rename to arch/arm/mach-pxa/poodle.h
index b56b19351a03..e675a3d1aa18 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/poodle.h
@@ -15,7 +15,7 @@
 #ifndef __ASM_ARCH_POODLE_H
 #define __ASM_ARCH_POODLE_H  1
 
-#include "irqs.h" /* PXA_GPIO_TO_IRQ */
+#include <mach/irqs.h> /* PXA_GPIO_TO_IRQ */
 
 /*
  * GPIOs
@@ -89,6 +89,4 @@
 
 #define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
 
-extern struct platform_device poodle_locomo_device;
-
 #endif /* __ASM_ARCH_POODLE_H  */
diff --git a/include/linux/platform_data/asoc-poodle.h b/include/linux/platform_data/asoc-poodle.h
new file mode 100644
index 000000000000..2052fad55c5c
--- /dev/null
+++ b/include/linux/platform_data/asoc-poodle.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_PLATFORM_DATA_POODLE_AUDIO
+#define __LINUX_PLATFORM_DATA_POODLE_AUDIO
+
+/* locomo is not a proper gpio driver, and uses its own api */
+struct poodle_audio_platform_data {
+	struct device	*locomo_dev;
+
+	int		gpio_amp_on;
+	int		gpio_mute_l;
+	int		gpio_mute_r;
+	int		gpio_232vcc_on;
+	int		gpio_jk_b;
+};
+
+#endif
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index f289c089aede..39768288b80c 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -21,8 +21,8 @@
 
 #include <asm/mach-types.h>
 #include <asm/hardware/locomo.h>
-#include <mach/poodle.h>
 #include <linux/platform_data/asoc-pxa.h>
+#include <linux/platform_data/asoc-poodle.h>
 
 #include "../codecs/wm8731.h"
 #include "pxa2xx-i2s.h"
@@ -38,21 +38,23 @@
 static int poodle_jack_func;
 static int poodle_spk_func;
 
+static struct poodle_audio_platform_data *poodle_pdata;
+
 static void poodle_ext_control(struct snd_soc_dapm_context *dapm)
 {
 	/* set up jack connection */
 	if (poodle_jack_func == POODLE_HP) {
 		/* set = unmute headphone */
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 1);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 1);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_l, 1);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_r, 1);
 		snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
 	} else {
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_L, 0);
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_MUTE_R, 0);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_l, 0);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_mute_r, 0);
 		snd_soc_dapm_disable_pin(dapm, "Headphone Jack");
 	}
 
@@ -80,10 +82,10 @@ static int poodle_startup(struct snd_pcm_substream *substream)
 static void poodle_shutdown(struct snd_pcm_substream *substream)
 {
 	/* set = unmute headphone */
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 1);
-	locomo_gpio_write(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 1);
+	locomo_gpio_write(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_l, 1);
+	locomo_gpio_write(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_r, 1);
 }
 
 static int poodle_hw_params(struct snd_pcm_substream *substream,
@@ -174,11 +176,11 @@ static int poodle_amp_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 0);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_amp_on, 0);
 	else
-		locomo_gpio_write(&poodle_locomo_device.dev,
-			POODLE_LOCOMO_GPIO_AMP_ON, 1);
+		locomo_gpio_write(poodle_pdata->locomo_dev,
+			poodle_pdata->gpio_amp_on, 1);
 
 	return 0;
 }
@@ -254,13 +256,14 @@ static int poodle_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &poodle;
 	int ret;
 
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_AMP_ON, 0);
+	poodle_pdata = pdev->dev.platform_data;
+	locomo_gpio_set_dir(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_amp_on, 0);
 	/* should we mute HP at startup - burning power ?*/
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_L, 0);
-	locomo_gpio_set_dir(&poodle_locomo_device.dev,
-		POODLE_LOCOMO_GPIO_MUTE_R, 0);
+	locomo_gpio_set_dir(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_l, 0);
+	locomo_gpio_set_dir(poodle_pdata->locomo_dev,
+		poodle_pdata->gpio_mute_r, 0);
 
 	card->dev = &pdev->dev;
 
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
