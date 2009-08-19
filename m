From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ali5451: remove dead code
Date: Wed, 19 Aug 2009 22:09:55 +0200
Message-ID: <200908192209.55701.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F481245AB
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Aug 2009 22:11:46 +0200 (CEST)
Received: by bwz25 with SMTP id 25so990956bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2009 13:11:45 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ali5451: remove dead code

Remove code covered by #if/endif 0 and #ifdef/endif CODEC_RESET
(CODEC_RESET is never defined).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 sound/pci/ali5451/ali5451.c |   65 --------------------------------------------
 1 file changed, 65 deletions(-)

Index: b/sound/pci/ali5451/ali5451.c
===================================================================
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -477,45 +477,6 @@ static int snd_ali_reset_5451(struct snd
 	return 0;
 }
 
-#ifdef CODEC_RESET
-
-static int snd_ali_reset_codec(struct snd_ali *codec)
-{
-	struct pci_dev *pci_dev;
-	unsigned char bVal;
-	unsigned int   dwVal;
-	unsigned short wCount, wReg;
-
-	pci_dev = codec->pci_m1533;
-	
-	pci_read_config_dword(pci_dev, 0x7c, &dwVal);
-	pci_write_config_dword(pci_dev, 0x7c, dwVal | 0x08000000);
-	udelay(5000);
-	pci_read_config_dword(pci_dev, 0x7c, &dwVal);
-	pci_write_config_dword(pci_dev, 0x7c, dwVal & 0xf7ffffff);
-	udelay(5000);
-
-	bVal = inb(ALI_REG(codec,ALI_SCTRL));
-	bVal |= 0x02;
-	outb(ALI_REG(codec,ALI_SCTRL),bVal);
-	udelay(5000);
-	bVal = inb(ALI_REG(codec,ALI_SCTRL));
-	bVal &= 0xfd;
-	outb(ALI_REG(codec,ALI_SCTRL),bVal);
-	udelay(15000);
-
-	wCount = 200;
-	while (wCount--) {
-		wReg = snd_ali_codec_read(codec->ac97, AC97_POWERDOWN);
-		if ((wReg & 0x000f) == 0x000f)
-			return 0;
-		udelay(5000);
-	}
-	return -1;
-}
-
-#endif
-
 /*
  *  ALI 5451 Controller
  */
@@ -560,22 +521,6 @@ static void snd_ali_disable_address_inte
 	outl(gc, ALI_REG(codec, ALI_GC_CIR));
 }
 
-#if 0 /* not used */
-static void snd_ali_enable_voice_irq(struct snd_ali *codec,
-				     unsigned int channel)
-{
-	unsigned int mask;
-	struct snd_ali_channel_control *pchregs = &(codec->chregs);
-
-	snd_ali_printk("enable_voice_irq channel=%d\n",channel);
-	
-	mask = 1 << (channel & 0x1f);
-	pchregs->data.ainten  = inl(ALI_REG(codec, pchregs->regs.ainten));
-	pchregs->data.ainten |= mask;
-	outl(pchregs->data.ainten, ALI_REG(codec, pchregs->regs.ainten));
-}
-#endif
-
 static void snd_ali_disable_voice_irq(struct snd_ali *codec,
 				      unsigned int channel)
 {
@@ -676,16 +621,6 @@ static void snd_ali_free_channel_pcm(str
 	}
 }
 
-#if 0 /* not used */
-static void snd_ali_start_voice(struct snd_ali *codec, unsigned int channel)
-{
-	unsigned int mask = 1 << (channel & 0x1f);
-	
-	snd_ali_printk("start_voice: channel=%d\n",channel);
-	outl(mask, ALI_REG(codec,codec->chregs.regs.start));
-}
-#endif
-
 static void snd_ali_stop_voice(struct snd_ali *codec, unsigned int channel)
 {
 	unsigned int mask = 1 << (channel & 0x1f);
