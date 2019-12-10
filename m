Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B2C43603
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:38:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B044E206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 06:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B044E206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 109A016A5;
	Tue, 10 Dec 2019 07:37:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 109A016A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575959904;
	bh=kfEeurP6tFOQHMWjDhmlo/Eqtz+HyqbBf30BKHSBlnw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KOf9ZURcpLR1i2sy1hyF160GsGJ/23LG/s647Ct3PrtqBfuiz8k4qCstpyhE1vE1T
	 N2N1eJBRy3L8rWmr6/MzBJiVo1KjjvjUfOL8hB67lAciVIeGG6mX53NNxHZ3Fwj3tg
	 6/X+MYHVVp2vkEyU8U4Dts8NbtuOm8x2GPd/YfAI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A78A9F802E0;
	Tue, 10 Dec 2019 07:35:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16059F802DD; Tue, 10 Dec 2019 07:35:12 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5A4C1F80249
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:35:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A4C1F80249
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 52610AFAE
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:34:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:34:04 +0100
Message-Id: <20191210063454.31603-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210063454.31603-1-tiwai@suse.de>
References: <20191210063454.31603-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 05/55] ALSA: au88x0: Support PCM sync_stop
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
operation.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 782333c90223..c9e0159af2b1 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -202,6 +202,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 		goto irq_out;
 	}
 	chip->irq = pci->irq;
+	card->sync_irq = chip->irq;
 
 	pci_set_master(pci);
 	// End of PCI setup.
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
