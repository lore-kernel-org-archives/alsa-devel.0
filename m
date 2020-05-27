Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55773C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 08:47:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F0120787
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 08:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oCrhIqWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F0120787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BF1C17AB;
	Wed, 27 May 2020 10:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BF1C17AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590569236;
	bh=dulaDE6NvbojeWgOEYcIwtXiNTmtLpD4UtJ8Sr5gizU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oCrhIqWz1ZbxR31dVHrtru6er8EVgYeysbdh1fqJcJSwwI0I25cpUvndpH1DnJUFO
	 wCJXLzcdqxFyxIcaq2tqIrglrx7QRRBHuh1aBaupB5F6Dl695UDqFEVcMKY0qU7c6r
	 idiNEo/EYzwh57gGkGxf49GAYbAqqozizaTsi8wg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6068F80149;
	Wed, 27 May 2020 10:46:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6D79FF8014E; Wed, 27 May 2020 10:46:24 +0200 (CEST)
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
 by alsa1.perex.cz (Postfix) with ESMTP id DFAE6F800FF
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 10:46:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DFAE6F800FF
Received: from localhost.localdomain (unknown [222.205.60.151])
 by mail-app2 (Coremail) with SMTP id by_KCgCH_5bSKM5eQWchAA--.7710S4;
 Wed, 27 May 2020 16:46:13 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn,
	kjlu@umn.edu
Subject: [PATCH] ASoC: img-spdif-out: Fix runtime PM imbalance on error
Date: Wed, 27 May 2020 16:46:08 +0800
Message-Id: <20200527084610.4790-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCH_5bSKM5eQWchAA--.7710S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWrZF15CFyUGr4xXF1UKFg_yoWfAFg_uw
 4kGws3W3yfGws2qrW7Ja1Yv397Wrn7K3WUGr10vr15K34YyFZ8W3y8Xr98Cr18Xa1kZry0
 q3yDuryxAryqvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb-8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
 wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
 vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
 jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
 x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWU
 XwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
 8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE
 14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026x
 CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
 JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
 1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
 Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
 1UYxBIdaVFxhVjvjDU0xZFpf9x0JUP-B_UUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0MBlZdtOUT6wAPso
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
 sound/soc/img/img-spdif-out.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index 456c462d52fb..b1d8e4535726 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -370,8 +370,10 @@ static int img_spdif_out_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(&pdev->dev);
 		goto err_suspend;
+	}
 
 	img_spdif_out_writel(spdif, IMG_SPDIF_OUT_CTL_FS_MASK,
 			     IMG_SPDIF_OUT_CTL);
-- 
2.17.1

