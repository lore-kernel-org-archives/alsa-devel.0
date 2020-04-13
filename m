Return-Path: <SRS0=SID+=55=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953F9C2BA19
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:25:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23AE220678
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Apr 2020 08:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="imT/4yG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AE220678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6080A16E9;
	Mon, 13 Apr 2020 10:24:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6080A16E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586766325;
	bh=714HRTyR6VfjnfNDZtcRMQz3hO7iWlOPmmbnFB6MeV8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=imT/4yG+wXhp03/Trbv8mc7wAMPyikhdta9hCbaxbsm02/suppGGluTIX2eUhh8Sf
	 HsJEY58tuSqWf1XlgEK1+Bo66HHgCF2O8wsSkTBB4M41iOF0SV4k67mgR+sKYtcY7G
	 jYKjRWIzCQkreAQI5IRTEv9Be0EBjAiu40ZXV66k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2874F802A9;
	Mon, 13 Apr 2020 10:20:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC72AF8025F; Mon, 13 Apr 2020 10:20:51 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C301F800B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 10:20:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C301F800B9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 99194AD08;
 Mon, 13 Apr 2020 08:20:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/6] ALSA: hda: Release resources at error in delayed probe
Date: Mon, 13 Apr 2020 10:20:31 +0200
Message-Id: <20200413082034.25166-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200413082034.25166-1-tiwai@suse.de>
References: <20200413082034.25166-1-tiwai@suse.de>
Cc: Roy Spliet <nouveau@spliet.org>
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

snd-hda-intel driver handles the most of its probe task in the delayed
work (either via workqueue or via firmware loader).  When an error
happens in the later delayed probe, we can't deregister the device
itself because the probe callback already returned success and the
device was bound.  So, for now, we set hda->init_failed flag and make
the rest untouched until the device gets really unbound.
However, this leaves the device up running, keeping the resources
without any use that prevents other operations.

In this patch, we release the resources at first when a probe error
happens in the delayed probe stage, but keeps the top-level object, so
that the PM and other ops can still refer to the object itself.

Also for simplicity, snd_hda_intel object is allocated via devm, so
that we can get rid of the explicit kfree calls.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 29 ++++++++++++++++-------------
 sound/pci/hda/hda_intel.h |  1 +
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f41d8b7864c1..692857904d49 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1203,10 +1203,8 @@ static void azx_vs_set_state(struct pci_dev *pci,
 		if (!disabled) {
 			dev_info(chip->card->dev,
 				 "Start delayed initialization\n");
-			if (azx_probe_continue(chip) < 0) {
+			if (azx_probe_continue(chip) < 0)
 				dev_err(chip->card->dev, "initialization error\n");
-				hda->init_failed = true;
-			}
 		}
 	} else {
 		dev_info(chip->card->dev, "%s via vga_switcheroo\n",
@@ -1339,12 +1337,15 @@ static int register_vga_switcheroo(struct azx *chip)
 /*
  * destructor
  */
-static int azx_free(struct azx *chip)
+static void azx_free(struct azx *chip)
 {
 	struct pci_dev *pci = chip->pci;
 	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
 	struct hdac_bus *bus = azx_bus(chip);
 
+	if (hda->freed)
+		return;
+
 	if (azx_has_pm_runtime(chip) && chip->running)
 		pm_runtime_get_noresume(&pci->dev);
 	chip->running = 0;
@@ -1388,9 +1389,8 @@ static int azx_free(struct azx *chip)
 
 	if (chip->driver_caps & AZX_DCAPS_I915_COMPONENT)
 		snd_hdac_i915_exit(bus);
-	kfree(hda);
 
-	return 0;
+	hda->freed = 1;
 }
 
 static int azx_dev_disconnect(struct snd_device *device)
@@ -1406,7 +1406,8 @@ static int azx_dev_disconnect(struct snd_device *device)
 
 static int azx_dev_free(struct snd_device *device)
 {
-	return azx_free(device->device_data);
+	azx_free(device->device_data);
+	return 0;
 }
 
 #ifdef SUPPORT_VGA_SWITCHEROO
@@ -1773,7 +1774,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	if (err < 0)
 		return err;
 
-	hda = kzalloc(sizeof(*hda), GFP_KERNEL);
+	hda = devm_kzalloc(&pci->dev, sizeof(*hda), GFP_KERNEL);
 	if (!hda) {
 		pci_disable_device(pci);
 		return -ENOMEM;
@@ -1814,7 +1815,6 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 
 	err = azx_bus_init(chip, model[dev]);
 	if (err < 0) {
-		kfree(hda);
 		pci_disable_device(pci);
 		return err;
 	}
@@ -2340,13 +2340,16 @@ static int azx_probe_continue(struct azx *chip)
 		pm_runtime_put_autosuspend(&pci->dev);
 
 out_free:
-	if (err < 0 || !hda->need_i915_power)
+	if (err < 0) {
+		azx_free(chip);
+		return err;
+	}
+
+	if (!hda->need_i915_power)
 		display_power(chip, false);
-	if (err < 0)
-		hda->init_failed = 1;
 	complete_all(&hda->probe_wait);
 	to_hda_bus(bus)->bus_probing = 0;
-	return err;
+	return 0;
 }
 
 static void azx_remove(struct pci_dev *pci)
diff --git a/sound/pci/hda/hda_intel.h b/sound/pci/hda/hda_intel.h
index 2acfff3da1a0..3fb119f09040 100644
--- a/sound/pci/hda/hda_intel.h
+++ b/sound/pci/hda/hda_intel.h
@@ -27,6 +27,7 @@ struct hda_intel {
 	unsigned int use_vga_switcheroo:1;
 	unsigned int vga_switcheroo_registered:1;
 	unsigned int init_failed:1; /* delayed init failed */
+	unsigned int freed:1; /* resources already released */
 
 	bool need_i915_power:1; /* the hda controller needs i915 power */
 };
-- 
2.16.4

