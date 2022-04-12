Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8024C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:30:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 066AA1893;
	Tue, 12 Apr 2022 12:29:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 066AA1893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759403;
	bh=7zCoQDPKy6SJJr6nZmoqJvMODzjqfvGKNoJK8s8TEBw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ReszIpO3z/iQAxGAbMZpBITkFVLS8su+nOJk3IGhqp8mAmLoYO0Fkgya6FWwMFuGq
	 dQc/9bBCI9fUlF13YZNlMl9UqFy4KgxTh7B3xwFNVGOvXT3P0+gAhz3qVfO8xAzQo5
	 Vm0Z7GSDyVx8ZYyLfMjSwGe4J9KisGwZX5Wrocb0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 876D6F80570;
	Tue, 12 Apr 2022 12:27:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8FD4F80567; Tue, 12 Apr 2022 12:27:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F624F804FD
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F624F804FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="MKG6Pn9V"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="Pi4iSzrc"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5C8F61FCFE
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oSnYmTO2wDNIX0XradbYUN9BcavbTS3O1rUNBIOjCA=;
 b=MKG6Pn9VXM8chACHTBQOG3lArcHnB76jWPTwiRmS6RdDgwpD6hl0cmzuRYw7oEMX5Hupo/
 1d7sQnKxRu5mAxdjMwOklHiP8sd3QObowWrPpBxsUI+hY4HzdSKKvAgzO0arERWniT+3Bz
 y0MJG572KdQsTv8cu/T2Of1uyRm9+IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1oSnYmTO2wDNIX0XradbYUN9BcavbTS3O1rUNBIOjCA=;
 b=Pi4iSzrcYRNv4MdYwaLoYer2JoHrxejvVScDk5SazUcz8hhg8aPNElfWn5c6Swqbi6oChR
 im0uSho+D8p7hpCQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 5861BA3B82;
 Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/39] ALSA: au88x0: Fix the missing snd_card_free() call at
 probe error
Date: Tue, 12 Apr 2022 12:26:04 +0200
Message-Id: <20220412102636.16000-8-tiwai@suse.de>
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

Fixes: e44b5b440609 ("ALSA: au88x0: Allocate resources with device-managed APIs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 342ef2a6655e..eb234153691b 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -193,7 +193,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci)
 
 // constructor -- see "Constructor" sub-section
 static int
-snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+__snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct snd_card *card;
@@ -310,6 +310,12 @@ snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	return 0;
 }
 
+static int
+snd_vortex_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	return snd_card_free_on_error(&pci->dev, __snd_vortex_probe(pci, pci_id));
+}
+
 // pci_driver definition
 static struct pci_driver vortex_driver = {
 	.name = KBUILD_MODNAME,
-- 
2.31.1

