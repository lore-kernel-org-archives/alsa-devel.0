From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: usbus428.c.patch_1.3_1.4
Date: Thu, 25 Sep 2003 11:42:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309251142.44130.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Uirc/Uka+F2PTSp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_Uirc/Uka+F2PTSp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

this makes it work again!

ciao,
Karsten


--Boundary-00=_Uirc/Uka+F2PTSp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="usbus428.c.patch_1.3_1.4"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usbus428.c.patch_1.3_1.4"

Index: alsa-driver/usb/us428/usbus428.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/us428/usbus428.c,v
retrieving revision 1.3
diff -u -r1.3 usbus428.c
--- alsa-driver/usb/us428/usbus428.c	24 Sep 2003 16:45:10 -0000	1.3
+++ alsa-driver/usb/us428/usbus428.c	25 Sep 2003 09:29:07 -0000
@@ -169,15 +169,12 @@
 				int j, send = us428ctls->p4outSent + 1;
 				if (send >= N_us428_p4out_BUFS)
 					send = 0;
-				while (us428ctls->p4out[send].type == eLT_Light && send != us428ctls->p4outLast)
-					if (++send >= N_us428_p4out_BUFS)
-						send = 0;
 				for (j = 0; j < URBS_AsyncSeq; ++j)
 					if (0 == us428->AS04.urb[j]->status) {
 						us428_p4out_t *p4out = us428ctls->p4out + send;	// FIXME if more then 1 p4out is new, 1 gets lost.
 						usb_fill_bulk_urb(us428->AS04.urb[j], us428->chip.dev,
 								  usb_sndbulkpipe(us428->chip.dev, 0x04), &p4out->vol, 
-								  p4out->type == eLT_Light ? sizeof(us428_lights_t) : sizeof(usX2Y_volume_t),
+								  p4out->type == eLT_Light ? sizeof(us428_lights_t) : 5,
 								  snd_us428_Out04Int, us428);
 #ifdef OLD_USB
 						us428->AS04.urb[j]->transfer_flags = USB_QUEUE_BULK;
@@ -225,7 +222,7 @@
 
 	for (dev = 0; dev < SNDRV_CARDS; ++dev)
 		if (enable[dev] && !snd_us428_card_used[dev])
-			return NULL;
+			break;
 
 	if (dev >= SNDRV_CARDS)
 		return NULL;

--Boundary-00=_Uirc/Uka+F2PTSp--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
