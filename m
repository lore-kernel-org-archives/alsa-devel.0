From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: ATI IXP Modem driver
Date: Sun, 25 Jul 2004 18:21:54 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040725182154.3317e5d8@sashak.lan>
References: <1083465072.1639.8.camel@server.gowanlea.net>
	<20040503163657.668357a9@sashak.lan>
	<1087962001.4844.0.camel@server.gowanlea.net>
	<20040711191833.462a0b4b@sashak.lan>
	<s5hr7rhcztt.wl@alsa2.suse.de>
	<20040712162839.2c58e1c3@sashak.lan>
	<s5hd631cq5v.wl@alsa2.suse.de>
	<20040712195450.04494434@sashak.lan>
	<s5hr7rhb1tx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__25_Jul_2004_18_21_54_+0300_i.v2OVm1FGhJ3/SQ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7rhb1tx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: unixtricks@btinternet.com, alsa-devel@lists.sourceforge.net, Antonis Tsolomitis <atsol@aegean.gr>, Jacques Goldberg <Jacques.Goldberg@cern.ch>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Sun__25_Jul_2004_18_21_54_+0300_i.v2OVm1FGhJ3/SQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Takashi,

On Mon, 12 Jul 2004 18:57:30 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> 
> The change is already on CVS.

Additional 'atiixp_modem' patch (I cannot upload it to bug#0000259 - it
is fixed already)

The problem was reported at discuss@linmodems.org (and looks like one
that was with intel8x0m in the past) - When modem driver probes codecs
for mixer it mutes all sound devices.

Solution is same as with 'intel8x0m' - to allocate mixer only for modem
codec(MC). The approach is that MC is always last one. This will work
with one and two codecs configurations. Not sure about three codecs (are
there such in practice?), but if 'not' it would be simply fixed by valid
'codec_num' setup.

Best Regards,
Sasha.


--Multipart=_Sun__25_Jul_2004_18_21_54_+0300_i.v2OVm1FGhJ3/SQ
Content-Type: text/x-patch;
 name="ati.patch"
Content-Disposition: attachment;
 filename="ati.patch"
Content-Transfer-Encoding: 7bit

Index: alsa-kernel/pci/atiixp_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/atiixp_modem.c,v
retrieving revision 1.4
diff -u -b -B -r1.4 atiixp_modem.c
--- alsa-kernel/pci/atiixp_modem.c	15 Jul 2004 15:25:22 -0000	1.4
+++ alsa-kernel/pci/atiixp_modem.c	25 Jul 2004 14:39:59 -0000
@@ -246,7 +246,7 @@
 	int irq;
 	
 	ac97_bus_t *ac97_bus;
-	ac97_t *ac97[NUM_ATI_CODECS];
+	ac97_t *mc97;
 
 	spinlock_t reg_lock;
 	spinlock_t ac97_lock;
@@ -674,7 +674,6 @@
 	atiixp_t *chip = snd_pcm_substream_chip(substream);
 	atiixp_dma_t *dma = (atiixp_dma_t *)substream->runtime->private_data;
 	unsigned int reg = 0;
-	int i;
 
 	snd_assert(dma->ops->enable_transfer && dma->ops->flush_dma, return -EINVAL);
 
@@ -684,12 +683,7 @@
 	spin_lock(&chip->reg_lock);
 
 	/* hook off/on: via GPIO_OUT */
-	for (i = 0; i < NUM_ATI_CODECS; i++) {
-		if (chip->ac97[i]) {
-			reg = snd_ac97_read(chip->ac97[i], AC97_GPIO_STATUS);
-			break;
-	}
-	}
+	reg = snd_ac97_read(chip->mc97, AC97_GPIO_STATUS);
 	if(cmd == SNDRV_PCM_TRIGGER_START)
 		reg |= AC97_GPIO_LINE1_OH;
 	else
@@ -805,7 +799,6 @@
 	atiixp_t *chip = snd_pcm_substream_chip(substream);
 	atiixp_dma_t *dma = (atiixp_dma_t *)substream->runtime->private_data;
 	int err;
-	int i;
 
 	err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
 	if (err < 0)
@@ -820,12 +813,8 @@
 		return err;
 
 	/* set up modem rate */
-	for (i = 0; i < NUM_ATI_CODECS; i++) {
-		if (! chip->ac97[i])
-			continue;
-		snd_ac97_write(chip->ac97[i], AC97_LINE1_RATE, params_rate(hw_params));
-		snd_ac97_write(chip->ac97[i], AC97_LINE1_LEVEL, 0);
-	}
+	snd_ac97_write(chip->mc97, AC97_LINE1_RATE, params_rate(hw_params));
+	snd_ac97_write(chip->mc97, AC97_LINE1_LEVEL, 0);
 
 	return err;
 }
@@ -1065,7 +1054,7 @@
 	ac97_bus_t *pbus;
 	ac97_template_t ac97;
 	int i, err;
-	int codec_count;
+	int codec_num;
 	static ac97_bus_ops_t ops = {
 		.write = snd_atiixp_ac97_write,
 		.read = snd_atiixp_ac97_read,
@@ -1084,25 +1073,26 @@
 	pbus->clock = clock;
 	chip->ac97_bus = pbus;
 
-	codec_count = 0;
+	codec_num = -1;
 	for (i = 0; i < NUM_ATI_CODECS; i++) {
 		if (chip->codec_not_ready_bits & codec_skip[i])
-			continue;
+			break;
+		codec_num = i;
+	}
+
+	if(codec_num == -1) {
+		snd_printk(KERN_ERR "atiixp: no codec available\n");
+		return -ENODEV;		
+	}
+
 		memset(&ac97, 0, sizeof(ac97));
 		ac97.private_data = chip;
 		ac97.pci = chip->pci;
-		ac97.num = i;
+	ac97.num = codec_num;
 		ac97.scaps = AC97_SCAP_SKIP_AUDIO;
-		if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i])) < 0) {
-			chip->ac97[i] = NULL; /* to be sure */
-			snd_printdd("atiixp: codec %d not available for modem\n", i);
-			continue;
-		}
-		codec_count++;
-	}
-
-	if (! codec_count) {
-		snd_printk(KERN_ERR "atiixp: no codec available\n");
+	if ((err = snd_ac97_mixer(pbus, &ac97, &chip->mc97)) < 0) {
+		chip->mc97 = NULL; /* to be sure */
+		snd_printdd("atiixp: codec %d not available for modem\n",codec_num);
 		return -ENODEV;
 	}
 
@@ -1124,9 +1114,8 @@
 	for (i = 0; i < NUM_ATI_PCMDEVS; i++)
 		if (chip->pcmdevs[i])
 			snd_pcm_suspend_all(chip->pcmdevs[i]);
-	for (i = 0; i < NUM_ATI_CODECS; i++)
-		if (chip->ac97[i])
-			snd_ac97_suspend(chip->ac97[i]);
+	if (chip->mc97)
+		snd_ac97_suspend(chip->mc97);
 	snd_atiixp_aclink_down(chip);
 	snd_atiixp_chip_stop(chip);
 
@@ -1139,7 +1128,6 @@
 static int snd_atiixp_resume(snd_card_t *card, unsigned int state)
 {
 	atiixp_t *chip = card->pm_private_data;
-	int i;
 
 	pci_enable_device(chip->pci);
 	pci_set_power_state(chip->pci, 0);
@@ -1147,9 +1135,8 @@
 	snd_atiixp_aclink_reset(chip);
 	snd_atiixp_chip_start(chip);
 
-	for (i = 0; i < NUM_ATI_CODECS; i++)
-		if (chip->ac97[i])
-			snd_ac97_resume(chip->ac97[i]);
+	if (chip->mc97)
+		snd_ac97_resume(chip->mc97);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;

--Multipart=_Sun__25_Jul_2004_18_21_54_+0300_i.v2OVm1FGhJ3/SQ--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
