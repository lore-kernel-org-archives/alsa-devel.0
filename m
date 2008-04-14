From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: [PATCH 001/003] snd-powermac: enable headphone
	detection
Date: Mon, 14 Apr 2008 20:12:18 +0300
Message-ID: <46e1c7760804141012s22f638a1v199ae9a4af112169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D875245B2
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 19:12:20 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so465483ana.80
	for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2008 10:12:18 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Risto Suominen <Risto.Suominen at gmail.com>

Enable port change interrupt while initialising AWACS, Screamer, and
Burgundy chipsets.

Signed-off-by: Risto Suominen <Risto.Suominen at gmail.com>
---
Kernel version 2.6.25-rc8 (probably any 2.6)

--- sound/ppc/pmac.c.orig	2008-04-05 17:45:08.000000000 +0300
+++ sound/ppc/pmac.c	2008-04-07 12:18:47.503077312 +0300
@@ -214,7 +214,7 @@ static int snd_pmac_pcm_prepare(struct s
 	int rate_index;
 	long offset;
 	struct pmac_stream *astr;
-	
+
 	rec->dma_size = snd_pcm_lib_buffer_bytes(subs);
 	rec->period_size = snd_pcm_lib_period_bytes(subs);
 	rec->nperiods = rec->dma_size / rec->period_size;
@@ -643,7 +643,7 @@ static int snd_pmac_pcm_close(struct snd
 	/* reset constraints */
 	astr->cur_freqs = chip->freqs_ok;
 	astr->cur_formats = chip->formats_ok;
-	
+
 	return 0;
 }

@@ -1063,6 +1063,10 @@ static int __init snd_pmac_detect(struct
 	else {
 		struct pci_dev *pdev = NULL;

+#ifndef for_each_pci_dev
+#define for_each_pci_dev(d) \
+		while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
+#endif
 		for_each_pci_dev(pdev) {
 			struct device_node *np = pci_device_to_OF_node(pdev);
 			if (np && np == macio->of_node) {
@@ -1300,9 +1304,9 @@ int __init snd_pmac_new(struct snd_card

 	snd_pmac_sound_feature(chip, 1);

-	/* reset */
-	if (chip->model == PMAC_AWACS)
-		out_le32(&chip->awacs->control, 0x11);
+	/* reset & enable interrupts */
+	if (chip->model <= PMAC_BURGUNDY)
+		out_le32(&chip->awacs->control, chip->control_mask);

 	/* Powerbooks have odd ways of enabling inputs such as
 	   an expansion-bay CD or sound from an internal modem
