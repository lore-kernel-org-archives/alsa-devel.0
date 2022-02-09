Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367ECC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Feb 2022 08:20:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4C4B1831;
	Wed,  9 Feb 2022 09:19:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4C4B1831
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644394818;
	bh=hsiz7mEWy8JMkhaec1KZJGTEIr5cChnfF09GLTp9zLY=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OlOt7S4BbEn0CBp2eGRhElE+XPHdOYfmy3IppDT4/EFtzWI28VzTcdJY+Za+lwq5A
	 eRhU/7U6KDqVYDaRPxyqoZ18LEu+hP2j0T9q7UBGuGghNGC9/PJZD+IcivMc1b9ohT
	 CnIvG+qRhN8LsojM8TljNg+VjC0+HYCKwp6JNJ10=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F34EF8014B;
	Wed,  9 Feb 2022 09:19:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADDF8F8016A; Wed,  9 Feb 2022 09:19:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D960F800ED
 for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2022 09:19:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D960F800ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="Mv5GXhd6"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="gNs4UHc6"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id F3CD11F390
 for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2022 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644394755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wpn4RFeUdoJrW+Irg/TI47v9TP9/LOIfCeGcX52FeT4=;
 b=Mv5GXhd6YdGRTPjZK1iXaqDKuf1KjDq0U27A625BUxVElenFuQjUU9t4HxcjiRJtYBp/Xz
 3sKgfDuHWIFQL3797r79VopJVydQzUoWuIjD/VarcyrhOLIVqYMNiUVJZ7FrsaWgQRGgqQ
 7o8E1m24iL5ojKTng3K5NPp/aCawo6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644394755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Wpn4RFeUdoJrW+Irg/TI47v9TP9/LOIfCeGcX52FeT4=;
 b=gNs4UHc6/PnPfBqYbUiYZS6Y107RWixW4YqMScqE7IB23N5AFhoSm9q3bWNc7y8Y1tNh0J
 eV8il6TQd5E5WnBA==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id E2297A3B81;
 Wed,  9 Feb 2022 08:19:14 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Fix driver index handling at re-binding
Date: Wed,  9 Feb 2022 09:19:12 +0100
Message-Id: <20220209081912.20687-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
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

HD-audio driver handles the multiple instances and keeps the static
index that is incremented at each probe.  This becomes a problem when
user tries to re-bind the device via sysfs multiple times; as the
device index isn't cleared unlike rmmod case, it points to the next
element at re-binding, and eventually later you can't probe any more
when it reaches to SNDRV_CARDS_MAX (usually 32).

This patch is an attempt to improve the handling at rebinding.
Instead of a static device index, now we keep a bitmap and assigns to
the first zero bit position.  At the driver remove, in return, the
bitmap slot is cleared again, so that it'll be available for the next
probe.

Reported-by: Alexander Sergeyev <sergeev917@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4b0338c4c543..a2922233e85f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2064,14 +2064,16 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.position_check = azx_position_check,
 };
 
+static DECLARE_BITMAP(probed_devs, SNDRV_CARDS);
+
 static int azx_probe(struct pci_dev *pci,
 		     const struct pci_device_id *pci_id)
 {
-	static int dev;
 	struct snd_card *card;
 	struct hda_intel *hda;
 	struct azx *chip;
 	bool schedule_probe;
+	int dev;
 	int err;
 
 	if (pci_match_id(driver_denylist, pci)) {
@@ -2079,10 +2081,11 @@ static int azx_probe(struct pci_dev *pci,
 		return -ENODEV;
 	}
 
+	dev = find_first_zero_bit(probed_devs, SNDRV_CARDS);
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
-		dev++;
+		set_bit(dev, probed_devs);
 		return -ENOENT;
 	}
 
@@ -2149,7 +2152,7 @@ static int azx_probe(struct pci_dev *pci,
 	if (schedule_probe)
 		schedule_delayed_work(&hda->probe_work, 0);
 
-	dev++;
+	set_bit(dev, probed_devs);
 	if (chip->disabled)
 		complete_all(&hda->probe_wait);
 	return 0;
@@ -2372,6 +2375,7 @@ static void azx_remove(struct pci_dev *pci)
 		cancel_delayed_work_sync(&hda->probe_work);
 		device_lock(&pci->dev);
 
+		clear_bit(chip->dev_index, probed_devs);
 		pci_set_drvdata(pci, NULL);
 		snd_card_free(card);
 	}
-- 
2.34.1

