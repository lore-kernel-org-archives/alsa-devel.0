From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Fix for intel8x0m.c
Date: Tue, 2 Mar 2004 22:34:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040302223459.6f6f79a6.sashak@smlink.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__2_Mar_2004_22_34_59_+0200_cb+07NW6g51MoJbI"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.netalsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Tue__2_Mar_2004_22_34_59_+0200_cb+07NW6g51MoJbI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

There is such 'side effect' with 'intel8x0m' AC97 modem driver. During
AC97 initialization 'intel8x0m' allocates mixers for both codecs - audio
and modem. With two codec cards if 'intel8x0m' is modprobed after sound
driver ('intel8x0') when card was 'unmuted' already it mutes whole card
again, but sound driver does not (and cannot) know about it - mixer
settings are ok, but sound just disappears.

This patch prevents such behaviour. Now mixer is allocated only for
modem codec (according to AC97 spec modem codec will be always secondary
on multi-codec AC97 bus).

Regards,
Sasha.

--Multipart=_Tue__2_Mar_2004_22_34_59_+0200_cb+07NW6g51MoJbI
Content-Type: text/x-diff;
 name="intel8x0m.c.patch"
Content-Disposition: attachment;
 filename="intel8x0m.c.patch"
Content-Transfer-Encoding: 7bit

--- pci/intel8x0m.c~	2004-01-21 20:33:32.000000000 +0200
+++ pci/intel8x0m.c	2004-03-01 16:13:11.000000000 +0200
@@ -255,7 +255,7 @@
 	int in_ac97_init: 1;
 
 	ac97_bus_t *ac97_bus;
-	ac97_t *ac97[3];
+	ac97_t *ac97;
 
 	spinlock_t reg_lock;
 	spinlock_t ac97_lock;
@@ -880,7 +880,7 @@
 static void snd_intel8x0_mixer_free_ac97(ac97_t *ac97)
 {
 	intel8x0_t *chip = snd_magic_cast(intel8x0_t, ac97->private_data, return);
-	chip->ac97[ac97->num] = NULL;
+	chip->ac97 = NULL;
 }
 
 
@@ -889,7 +889,6 @@
 	ac97_bus_t bus, *pbus;
 	ac97_t ac97, *x97;
 	int err;
-	unsigned int i, codecs;
 	unsigned int glob_sta = 0;
 
 	chip->in_ac97_init = 1;
@@ -908,27 +907,25 @@
 	glob_sta = igetdword(chip, ICHREG(GLOB_STA));
 	bus.write = snd_intel8x0_codec_write;
 	bus.read = snd_intel8x0_codec_read;
-	codecs = glob_sta & ICH_SCR ? 2 : 1;
 	bus.vra = 1;
 
 	if ((err = snd_ac97_bus(chip->card, &bus, &pbus)) < 0)
 		goto __err;
 	chip->ac97_bus = pbus;
 	ac97.pci = chip->pci;
-	for (i = 0; i < codecs; i++) {
-		ac97.num = i;
-		if ((err = snd_ac97_mixer(pbus, &ac97, &x97)) < 0) {
-			snd_printk(KERN_ERR "Unable to initialize codec #%d\n", i);
-			if (i == 0)
-				goto __err;
-			continue;
-		}
-		chip->ac97[i] = x97;
-		if(ac97_is_modem(x97) && !chip->ichd[ICHD_MDMIN].ac97 ) {
-			chip->ichd[ICHD_MDMIN].ac97 = x97;
-			chip->ichd[ICHD_MDMOUT].ac97 = x97;
-		}
+	ac97.num = glob_sta & ICH_SCR ? 1 : 0;
+	if ((err = snd_ac97_mixer(pbus, &ac97, &x97)) < 0) {
+		snd_printk(KERN_ERR "Unable to initialize codec #%d\n", ac97.num);
+		if (ac97.num == 0)
+			goto __err;
+		return err;
 	}
+	chip->ac97 = x97;
+	if(ac97_is_modem(x97) && !chip->ichd[ICHD_MDMIN].ac97 ) {
+		chip->ichd[ICHD_MDMIN].ac97 = x97;
+		chip->ichd[ICHD_MDMOUT].ac97 = x97;
+	}
+
 	chip->in_ac97_init = 0;
 	return 0;
 
@@ -1006,11 +1003,9 @@
 
 	} else {
 		/* resume phase */
-		int i;
 		status = 0;
-		for (i = 0; i < 3; i++)
-			if (chip->ac97[i])
-				status |= get_ich_codec_bit(chip, i);
+		if (chip->ac97)
+			status |= get_ich_codec_bit(chip, chip->ac97->num);
 		/* wait until all the probed codecs are ready */
 		end_time = jiffies + HZ;
 		do {
@@ -1102,7 +1097,6 @@
 static void intel8x0_resume(intel8x0_t *chip)
 {
 	snd_card_t *card = chip->card;
-	int i;
 
 	if (! chip->in_suspend ||
 	    card->power_state == SNDRV_CTL_POWER_D0)
@@ -1111,9 +1105,8 @@
 	pci_enable_device(chip->pci);
 	pci_set_master(chip->pci);
 	snd_intel8x0_chip_init(chip, 0);
-	for (i = 0; i < 3; i++)
-		if (chip->ac97[i])
-			snd_ac97_resume(chip->ac97[i]);
+	if (chip->ac97)
+		snd_ac97_resume(chip->ac97);
 
 	chip->in_suspend = 0;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);

--Multipart=_Tue__2_Mar_2004_22_34_59_+0200_cb+07NW6g51MoJbI--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
