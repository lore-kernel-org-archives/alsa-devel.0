From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y
Date: Thu, 27 Nov 2003 15:44:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311271544.21367.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_F3gx/I0/7KmqKxo"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_F3gx/I0/7KmqKxo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

this fixes an us428 error that crept in during us122 merge.
Please commit with comment:
- Start devices audio-engine on driver startup.
- Prepare for us224 - Tests.

Thanks,
Karsten

--Boundary-00=_F3gx/I0/7KmqKxo
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.4"

Index: alsa-driver/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.2
diff -u -r1.2 usbusx2y.c
--- alsa-driver/usb/usx2y/usbusx2y.c	26 Nov 2003 10:01:28 -0000	1.2
+++ alsa-driver/usb/usx2y/usbusx2y.c	27 Nov 2003 14:32:23 -0000
@@ -1,6 +1,11 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2003-11-27 Karsten Wiese, Martin Langer
+	Version 0.4:
+	us122 support.
+	us224 could be tested by uncommenting the sections containing USB_ID_US224
+
 2003-11-03 Karsten Wiese
 	Version 0.3:
 	24Bit support. 
@@ -229,6 +234,11 @@
 		.idVendor =	0x1604,
 		.idProduct =	USB_ID_US122 
 	},
+/* 	{ FIXME: uncomment  to test us224 support*/
+/* 		.match_flags =	USB_DEVICE_ID_MATCH_DEVICE, */
+/* 		.idVendor =	0x1604, */
+/* 		.idProduct =	USB_ID_US224  */
+/* 	}, */
 	{ /* terminator */ }
 };
 
@@ -268,7 +278,7 @@
 	int		err;
 	snd_card_t*	card;
 	if (device->descriptor.idVendor != 0x1604 ||
-	    (device->descriptor.idProduct != USB_ID_US122 && device->descriptor.idProduct != USB_ID_US428) ||
+	    (device->descriptor.idProduct != USB_ID_US122 && /* device->descriptor.idProduct != USB_ID_US224 && */ device->descriptor.idProduct != USB_ID_US428) ||
 	    !(card = snd_usX2Y_create_card(device)))
 		return 0;
 	if ((err = snd_usX2Y_hwdep_new(card, device)) < 0  ||
Index: alsa-driver/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.1
diff -u -r1.1 usbusx2yaudio.c
--- alsa-driver/usb/usx2y/usbusx2yaudio.c	25 Nov 2003 11:21:49 -0000	1.1
+++ alsa-driver/usb/usx2y/usbusx2yaudio.c	27 Nov 2003 14:32:25 -0000
@@ -1225,7 +1225,8 @@
 	sprintf(pcm->name, NAME_ALLCAPS" Audio #%d", usX2Y(card)->chip.pcm_devs);
 
 	if (0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream,  64*1024, 128*1024, GFP_ATOMIC))
-	    || 0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream ,  usX2Y_capt_substream->endpoints * 64*1024, usX2Y_capt_substream->endpoints * 128*1024, GFP_ATOMIC))) {
+	    || 0 > (err = snd_pcm_lib_preallocate_pages(pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream ,  usX2Y_capt_substream->endpoints * 64*1024, usX2Y_capt_substream->endpoints * 128*1024, GFP_ATOMIC))
+	    || 0 > (err = usX2Y_rate_set(usX2Y_stream, 44100))) {  // needed to make us428 recognize output-volume settings for direct-monitoring and master-pcm. shouldn't disturb other usx2y.
 		snd_usX2Y_audio_stream_free(usX2Y_stream);
 		return err;
 	}

--Boundary-00=_F3gx/I0/7KmqKxo--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
