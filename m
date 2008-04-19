From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] ALSA: Fix capturing for envy1724ht based
	"audiophile 192"
Date: Sun, 20 Apr 2008 00:52:51 +0200
Message-ID: <200804200052.51804.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 67C6224412
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Apr 2008 00:53:05 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so486772nfd.32
	for <alsa-devel@alsa-project.org>; Sat, 19 Apr 2008 15:52:56 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The 1st hunk changes snd_ice1712_gpio_write_bits() to not affect the gpio's mask
register. Lets gpio writers that are unaware of a changed mask register
successfully write the gpio.
The 2nd and 3rd hunks toggle "chip reset" and "eeprom based setup" sequence so
"chip reset" becomes first. Increasement of the "chip reset" related timeout
leads to correctly read eeprom's contents here.
Also corrects some arguments in calls to snd_ice1712_gpio_write_bits() from
ap192_set_rate_val().

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---

Hi,

patch might hamper cards that actually relied on snd_ice1712_gpio_write_bits()
setting the gpio's mask register. Cscope tells me terratec ews and m-audio
rev51 are might be candidates. I guess they are ok ;-)

regards,
      Karsten

diff -pur alsa.hg/alsa-kernel/pci/ice1712/ice1712.h fixed/alsa-kernel/pci/ice1712/ice1712.h
--- alsa.hg/alsa-kernel/pci/ice1712/ice1712.h	2008-03-20 12:25:01.000000000 +0100
+++ fixed/alsa-kernel/pci/ice1712/ice1712.h	2008-04-19 23:21:31.000000000 +0200
@@ -438,10 +438,14 @@ int snd_ice1712_gpio_put(struct snd_kcon
 static inline void snd_ice1712_gpio_write_bits(struct snd_ice1712 *ice,
 					       unsigned int mask, unsigned int bits)
 {
+	unsigned val;
+
 	ice->gpio.direction |= mask;
 	snd_ice1712_gpio_set_dir(ice, ice->gpio.direction);
-	snd_ice1712_gpio_set_mask(ice, ~mask);
-	snd_ice1712_gpio_write(ice, mask & bits);
+	val = snd_ice1712_gpio_read(ice);
+	val &= ~mask;
+	val |= mask & bits;
+	snd_ice1712_gpio_write(ice, val);
 }
 
 static inline int snd_ice1712_gpio_read_bits(struct snd_ice1712 *ice,
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
diff -pur alsa.hg/alsa-kernel/pci/ice1712/revo.c fixed/alsa-kernel/pci/ice1712/revo.c
--- alsa.hg/alsa-kernel/pci/ice1712/revo.c	2008-03-17 09:25:02.000000000 +0100
+++ fixed/alsa-kernel/pci/ice1712/revo.c	2008-04-19 23:12:33.000000000 +0200
@@ -327,7 +327,7 @@ static void ap192_set_rate_val(struct sn
 	revo_set_rate_val(ak, rate);
 
 	/* reset CKS */
-	snd_ice1712_gpio_write_bits(ice, 1 << 8, rate > 96000 ? 1 : 0);
+	snd_ice1712_gpio_write_bits(ice, 1 << 8, rate > 96000 ? 1 << 8 : 0);
 	/* reset DFS pins of AK5385A for ADC, too */
 	if (rate > 96000)
 		dfs = 2;
@@ -338,7 +338,7 @@ static void ap192_set_rate_val(struct sn
 	snd_ice1712_gpio_write_bits(ice, 3 << 9, dfs << 9);
 	/* reset ADC */
 	snd_ice1712_gpio_write_bits(ice, 1 << 11, 0);
-	snd_ice1712_gpio_write_bits(ice, 1 << 11, 1);
+	snd_ice1712_gpio_write_bits(ice, 1 << 11, 1 << 11);
 }
 
 static const struct snd_akm4xxx_dac_channel ap192_dac[] = {
