Return-Path: <SRS0=Fseo=P4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E4AC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:32:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E836134F
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Nov 2021 22:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27E836134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D2D716BE;
	Tue,  9 Nov 2021 23:31:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D2D716BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636497167;
	bh=nj1FTzjwkeR7B4FSSl63i4tJKlVTSuNv7GNf3Bc4GDw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vAg4t8e8OrMVJMPPa7tm4jN2y58NPgSySURYbNajSAw3GViEWfe6joOzqCUQhmK8r
	 Qux3sf5jUW0t8DGKFc8ilmn2M/r3yIgDyFO5CskIs7L7U2sLcanTkyrlrz0PK6UcJH
	 mxMMxIM2WN7n4OWd5znEJ/c2kVi1sV+dMqq+j0I4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0EFF3F804FB;
	Tue,  9 Nov 2021 23:24:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15C0DF80544; Tue,  9 Nov 2021 23:24:54 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 200CAF804FB
 for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2021 23:24:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 200CAF804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cGMWS8wS"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EF8F61B46;
 Tue,  9 Nov 2021 22:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496685;
 bh=nj1FTzjwkeR7B4FSSl63i4tJKlVTSuNv7GNf3Bc4GDw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cGMWS8wSeVgthJx9F4VRgVXWmn2a4MfcKdOFCU9zN6iKcE05zhdfSQfIe8cR7Tt5r
 JYlC/6T2fT/nV+yyCk8tuMAPFiP3vOM7Va95APnqwO52/eqgO3qT5sg3YOIjKSXYnh
 yJEV+ypbvutGWMGbs0BaIPKUdE36Hcmkci4EzbcOwYoU2i8or5ajvuKWXbEqwOe3FR
 YaKNsnkb4JX4zWFTqtMsXbE7UqHUDLPAPW31Q8yCvqGXDj/HT9XxFiSsvTNQ1FIMVr
 CCd6hAr+Up8KirgnAwlx14gXCyhxon9SE0xHhEpzHKs/X42yiJCt/+JlXbSclU1Yn0
 wKEwphIJy6jZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 11/12] ALSA: gus: fix null pointer dereference on
 pointer block
Date: Tue,  9 Nov 2021 17:24:25 -0500
Message-Id: <20211109222426.1236575-11-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109222426.1236575-1-sashal@kernel.org>
References: <20211109222426.1236575-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>, tiwai@suse.com,
 Chengfeng Ye <cyeaa@connect.ust.hk>
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

From: Chengfeng Ye <cyeaa@connect.ust.hk>

[ Upstream commit a0d21bb3279476c777434c40d969ea88ca64f9aa ]

The pointer block return from snd_gf1_dma_next_block could be
null, so there is a potential null pointer dereference issue.
Fix this by adding a null check before dereference.

Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
Link: https://lore.kernel.org/r/20211024104611.9919-1-cyeaa@connect.ust.hk
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/isa/gus/gus_dma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/isa/gus/gus_dma.c b/sound/isa/gus/gus_dma.c
index 36c27c8323601..2e27cd3427c87 100644
--- a/sound/isa/gus/gus_dma.c
+++ b/sound/isa/gus/gus_dma.c
@@ -141,6 +141,8 @@ static void snd_gf1_dma_interrupt(struct snd_gus_card * gus)
 	}
 	block = snd_gf1_dma_next_block(gus);
 	spin_unlock(&gus->dma_lock);
+	if (!block)
+		return;
 	snd_gf1_dma_program(gus, block->addr, block->buf_addr, block->count, (unsigned short) block->cmd);
 	kfree(block);
 #if 0
-- 
2.33.0

