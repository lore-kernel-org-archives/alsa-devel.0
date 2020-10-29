Return-Path: <SRS0=XEtc=EE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101CC2D0A3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:42:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C7B20735
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Oct 2020 08:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MIKxnysQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C7B20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD612167D;
	Thu, 29 Oct 2020 09:41:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD612167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603960963;
	bh=epx83kc2LYEbo218FE4r/mceEMRkJh670wIkAyV8Yvk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MIKxnysQL4PH9ZlHg0uP7yP6VDjW0JZ1eEyFGL5zyP8UKZlzYtyxRinTmaLZ1pDVJ
	 vSavIiG59ZLCkFAb05vJkTEGsLIpsqm8QP5A2OTqFujBDLBQ+7f3Piq/7rZMFxEVBW
	 BItOp9M15tB4DMBcKMP1/cD5v7EFjSYAwGBgP/f4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08CA2F800FF;
	Thu, 29 Oct 2020 09:41:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4963DF8020D; Thu, 29 Oct 2020 09:41:51 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by alsa1.perex.cz (Postfix) with ESMTP id E8C42F80095
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2020 09:41:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8C42F80095
Received: from localhost.localdomain (unknown [124.16.141.242])
 by APP-05 (Coremail) with SMTP id zQCowABnWFFEgJpf7hJLAA--.4521S2;
 Thu, 29 Oct 2020 16:41:42 +0800 (CST)
From: Xu Wang <vulab@iscas.ac.cn>
To: s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: samsung: i2s: Remove redundant null check before
 clk_disable_unprepare
Date: Thu, 29 Oct 2020 08:41:37 +0000
Message-Id: <20201029084137.28771-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowABnWFFEgJpf7hJLAA--.4521S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFy8Aw45GryUtFy5urg_yoW3ZwbEq3
 W5Wa1Y9F1UWrZ2y34DCw45Cr4qgF97uFW8Ww1rKr1xKF9rXw43ZrZ7tr13Aa9rJrWkCas5
 ZrnFvrWfCrsakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb28YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r43MxAIw28I
 cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
 IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
 42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
 IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
 jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4yxiUUUUU=
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCAwEA18J9vctFgAAsv
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
 sound/soc/samsung/i2s.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index df53d4ea808f..36969f0a3f9a 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1212,8 +1212,7 @@ static int i2s_runtime_suspend(struct device *dev)
 	priv->suspend_i2scon = readl(priv->addr + I2SCON);
 	priv->suspend_i2spsr = readl(priv->addr + I2SPSR);
 
-	if (priv->op_clk)
-		clk_disable_unprepare(priv->op_clk);
+	clk_disable_unprepare(priv->op_clk);
 	clk_disable_unprepare(priv->clk);
 
 	return 0;
-- 
2.17.1

