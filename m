Return-Path: <SRS0=g50q=C3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF3C43465
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:14:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB32208DB
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2020 02:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CfwHQFqv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="emvbVLbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB32208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECF9E1789;
	Fri, 18 Sep 2020 04:13:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECF9E1789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600395265;
	bh=LJr5lMTFye2vxGi0Lfw2VYCci9SKwWK0bBAKI4s7QuI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CfwHQFqvgBzRUYa4eI4Zk/QR1sKMajx3FVf2gKPH8GBlc8XjlKZuNrMtsk3/Qgcsy
	 jG0Jf/lWt0TP8yssMhd5oQA7DDIBqjza6GN2Hy88vswln3swJD6Q9yYMUYqErZDY07
	 Do5ojD3CkiEkx+On+zJ3J7WfxR4x8u2eLdcFKRvI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E41C7F8012D;
	Fri, 18 Sep 2020 04:13:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9738F800E8; Fri, 18 Sep 2020 04:13:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05094F800E8
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2020 04:13:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05094F800E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="emvbVLbN"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B8F5A208DB;
 Fri, 18 Sep 2020 02:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600395189;
 bh=LJr5lMTFye2vxGi0Lfw2VYCci9SKwWK0bBAKI4s7QuI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=emvbVLbN+tImPAJjNyFkGWgm3ExfE5FJ7cGKAdZdHeG3/Ufx/WocLX9FBVEa6pPG5
 urPvcyAeriQKGZc/6JY3fC0VwvYH5eISIjimv2s5+RSsYQNBO+XhFOub/yxRnTBW0u
 zfpKcthI2XziGtiZpY21543tBAA7bDq8x0TABWLM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 041/127] ALSA: hda: Clear RIRB status before
 reading WP
Date: Thu, 17 Sep 2020 22:10:54 -0400
Message-Id: <20200918021220.2066485-41-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021220.2066485-1-sashal@kernel.org>
References: <20200918021220.2066485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Viswanath L <viswanathl@nvidia.com>, Takashi Iwai <tiwai@suse.de>,
 alsa-devel@alsa-project.org, Mohan Kumar <mkumard@nvidia.com>,
 Sasha Levin <sashal@kernel.org>
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

From: Mohan Kumar <mkumard@nvidia.com>

[ Upstream commit 6d011d5057ff88ee556c000ac6fe0be23bdfcd72 ]

RIRB interrupt status getting cleared after the write pointer is read
causes a race condition, where last response(s) into RIRB may remain
unserviced by IRQ, eventually causing azx_rirb_get_response to fall
back to polling mode. Clearing the RIRB interrupt status ahead of
write pointer access ensures that this condition is avoided.

Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
Signed-off-by: Viswanath L <viswanathl@nvidia.com>
Link: https://lore.kernel.org/r/1580983853-351-1-git-send-email-viswanathl@nvidia.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_controller.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index fa261b27d8588..8198d2e53b7df 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1169,16 +1169,23 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
 		if (snd_hdac_bus_handle_stream_irq(bus, status, stream_update))
 			active = true;
 
-		/* clear rirb int */
 		status = azx_readb(chip, RIRBSTS);
 		if (status & RIRB_INT_MASK) {
+			/*
+			 * Clearing the interrupt status here ensures that no
+			 * interrupt gets masked after the RIRB wp is read in
+			 * snd_hdac_bus_update_rirb. This avoids a possible
+			 * race condition where codec response in RIRB may
+			 * remain unserviced by IRQ, eventually falling back
+			 * to polling mode in azx_rirb_get_response.
+			 */
+			azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
 			active = true;
 			if (status & RIRB_INT_RESPONSE) {
 				if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
 					udelay(80);
 				snd_hdac_bus_update_rirb(bus);
 			}
-			azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
 		}
 	} while (active && ++repeat < 10);
 
-- 
2.25.1

