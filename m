Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E205C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:47:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB992078B
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 07:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vvNDDMp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB992078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBC3284B;
	Thu, 13 Aug 2020 09:47:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBC3284B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597304871;
	bh=LTiBluf1jyT9KMbTPvCaYPx0PEqJxGAMHB28Oxbn/uY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vvNDDMp+675H+9pSp2MaVge4Uz5x0SGFx1XKW8LuJAtD7ZvFUxN4vWfiQ2WQ87Fs3
	 C8gSGzrRqBy9AnD+icWHNbU7ZeX1vxEh5Roj7S/8tlFjiZuAcox4gL0eantlU6JqxG
	 k+XIdegV71cB9LHia4IdKvW34jathsZsYOLCBBKA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72227F8014C;
	Thu, 13 Aug 2020 09:47:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0203BF8015B; Thu, 13 Aug 2020 09:47:00 +0200 (CEST)
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
 by alsa1.perex.cz (Postfix) with ESMTP id 778C2F800F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 09:46:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 778C2F800F4
Received: from localhost.localdomain (unknown [10.192.85.18])
 by mail-app2 (Coremail) with SMTP id by_KCgCHj+fd7zRfB4jOAQ--.60727S4;
 Thu, 13 Aug 2020 15:46:41 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn,
	kjlu@umn.edu
Subject: [PATCH] [v2] ALSA: echoaudio: Fix potential Oops in snd_echo_resume()
Date: Thu, 13 Aug 2020 15:46:30 +0800
Message-Id: <20200813074632.17022-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCHj+fd7zRfB4jOAQ--.60727S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JrWDuw4rArWkZF45tr4xWFg_yoWkWrX_Gw
 48urn5Cay5tr95C34DJrW8WryDJ3Za9r1xA39xtF47JasxJas2qr97Xrs3AryxurW09r98
 KrWrXryjkrn0kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbV8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
 wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
 vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
 jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
 x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
 GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
 8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
 0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
 DU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgoLBlZdtPic1gABsJ
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Hills <mark@xwax.org>
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

Freeing chip on error may lead to an Oops at the next time
the system goes to resume. Fix this by removing all
snd_echo_free() calls on error.

Fixes: 47b5d028fdce8 ("ALSA: Echoaudio - Add suspend support #2")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Remove snd_echo_free() calls in all error paths.
---
 sound/pci/echoaudio/echoaudio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 6aeb99aa2414..868f1dcd27d6 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2213,7 +2213,6 @@ static int snd_echo_resume(struct device *dev)
 	if (err < 0) {
 		kfree(commpage_bak);
 		dev_err(dev, "resume init_hw err=%d\n", err);
-		snd_echo_free(chip);
 		return err;
 	}
 
@@ -2240,7 +2239,6 @@ static int snd_echo_resume(struct device *dev)
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(chip->card->dev, "cannot grab irq\n");
-		snd_echo_free(chip);
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-- 
2.17.1

