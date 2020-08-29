Return-Path: <SRS0=Trf1=CH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7792AC433E2
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Aug 2020 08:06:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8592076D
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Aug 2020 08:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Jnx+QWVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8592076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 77C9B18C6;
	Sat, 29 Aug 2020 10:05:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 77C9B18C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598688398;
	bh=9N0AktWHzIAmISRt9vl7kZrJXI2S369liTLG5SCxsBM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jnx+QWVkPBr+Ke2CAOHbY4yg03mrI0iEBN37C3yrjgDr0UUyZkb/fRHO1jpl5Xtfn
	 +RmYCh7mzUdvGESZeUv7Rd1BTfAcEWXwG7hkNm+QNuwERumXe4K/0nEiJKCGLl8bsu
	 2YX+aDnRJ3dj95BiI05ufkfiSGNAclrfbZlitXlI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBD2AF80245;
	Sat, 29 Aug 2020 10:05:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 221ADF8025A; Sat, 29 Aug 2020 10:05:45 +0200 (CEST)
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
 by alsa1.perex.cz (Postfix) with ESMTP id 2D9B5F8014E
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2020 10:05:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D9B5F8014E
Received: from localhost.localdomain (unknown [10.192.85.18])
 by mail-app2 (Coremail) with SMTP id by_KCgCnbuQ9DEpfb+9KAg--.45056S4;
 Sat, 29 Aug 2020 16:05:20 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn,
	kjlu@umn.edu
Subject: [PATCH] ALSA: opti9xx: Fix memleak in snd_opti9xx_read_check
Date: Sat, 29 Aug 2020 16:05:15 +0800
Message-Id: <20200829080517.22182-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCnbuQ9DEpfb+9KAg--.45056S4
X-Coremail-Antispam: 1UD129KBjvdXoWrtr4fWr48AFWrZr18XFWfAFb_yoWDGFX_G3
 48Ww4fKw42qr1agr4UJrZ8Aw4Utrn7C3Z5C3yDK3WUJ3W5Wayqv3s8JF9Yy3W7C3ykGrW7
 WFyqvrWfCw1UujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbc8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
 wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
 vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
 87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
 8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
 Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
 xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
 aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
 6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0EBlZdtPrBDAA0sx
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
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

When request_region() on chip->res_mc_indir fails,
chip->res_mc_base should be freed to prevent memleak.

Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 sound/isa/opti9xx/opti92x-ad1848.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 881d3b5711d2..06ba18d1737c 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -679,8 +679,11 @@ static int snd_opti9xx_read_check(struct snd_opti9xx *chip)
 #else	/* OPTi93X */
 	chip->res_mc_indir = request_region(chip->mc_indir_index, 2,
 					    "OPTi93x MC");
-	if (chip->res_mc_indir == NULL)
+	if (chip->res_mc_indir == NULL) {
+		release_and_free_resource(chip->res_mc_base);
+		chip->res_mc_base = NULL;
 		return -EBUSY;
+	}
 
 	spin_lock_irqsave(&chip->lock, flags);
 	outb(chip->password, chip->mc_base + chip->pwd_reg);
-- 
2.17.1

