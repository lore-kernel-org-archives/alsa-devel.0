From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y.patch.0.4.1
Date: Tue, 30 Dec 2003 14:35:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312301435.08262.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_M8X8/49wMXOW/A8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_M8X8/49wMXOW/A8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jaroslav,

this fixes 24Bit 4Channel capturing.
Please commit.

Thanks,
Karsten

--Boundary-00=_M8X8/49wMXOW/A8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.4.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.4.1"

Index: usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.4
diff -u -r1.4 usbusx2y.c
--- usbusx2y.c	2 Dec 2003 10:15:02 -0000	1.4
+++ usbusx2y.c	30 Dec 2003 13:21:03 -0000
@@ -1,6 +1,10 @@
 /*
  * usbus428.c - ALSA USB US-428 Driver
  *
+2003-12-30 Karsten Wiese
+	Version 0.4.1:
+	Fix 24Bit 4Channel capturing for the us428.
+
 2003-11-27 Karsten Wiese, Martin Langer
 	Version 0.4:
 	us122 support.
@@ -85,7 +89,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.4");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.4.1");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8007) }}");
Index: usbusx2yaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2yaudio.c,v
retrieving revision 1.4
diff -u -r1.4 usbusx2yaudio.c
--- usbusx2yaudio.c	5 Dec 2003 08:06:19 -0000	1.4
+++ usbusx2yaudio.c	30 Dec 2003 13:21:05 -0000
@@ -141,13 +141,22 @@
  * copy the data from each desctiptor to the pcm buffer, and
  * update the current position.
  */
-static void framecpy_4c(int* p_dma_area, int* cp, int cnt)
+static void framecpy_4c_16(unsigned char *p_dma_area, unsigned char *cp, int cnt)
 {
 	do{
-		*p_dma_area = *cp;
-		p_dma_area += 2;
-		cp++;
-	}while (--cnt);
+		*(int *)p_dma_area = *(int *)cp;
+		p_dma_area += 8;
+		cp += 4;
+	} while (--cnt);
+}
+
+static void framecpy_4c_24(unsigned char *p_dma_area, unsigned char *cp, int cnt)
+{
+	do{
+		memcpy(p_dma_area, cp, 6);
+		p_dma_area +=  12;
+		cp += 6;
+	} while (--cnt);
 }
 
 static int snd_usX2Y_urb_capt_retire(snd_usX2Y_substream_t *subs,
@@ -158,6 +167,10 @@
 	unsigned char	*cp;
 	int 		i, len, lens = 0, hwptr_done = subs->hwptr_done;
 	usX2Ydev_t	*usX2Y = subs->stream->usX2Y;
+	void (*fourc_cpy)(unsigned char* p_dma_area, unsigned char* cp, int cnt) = 0;
+
+	if (runtime->channels == 4)
+		fourc_cpy = usX2Y->stride == 4 ? framecpy_4c_16 : framecpy_4c_24;
 
 	for (i = 0; i < NRPACKS; i++) {
 		cp = (unsigned char*)urb->transfer_buffer + urb->iso_frame_desc[i].offset;
@@ -200,21 +213,21 @@
 		/* copy a data chunk */
 		if ((hwptr_done + len) > runtime->buffer_size) {
 			int cnt = runtime->buffer_size - hwptr_done;
-			if (runtime->channels != 4) {
+			if (fourc_cpy) {
+				unsigned char *p_dma_area = runtime->dma_area + (urb->pipe == subs->datapipe[0] ? 0 : usX2Y->stride);
+				fourc_cpy(p_dma_area + hwptr_done * usX2Y->stride * 2, cp, cnt);
+				fourc_cpy(p_dma_area, cp + cnt * usX2Y->stride, len - cnt);
+			} else {
 				int blen = cnt * usX2Y->stride;
 				memcpy(runtime->dma_area + hwptr_done * usX2Y->stride, cp, blen);
 				memcpy(runtime->dma_area, cp + blen, len * usX2Y->stride - blen);
-			} else {
-				int* p_dma_area = (int*)runtime->dma_area + (urb->pipe == subs->datapipe[0] ? 0 : 1);
-				framecpy_4c(p_dma_area + hwptr_done * 2, (int*)cp, cnt);
-				framecpy_4c(p_dma_area, (int*)cp + cnt, len - cnt);
 			}
 		} else {
-			if (runtime->channels != 4) {
-				memcpy(runtime->dma_area + hwptr_done * usX2Y->stride, cp, len * usX2Y->stride);
+			if (fourc_cpy) {
+				unsigned char *p_dma_area = runtime->dma_area + (urb->pipe == subs->datapipe[0] ? 0 : usX2Y->stride);
+				fourc_cpy(p_dma_area + hwptr_done * usX2Y->stride * 2, cp, len);
 			} else {
-				int* p_dma_area = (int*)runtime->dma_area + (urb->pipe == subs->datapipe[0] ? 0 : 1);
-				framecpy_4c(p_dma_area + hwptr_done * 2, (int*)cp, len);
+				memcpy(runtime->dma_area + hwptr_done * usX2Y->stride, cp, len * usX2Y->stride);
 			}
 		}
 		lens += len;
@@ -290,7 +303,8 @@
 	} else {
 		/* set the buffer pointer */
 		urb->transfer_buffer = runtime->dma_area + subs->hwptr * usX2Y->stride;
-		subs->hwptr += count;
+		if ((subs->hwptr += count) >= runtime->buffer_size)
+			subs->hwptr -= runtime->buffer_size;			
 	}
 	spin_unlock_irqrestore(&subs->lock, flags);
 	urb->transfer_buffer_length = count * usX2Y->stride;

--Boundary-00=_M8X8/49wMXOW/A8--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
