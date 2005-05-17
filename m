From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: High Speed USB Support?
Date: Tue, 17 May 2005 12:42:23 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505171239130.4787-100000@studcom.urz.uni-halle.de>
References: <33485.192.168.0.245.1115909520.squirrel@www.teg-electronics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <33485.192.168.0.245.1115909520.squirrel@www.teg-electronics.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mailinglist@teg-electronics.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

mailinglist@teg-electronics.com wrote:
> if I send the wrong byte order to the feedback endpoint which may
> lock the computer (I guess I shouldn't do that :-) ).

Thanks, fixed now.  :-)

> I was hoping to avoid having do develop a driver by folowing the
> USB audio spec, unfortunately neither the general USB audio driver
> in Windows or Linux seems to support High Speed USB.

Playback on the Audigy 2 NX works fine now.

Please try the latest driver (my patch should be on the public
SourceForge CVS server in a few hours), _and_ apply the following
patch to the kernel:


Index: linux-2.6.11/drivers/usb/host/ehci-sched.c
===================================================================
--- linux-2.6.11.orig/drivers/usb/host/ehci-sched.c	2005-03-02 22:00:29.000000000 +0100
+++ linux-2.6.11/drivers/usb/host/ehci-sched.c	2005-05-14 16:41:21.000000000 +0200
@@ -1203,8 +1203,7 @@
 	struct ehci_itd		*itd,
 	struct ehci_iso_sched	*iso_sched,
 	unsigned		index,
-	u16			uframe,
-	int			first
+	u16			uframe
 )
 {
 	struct ehci_iso_packet	*uf = &iso_sched->packet [index];
@@ -1221,7 +1220,7 @@
 	itd->hw_bufp_hi [pg] |= cpu_to_le32 ((u32)(uf->bufp >> 32));

 	/* iso_frame_desc[].offset must be strictly increasing */
-	if (unlikely (!first && uf->cross)) {
+	if (unlikely (uf->cross)) {
 		u64	bufp = uf->bufp + 4096;
 		itd->pg = ++pg;
 		itd->hw_bufp [pg] |= cpu_to_le32 (bufp & ~(u32)0);
@@ -1250,7 +1249,7 @@
 	struct ehci_iso_stream	*stream
 )
 {
-	int			packet, first = 1;
+	int			packet;
 	unsigned		next_uframe, uframe, frame;
 	struct ehci_iso_sched	*iso_sched = urb->hcpriv;
 	struct ehci_itd		*itd;
@@ -1283,7 +1282,6 @@
 			list_move_tail (&itd->itd_list, &stream->td_list);
 			itd->stream = iso_stream_get (stream);
 			itd->urb = usb_get_urb (urb);
-			first = 1;
 			itd_init (stream, itd);
 		}

@@ -1291,8 +1289,7 @@
 		frame = next_uframe >> 3;

 		itd->usecs [uframe] = stream->usecs;
-		itd_patch (itd, iso_sched, packet, uframe, first);
-		first = 0;
+		itd_patch (itd, iso_sched, packet, uframe);

 		next_uframe += stream->interval;
 		stream->depth += stream->interval;



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
