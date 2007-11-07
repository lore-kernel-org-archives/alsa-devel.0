From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Fwd: [PATCH] ehci-hcd: complete iso urbs ASAP for
	number_of_packets != (n * 8) also
Date: Wed, 7 Nov 2007 16:41:28 +0100
Message-ID: <200711071641.28551.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oydMH4KTeqU+hea"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	by alsa0.perex.cz (Postfix) with ESMTP id 673E52438B
	for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2007 16:41:31 +0100 (CET)
Received: from [195.4.92.19] (helo=9.mx.freenet.de)
	by mout0.freenet.de with esmtpa (Exim 4.68)
	(envelope-from <fzu@wemgehoertderstaat.de>) id 1Ipn22-0001pI-EG
	for alsa-devel@alsa-project.org; Wed, 07 Nov 2007 16:41:30 +0100
Received: from p5b10a195.dip0.t-ipconnect.de ([91.16.161.149]:32828
	helo=[10.130.108.11])
	by 9.mx.freenet.de with esmtpa (ID fzu@wemgehoertderstaat.de) (port 25)
	(Exim 4.68 #1) id 1Ipn21-00073g-Mf
	for alsa-devel@alsa-project.org; Wed, 07 Nov 2007 16:41:30 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_oydMH4KTeqU+hea
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

I just sent attached patch to usb-devel.
It makes special workaround for iso usb communication using ehci-hcd highspeed
needless.
Comments, Bug/success reports welcome!

kind regards
      Karsten

Upstream (as of 2.6.23) ehci-hcd only completes iso urbs, if the last frame
(= 8 uframes) they overlapped with has elapsed. That can be as late as when
the following urb emits its interrupt on completion.
soundcard drivers tend to work around by only transfering iso urbs with
number_of_packets = (n * 8).
Patch lets iso urbs complete asap by scanning itd always up to the elapsed
uframe. An itd's last scanned uframe is stored in the new struct ehci_itd
member uframe_scanned.
Itds stay kept in the hcd's schedule until the complete frame they cover
has elapsed, like without patch.
To make this possible, ehci->periodic_sched is changed based on the number of
active itds instead of the number of active iso urbs.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 drivers/usb/host/ehci-sched.c |  108 ++++++++++++++++++++---------------------
 drivers/usb/host/ehci.h       |    1 +
 2 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index e682f23..c456b16 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1481,6 +1481,8 @@ itd_link (struct ehci_hcd *ehci, unsigned frame, struct ehci_itd *itd)
 	itd->frame = frame;
 	wmb ();
 	ehci->periodic[frame] = cpu_to_hc32(ehci, itd->itd_dma | Q_TYPE_ITD);
+	if (unlikely (!ehci->periodic_sched++))
+		enable_periodic (ehci);
 }
 
 /* fit urb's itds into the selected schedule slot; activate as needed */
@@ -1553,30 +1555,30 @@ itd_link_urb (
 	urb->hcpriv = NULL;
 
 	timer_action (ehci, TIMER_IO_WATCHDOG);
-	if (unlikely (!ehci->periodic_sched++))
-		return enable_periodic (ehci);
 	return 0;
 }
 
 #define	ISO_ERRS (EHCI_ISOC_BUF_ERR | EHCI_ISOC_BABBLE | EHCI_ISOC_XACTERR)
 
-static unsigned
-itd_complete (
-	struct ehci_hcd	*ehci,
-	struct ehci_itd	*itd
-) {
+static bool
+itd_scan (
+	struct ehci_hcd *ehci,
+	struct ehci_itd	*itd,
+	unsigned uframe_after
+)
+{
 	struct urb				*urb = itd->urb;
 	struct usb_iso_packet_descriptor	*desc;
 	u32					t;
 	unsigned				uframe;
 	int					urb_index = -1;
 	struct ehci_iso_stream			*stream = itd->stream;
-	struct usb_device			*dev;
 
 	/* for each uframe with a packet */
-	for (uframe = 0; uframe < 8; uframe++) {
+	for (uframe = itd->uframe_scanned; uframe < uframe_after; uframe++) {
 		if (likely (itd->index[uframe] == -1))
 			continue;
+
 		urb_index = itd->index[uframe];
 		desc = &urb->iso_frame_desc [urb_index];
 
@@ -1603,45 +1605,53 @@ itd_complete (
 			desc->status = 0;
 			desc->actual_length = EHCI_ITD_LENGTH (t);
 		}
+
+		/* handle completion now? */
+		if (urb_index + 1 == urb->number_of_packets) {
+			struct usb_device *dev;
+
+			usb_put_urb (urb);
+			/* ASSERT: it's really the last itd for this urb
+			   struct ehci_itd	*stritd;
+			   list_for_each_entry (stritd, &stream->td_list, itd_list)
+			   BUG_ON (stritd != itd && stritd->urb == urb);
+			*/
+			itd->urb = NULL;
+
+			/* give urb back to the driver ... can be out-of-order */
+			dev = urb->dev;
+			ehci_urb_done (ehci, urb);
+			urb = NULL;
+
+			ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
+
+			if (unlikely (list_empty (&stream->td_list))) {
+				ehci_to_hcd(ehci)->self.bandwidth_allocated
+					-= stream->bandwidth;
+				ehci_vdbg (ehci,
+					   "deschedule devp %s ep%d%s-iso\n",
+					   dev->devpath, stream->bEndpointAddress & 0x0f,
+					   (stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
+			}
+			iso_stream_put (ehci, stream);
+		}
 	}
 
-	usb_put_urb (urb);
-	itd->urb = NULL;
+	itd->uframe_scanned = uframe_after;
+	if (uframe_after < 8)
+		return false;
+
 	itd->stream = NULL;
+	itd->uframe_scanned = 0;
 	list_move (&itd->itd_list, &stream->free_list);
 	iso_stream_put (ehci, stream);
 
-	/* handle completion now? */
-	if (likely ((urb_index + 1) != urb->number_of_packets))
-		return 0;
-
-	/* ASSERT: it's really the last itd for this urb
-	list_for_each_entry (itd, &stream->td_list, itd_list)
-		BUG_ON (itd->urb == urb);
-	 */
-
-	/* give urb back to the driver ... can be out-of-order */
-	dev = urb->dev;
-	ehci_urb_done (ehci, urb);
-	urb = NULL;
-
 	/* defer stopping schedule; completion can submit */
 	ehci->periodic_sched--;
 	if (unlikely (!ehci->periodic_sched))
 		(void) disable_periodic (ehci);
-	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
 
-	if (unlikely (list_empty (&stream->td_list))) {
-		ehci_to_hcd(ehci)->self.bandwidth_allocated
-				-= stream->bandwidth;
-		ehci_vdbg (ehci,
-			"deschedule devp %s ep%d%s-iso\n",
-			dev->devpath, stream->bEndpointAddress & 0x0f,
-			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
-	}
-	iso_stream_put (ehci, stream);
-
-	return 1;
+	return true;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2156,30 +2166,18 @@ restart:
 				q = q.fstn->fstn_next;
 				break;
 			case Q_TYPE_ITD:
-				/* skip itds for later in the frame */
 				rmb ();
-				for (uf = live ? uframes : 8; uf < 8; uf++) {
-					if (0 == (q.itd->hw_transaction [uf]
-							& ITD_ACTIVE(ehci)))
-						continue;
+				modified = itd_scan(ehci, q.itd, uf = live ? uframes : 8);
+				if (!modified) {
 					q_p = &q.itd->itd_next;
 					hw_p = &q.itd->hw_next;
-					type = Q_NEXT_TYPE(ehci,
-							q.itd->hw_next);
-					q = *q_p;
-					break;
+				} else {
+					*q_p = q.itd->itd_next;
+					*hw_p = q.itd->hw_next;
 				}
-				if (uf != 8)
-					break;
-
-				/* this one's ready ... HC won't cache the
-				 * pointer for much longer, if at all.
-				 */
-				*q_p = q.itd->itd_next;
-				*hw_p = q.itd->hw_next;
 				type = Q_NEXT_TYPE(ehci, q.itd->hw_next);
+
 				wmb();
-				modified = itd_complete (ehci, q.itd);
 				q = *q_p;
 				break;
 			case Q_TYPE_SITD:
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 951d69f..df35964 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -581,6 +581,7 @@ struct ehci_itd {
 	struct urb		*urb;
 	struct ehci_iso_stream	*stream;	/* endpoint's queue */
 	struct list_head	itd_list;	/* list of stream's itds */
+	unsigned		uframe_scanned;
 
 	/* any/all hw_transactions here may be used by that urb */
 	unsigned		frame;		/* where scheduled */
-- 
1.5.3.3


--Boundary-00=_oydMH4KTeqU+hea
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: Karsten Wiese <fzu@wemgehoertderstaat.de>: [PATCH] ehci-hcd: complete iso urbs ASAP for number_of_packets != (n * 8) also
Content-Disposition: inline

From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] ehci-hcd: complete iso urbs ASAP for number_of_packets != (n * 8) also
Date: Wed, 7 Nov 2007 16:16:34 +0100
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711071616.34194.fzu@wemgehoertderstaat.de>


Upstream (as of 2.6.23) ehci-hcd only completes iso urbs, if the last frame
(= 8 uframes) they overlapped with has elapsed. That can be as late as when
the following urb emits its interrupt on completion.
soundcard drivers tend to work around by only transfering iso urbs with
number_of_packets = (n * 8).
Patch lets iso urbs complete asap by scanning itd always up to the elapsed
uframe. An itd's last scanned uframe is stored in the new struct ehci_itd
member uframe_scanned.
Itds stay kept in the hcd's schedule until the complete frame they cover
has elapsed, like without patch.
To make this possible, ehci->periodic_sched is changed based on the number of
active itds instead of the number of active iso urbs.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 drivers/usb/host/ehci-sched.c |  108 ++++++++++++++++++++---------------------
 drivers/usb/host/ehci.h       |    1 +
 2 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index e682f23..c456b16 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1481,6 +1481,8 @@ itd_link (struct ehci_hcd *ehci, unsigned frame, struct ehci_itd *itd)
 	itd->frame = frame;
 	wmb ();
 	ehci->periodic[frame] = cpu_to_hc32(ehci, itd->itd_dma | Q_TYPE_ITD);
+	if (unlikely (!ehci->periodic_sched++))
+		enable_periodic (ehci);
 }
 
 /* fit urb's itds into the selected schedule slot; activate as needed */
@@ -1553,30 +1555,30 @@ itd_link_urb (
 	urb->hcpriv = NULL;
 
 	timer_action (ehci, TIMER_IO_WATCHDOG);
-	if (unlikely (!ehci->periodic_sched++))
-		return enable_periodic (ehci);
 	return 0;
 }
 
 #define	ISO_ERRS (EHCI_ISOC_BUF_ERR | EHCI_ISOC_BABBLE | EHCI_ISOC_XACTERR)
 
-static unsigned
-itd_complete (
-	struct ehci_hcd	*ehci,
-	struct ehci_itd	*itd
-) {
+static bool
+itd_scan (
+	struct ehci_hcd *ehci,
+	struct ehci_itd	*itd,
+	unsigned uframe_after
+)
+{
 	struct urb				*urb = itd->urb;
 	struct usb_iso_packet_descriptor	*desc;
 	u32					t;
 	unsigned				uframe;
 	int					urb_index = -1;
 	struct ehci_iso_stream			*stream = itd->stream;
-	struct usb_device			*dev;
 
 	/* for each uframe with a packet */
-	for (uframe = 0; uframe < 8; uframe++) {
+	for (uframe = itd->uframe_scanned; uframe < uframe_after; uframe++) {
 		if (likely (itd->index[uframe] == -1))
 			continue;
+
 		urb_index = itd->index[uframe];
 		desc = &urb->iso_frame_desc [urb_index];
 
@@ -1603,45 +1605,53 @@ itd_complete (
 			desc->status = 0;
 			desc->actual_length = EHCI_ITD_LENGTH (t);
 		}
+
+		/* handle completion now? */
+		if (urb_index + 1 == urb->number_of_packets) {
+			struct usb_device *dev;
+
+			usb_put_urb (urb);
+			/* ASSERT: it's really the last itd for this urb
+			   struct ehci_itd	*stritd;
+			   list_for_each_entry (stritd, &stream->td_list, itd_list)
+			   BUG_ON (stritd != itd && stritd->urb == urb);
+			*/
+			itd->urb = NULL;
+
+			/* give urb back to the driver ... can be out-of-order */
+			dev = urb->dev;
+			ehci_urb_done (ehci, urb);
+			urb = NULL;
+
+			ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
+
+			if (unlikely (list_empty (&stream->td_list))) {
+				ehci_to_hcd(ehci)->self.bandwidth_allocated
+					-= stream->bandwidth;
+				ehci_vdbg (ehci,
+					   "deschedule devp %s ep%d%s-iso\n",
+					   dev->devpath, stream->bEndpointAddress & 0x0f,
+					   (stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
+			}
+			iso_stream_put (ehci, stream);
+		}
 	}
 
-	usb_put_urb (urb);
-	itd->urb = NULL;
+	itd->uframe_scanned = uframe_after;
+	if (uframe_after < 8)
+		return false;
+
 	itd->stream = NULL;
+	itd->uframe_scanned = 0;
 	list_move (&itd->itd_list, &stream->free_list);
 	iso_stream_put (ehci, stream);
 
-	/* handle completion now? */
-	if (likely ((urb_index + 1) != urb->number_of_packets))
-		return 0;
-
-	/* ASSERT: it's really the last itd for this urb
-	list_for_each_entry (itd, &stream->td_list, itd_list)
-		BUG_ON (itd->urb == urb);
-	 */
-
-	/* give urb back to the driver ... can be out-of-order */
-	dev = urb->dev;
-	ehci_urb_done (ehci, urb);
-	urb = NULL;
-
 	/* defer stopping schedule; completion can submit */
 	ehci->periodic_sched--;
 	if (unlikely (!ehci->periodic_sched))
 		(void) disable_periodic (ehci);
-	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
 
-	if (unlikely (list_empty (&stream->td_list))) {
-		ehci_to_hcd(ehci)->self.bandwidth_allocated
-				-= stream->bandwidth;
-		ehci_vdbg (ehci,
-			"deschedule devp %s ep%d%s-iso\n",
-			dev->devpath, stream->bEndpointAddress & 0x0f,
-			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
-	}
-	iso_stream_put (ehci, stream);
-
-	return 1;
+	return true;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2156,30 +2166,18 @@ restart:
 				q = q.fstn->fstn_next;
 				break;
 			case Q_TYPE_ITD:
-				/* skip itds for later in the frame */
 				rmb ();
-				for (uf = live ? uframes : 8; uf < 8; uf++) {
-					if (0 == (q.itd->hw_transaction [uf]
-							& ITD_ACTIVE(ehci)))
-						continue;
+				modified = itd_scan(ehci, q.itd, uf = live ? uframes : 8);
+				if (!modified) {
 					q_p = &q.itd->itd_next;
 					hw_p = &q.itd->hw_next;
-					type = Q_NEXT_TYPE(ehci,
-							q.itd->hw_next);
-					q = *q_p;
-					break;
+				} else {
+					*q_p = q.itd->itd_next;
+					*hw_p = q.itd->hw_next;
 				}
-				if (uf != 8)
-					break;
-
-				/* this one's ready ... HC won't cache the
-				 * pointer for much longer, if at all.
-				 */
-				*q_p = q.itd->itd_next;
-				*hw_p = q.itd->hw_next;
 				type = Q_NEXT_TYPE(ehci, q.itd->hw_next);
+
 				wmb();
-				modified = itd_complete (ehci, q.itd);
 				q = *q_p;
 				break;
 			case Q_TYPE_SITD:
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 951d69f..df35964 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -581,6 +581,7 @@ struct ehci_itd {
 	struct urb		*urb;
 	struct ehci_iso_stream	*stream;	/* endpoint's queue */
 	struct list_head	itd_list;	/* list of stream's itds */
+	unsigned		uframe_scanned;
 
 	/* any/all hw_transactions here may be used by that urb */
 	unsigned		frame;		/* where scheduled */
-- 
1.5.3.3


--Boundary-00=_oydMH4KTeqU+hea
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_oydMH4KTeqU+hea--
