Return-Path: <SRS0=hypa=BU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A5BC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 06:41:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7BC2073E
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2020 06:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nBy/Taew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7BC2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10DF515F2;
	Mon, 10 Aug 2020 08:40:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10DF515F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597041672;
	bh=2ZX96sk048JTiQDV/hHr6z/v2CigTZ1cfLvTrfuZYBM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nBy/TaewFoLEedGox0ZVNtQPTwsA3NaamXhwjCIMIXBqCFvMNmN4MJJuOfWooe803
	 IRsuDSO7hQScE36jJ5L3gHLLwXxnCzoNbdVZlSM+jqlZ2+7tDk/JBAoA6t0NWLQuFv
	 wOQkdFvVLXqIURFIF5AXD9rO1YRooaWGIqtWf/Qk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80932F801DB;
	Mon, 10 Aug 2020 08:40:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97E06F8022B; Mon, 10 Aug 2020 08:40:19 +0200 (CEST)
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
 by alsa1.perex.cz (Postfix) with ESMTP id 4653AF80085
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2020 08:40:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4653AF80085
Received: from localhost.localdomain (unknown [210.32.144.186])
 by mail-app3 (Coremail) with SMTP id cC_KCgBnS9y+6zBfmpxZAg--.64946S4;
 Mon, 10 Aug 2020 14:40:01 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn,
	kjlu@umn.edu
Subject: [PATCH] ALSA: pci/asihpi: Fix memory leak in
 snd_card_asihpi_capture_open()
Date: Mon, 10 Aug 2020 14:39:55 +0800
Message-Id: <20200810063957.13692-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBnS9y+6zBfmpxZAg--.64946S4
X-Coremail-Antispam: 1UD129KBjvdXoWruryktF1xCr4Duw43Jw1rXrb_yoWfZwc_Gr
 4xAr43WFWjvr9Fv34qyr4SqrW2v395CF4vgr9xtFsxWw45t3y29rWxXryfGF92k34vkw18
 GanFqry7AFy3JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbIxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
 wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
 vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
 jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
 x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
 GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
 8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l
 42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
 8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
 ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
 0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
 wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
 7VUjHUDJUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgsFBlZdtPe8fwAKsL
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Eliot Blennerhassett <eblennerhassett@audioscience.com>
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

When snd_pcm_hw_constraint_pow2() fails, dpcm should be freed
just like when hpi_instream_open()  fails.

Fixes: 719f82d3987aa ("ALSA: Add support of AudioScience ASI boards")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 sound/pci/asihpi/asihpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 023c35a2a951..736eceacd3d0 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1244,8 +1244,10 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	if (card->can_dma)
 		err = snd_pcm_hw_constraint_pow2(runtime, 0,
 					SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
-	if (err < 0)
+	if (err < 0) {
+		kfree(dpcm);
 		return err;
+	}
 
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 		card->update_interval_frames);
-- 
2.17.1

