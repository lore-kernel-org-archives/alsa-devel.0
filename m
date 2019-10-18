Return-Path: <SRS0=bEgE=YL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A3CA9EA9
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:49:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B4B2064B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c/vFoFwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B4B2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88E92168A;
	Fri, 18 Oct 2019 17:48:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88E92168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571413770;
	bh=d1eX7mjM0rX5z3YXoEcD0r6xS/U7nkfd85x0gALt6yA=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/vFoFwU+sf8zvJpWeIFYmNuoqoemCBzjUU1pN9dm3PP51oqiipAHH83JV6XuwAYn
	 52wbzW9adsHgSgl2HkisW+COPvSQnIGpvkBKH154xbbp+2AnDTDyKsVHjk60JP6fYc
	 5+kAYYM7VhAyxtoI9hsZdqymNjbAt1H6BUQpMBzk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 120E6F80674;
	Fri, 18 Oct 2019 17:42:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C336F8063D; Fri, 18 Oct 2019 17:42:44 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83F0BF805FC
 for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2019 17:42:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83F0BF805FC
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKbXu-1ibuFm0USC-00L1jl; Fri, 18 Oct 2019 17:42:30 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
Date: Fri, 18 Oct 2019 17:41:45 +0200
Message-Id: <20191018154201.1276638-30-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:JnyiR7rxqnAnO9BolIMCAtr756n0YCtxDEUDXWA0qY34R6AhKmw
 JIS6nus6XOfzi/0EFukEBpCihUFcq4KDlzoAh3G+v5xAoBL+UjfTnccuvUl2RbRgXj1CrWl
 S72O66Yd0/wThsj3sCDsF7yvfEq6ML3/xAJUucEGi/0xa3Pd5QkcWl7ryGzRO53qiiI072v
 Yx76SnTUIfT8I6fDNL54Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KidX8pZMFC8=:XCbuwKMNPuxxsgY+EWmE+8
 NYw8+N0UXRTkGdvBirUjzDp7wzwI42Dt0xuGG89pqCJhqIVDCgGakQLQ4M2x94cX5hG/APMrE
 lAh28BAwA5DMsfIqaUdOrngo8N6sSRtIUrJb18qIcpj9Jc+BrfSGgmR7bP+ln6421gg/bp4HS
 bIN92XgUWekVG+OBarxbvtNZqb3SIkBQP4bS2vtTT2QrssuiLEH3i3PafxFwP/u2njPLVHsZl
 7EwBCSJl9D5bqrAtdex6beRJLEeAPoXijoSmza/gOTBOpC9b9toPErH/fbHSoND6LWHJCnuPE
 +BhiDBEhgSqh0i8awtuhArhp1eBLUiWXwK3WV+ShQYjnbPUz9OupLUfbqNxiYc2IKWwl6SbsH
 tCRJERTbqeeFt4lS0k1wAWzm+zqp3tbQM6yhUBkikrIXdlT/416v+fZGBzIMp9bf5wu7yEvie
 hJnFHnJQ3szUkvEYbq+1fxyKmnec1ot16eGfsp941nVS3MefWLTMRsgFcjmhi+S4S+o+p3eYW
 BT+VPjAAEhgO6wsDdwK+rBNLDZC0DzyxteiVS7XS+R7cbUH2+ml/dN4kwoRwhb2NELsOj+qze
 dgdOVAK2CZzBW7MEZwv+ocrHLJ8QUnQBfq0z7OtCPd2fNNxr6F2SxYqxWOjxhHu6fq6+a7ea9
 EkNbWd7RigP1QwXwzVp8JLFKkhnY+Stlt3dkOqIvTjFCh6QT4+POSWUzu/Ln2ZQye3SjCJdVS
 Yec/pO/nUFBLF4Bhc+8KxIuswH6KaqKLsvEFqfmDF5pRYrsbFu44jnKFXnZzLTMYPGZ4ESZ1o
 7M6DYIQUZPaiO93OUq48eqrc9fnopwPT1AhWiBrjNtQOeUGLUt6BQI9JTEoEKi3Te5SgTIbd2
 xTEXU2HDMa+Fro1lEUzw==
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: [alsa-devel] [PATCH 30/46] SoC: pxa: use pdev resource for FIFO regs
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

The driver currently takes the hardwired FIFO address from
a header file that we want to eliminate. Change it to use
the mmio resource instead and stop including the heare.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/pxa2xx-ac97.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 2138106fed23..4fd97c50aa2c 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -21,10 +21,12 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-#include <mach/pxa-regs.h>
-#include <mach/regs-ac97.h>
 #include <linux/platform_data/asoc-pxa.h>
 
+#define PCDR	0x0040  /* PCM FIFO Data Register */
+#define MODR	0x0140  /* Modem FIFO Data Register */
+#define MCDR	0x0060  /* Mic-in FIFO Data Register */
+
 static void pxa2xx_ac97_warm_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_warm_reset();
@@ -59,35 +61,30 @@ static struct ac97_controller_ops pxa2xx_ac97_ops = {
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
-	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.chan_name	= "pcm_pcm_stereo_in",
 	.maxburst	= 32,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
-	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.chan_name	= "pcm_pcm_stereo_out",
 	.maxburst	= 32,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_out = {
-	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
 	.chan_name	= "pcm_aux_mono_out",
 	.maxburst	= 16,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_in = {
-	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
 	.chan_name	= "pcm_aux_mono_in",
 	.maxburst	= 16,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_mic_mono_in = {
-	.addr		= __PREG(MCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
 	.chan_name	= "pcm_aux_mic_mono",
 	.maxburst	= 16,
@@ -225,6 +222,7 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 	int ret;
 	struct ac97_controller *ctrl;
 	pxa2xx_audio_ops_t *pdata = pdev->dev.platform_data;
+	struct resource *regs;
 	void **codecs_pdata;
 
 	if (pdev->id != -1) {
@@ -232,6 +230,16 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
+	pxa2xx_ac97_pcm_stereo_in.addr = regs->start + PCDR;
+	pxa2xx_ac97_pcm_stereo_out.addr = regs->start + PCDR;
+	pxa2xx_ac97_pcm_aux_mono_out.addr = regs->start + MODR;
+	pxa2xx_ac97_pcm_aux_mono_in.addr = regs->start + MODR;
+	pxa2xx_ac97_pcm_mic_mono_in.addr = regs->start + MCDR;
+
 	ret = pxa2xx_ac97_hw_probe(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "PXA2xx AC97 hw probe error (%d)\n", ret);
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
