From: Zhouyang Jia <jiazhouyang09@gmail.com>
Subject: [PATCH] ALSA: lx6464es: add error handling for pci_ioremap_bar
Date: Tue, 12 Jun 2018 11:23:14 +0800
Message-ID: <1528773796-37922-1-git-send-email-jiazhouyang09@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

When pci_ioremap_bar fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling pci_ioremap_bar.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 sound/pci/lx6464es/lx6464es.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 9655b08..6157b6d 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1016,6 +1016,10 @@ static int snd_lx6464es_create(struct snd_card *card,
 
 	/* dsp port */
 	chip->port_dsp_bar = pci_ioremap_bar(pci, 2);
+	if (!chip->port_dsp_bar) {
+		dev_err(card->dev, "cannot remap PCI memory region\n");
+		goto request_irq_failed;
+	}
 
 	err = request_threaded_irq(pci->irq, lx_interrupt, lx_threaded_irq,
 				   IRQF_SHARED, KBUILD_MODNAME, chip);
-- 
2.7.4
