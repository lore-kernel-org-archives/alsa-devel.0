From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: [PATCH] Audiophile 192: Fix ad converter initialization
Date: Mon, 21 Apr 2008 22:45:31 +0200
Message-ID: <200804212245.31567.fzu@wemgehoertderstaat.de>
References: <200804200052.51804.fzu@wemgehoertderstaat.de>
	<s5htzhvcvih.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by alsa0.perex.cz (Postfix) with ESMTP id A60EB243A3
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 22:45:35 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so5720618fka.0
	for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2008 13:45:35 -0700 (PDT)
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


Correct some arguments in calls to snd_ice1712_gpio_write_bits() from
ap192_set_rate_val().

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>



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
