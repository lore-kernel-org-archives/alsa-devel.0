Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8971AC433E2
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:44:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F9320716
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CyTsY5dH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F9320716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4393618F8;
	Thu,  3 Sep 2020 12:43:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4393618F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599129861;
	bh=TPd8PjBkIYJV3XBWK4HkPCFBwxa7eK/A77Wvp74cZWc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CyTsY5dHOWs4W7D4+TbaPV2NjgyK4xDmou7QmQkaiCY6JscWXcopxW0m7nuzXS3sM
	 ko348gnfJKGU6n+D2V64eNBFZr8kuzLHOfws4pupQH88yQc7ccBjF0L3CELpImAs4Y
	 5ly630gzYib4BbvrTRu3Oh3JMiJpA+XzRs6Ea5gY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89086F800F0;
	Thu,  3 Sep 2020 12:41:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05C6CF802E2; Thu,  3 Sep 2020 12:41:55 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B51B4F802A9
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 12:41:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B51B4F802A9
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DD8BCB152;
 Thu,  3 Sep 2020 10:41:38 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 07/11] ALSA: hdspm: Replace tasklet with work
Date: Thu,  3 Sep 2020 12:41:27 +0200
Message-Id: <20200903104131.21097-8-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200903104131.21097-1-tiwai@suse.de>
References: <20200903104131.21097-1-tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
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

The tasklet is an old API that should be deprecated, usually can be
converted to another decent API.  In HDSP-MADI driver, a tasklet is
still used for offloading the MIDI I/O handling (optional via mixer
switch).  It can be achieved gracefully with a work queued, too.

This patch replaces the tasklet usage in HDSP-MADI driver with a
simple work.  The conversion is fairly straightforward.  The only
significant difference is that the work initialization is moved to the
right place in snd_hdspm_create() and cancel_work_sync() is always
called in snd_hdspm_free() to assure killing the pending works.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdspm.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 572350aaf18d..e532312a5e1c 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -997,7 +997,7 @@ struct hdspm {
 	u32 settings_register;  /* cached value for AIO / RayDat (sync reference, master/slave) */
 
 	struct hdspm_midi midi[4];
-	struct tasklet_struct midi_tasklet;
+	struct work_struct midi_work;
 
 	size_t period_bytes;
 	unsigned char ss_in_channels;
@@ -2169,9 +2169,9 @@ static int snd_hdspm_create_midi(struct snd_card *card,
 }
 
 
-static void hdspm_midi_tasklet(struct tasklet_struct *t)
+static void hdspm_midi_work(struct work_struct *work)
 {
-	struct hdspm *hdspm = from_tasklet(hdspm, t, midi_tasklet);
+	struct hdspm *hdspm = container_of(work, struct hdspm, midi_work);
 	int i = 0;
 
 	while (i < hdspm->midiPorts) {
@@ -5449,7 +5449,7 @@ static irqreturn_t snd_hdspm_interrupt(int irq, void *dev_id)
 		}
 
 		if (schedule)
-			tasklet_hi_schedule(&hdspm->midi_tasklet);
+			queue_work(system_highpri_wq, &hdspm->midi_work);
 	}
 
 	return IRQ_HANDLED;
@@ -6538,6 +6538,7 @@ static int snd_hdspm_create(struct snd_card *card,
 	hdspm->card = card;
 
 	spin_lock_init(&hdspm->lock);
+	INIT_WORK(&hdspm->midi_work, hdspm_midi_work);
 
 	pci_read_config_word(hdspm->pci,
 			PCI_CLASS_REVISION, &hdspm->firmware_rev);
@@ -6836,9 +6837,6 @@ static int snd_hdspm_create(struct snd_card *card,
 
 	}
 
-	tasklet_setup(&hdspm->midi_tasklet, hdspm_midi_tasklet);
-
-
 	if (hdspm->io_type != MADIface) {
 		hdspm->serial = (hdspm_read(hdspm,
 				HDSPM_midiStatusIn0)>>8) & 0xFFFFFF;
@@ -6873,6 +6871,7 @@ static int snd_hdspm_free(struct hdspm * hdspm)
 {
 
 	if (hdspm->port) {
+		cancel_work_sync(&hdspm->midi_work);
 
 		/* stop th audio, and cancel all interrupts */
 		hdspm->control_register &=
-- 
2.16.4

