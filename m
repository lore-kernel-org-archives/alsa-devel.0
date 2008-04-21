From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] ice1724.c: toggle "chip reset" and "eeprom
	based setup" sequence
Date: Mon, 21 Apr 2008 22:45:03 +0200
Message-ID: <200804212245.04052.fzu@wemgehoertderstaat.de>
References: <200804200052.51804.fzu@wemgehoertderstaat.de>
	<s5htzhvcvih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.188])
	by alsa0.perex.cz (Postfix) with ESMTP id D76522434E
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 22:45:08 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id i2so2673018mue.2
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 13:45:07 -0700 (PDT)
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


Let "chip reset" become first. Increasement of the "chip reset" related timeout
leads to correctly read eeprom's contents here.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>



diff -pur alsa.hg/alsa-kernel/pci/ice1712/ice1724.c fixed/alsa-kernel/pci/ice1712/ice1724.c
--- alsa.hg/alsa-kernel/pci/ice1712/ice1724.c	2008-03-20 12:25:01.000000000 +0100
+++ fixed/alsa-kernel/pci/ice1712/ice1724.c	2008-04-19 23:07:29.000000000 +0200
@@ -2045,12 +2045,16 @@ static int __devinit snd_vt1724_read_eep
 
 
 
-static int __devinit snd_vt1724_chip_init(struct snd_ice1712 *ice)
+static void __devinit snd_vt1724_chip_reset(struct snd_ice1712 *ice)
 {
 	outb(VT1724_RESET , ICEREG1724(ice, CONTROL));
-	udelay(200);
+	msleep(10);
 	outb(0, ICEREG1724(ice, CONTROL));
-	udelay(200);
+	msleep(10);
+}
+
+static int __devinit snd_vt1724_chip_init(struct snd_ice1712 *ice)
+{
 	outb(ice->eeprom.data[ICE_EEP2_SYSCONF], ICEREG1724(ice, SYS_CFG));
 	outb(ice->eeprom.data[ICE_EEP2_ACLINK], ICEREG1724(ice, AC97_CFG));
 	outb(ice->eeprom.data[ICE_EEP2_I2S], ICEREG1724(ice, I2S_FEATURES));
@@ -2223,6 +2227,7 @@ static int __devinit snd_vt1724_create(s
 
 	ice->irq = pci->irq;
 
+	snd_vt1724_chip_reset(ice);
 	if (snd_vt1724_read_eeprom(ice, modelname) < 0) {
 		snd_vt1724_free(ice);
 		return -EIO;
