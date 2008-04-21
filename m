From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] Don't set gpio mask register in
	snd_ice1712_gpio_write_bits()
Date: Mon, 21 Apr 2008 22:45:18 +0200
Message-ID: <200804212245.18799.fzu@wemgehoertderstaat.de>
References: <200804200052.51804.fzu@wemgehoertderstaat.de>
	<s5htzhvcvih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by alsa0.perex.cz (Postfix) with ESMTP id C854C243A9
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 22:45:22 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so5720618fka.0
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 13:45:22 -0700 (PDT)
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


Some calls to snd_ice1712_gpio_write() go wrong, if
snd_ice1712_gpio_write_bits() ran before and changed the gpio mask register.
Read the actual gpio value and combine it with the to be set bits in the cpu
instead.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>


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
