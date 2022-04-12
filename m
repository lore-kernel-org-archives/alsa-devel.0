Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CF3C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 10:36:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A907B1A00;
	Tue, 12 Apr 2022 12:35:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A907B1A00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649759763;
	bh=cw6cyQiAOI1f5WdJ6HKpZ5o+o16YfgCIIEyHqppGlN4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZ8rtCteNchxTpIAlwD/ewau7AYa2C98hBCgQ3TjL4I+8CT2Aq72FMzBbuP/lCiHM
	 fDogqf1PzCYahmITCac0A5W+A9OnsB3wxGIE/i8hDlSMiyw+jVc+qy01DWhw7RPj/k
	 KCL1jVBpkzTSW1Z1Ov1cgQfKr+T0PGWxTO2hbA44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12440F80544;
	Tue, 12 Apr 2022 12:27:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6942DF80537; Tue, 12 Apr 2022 12:27:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B95D1F80539
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 12:26:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B95D1F80539
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="f0OF4FOU"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="/aL4Se4w"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 92B1C1FD0D
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649759204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5n2ayn9s6NGsJYdLXtRUgZruzVN1K0m3AVhEHXupUM=;
 b=f0OF4FOUAX8alzm4G3GJsAy3AJqMjhlNYGYlmU0UyBiL0jEtTMBRTupHdUGv3QW/BaC2rF
 krZh7YoAh4SYD7Z5DjfqkyzzcwbBjzYtHBfluKIH5huSIF+huWJK8n+CfysvT7t4e0EsvF
 Q8qfeKiHLmwi0J2RQ9x/fHkNVUmISBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649759204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5n2ayn9s6NGsJYdLXtRUgZruzVN1K0m3AVhEHXupUM=;
 b=/aL4Se4w+WrPlF4FP1DloyqyTpkYAEqXNEtFh+WGHXNUwdnHRZaptIdXvXnkNk0vZ6nFpb
 eFpe/ZSpHreADwDw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 8F284A3B83;
 Tue, 12 Apr 2022 10:26:44 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 23/39] ALSA: rme96: Fix the missing snd_card_free() call at
 probe error
Date: Tue, 12 Apr 2022 12:26:20 +0200
Message-Id: <20220412102636.16000-24-tiwai@suse.de>
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

Fixes: df06df7cc997 ("ALSA: rme96: Allocate resources with device-managed APIs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme96.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 8fc811504920..bccb7e0d3d11 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -2430,8 +2430,8 @@ static void snd_rme96_card_free(struct snd_card *card)
 }
 
 static int
-snd_rme96_probe(struct pci_dev *pci,
-		const struct pci_device_id *pci_id)
+__snd_rme96_probe(struct pci_dev *pci,
+		  const struct pci_device_id *pci_id)
 {
 	static int dev;
 	struct rme96 *rme96;
@@ -2498,6 +2498,12 @@ snd_rme96_probe(struct pci_dev *pci,
 	return 0;
 }
 
+static int snd_rme96_probe(struct pci_dev *pci,
+			   const struct pci_device_id *pci_id)
+{
+	return snd_card_free_on_error(&pci->dev, __snd_rme96_probe(pci, pci_id));
+}
+
 static struct pci_driver rme96_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_rme96_ids,
-- 
2.31.1

