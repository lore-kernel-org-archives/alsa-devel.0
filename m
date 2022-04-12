Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABF6C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:38:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 068CD1A7E;
	Tue, 12 Apr 2022 12:37:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 068CD1A7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759903;
	bh=ImkGrqioPwSEWOdEkPMxFXmNsfgaXQIJwncREgf/Bls=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gJ3fIzBC/CVCL5baUcg2BZIXXacVI7oqoxvfI58YkWBGcemzzOARzH5cxyWH2dO3X
	 nx2iWKeHfIBdvMuCCSkVN1ihgGZbAJpGkzOzjOVaraYMpUf/x7qOmPPWyMfgi3C1q8
	 i3IbSwa/dZC/DNyLbOPF4eq0jp+4vYgCTOBUt5b0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E170F8061C;
	Tue, 12 Apr 2022 12:27:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C6F5F805F9; Tue, 12 Apr 2022 12:27:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA1C8F80543
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA1C8F80543
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="foXIayOm"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="eV7QH4DM"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BAF1B1FD12
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiXeiCdRYMWCZdwLpZtcxju1lZt5yXk7EN3oMD1p5pc=;
 b=foXIayOmMVOx2sGb9JJN6YyX/bdOF2qrSpklFs4fRAk2769oTAsX5EOR6gfP8lHPKSa4wJ
 0ggwxJqxad+nXvZiLQwtkyHyMKPB+/JprrEoWBu1E6Hxcb5zrG5QGGrMQnSRh8EToYPEFT
 K7OepJE2y0JyjG1/eKPeVo1zF48OUMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xiXeiCdRYMWCZdwLpZtcxju1lZt5yXk7EN3oMD1p5pc=;
 b=eV7QH4DMcJX2YXDx93eQ9ZjX4rwYS194JEi3piujP6v5emsuTwZw/QrVR6jTQd19N17g6K
 ZIsTiZFVvym9X1DQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id B6782A3B83;
 Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 29/39] ALSA: lola: Fix the missing snd_card_free() call at
 probe error
Date: Tue, 12 Apr 2022 12:26:26 +0200
Message-Id: <20220412102636.16000-30-tiwai@suse.de>
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

Fixes: 098fe3d6e775 ("ALSA: lola: Allocate resources with device-managed APIs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/lola/lola.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index 5269a1d396a5..1aa30e90b86a 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -637,8 +637,8 @@ static int lola_create(struct snd_card *card, struct pci_dev *pci, int dev)
 	return 0;
 }
 
-static int lola_probe(struct pci_dev *pci,
-		      const struct pci_device_id *pci_id)
+static int __lola_probe(struct pci_dev *pci,
+			const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
@@ -687,6 +687,12 @@ static int lola_probe(struct pci_dev *pci,
 	return 0;
 }
 
+static int lola_probe(struct pci_dev *pci,
+		      const struct pci_device_id *pci_id)
+{
+	return snd_card_free_on_error(&pci->dev, __lola_probe(pci, pci_id));
+}
+
 /* PCI IDs */
 static const struct pci_device_id lola_ids[] = {
 	{ PCI_VDEVICE(DIGIGRAM, 0x0001) },
-- 
2.31.1

