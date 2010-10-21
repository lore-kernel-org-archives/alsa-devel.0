From: Andy Owen <andy-alsa@ultra-premium.com>
Subject: [PATCH - ca0106 5/6] ALSA: ca0106: Allow different
	sound cards to use different SPI channel mappings.
Date: Thu, 21 Oct 2010 23:39:23 +1100
Message-ID: <1287664764-4996-5-git-send-email-andy-alsa@ultra-premium.com>
References: <1287664764-4996-1-git-send-email-andy-alsa@ultra-premium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from starfish.geekisp.com (starfish.geekisp.com [216.168.135.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E8A81038C3
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 14:39:49 +0200 (CEST)
In-Reply-To: <1287664764-4996-1-git-send-email-andy-alsa@ultra-premium.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Andy Owen <andy-alsa@ultra-premium.com>
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Andy Owen <andy-alsa@ultra-premium.com>

diff --git a/sound/pci/ca0106/ca0106.h b/sound/pci/ca0106/ca0106.h
index 14b8d9a..f19c110 100644
--- a/sound/pci/ca0106/ca0106.h
+++ b/sound/pci/ca0106/ca0106.h
@@ -670,8 +670,9 @@ struct snd_ca0106_details {
 			   gpio_type = 2 -> shared side-out/line-in. */
 	int i2c_adc;	/* with i2c_adc=1, the driver adds some capture volume
 			   controls, phone, mic, line-in and aux. */
-	int spi_dac;	/* spi_dac=1 adds the mute switch for each analog
-			   output, front, rear, etc. */
+	u16 spi_dac;	/* spi_dac = 0 -> no spi interface for DACs
+			   spi_dac = 0x<front><rear><center-lfe><side>
+			   -> specifies DAC id for each channel pair. */
 };
 
 // definition of the chip-specific record
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index da91003..d2d12c0 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -227,7 +227,7 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	   .name   = "Audigy SE [SB0570]",
 	   .gpio_type = 1,
 	   .i2c_adc = 1,
-	   .spi_dac = 1 } ,
+	   .spi_dac = 0x4021 } ,
 	 /* New Audigy LS. Has a different DAC. */
 	 /* SB0570:
 	  * CTRL:CA0106-DAT
@@ -238,7 +238,7 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	   .name   = "Audigy SE OEM [SB0570a]",
 	   .gpio_type = 1,
 	   .i2c_adc = 1,
-	   .spi_dac = 1 } ,
+	   .spi_dac = 0x4021 } ,
 	/* Sound Blaster 5.1vx
 	 * Tested: Playback on front, rear, center/lfe speakers
 	 * Not-Tested: Capture
@@ -247,7 +247,7 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	  .name   = "Sound Blaster 5.1vx [SB1070]",
 	  .gpio_type = 1,
 	  .i2c_adc = 0,
-	  .spi_dac = 1
+	  .spi_dac = 0x0124
 	 } ,
 	 /* MSI K8N Diamond Motherboard with onboard SB Live 24bit without AC97 */
 	 /* SB0438
@@ -264,7 +264,7 @@ static struct snd_ca0106_details ca0106_chip_details[] = {
 	   .name   = "MSI K8N Diamond MB",
 	   .gpio_type = 2,
 	   .i2c_adc = 1,
-	   .spi_dac = 1 } ,
+	   .spi_dac = 0x4021 } ,
 	/* Giga-byte GA-G1975X mobo
 	 * Novell bnc#395807
 	 */
@@ -520,12 +520,18 @@ static int snd_ca0106_channel_dac(struct snd_ca0106_details *details,
 				  int channel_id)
 {
 	switch (channel_id) {
-	case PCM_FRONT_CHANNEL:		return 4;
-	case PCM_REAR_CHANNEL:		return 0;
-	case PCM_CENTER_LFE_CHANNEL:	return 2;
-	case PCM_UNKNOWN_CHANNEL:	return 1;
+	case PCM_FRONT_CHANNEL:
+		return (details->spi_dac & 0xf000) >> (4 * 3);
+	case PCM_REAR_CHANNEL:
+		return (details->spi_dac & 0x0f00) >> (4 * 2);
+	case PCM_CENTER_LFE_CHANNEL:
+		return (details->spi_dac & 0x00f0) >> (4 * 1);
+	case PCM_UNKNOWN_CHANNEL:
+		return (details->spi_dac & 0x000f) >> (4 * 0);
+	default:
+		snd_printk(KERN_DEBUG "ca0106: unknown channel_id %d\n",
+			   channel_id);
 	}
-	snd_printk(KERN_DEBUG "ca0106: unknown channel_id %d\n", channel_id);
 	return 0;
 }
 
@@ -1582,7 +1588,7 @@ static void ca0106_init_chip(struct snd_ca0106 *chip, int resume)
 		/* snd_ca0106_i2c_write(chip, ADC_MUX, ADC_MUX_LINEIN); */
 	}
 
-	if (chip->details->spi_dac == 1) {
+	if (chip->details->spi_dac) {
 		/* The SB0570 use SPI to control DAC. */
 		int size, n;
 
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 85fd315..b522401 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -832,7 +832,7 @@ int __devinit snd_ca0106_mixer(struct snd_ca0106 *emu)
 		if (err < 0)
 			return err;
 	}
-	if (emu->details->spi_dac == 1)
+	if (emu->details->spi_dac)
 		ADD_CTLS(emu, snd_ca0106_volume_spi_dac_ctls);
 
 	/* Create virtual master controls */
@@ -845,7 +845,7 @@ int __devinit snd_ca0106_mixer(struct snd_ca0106 *emu)
 		return err;
 	add_slaves(card, vmaster, slave_vols);
 
-	if (emu->details->spi_dac == 1) {
+	if (emu->details->spi_dac) {
 		vmaster = snd_ctl_make_virtual_master("Master Playback Switch",
 						      NULL);
 		if (!vmaster)
-- 
1.7.3.1.127.g1bb28
