From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Improve error reporting for Audigy2 cards.
Date: Sun, 27 Feb 2005 18:14:04 +0000
Message-ID: <42220DEC.5010606@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000202090705090109000901"
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DAEC5266
	for <alsa-devel@alsa-project.org>; Sun, 27 Feb 2005 19:14:06 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1D5Sti-000B1h-Gn
	for alsa-devel@alsa-project.org; Sun, 27 Feb 2005 18:12:06 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000202090705090109000901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is a small patch to help with error reporting when the probe of the 
sound card fails. It just tells us in dmesg why it failed, instead of 
failing quietly. This is particularly helpful for diagnosing problems 
with new sound cards. e.g. the as yet unsupported Audigy 2 PCMCIA card.

Signed off: James@superbug.demon.co.uk


--------------000202090705090109000901
Content-Type: text/plain;
 name="audigy2-error-reporting.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audigy2-error-reporting.diff.txt"

Index: alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1.c,v
retrieving revision 1.31
diff -u -r1.31 emu10k1.c
--- alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c	16 Feb 2005 10:25:36 -0000	1.31
+++ alsa-driver/alsa-kernel/pci/emu10k1/emu10k1.c	27 Feb 2005 18:10:15 -0000
@@ -106,16 +106,21 @@
 #endif
 	int err;
 
-	if (dev >= SNDRV_CARDS)
+	if (dev >= SNDRV_CARDS) {
+		snd_printk("Probe failed. Too many cards.\n");
         	return -ENODEV;
+	}
 	if (!enable[dev]) {
 		dev++;
+		snd_printk("Probe failed. Administatively disabled.\n");
 		return -ENOENT;
 	}
 
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	if (card == NULL)
+	if (card == NULL) {
+		snd_printk("Probe failed. Not enough memory for snd_card_new().\n");
 		return -ENOMEM;
+	}
 	if (max_buffer_size[dev] < 32)
 		max_buffer_size[dev] = 32;
 	else if (max_buffer_size[dev] > 1024)
@@ -125,48 +130,58 @@
 				      enable_ir[dev],
 				      &emu)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_create().\n");
 		return err;
 	}		
 	if ((err = snd_emu10k1_pcm(emu, 0, NULL)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_pcm().\n");
 		return err;
 	}		
 	if ((err = snd_emu10k1_pcm_mic(emu, 1, NULL)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_pcm_mic().\n");
 		return err;
 	}		
 	if ((err = snd_emu10k1_pcm_efx(emu, 2, NULL)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_pcm_efx().\n");
 		return err;
 	}		
 	if ((err = snd_emu10k1_mixer(emu)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_mixer().\n");
 		return err;
 	}
 	
 	if ((err = snd_emu10k1_timer(emu, 0)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_timer().\n");
 		return err;
 	}
 
 	if ((err = snd_emu10k1_pcm_multi(emu, 3, NULL)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_pcm_multi().\n");
 		return err;
 	}		
 
 	if (emu->audigy) {
 		if ((err = snd_emu10k1_audigy_midi(emu)) < 0) {
 			snd_card_free(card);
+			snd_printk("Probe failed. Error during snd_emu10k1_audigy_midi().\n");
 			return err;
 		}
 	} else {
 		if ((err = snd_emu10k1_midi(emu)) < 0) {
 			snd_card_free(card);
+			snd_printk("Probe failed. Error during snd_emu10k1_midi().\n");
 			return err;
 		}
 	}
 	if ((err = snd_emu10k1_fx8010_new(emu, 0, NULL)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_emu10k1_fx8010_new().\n");
 		return err;
 	}
 #ifdef ENABLE_SYNTH
@@ -205,6 +220,7 @@
 
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
+		snd_printk("Probe failed. Error during snd_card_register().\n");
 		return err;
 	}
 	pci_set_drvdata(pci, card);

--------------000202090705090109000901--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
