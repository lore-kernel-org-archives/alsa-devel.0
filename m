From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: sonicvibes: Adjust 15 function calls
 together with a variable assignment
Date: Sat, 18 Nov 2017 16:31:22 +0100
Message-ID: <3aea508c-ed26-8c82-5b73-93d9e0e293fb@users.sourceforge.net>
References: <663ac54c-baf9-ac11-50fd-d8b407d1eacf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id F149F26698E
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 16:32:02 +0100 (CET)
In-Reply-To: <663ac54c-baf9-ac11-50fd-d8b407d1eacf@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 16:08:23 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/sonicvibes.c | 70 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index a8abb15e3c3a..7c238d908031 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -882,9 +882,9 @@ static const struct snd_pcm_ops snd_sonicvibes_capture_ops = {
 static int snd_sonicvibes_pcm(struct sonicvibes *sonic, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(sonic->card, "s3_86c617", device, 1, 1, &pcm);
 
-	if ((err = snd_pcm_new(sonic->card, "s3_86c617", device, 1, 1, &pcm)) < 0)
+	if (err < 0)
 		return err;
 	if (snd_BUG_ON(!pcm))
 		return -EINVAL;
@@ -1125,7 +1125,9 @@ static int snd_sonicvibes_mixer(struct sonicvibes *sonic)
 	strcpy(card->mixername, "S3 SonicVibes");
 
 	for (idx = 0; idx < ARRAY_SIZE(snd_sonicvibes_controls); idx++) {
-		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_sonicvibes_controls[idx], sonic))) < 0)
+		kctl = snd_ctl_new1(&snd_sonicvibes_controls[idx], sonic);
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			return err;
 		switch (idx) {
 		case 0:
@@ -1256,7 +1258,8 @@ static int snd_sonicvibes_create(struct snd_card *card,
 
 	*rsonic = NULL;
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 24 bits */
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(24)) < 0 ||
@@ -1277,7 +1280,8 @@ static int snd_sonicvibes_create(struct snd_card *card,
 	sonic->pci = pci;
 	sonic->irq = -1;
 
-	if ((err = pci_request_regions(pci, "S3 SonicVibes")) < 0) {
+	err = pci_request_regions(pci, "S3 SonicVibes");
+	if (err < 0) {
 		kfree(sonic);
 		pci_disable_device(pci);
 		return err;
@@ -1319,14 +1323,17 @@ static int snd_sonicvibes_create(struct snd_card *card,
 	pci_write_config_dword(pci, 0x40, dmaa);
 	pci_write_config_dword(pci, 0x48, dmac);
 
-	if ((sonic->res_dmaa = request_region(dmaa, 0x10, "S3 SonicVibes DDMA-A")) == NULL) {
+	sonic->res_dmaa = request_region(dmaa, 0x10, "S3 SonicVibes DDMA-A");
+	if (!sonic->res_dmaa) {
 		snd_sonicvibes_free(sonic);
 		dev_err(card->dev,
 			"unable to grab DDMA-A port at 0x%x-0x%x\n",
 			dmaa, dmaa + 0x10 - 1);
 		return -EBUSY;
 	}
-	if ((sonic->res_dmac = request_region(dmac, 0x10, "S3 SonicVibes DDMA-C")) == NULL) {
+
+	sonic->res_dmac = request_region(dmac, 0x10, "S3 SonicVibes DDMA-C");
+	if (!sonic->res_dmac) {
 		snd_sonicvibes_free(sonic);
 		dev_err(card->dev,
 			"unable to grab DDMA-C port at 0x%x-0x%x\n",
@@ -1387,8 +1394,8 @@ static int snd_sonicvibes_create(struct snd_card *card,
 	snd_sonicvibes_debug(sonic);
 #endif
 	sonic->revision = snd_sonicvibes_in(sonic, SV_IREG_REVISION);
-
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, sonic, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, sonic, &ops);
+	if (err < 0) {
 		snd_sonicvibes_free(sonic);
 		return err;
 	}
@@ -1437,9 +1444,13 @@ static int snd_sonicvibes_midi(struct sonicvibes *sonic,
 	mpu->open_input = snd_sonicvibes_midi_input_open;
 	mpu->close_input = snd_sonicvibes_midi_input_close;
 	dir = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
-	for (idx = 0; idx < ARRAY_SIZE(snd_sonicvibes_midi_controls); idx++)
-		if ((err = snd_ctl_add(card, snd_ctl_new1(&snd_sonicvibes_midi_controls[idx], sonic))) < 0)
+	for (idx = 0; idx < ARRAY_SIZE(snd_sonicvibes_midi_controls); idx++) {
+		err = snd_ctl_add(card,
+				  snd_ctl_new1(&snd_sonicvibes_midi_controls[idx],
+					       sonic));
+		if (err < 0)
 			return err;
+	}
 	return 0;
 }
 
@@ -1471,10 +1482,10 @@ static int snd_sonic_probe(struct pci_dev *pci,
 			return -ENODEV;
 		}
 	}
-	if ((err = snd_sonicvibes_create(card, pci,
-					 reverb[dev] ? 1 : 0,
-					 mge[dev] ? 1 : 0,
-					 &sonic)) < 0) {
+
+	err = snd_sonicvibes_create(card, pci, reverb[dev] ? 1 : 0,
+				    mge[dev] ? 1 : 0, &sonic);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1487,37 +1498,42 @@ static int snd_sonic_probe(struct pci_dev *pci,
 		(unsigned long long)pci_resource_start(pci, 1),
 		sonic->irq);
 
-	if ((err = snd_sonicvibes_pcm(sonic, 0)) < 0) {
+	err = snd_sonicvibes_pcm(sonic, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_sonicvibes_mixer(sonic)) < 0) {
+	err = snd_sonicvibes_mixer(sonic);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_SONICVIBES,
-				       sonic->midi_port,
-				       MPU401_INFO_INTEGRATED |
-				       MPU401_INFO_IRQ_HOOK,
-				       -1, &midi_uart)) < 0) {
+	err = snd_mpu401_uart_new(card, 0, MPU401_HW_SONICVIBES,
+				  sonic->midi_port,
+				  MPU401_INFO_INTEGRATED | MPU401_INFO_IRQ_HOOK,
+				  -1, &midi_uart);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	snd_sonicvibes_midi(sonic, midi_uart);
-	if ((err = snd_opl3_create(card, sonic->synth_port,
-				   sonic->synth_port + 2,
-				   OPL3_HW_OPL3_SV, 1, &opl3)) < 0) {
+	err = snd_opl3_create(card, sonic->synth_port,
+			      sonic->synth_port + 2,
+			      OPL3_HW_OPL3_SV, 1, &opl3);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
+	err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
 	snd_sonicvibes_create_gameport(sonic);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
