Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA15C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35FD62076E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mSA31Vp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FD62076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CB741660;
	Mon,  3 Aug 2020 16:40:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CB741660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596465659;
	bh=WDmrYolz2PwS4yxkjbUZRfYVntTjmKfYhgUZ0xw7UTA=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mSA31Vp2RO+/jPDbTdp3UnADZVNzSEGcuQuroeRu+UzSZU/CvlEUuz4kCiplwbolc
	 e4Fq3wbXq7Nml0IR902qoc9fBkNhgYaEmc5UCKtH2tFBWzSPjcjKk4f5nA9RTNjvsN
	 35XPiolB/9u1G8wBPPmDb+15WrrZEZVq8lC8hzu0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 219F6F801F7;
	Mon,  3 Aug 2020 16:40:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3913BF80218; Mon,  3 Aug 2020 16:40:07 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9910F800B7
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 16:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9910F800B7
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2C3C4B607
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 14:40:15 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: echoaduio: Drop superfluous volatile modifier
Date: Mon,  3 Aug 2020 16:39:58 +0200
Message-Id: <20200803143958.24324-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

The dsp_registers field of struct echoaduio has the volatile modifier,
but it's basically superfluous; the field is accessed only for the
base pointer of readl() and writel(), hence marking with __iomem alone
should suffice.  OTOH, having the volatile prefix causes a compile
warning like:
  sound/pci/echoaudio/echoaudio.c:1878:14: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]

So it's better to drop this superfluous modifier.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/echoaudio/echoaudio.c | 3 +--
 sound/pci/echoaudio/echoaudio.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 6aeb99aa2414..1b7a67ccabce 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1950,8 +1950,7 @@ static int snd_echo_create(struct snd_card *card,
 		snd_echo_free(chip);
 		return -EBUSY;
 	}
-	chip->dsp_registers = (volatile u32 __iomem *)
-		ioremap(chip->dsp_registers_phys, sz);
+	chip->dsp_registers = ioremap(chip->dsp_registers_phys, sz);
 	if (!chip->dsp_registers) {
 		dev_err(chip->card->dev, "ioremap failed\n");
 		snd_echo_free(chip);
diff --git a/sound/pci/echoaudio/echoaudio.h b/sound/pci/echoaudio/echoaudio.h
index 30c640931f1e..0afe13f7b6e5 100644
--- a/sound/pci/echoaudio/echoaudio.h
+++ b/sound/pci/echoaudio/echoaudio.h
@@ -419,7 +419,7 @@ struct echoaudio {
 	short asic_code;		/* Current ASIC code */
 	u32 comm_page_phys;			/* Physical address of the
 						 * memory seen by DSP */
-	volatile u32 __iomem *dsp_registers;	/* DSP's register base */
+	u32 __iomem *dsp_registers;		/* DSP's register base */
 	u32 active_mask;			/* Chs. active mask or
 						 * punks out */
 #ifdef CONFIG_PM_SLEEP
-- 
2.16.4

