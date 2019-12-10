Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA35C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:46:54 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 041D7206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041D7206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BCF916B5;
	Tue, 10 Dec 2019 07:46:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BCF916B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575960412;
	bh=pmSRaLBFNdnQSB79JbPjIG0CjJHCoP1M8CEyUcgDILo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MJyuPaIGdH8xpx2ba/scJ50nUD7CXvNt4nbreRPnv8yusunst0B8dVasyciLZyGNP
	 UltiKY4vCxdt/GWtRizRXe8Wumnn8xT6BQpn0GmJP6Hn9gYkkmiTHWGgNqObIgrESn
	 aZHBDAnwSnLMuZ3zbssoXlEKSjW+yL8XEzRCwC6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87350F8027C;
	Tue, 10 Dec 2019 07:36:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C25F9F802F7; Tue, 10 Dec 2019 07:35:34 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5EC6F80259
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:35:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5EC6F80259
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E3B3EB1F7
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:34:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:34:16 +0100
Message-Id: <20191210063454.31603-18-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210063454.31603-1-tiwai@suse.de>
References: <20191210063454.31603-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 17/55] ALSA: ens137x: Support PCM sync_stop
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The driver invokes snd_pcm_period_elapsed() simply from the interrupt
handler.  Set card->sync_irq for enabling the missing sync_stop PCM
operation, as well as removing the superfluous synchronize_irq()
call.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ens1370.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index f69555c95263..378141aa7c7d 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1888,8 +1888,6 @@ static int snd_ensoniq_free(struct ensoniq *ensoniq)
 	outl(0, ES_REG(ensoniq, CONTROL));	/* switch everything off */
 	outl(0, ES_REG(ensoniq, SERIAL));	/* clear serial interface */
 #endif
-	if (ensoniq->irq >= 0)
-		synchronize_irq(ensoniq->irq);
 	pci_set_power_state(ensoniq->pci, PCI_D3hot);
       __hw_end:
 #ifdef CHIP1370
@@ -1990,7 +1988,6 @@ static void snd_ensoniq_chip_init(struct ensoniq *ensoniq)
 	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
 	outb(0x00, ES_REG(ensoniq, UART_RES));
 	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
-	synchronize_irq(ensoniq->irq);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -2074,6 +2071,7 @@ static int snd_ensoniq_create(struct snd_card *card,
 		return -EBUSY;
 	}
 	ensoniq->irq = pci->irq;
+	card->sync_irq = ensoniq->irq;
 #ifdef CHIP1370
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, &pci->dev,
 				16, &ensoniq->dma_bug) < 0) {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
