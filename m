Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2797C55178
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:26:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E1C2076E
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jag1rYbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E1C2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 188C4167F;
	Thu, 29 Oct 2020 09:25:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 188C4167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603959982;
	bh=ymmw/VPBma7CTH4kF/YpY/EkpD7p/sdtC8kfYBWRnZ0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jag1rYbmv2sXHhjfCGfxyCGy7KKUx8VNKm0K7P8+z0cEBEm10OPes1ZcUOQCwDnZJ
	 UMKyuvF7VTIfVvdAR0PnmNa+F0a7q1H60qu2/Sgtvk40sf+ZgnCWjo0npXHzPBZGBP
	 XEeQ+05/IP5MTq+hWQHTQZirgMlcgAqPgA7QEajU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62975F800FF;
	Thu, 29 Oct 2020 09:25:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C653F8020D; Thu, 29 Oct 2020 09:25:30 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by alsa1.perex.cz (Postfix) with ESMTP id 64CF6F80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 09:25:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64CF6F80095
Received: from localhost.localdomain (unknown [124.16.141.242])
 by APP-05 (Coremail) with SMTP id zQCowABnV1BtfJpfZ51KAA--.28505S2;
 Thu, 29 Oct 2020 16:25:18 +0800 (CST)
From: Xu Wang <vulab@iscas.ac.cn>
To: peter.ujfalusi@ti.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: ti: davinci-evm: Remove redundant null check before
 clk_disable_unprepare
Date: Thu, 29 Oct 2020 08:25:13 +0000
Message-Id: <20201029082513.28233-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowABnV1BtfJpfZ51KAA--.28505S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFy8Aw45GFW8AFWkJFb_yoW3KFg_Aw
 1Fg393Wa4UZw1ay34DK3yrAF1ktr4kuan5urnYqr4UtryUWrW5urykta1fur97Ww48J3W3
 Z34qqF4fXr92vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb7AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_GFyl42xK82IY
 c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
 026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
 0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
 vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU00PfPUUUUU==
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCAwEA18J9vch6gAAsf
Cc: linux-kernel@vger.kernel.org
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

Because clk_disable_unprepare() already checked NULL clock parameter,
so the additional check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/soc/ti/davinci-evm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-evm.c b/sound/soc/ti/davinci-evm.c
index 105e56ab9cdc..b043a0070d20 100644
--- a/sound/soc/ti/davinci-evm.c
+++ b/sound/soc/ti/davinci-evm.c
@@ -46,8 +46,7 @@ static void evm_shutdown(struct snd_pcm_substream *substream)
 	struct snd_soc_card_drvdata_davinci *drvdata =
 		snd_soc_card_get_drvdata(soc_card);
 
-	if (drvdata->mclk)
-		clk_disable_unprepare(drvdata->mclk);
+	clk_disable_unprepare(drvdata->mclk);
 }
 
 static int evm_hw_params(struct snd_pcm_substream *substream,
-- 
2.17.1

