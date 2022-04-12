Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78787C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:38:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C72C81A96;
	Tue, 12 Apr 2022 12:37:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C72C81A96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759916;
	bh=FbVJHItLsICAKfVRl+4pAOgtMEoggS7/eqn5Nud/CXU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNYHEje4AYUw2q2xI1qePaOCKwne7avT1G6fyWAi2votoicbivgxGup+qrvnb7UY0
	 bpoy3laDEd2Poq7Z93vc8nRz9y3jzIK0iwb7pJrSLE35zwS6N09+WG6Bm1TfrUv3HL
	 VdSqkA7rVYQyLWqrOw+LWw0AAoLCT7/ngXwOGjoc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1646FF80622;
	Tue, 12 Apr 2022 12:27:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31A23F805F8; Tue, 12 Apr 2022 12:27:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3EACCF80542
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3EACCF80542
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="d+l/CtWv"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="tgwqiZVF"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 27BBD1FD16
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03dgr07nhG4Rn1cIBF5pDGEidG7Jn4qc5FrK0AHa2ig=;
 b=d+l/CtWvVSN7dW7kC0kfMG8ZGCtl8ldy6N24KaFQ7IR4UhR14jaRt4nSz1eI7dFYBCsHGi
 8i8DOGWx7sAgVWDgDtEVoNH+OmdY3MNGYf2QpCXAvcqoohxjJfNcluBWhB/K6Ov9ynhGpG
 tAijhrfCwGGzukp+91YuAY4o3ComSDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03dgr07nhG4Rn1cIBF5pDGEidG7Jn4qc5FrK0AHa2ig=;
 b=tgwqiZVFGscLGSFCxZzIbMgzj3KFGJPKn7qnKQSzQR8L511E1WjQoCXjXo8RxMwMt8XKMO
 Q+070LUO7uhXu0Dg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 17EC7A3B82;
 Tue, 12 Apr 2022 10:26:45 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 39/39] ALSA: nm256: Don't call card private_free at probe
 error path
Date: Tue, 12 Apr 2022 12:26:36 +0200
Message-Id: <20220412102636.16000-40-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412102636.16000-1-tiwai@suse.de>
References: <20220412102636.16000-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The card destructor of nm256 driver does merely stopping the running
streams, and it's superfluous for the probe error handling.  Moreover,
calling this via the previous devres change would lead to another
problem due to the reverse call order.

This patch moves the setup of the private_free callback after the card
registration, so that it can be used only after fully set up.

Fixes: c19935f04784 ("ALSA: nm256: Allocate resources with device-managed APIs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/nm256/nm256.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index c9c178504959..f99a1e96e923 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1573,7 +1573,6 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci)
 	chip->coeffs_current = 0;
 
 	snd_nm256_init_chip(chip);
-	card->private_free = snd_nm256_free;
 
 	// pci_set_master(pci); /* needed? */
 	return 0;
@@ -1680,6 +1679,7 @@ static int snd_nm256_probe(struct pci_dev *pci,
 	err = snd_card_register(card);
 	if (err < 0)
 		return err;
+	card->private_free = snd_nm256_free;
 
 	pci_set_drvdata(pci, card);
 	return 0;
-- 
2.31.1

