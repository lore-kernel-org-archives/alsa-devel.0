Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46DCC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 08:44:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447162084C
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 08:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nl16XyNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447162084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C85217AA;
	Wed, 27 May 2020 10:43:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C85217AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590569078;
	bh=UOqetWIPvju5tnPtEadFTXE03WKlwWQt34PCVx75vk8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nl16XyNPZyv7e80lM3hA/01LAok9ZEq+RjqxiRyYn5qIVOO/7UPA9uEyiVwGxxdzX
	 Mon9tc4BL0kARcj82bgdLgppXGJzPX1WQhkL9m94pm4nl1oxGhd5T9D0Lbh0RQR7Jo
	 tCMfq3rTMwdi2yN6ljMtxuYZM1s3VkduSqYwopcQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 217E0F80146;
	Wed, 27 May 2020 10:43:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 573B3F8014E; Wed, 27 May 2020 10:43:47 +0200 (CEST)
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
 by alsa1.perex.cz (Postfix) with ESMTP id C7414F800FF
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 10:43:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7414F800FF
Received: from localhost.localdomain (unknown [222.205.60.151])
 by mail-app2 (Coremail) with SMTP id by_KCgBnEb0vKM5ey2AhAA--.8240S4;
 Wed, 27 May 2020 16:43:31 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn,
	kjlu@umn.edu
Subject: [PATCH] ASoC: img-spdif-in: Fix runtime PM imbalance on error
Date: Wed, 27 May 2020 16:43:24 +0800
Message-Id: <20200527084326.4131-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgBnEb0vKM5ey2AhAA--.8240S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWrZF15CFyUGr4xXF1UKFg_yoWfWwcE9w
 4kCws3W3yrCayIqrWDXa1YvrWrWrn7KFWUWF1Iyr1fK34Ykrs8X3ykJFn8ur45Wa18Xr1I
 qry8urWfuryvkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
 wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
 vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
 jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
 x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
 GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
 8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE
 14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
 WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
 4UJbIYCTnIWIevJa73UjIFyTuYvjfUeHUDDUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0MBlZdtOUT6wANsq
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>
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

pm_runtime_get_sync() increments the runtime PM usage counter even
the call returns an error code. Thus a pairing decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 sound/soc/img/img-spdif-in.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-spdif-in.c b/sound/soc/img/img-spdif-in.c
index fd639f4d082b..46ff8a3621d5 100644
--- a/sound/soc/img/img-spdif-in.c
+++ b/sound/soc/img/img-spdif-in.c
@@ -753,8 +753,10 @@ static int img_spdif_in_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		goto err_suspend;
+	}
 
 	rst = devm_reset_control_get_exclusive(&pdev->dev, "rst");
 	if (IS_ERR(rst)) {
-- 
2.17.1

