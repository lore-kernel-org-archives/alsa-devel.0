From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.8.7: Use macro usb_maxpacket() for portability
Date: Thu, 2 Dec 2004 13:19:19 +0100
Message-ID: <200412021319.20027.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HhwrBTKMMLRAzRz"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_HhwrBTKMMLRAzRz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

on the usb-devel list there is a similar patch by David Brownell:
http://marc.theaimsgroup.com/?i=<200411281314.50175.david-b%20()%20pacbell%20!%20net>
David's patch doesn't compile on current kernel, so I wrote this one.

regards,
Karsten

patch header:
>>>>
Summary: Use macro usb_maxpacket() for portability.

In future kernels struct usb_device won't have the epmaxpacketin/out members.
Use macro usb_maxpacket() instead of directly accessing those members.

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
<<<<

--Boundary-00=_HhwrBTKMMLRAzRz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.8.7"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.8.7"

Index: alsa-kernel/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2y.c,v
retrieving revision 1.6
diff -U3 -r1.6 usbusx2y.c
--- alsa-kernel/usb/usx2y/usbusx2y.c	29 Nov 2004 14:09:49 -0000	1.6
+++ alsa-kernel/usb/usx2y/usbusx2y.c	2 Dec 2004 11:57:57 -0000
@@ -1,6 +1,10 @@
 /*
  * usbusy2y.c - ALSA USB US-428 Driver
  *
+2004-12-02 Karsten Wiese
+	Version 0.8.7:
+	Use macro usb_maxpacket() for portability.
+
 2004-10-26 Karsten Wiese
 	Version 0.8.6:
 	wake_up() process waiting in usX2Y_urbs_start() on error.
@@ -135,7 +139,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.6");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");
 
Index: alsa-kernel/usb/usx2y/usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.6
diff -U3 -r1.6 usbusx2yaudio.c
--- alsa-kernel/usb/usx2y/usbusx2yaudio.c	27 Oct 2004 07:38:35 -0000	1.6
+++ alsa-kernel/usb/usx2y/usbusx2yaudio.c	2 Dec 2004 11:57:59 -0000
@@ -413,25 +413,23 @@
 static int usX2Y_urbs_allocate(snd_usX2Y_substream_t *subs)
 {
 	int i;
-	unsigned int datapipe;  		/* the data i/o pipe */
+	unsigned int pipe;
 	int is_playback = subs == subs->usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
 	struct usb_device *dev = subs->usX2Y->chip.dev;
 
-	if (is_playback) {	/* allocate a temporary buffer for playback */
-		datapipe = usb_sndisocpipe(dev, subs->endpoint);
-		subs->maxpacksize = dev->epmaxpacketout[subs->endpoint];
+	pipe = is_playback ? usb_sndisocpipe(dev, subs->endpoint) :
+			usb_rcvisocpipe(dev, subs->endpoint);
+	subs->maxpacksize = usb_maxpacket(dev, pipe, is_playback);
+	if (!subs->maxpacksize)
+		return -EINVAL;
+
+	if (is_playback && NULL == subs->tmpbuf) {	/* allocate a temporary buffer for playback */
+		subs->tmpbuf = kcalloc(nr_of_packs(), subs->maxpacksize, GFP_KERNEL);
 		if (NULL == subs->tmpbuf) {
-			subs->tmpbuf = kcalloc(nr_of_packs(), subs->maxpacksize, GFP_KERNEL);
-			if (NULL == subs->tmpbuf) {
-				snd_printk(KERN_ERR "cannot malloc tmpbuf\n");
-				return -ENOMEM;
-			}
+			snd_printk(KERN_ERR "cannot malloc tmpbuf\n");
+			return -ENOMEM;
 		}
-	} else {
-		datapipe = usb_rcvisocpipe(dev, subs->endpoint);
-		subs->maxpacksize = dev->epmaxpacketin[subs->endpoint];
 	}
-
 	/* allocate and initialize data urbs */
 	for (i = 0; i < NRURBS; i++) {
 		struct urb** purb = subs->urb + i;
@@ -453,7 +451,7 @@
 			}
 		}
 		(*purb)->dev = dev;
-		(*purb)->pipe = datapipe;
+		(*purb)->pipe = pipe;
 		(*purb)->number_of_packets = nr_of_packs();
 		(*purb)->context = subs;
 		(*purb)->interval = 1;

--Boundary-00=_HhwrBTKMMLRAzRz--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
