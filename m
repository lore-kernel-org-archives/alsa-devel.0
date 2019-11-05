Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD6C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:35:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032B62087E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bh4bcxMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032B62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 426671711;
	Tue,  5 Nov 2019 16:35:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 426671711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572968153;
	bh=XJaJ9wf28Y7q9R8GctN7vM6hqs0FAQQbImbF6WpIvOU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bh4bcxMi6BDQW5xir/aT+BBcfRdtF7pOMXkt+YNnZuQiPnv6zUtWJ1Yeft1Dakwen
	 yxpDPJm3Bz9WmqrPzyieSfiDsFfEbXpCvkKFPABNskNePw7LntaiXft+YaT+Ho5yPk
	 4LNidYFpuYCQMdrCyJ8CYofnlwqRzPULmmkXgvCM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADCD6F80864;
	Tue,  5 Nov 2019 16:19:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35A1AF80671; Tue,  5 Nov 2019 16:19:30 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 50B23F8049B
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:19:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50B23F8049B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B4ABCB26E
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:54 +0100
Message-Id: <20191105151856.10785-23-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 22/24] ALSA: rme: Avoid non-standard macro usage
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

Pass the device pointer from the PCI pointer directly, instead of a
non-standard macro.  The macro didn't give any better readability.

Along with it, drop the unnecessary assignment before the
snd_dma_alloc_pages() call and simplify by returning the error code
directly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdsp.c    | 7 +------
 sound/pci/rme9652/hdspm.c   | 2 +-
 sound/pci/rme9652/rme9652.c | 7 +------
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 5cbdc9be9c7e..cd20af465d8e 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -569,12 +569,7 @@ static char channel_map_H9632_qs[HDSP_MAX_CHANNELS] = {
 
 static int snd_hammerfall_get_buffer(struct pci_dev *pci, struct snd_dma_buffer *dmab, size_t size)
 {
-	dmab->dev.type = SNDRV_DMA_TYPE_DEV;
-	dmab->dev.dev = snd_dma_pci_data(pci);
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				size, dmab) < 0)
-		return -ENOMEM;
-	return 0;
+	return snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, &pci->dev, size, dmab);
 }
 
 static void snd_hammerfall_free_buffer(struct snd_dma_buffer *dmab, struct pci_dev *pci)
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index b571d9d017bb..75c06a7cc779 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6406,7 +6406,7 @@ static int snd_hdspm_preallocate_memory(struct hdspm *hdspm)
 	wanted = HDSPM_DMA_AREA_BYTES;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
-					      snd_dma_pci_data(hdspm->pci),
+					      &hdspm->pci->dev,
 					      wanted, wanted);
 	dev_dbg(hdspm->card->dev, " Preallocated %zd Bytes\n", wanted);
 	return 0;
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 4c851f8dcaf8..ef5c2f8e17c7 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -279,12 +279,7 @@ static char channel_map_9636_ds[26] = {
 
 static int snd_hammerfall_get_buffer(struct pci_dev *pci, struct snd_dma_buffer *dmab, size_t size)
 {
-	dmab->dev.type = SNDRV_DMA_TYPE_DEV;
-	dmab->dev.dev = snd_dma_pci_data(pci);
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				size, dmab) < 0)
-		return -ENOMEM;
-	return 0;
+	return snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, &pci->dev, size, dmab);
 }
 
 static void snd_hammerfall_free_buffer(struct snd_dma_buffer *dmab, struct pci_dev *pci)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
