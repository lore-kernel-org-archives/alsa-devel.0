Return-Path: <SRS0=7vEg=22=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8DEC33C8C
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:10:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA73B2085B
	for <alsa-devel@archiver.kernel.org>; Sun,  5 Jan 2020 15:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uqiSZbUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA73B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC35317E9;
	Sun,  5 Jan 2020 16:09:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC35317E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578237040;
	bh=OUXVGxTqGxcfvhKS+b/euBC693aGlO7yP3YT6CIAzIs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uqiSZbULZvgXkEkzKVe2dEdYcibhkwV8nl7VyZMF2u4jMPZ6On+5j51aZCL7Py4ep
	 NvodSH9h7sBrjGvNPgpcmt+Z+7DHrZ5HmFr8lzeMkpuCrhuzK8dNSXt/bPbJAGqiRW
	 O4v+Jo867DRXedi3YzyF6QjhPAG1m+8JLssmwBxU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF8FDF80406;
	Sun,  5 Jan 2020 15:50:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2140CF8036E; Sun,  5 Jan 2020 15:49:23 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43502F802A0
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 15:48:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43502F802A0
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 47E7AB2A3
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2020 14:48:33 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Sun,  5 Jan 2020 15:47:49 +0100
Message-Id: <20200105144823.29547-35-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200105144823.29547-1-tiwai@suse.de>
References: <20200105144823.29547-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 34/68] ALSA: es1938: More constifications
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

Apply const prefix to the static register table and its callers.

Just for minor optimization and no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/es1938.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 8336b20fbafc..b4a0adf7451c 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1420,7 +1420,7 @@ static void snd_es1938_chip_init(struct es1938 *chip)
  * PM support
  */
 
-static unsigned char saved_regs[SAVED_REG_SIZE+1] = {
+static const unsigned char saved_regs[SAVED_REG_SIZE+1] = {
 	0x14, 0x1a, 0x1c, 0x3a, 0x3c, 0x3e, 0x36, 0x38,
 	0x50, 0x52, 0x60, 0x61, 0x62, 0x63, 0x64, 0x68,
 	0x69, 0x6a, 0x6b, 0x6d, 0x6e, 0x6f, 0x7c, 0x7d,
@@ -1432,7 +1432,8 @@ static int es1938_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct es1938 *chip = card->private_data;
-	unsigned char *s, *d;
+	const unsigned char *s;
+	unsigned char *d;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
@@ -1454,7 +1455,8 @@ static int es1938_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct es1938 *chip = card->private_data;
-	unsigned char *s, *d;
+	const unsigned char *s;
+	unsigned char *d;
 
 	if (request_irq(pci->irq, snd_es1938_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
