From: Glen Nakamura <glen@imodulo.com>
Subject: [PATCH] Fix typos in alsa-drivers-0.9.5
Date: Wed, 23 Jul 2003 15:01:09 -1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030724010109.GB12995@modulo.internal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Aloha,
This patch fixes a few typos in alsa-drivers-0.9.5...

-glen

diff -Nru3p alsa-driver-0.9.5.orig/alsa-kernel/pci/intel8x0.c alsa-driver-0.9.5/alsa-kernel/pci/intel8x0.c
--- alsa-driver-0.9.5.orig/alsa-kernel/pci/intel8x0.c	2003-06-27 17:52:59.000000000 +0000
+++ alsa-driver-0.9.5/alsa-kernel/pci/intel8x0.c	2003-06-27 17:52:59.000000000 +0000
@@ -1002,7 +1002,7 @@ static int snd_intel8x0_pcm_open(snd_pcm
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	static unsigned int i, rates[] = {
 		/* ATTENTION: these values depend on the definition in pcm.h! */
-		5512, 8000, 11025, 16000, 22050, 32000, 44100, 480000
+		5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000
 	};
 	int err;
 
diff -Nru3p alsa-driver-0.9.5.orig/include/ak4117.h alsa-driver-0.9.5/include/ak4117.h
--- alsa-driver-0.9.5.orig/include/ak4117.h	2003-05-14 20:21:17.000000000 +0000
+++ alsa-driver-0.9.5/include/ak4117.h	2003-05-14 20:21:17.000000000 +0000
@@ -163,7 +163,7 @@ struct ak4117 {
 	ak4117_read_t * read;
 	void * private_data;
 	unsigned int init: 1;
-	spinlock_t * lock;
+	spinlock_t lock;
 	unsigned char regmap[5];
 	snd_kcontrol_t *kctls[AK4117_CONTROLS];
 	snd_pcm_substream_t *substream;
diff -Nru3p alsa-driver-0.9.5.orig/pcmcia/pdaudiocf/pdaudiocf_core.c alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_core.c
--- alsa-driver-0.9.5.orig/pcmcia/pdaudiocf/pdaudiocf_core.c	2003-06-29 14:56:19.000000000 +0000
+++ alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_core.c	2003-06-29 14:56:19.000000000 +0000
@@ -133,8 +133,7 @@ pdacf_t *snd_pdacf_create(snd_card_t *ca
 	if (chip == NULL)
 		return NULL;
 	chip->card = card;
-	spin_lock_init(&chip->lock);
-	spin_lock_init(&chip->irq_lock);
+	spin_lock_init(&chip->reg_lock);
 	spin_lock_init(&chip->ak4117_lock);
 	tasklet_init(&chip->tq, pdacf_tasklet, (unsigned long)chip);
 	card->private_data = chip;
diff -Nru3p alsa-driver-0.9.5.orig/pcmcia/pdaudiocf/pdaudiocf_pcm.c alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_pcm.c
--- alsa-driver-0.9.5.orig/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2003-06-29 14:56:19.000000000 +0000
+++ alsa-driver-0.9.5/pcmcia/pdaudiocf/pdaudiocf_pcm.c	2003-06-29 14:56:19.000000000 +0000
@@ -126,7 +126,7 @@ static int pdacf_pcm_trigger(snd_pcm_sub
 	tmp |= val;
 	pdacf_reg_write(chip, PDAUDIOCF_REG_SCR, tmp);
       __end:
-	spin_unlock(&chip_reg_lock);
+	spin_unlock(&chip->reg_lock);
 	if (cmd == SNDRV_PCM_TRIGGER_STOP)
 		pdacf_reinit(chip, 0);
 	snd_ak4117_check_rate_and_errors(chip->ak4117, AK4117_CHECK_NO_RATE);


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
