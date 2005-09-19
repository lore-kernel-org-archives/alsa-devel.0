From: Sasha Khapyorsky <sashak@smlink.com>
Subject: [patch] dev_class=SNDRV_PCM_CLASS_MODEM for modem PCMs
Date: Tue, 20 Sep 2005 01:15:39 +0300
Message-ID: <20050919221539.GB15916@tecr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi,

This patch defines all modem PCM's classes as SNDRV_PCM_CLASS_MODEM.

Sasha.


dev_class=SNDRV_PCM_CLASS_MODEM for all supported softmodem PCMs

Signed-off-by: Sasha Khapyorsky <sashak@smlink.com>

Index: alsa-kernel/pci/atiixp_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/atiixp_modem.c,v
retrieving revision 1.22
diff -u -p -r1.22 atiixp_modem.c
--- alsa-kernel/pci/atiixp_modem.c	12 Sep 2005 10:42:16 -0000	1.22
+++ alsa-kernel/pci/atiixp_modem.c	16 Sep 2005 21:44:14 -0000
@@ -989,6 +989,7 @@ static int __devinit snd_atiixp_pcm_new(
 		return err;
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_atiixp_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_atiixp_capture_ops);
+	pcm->dev_class = SNDRV_PCM_CLASS_MODEM;
 	pcm->private_data = chip;
 	strcpy(pcm->name, "ATI IXP MC97");
 	chip->pcmdevs[ATI_PCMDEV_ANALOG] = pcm;
Index: alsa-kernel/pci/intel8x0m.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/intel8x0m.c,v
retrieving revision 1.36
diff -u -p -r1.36 intel8x0m.c
--- alsa-kernel/pci/intel8x0m.c	12 Sep 2005 07:20:55 -0000	1.36
+++ alsa-kernel/pci/intel8x0m.c	16 Sep 2005 21:44:17 -0000
@@ -746,6 +746,7 @@ static int __devinit snd_intel8x0_pcm1(i
 
 	pcm->private_data = chip;
 	pcm->info_flags = 0;
+	pcm->dev_class = SNDRV_PCM_CLASS_MODEM;
 	if (rec->suffix)
 		sprintf(pcm->name, "%s - %s", chip->card->shortname, rec->suffix);
 	else
Index: alsa-kernel/pci/via82xx_modem.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/via82xx_modem.c,v
retrieving revision 1.14
diff -u -p -r1.14 via82xx_modem.c
--- alsa-kernel/pci/via82xx_modem.c	12 Sep 2005 07:20:55 -0000	1.14
+++ alsa-kernel/pci/via82xx_modem.c	16 Sep 2005 21:44:19 -0000
@@ -832,6 +832,7 @@ static int __devinit snd_via686_pcm_new(
 		return err;
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_via686_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_via686_capture_ops);
+	pcm->dev_class = SNDRV_PCM_CLASS_MODEM;
 	pcm->private_data = chip;
 	strcpy(pcm->name, chip->card->shortname);
 	chip->pcms[0] = pcm;
Index: alsa-kernel/pci/ali5451/ali5451.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ali5451/ali5451.c,v
retrieving revision 1.71
diff -u -p -r1.71 ali5451.c
--- alsa-kernel/pci/ali5451/ali5451.c	12 Sep 2005 07:20:55 -0000	1.71
+++ alsa-kernel/pci/ali5451/ali5451.c	16 Sep 2005 21:44:24 -0000
@@ -1795,6 +1795,7 @@ struct ali_pcm_description {
 	unsigned int capture_num;
 	snd_pcm_ops_t *playback_ops;
 	snd_pcm_ops_t *capture_ops;
+	unsigned short class;
 };
 
 
@@ -1818,7 +1819,6 @@ static int __devinit snd_ali_pcm(ali_t *
 	}
 	pcm->private_data = codec;
 	pcm->private_free = snd_ali_pcm_free;
-	pcm->info_flags = 0;
 	if (desc->playback_ops)
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, desc->playback_ops);
 	if (desc->capture_ops)
@@ -1828,6 +1828,7 @@ static int __devinit snd_ali_pcm(ali_t *
 					      snd_dma_pci_data(codec->pci), 64*1024, 128*1024);
 
 	pcm->info_flags = 0;
+	pcm->dev_class = desc->class;
 	pcm->dev_subclass = SNDRV_PCM_SUBCLASS_GENERIC_MIX;
 	strcpy(pcm->name, desc->name);
 	codec->pcm[0] = pcm;
@@ -1836,7 +1837,7 @@ static int __devinit snd_ali_pcm(ali_t *
 
 static struct ali_pcm_description ali_pcms[] = {
 	{ "ALI 5451", ALI_CHANNELS, 1, &snd_ali_playback_ops, &snd_ali_capture_ops },
-	{ "ALI 5451 modem", 1, 1, &snd_ali_modem_playback_ops, &snd_ali_modem_capture_ops }
+	{ "ALI 5451 modem", 1, 1, &snd_ali_modem_playback_ops, &snd_ali_modem_capture_ops, SNDRV_PCM_CLASS_MODEM }
 };
 
 static int __devinit snd_ali_build_pcms(ali_t *codec)
Index: alsa-kernel/pci/hda/hda_intel.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/hda/hda_intel.c,v
retrieving revision 1.23
diff -u -p -r1.23 hda_intel.c
--- alsa-kernel/pci/hda/hda_intel.c	13 Sep 2005 17:49:12 -0000	1.23
+++ alsa-kernel/pci/hda/hda_intel.c	16 Sep 2005 21:44:27 -0000
@@ -1277,6 +1277,7 @@ static int __devinit azx_pcm_create(azx_
 			err = create_codec_pcm(chip, codec, &codec->pcm_info[c], pcm_dev);
 			if (err < 0)
 				return err;
+			chip->pcm[pcm_dev]->dev_class = SNDRV_PCM_CLASS_MODEM;
 			pcm_dev++;
 		}
 	}


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
