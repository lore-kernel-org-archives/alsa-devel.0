Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CD0C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Nov 2022 06:37:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEBB01DE;
	Mon,  7 Nov 2022 07:36:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEBB01DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667803035;
	bh=8wksGgRGECuPE7sGPMjcEJqwB7ajoV4ChCbWxiYcI9o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SEhpPIduoRgH2bqM43W6+0yyExB7YX1QfQhgXAuC7RvYTubvRIBxWSVplEIi2VieY
	 rPTq6vObZdddmFoTd9maetDepYkflEE+Z0qVz6/dQkTAAntHgoBZ2wx0xPYPZfdaGT
	 FgJ5OZUgXTbb/KsNggKpiU3Z+FcTEAUMtigt0aYM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D3C4F8024C;
	Mon,  7 Nov 2022 07:36:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F52FF80116; Mon,  7 Nov 2022 07:36:23 +0100 (CET)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E77CCF80116
 for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2022 07:36:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E77CCF80116
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R961e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0VU7DbWG_1667802962; 
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0VU7DbWG_1667802962) by smtp.aliyun-inc.com;
 Mon, 07 Nov 2022 14:36:11 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: jayakumar.alsa@gmail.com
Subject: [PATCH] ALSA: cs5535audio: Remove the redundant assignment
Date: Mon,  7 Nov 2022 14:35:54 +0800
Message-Id: <20221107063554.17933-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, tiwai@suse.com
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

Variable 'desc_addr' set but not used.

sound/pci/cs5535audio/cs5535audio_pcm.c:113:12: warning: variable 'desc_addr' set but not used.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2739
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/pci/cs5535audio/cs5535audio_pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audio/cs5535audio_pcm.c
index 0db24cc4d916..9c88e99e3750 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -110,7 +110,7 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 					 unsigned int period_bytes)
 {
 	unsigned int i;
-	u32 addr, desc_addr, jmpprd_addr;
+	u32 addr, jmpprd_addr;
 	struct cs5535audio_dma_desc *lastdesc;
 
 	if (periods > CS5535AUDIO_MAX_DESCRIPTORS)
@@ -131,14 +131,12 @@ static int cs5535audio_build_dma_packets(struct cs5535audio *cs5535au,
 	/* the u32 cast is okay because in snd*create we successfully told
 	   pci alloc that we're only 32 bit capable so the upper will be 0 */
 	addr = (u32) substream->runtime->dma_addr;
-	desc_addr = (u32) dma->desc_buf.addr;
 	for (i = 0; i < periods; i++) {
 		struct cs5535audio_dma_desc *desc =
 			&((struct cs5535audio_dma_desc *) dma->desc_buf.area)[i];
 		desc->addr = cpu_to_le32(addr);
 		desc->size = cpu_to_le16(period_bytes);
 		desc->ctlreserved = cpu_to_le16(PRD_EOP);
-		desc_addr += sizeof(struct cs5535audio_dma_desc);
 		addr += period_bytes;
 	}
 	/* we reserved one dummy descriptor at the end to do the PRD jump */
-- 
2.20.1.7.g153144c

