Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C61EC5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:34:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9556F2087E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 15:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="UD7MEn+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9556F2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9923416DD;
	Tue,  5 Nov 2019 16:33:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9923416DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572968074;
	bh=zjagK+pr9iceQEZEOErzic3O6yBg6zZkgh943sJosvE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UD7MEn+wf+0nbOOy521+Qr0QWLRgfjBdzxHz7HwI8YtDEbxrsnX000cexG0orrLkt
	 joZQcOy22R/5DahQtgjCx1nBjcjnJm+Lu5TXzb8yIz+VjKkNNvUeobm2ok/jI3TsAf
	 YrNwoe0IZDlNvlE9NNV5lI49guIIChTVsqDgUNqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09EE2F807A2;
	Tue,  5 Nov 2019 16:19:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0340F8065A; Tue,  5 Nov 2019 16:19:27 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE805F80610
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 16:19:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE805F80610
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9A6DEB3BD
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2019 15:18:59 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue,  5 Nov 2019 16:18:52 +0100
Message-Id: <20191105151856.10785-21-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191105151856.10785-1-tiwai@suse.de>
References: <20191105151856.10785-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 20/24] ALSA: echoaudio: Avoid non-standard
	macro usage
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

Also slightly refactor the code (drop the return value check from the
preallocation) as it never returns an error.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/echoaudio/echoaudio.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 40877e478bb6..1465813bf7c6 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -324,7 +324,7 @@ static int pcm_open(struct snd_pcm_substream *substream,
 
 	/* Finally allocate a page for the scatter-gather list */
 	if ((err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				       snd_dma_pci_data(chip->pci),
+				       &chip->pci->dev,
 				       PAGE_SIZE, &pipe->sgpage)) < 0) {
 		dev_err(chip->card->dev, "s-g list allocation failed\n");
 		return err;
@@ -865,7 +865,7 @@ static const struct snd_pcm_ops digital_capture_ops = {
 /* Preallocate memory only for the first substream because it's the most
  * used one
  */
-static int snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *dev)
+static void snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *dev)
 {
 	struct snd_pcm_substream *ss;
 	int stream;
@@ -876,8 +876,6 @@ static int snd_echo_preallocate_pages(struct snd_pcm *pcm, struct device *dev)
 						      dev,
 						      ss->number ? 0 : 128<<10,
 						      256<<10);
-
-	return 0;
 }
 
 
@@ -904,8 +902,7 @@ static int snd_echo_new_pcm(struct echoaudio *chip)
 	strcpy(pcm->name, chip->card->shortname);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &analog_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &analog_capture_ops);
-	if ((err = snd_echo_preallocate_pages(pcm, snd_dma_pci_data(chip->pci))) < 0)
-		return err;
+	snd_echo_preallocate_pages(pcm, &chip->pci->dev);
 
 #ifdef ECHOCARD_HAS_DIGITAL_IO
 	/* PCM#1 Digital inputs, no outputs */
@@ -916,8 +913,7 @@ static int snd_echo_new_pcm(struct echoaudio *chip)
 	chip->digital_pcm = pcm;
 	strcpy(pcm->name, chip->card->shortname);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &digital_capture_ops);
-	if ((err = snd_echo_preallocate_pages(pcm, snd_dma_pci_data(chip->pci))) < 0)
-		return err;
+	snd_echo_preallocate_pages(pcm, &chip->pci->dev);
 #endif /* ECHOCARD_HAS_DIGITAL_IO */
 
 #else /* ECHOCARD_HAS_VMIXER */
@@ -937,8 +933,7 @@ static int snd_echo_new_pcm(struct echoaudio *chip)
 	strcpy(pcm->name, chip->card->shortname);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &analog_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &analog_capture_ops);
-	if ((err = snd_echo_preallocate_pages(pcm, snd_dma_pci_data(chip->pci))) < 0)
-		return err;
+	snd_echo_preallocate_pages(pcm, &chip->pci->dev);
 
 #ifdef ECHOCARD_HAS_DIGITAL_IO
 	/* PCM#1 Digital i/o */
@@ -951,8 +946,7 @@ static int snd_echo_new_pcm(struct echoaudio *chip)
 	strcpy(pcm->name, chip->card->shortname);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &digital_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &digital_capture_ops);
-	if ((err = snd_echo_preallocate_pages(pcm, snd_dma_pci_data(chip->pci))) < 0)
-		return err;
+	snd_echo_preallocate_pages(pcm, &chip->pci->dev);
 #endif /* ECHOCARD_HAS_DIGITAL_IO */
 
 #endif /* ECHOCARD_HAS_VMIXER */
@@ -1954,7 +1948,7 @@ static int snd_echo_create(struct snd_card *card,
 
 	/* Create the DSP comm page - this is the area of memory used for most
 	of the communication with the DSP, which accesses it via bus mastering */
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(chip->pci),
+	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, &chip->pci->dev,
 				sizeof(struct comm_page),
 				&chip->commpage_dma_buf) < 0) {
 		dev_err(chip->card->dev, "cannot allocate the comm page\n");
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
