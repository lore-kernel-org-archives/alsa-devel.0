Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5289DC5517A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:02:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA74A20780
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UjMj5t1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA74A20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30060167A;
	Thu, 29 Oct 2020 10:01:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30060167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603962130;
	bh=/kzj4e/YR8RYCQgIoqkz9dTm+oATEsaxTT2iKZ/C/R0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UjMj5t1O1z6US/ZBl6tvtn/V/rxQzAxyYkZyo9oq9HVA1/NI2xEt8MGe7TwzZ4v7L
	 3c6jxVKAdSSGpoWzefv++nHG98x18XwMsaFuC3LBnMcbc2DIRMgIMLt60GWX0LEez7
	 3yyyh2SFjEt75zUltvqM5t81TNM8Sb9spWLqZ2jA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 969B9F801D8;
	Thu, 29 Oct 2020 10:01:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53DF3F8020D; Thu, 29 Oct 2020 10:01:18 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by alsa1.perex.cz (Postfix) with ESMTP id 1C89AF800FF
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 10:01:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C89AF800FF
Received: from localhost.localdomain (unknown [124.16.141.242])
 by APP-05 (Coremail) with SMTP id zQCowAAn_1LUhJpfva5LAA--.30207S2;
 Thu, 29 Oct 2020 17:01:08 +0800 (CST)
From: Xu Wang <vulab@iscas.ac.cn>
To: daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: pxa: pxa-ssp: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
Date: Thu, 29 Oct 2020 09:01:04 +0000
Message-Id: <20201029090104.29552-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAAn_1LUhJpfva5LAA--.30207S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFyfJFWxCFWkGrWDCFg_yoWkZFb_Ja
 12g39YgF4UZrsIy34UKrZYqr9rCrWxuF1qqr95tr13JrWUJw13Zr1Dtr43ZrZrWwn7Ca4r
 Jw12vw18Ja97ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbskYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xK
 xwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
 IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
 6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
 IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU4iF4DUUUU
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQUEA102ZrAgaAAAs+
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

ecause clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter, so the additional checks are unnecessary, just
remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/soc/pxa/pxa-ssp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index c4e7307a4437..b941adcbb8f9 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -99,8 +99,7 @@ static int pxa_ssp_startup(struct snd_pcm_substream *substream,
 		pxa_ssp_disable(ssp);
 	}
 
-	if (priv->extclk)
-		clk_prepare_enable(priv->extclk);
+	clk_prepare_enable(priv->extclk);
 
 	dma = kzalloc(sizeof(struct snd_dmaengine_dai_dma_data), GFP_KERNEL);
 	if (!dma)
@@ -124,8 +123,7 @@ static void pxa_ssp_shutdown(struct snd_pcm_substream *substream,
 		clk_disable_unprepare(ssp->clk);
 	}
 
-	if (priv->extclk)
-		clk_disable_unprepare(priv->extclk);
+	clk_disable_unprepare(priv->extclk);
 
 	kfree(snd_soc_dai_get_dma_data(cpu_dai, substream));
 	snd_soc_dai_set_dma_data(cpu_dai, substream, NULL);
-- 
2.17.1

