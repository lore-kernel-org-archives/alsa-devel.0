From: Sasha Khapyorsky <sashak@smlink.com>
Subject: atiixp_modem.c patch + problem.
Date: Wed, 7 Jul 2004 21:48:50 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040707214850.55a91c52@sashak.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__7_Jul_2004_21_48_50_+0300_HM2ZlSfC6tlbEOsD"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.netalsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
Cc: Alastair Poole <unixtricks@btinternet.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Wed__7_Jul_2004_21_48_50_+0300_HM2ZlSfC6tlbEOsD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello All,

I've played with atiixp modem driver and there is the patch for
atiixp_modem.c (also attached to [ALSA - driver 0000259]). Now the
driver is able to setup HOOK state and line level,rate.

However there still be a problem, and I need your suggestions to solve
this.

The problem is that there is 32-bit (only?) dma transfer, but modem
expects 16-bit samples (1 channel, S16_LE). For instance: with 1 channel
capture setup dma data actually looks like 2 channels frames (valid
samples are in right channel), sample rate is doubled and readi()
returns buffer with 2 channels frames.

I think that valid samples may be separated by using copy() callback,
but not sure that this is optimal and suitable way.

Also since I don't have sophisticated spec for this hardware, I am not
sure that there is no possibility just to setup DMA appropriately.

Any suggestions?

TIA,

Sasha.


--Multipart=_Wed__7_Jul_2004_21_48_50_+0300_HM2ZlSfC6tlbEOsD
Content-Type: text/x-patch;
 name="atiixp_modem.c.patch"
Content-Disposition: attachment;
 filename="atiixp_modem.c.patch"
Content-Transfer-Encoding: 7bit

Index: alsa-driver/pci/atiixp_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/atiixp_modem.c,v
retrieving revision 1.6
diff -u -b -B -r1.6 atiixp_modem.c
--- alsa-driver/pci/atiixp_modem.c	5 Jul 2004 15:07:21 -0000	1.6
+++ alsa-driver/pci/atiixp_modem.c	7 Jul 2004 14:06:49 -0000
@@ -155,8 +155,11 @@
 #define ATI_REG_MODEM_OUT_DMA3_DT_CUR	0x64
 #define ATI_REG_MODEM_OUT_DMA12_DT_SIZE	0x68
 #define ATI_REG_MODEM_OUT_DMA3_DT_SIZE	0x6c
-#define ATI_REG_MODEM_OUT_GPIO		0x70
-#define ATI_REG_MODEM_IN_GPIO		0x74
+#define ATI_REG_MODEM_OUT_FIFO_USED     0x70
+#define ATI_REG_MODEM_OUT_GPIO		0x74
+#define  ATI_REG_MODEM_OUT_GPIO_EN	   1
+#define  ATI_REG_MODEM_OUT_GPIO_DATA_SHIFT 5
+#define ATI_REG_MODEM_IN_GPIO		0x78
 
 #define ATI_REG_MODEM_MIRROR		0x7c
 #define ATI_REG_AUDIO_MIRROR		0x80
@@ -355,7 +358,7 @@
 		dma->period_bytes = dma->periods = 0; /* clear */
 	}
 
-	if (dma->periods == dma->periods && dma->period_bytes == period_bytes)
+	if (dma->periods == periods && dma->period_bytes == period_bytes)
 		return 0;
 
 	/* reset DMA before changing the descriptor table */
@@ -676,6 +679,7 @@
 {
 	atiixp_t *chip = snd_pcm_substream_chip(substream);
 	atiixp_dma_t *dma = (atiixp_dma_t *)substream->runtime->private_data;
+	unsigned int reg = 0;
 	int i;
 
 	snd_assert(dma->ops->enable_transfer && dma->ops->flush_dma, return -EINVAL);
@@ -683,15 +687,22 @@
 	if (cmd != SNDRV_PCM_TRIGGER_START && cmd != SNDRV_PCM_TRIGGER_STOP)
 		return -EINVAL;
 
+	spin_lock(&chip->reg_lock);
+
+	/* hook off/on: via GPIO_OUT */
 	for (i = 0; i < NUM_ATI_CODECS; i++) {
-		if (chip->ac97[i])
-			snd_ac97_update_bits(chip->ac97[i], AC97_GPIO_STATUS,
-					     AC97_GPIO_LINE1_OH,
-					     cmd == SNDRV_PCM_TRIGGER_START ?
-					     AC97_GPIO_LINE1_OH : 0);
+		if (chip->ac97[i]) {
+			reg = snd_ac97_read(chip->ac97[i], AC97_GPIO_STATUS);
+			break;
 	}
+	}
+	if(cmd == SNDRV_PCM_TRIGGER_START)
+		reg |= AC97_GPIO_LINE1_OH;
+	else
+		reg &= ~AC97_GPIO_LINE1_OH;
+	reg = (reg << ATI_REG_MODEM_OUT_GPIO_DATA_SHIFT) | ATI_REG_MODEM_OUT_GPIO_EN ;
+	atiixp_write(chip, MODEM_OUT_GPIO, reg);
 
-	spin_lock(&chip->reg_lock);
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
 		dma->ops->enable_transfer(chip, 1);
 		dma->running = 1;
@@ -818,8 +829,8 @@
 	for (i = 0; i < NUM_ATI_CODECS; i++) {
 		if (! chip->ac97[i])
 			continue;
-		snd_ac97_update(chip->ac97[i], AC97_LINE1_RATE, params_rate(hw_params));
-		snd_ac97_update(chip->ac97[i], AC97_LINE1_LEVEL, 0);
+		snd_ac97_write(chip->ac97[i], AC97_LINE1_RATE, params_rate(hw_params));
+		snd_ac97_write(chip->ac97[i], AC97_LINE1_LEVEL, 0);
 	}
 
 	return err;

--Multipart=_Wed__7_Jul_2004_21_48_50_+0300_HM2ZlSfC6tlbEOsD--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
