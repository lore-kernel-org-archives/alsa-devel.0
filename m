Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3C3C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:35:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3DD751906;
	Tue, 12 Apr 2022 12:34:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3DD751906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759717;
	bh=7LPNR6AKFc7mv87Ep768tv2/rl9MHd7CK+0qfeGUmIg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EkA5/+pbaJgG3St6Dm5idF2tLeORgvIVPz2BFvr+fTlks/hdPDwkmvgTnv+eC/0W/
	 pwoYog3cqzEWCddax3zeRlN1tJdU2Q4DO1Ncw6CEr5EDCIhZnYMxEl/JZNCKLOj4C3
	 T8KTJThQBMB9UjXlfw9C9ZrGou2n+DSZCxJB42v8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99640F805F2;
	Tue, 12 Apr 2022 12:27:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED78EF805D5; Tue, 12 Apr 2022 12:27:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 804B6F80534
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 804B6F80534
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="YXnkrg9e"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="eaFJ+j8z"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 958781FD0E
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CUdK9E+J+FHROcXAcHSmVQsgvYI2N0qjgr12mGva1+I=;
 b=YXnkrg9eQJrjwdfLevxCrpbEoroo4KZWbmUDnt3cilFy0lWyBzD+h+/ug0gN0K3FYWrjhK
 FWPjP3A/ixciCS6sVPu4IBN2E3O2QRlKQ78CvDBZxIqGad0BeBLaPxJ8BK71XC/IVTu7I/
 /0eXtvhavzb+V5UK01xzCU8p7gZFq+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CUdK9E+J+FHROcXAcHSmVQsgvYI2N0qjgr12mGva1+I=;
 b=eaFJ+j8zSaNnNerqM2vYGLUK5wOlS9Qwb1djp6K+kgeYRqyNbCElVV5pNVzrytBJ85GmBm
 2H4tsLBXVPzqEXCA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 91C72A3B87;
 Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 24/39] ALSA: sonicvibes: Fix the missing snd_card_free() call
 at probe error
Date: Tue, 12 Apr 2022 12:26:21 +0200
Message-Id: <20220412102636.16000-25-tiwai@suse.de>
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

The previous cleanup with devres may lead to the incorrect release
orders at the probe error handling due to the devres's nature.  Until
we register the card, snd_card_free() has to be called at first for
releasing the stuff properly when the driver tries to manage and
release the stuff via card->private_free().

This patch fixes it by calling snd_card_free() on the error from the
probe callback using a new helper function.

Fixes: 2ca6cbde6ad7 ("ALSA: sonicvibes: Allocate resources with device-managed APIs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/sonicvibes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index c8c49881008f..f91cbf6eeca0 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1387,8 +1387,8 @@ static int snd_sonicvibes_midi(struct sonicvibes *sonic,
 	return 0;
 }
 
-static int snd_sonic_probe(struct pci_dev *pci,
-			   const struct pci_device_id *pci_id)
+static int __snd_sonic_probe(struct pci_dev *pci,
+			     const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
@@ -1459,6 +1459,12 @@ static int snd_sonic_probe(struct pci_dev *pci,
 	return 0;
 }
 
+static int snd_sonic_probe(struct pci_dev *pci,
+			   const struct pci_device_id *pci_id)
+{
+	return snd_card_free_on_error(&pci->dev, __snd_sonic_probe(pci, pci_id));
+}
+
 static struct pci_driver sonicvibes_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_sonic_ids,
-- 
2.31.1

