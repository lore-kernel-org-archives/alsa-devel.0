From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH] Repair snd-usb-usx2y over OHCI
Date: Wed, 10 Jan 2007 13:33:27 +0100
Message-ID: <200701101333.27236.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Matt Savigear <mcs_jack@savigear.com>, alsa-devel@lists.sourceforge.net, stable@kernel.org, Rui Capela <rncbc@rncbc.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I messed up OHCI support; Rui and Matt confirmed that this fixes it.
Do you also need an alsa-driver patch?

kind regards
      Karsten

------------------------------------------------------------------------
Subject: Repair snd-usb-usx2y over OHCI
From: Karsten Wiese <fzu@wemgehoertderstaat.de>

The previous patch "Repair snd-usb-usx2y for usb 2.6.18" assumed
urb->start_frame roll over beyond MAX_INT for both UHCI & OHCI.
This isn't true until now (kernel 2.6.20).
Fix this by only looking at the common between OHCI & UHCI Frame number
range.
This is for mainline and stable kernels >= 2.6.18.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>



--- rc6-rt8-kw/sound/usb/usx2y/usbusx2yaudio.c	2006-11-28 18:53:21.000000000 +0100
+++ rc6-rt5-kw/sound/usb/usx2y/usbusx2yaudio.c	2006-12-02 22:43:11.000000000 +0100
@@ -322,7 +322,7 @@ static void i_usX2Y_urb_complete(struct 
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
+	if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 0xFFFF)))
 		subs->completed_urb = urb;
 	else {
 		usX2Y_error_sequence(usX2Y, subs, urb);
--- rc6-rt8-kw/sound/usb/usx2y/usx2yhwdeppcm.c	2006-11-28 18:47:00.000000000 +0100
+++ rc6-rt5-kw/sound/usb/usx2y/usx2yhwdeppcm.c	2006-12-02 22:43:10.000000000 +0100
@@ -243,7 +243,7 @@ static void i_usX2Y_usbpcm_urb_complete(
 		usX2Y_error_urb_status(usX2Y, subs, urb);
 		return;
 	}
-	if (likely(urb->start_frame == usX2Y->wait_iso_frame))
+	if (likely((urb->start_frame & 0xFFFF) == (usX2Y->wait_iso_frame & 0xFFFF)))
 		subs->completed_urb = urb;
 	else {
 		usX2Y_error_sequence(usX2Y, subs, urb);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
