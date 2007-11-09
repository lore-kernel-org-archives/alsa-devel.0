From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [linux-usb-devel] [PATCH] ehci-hcd: complete iso
	urbs ASAP for number_of_packets != (n * 8) also
Date: Fri, 9 Nov 2007 20:47:38 +0100
Message-ID: <200711092047.38769.fzu@wemgehoertderstaat.de>
References: <200711071616.34194.fzu@wemgehoertderstaat.de>
	<200711081344.23149.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	by alsa0.perex.cz (Postfix) with ESMTP id B737B2440A
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 20:47:46 +0100 (CET)
In-Reply-To: <200711081344.23149.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Brownell <david-b@pacbell.net>
Cc: alsa-devel@alsa-project.org, linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 8. November 2007 schrieb David Brownell:
> 
> Looks interesting, but could you make this apply to *BOTH* types of
> ISO transfer descriptor?  You did it for ITDs, but not Split-ITDs.

Done. Split-ITD changes untested.
> 
> Plus there are two non-technical problems with this patch.  First,
> it doesn't apply against 2.6.24-rc2-git; second, it triggers lots
> of messages from scripts/checkpatch.pl ... both issues need to get
> fixed before I can properly review this.

Fixed.

      Karsten

------------------------------------->

From: Karsten Wiese <fzu@wemgehoertderstaat.de>

ehci-hcd: complete iso urbs ASAP for number_of_packets != (n * 8) also

Upstream ehci-hcd only completes iso urbs, if the last frame (= 8 uframes)
they overlapped with has elapsed. That can be as late as when the following
urb emits its interrupt on completion.
soundcard drivers tend to work around by only transfering iso urbs with
number_of_packets = (n * 8).
Patch lets iso urbs complete asap by scanning ITDs always up to the elapsed
uframe. An ITD's last scanned uframe is stored in the new struct ehci_itd
member uframe_scanned.
ITDs stay kept in the hcd's schedule until the complete frame they cover
has elapsed, like without patch.
To make this possible, ehci->periodic_sched is changed based on the number of
active itds instead of the number of active iso urbs.
SITD handling is unchanged, only sitd_complete() is renamed to sitd_scan() and
the active check is moved to sitd_scan() to make the "case Q_TYPE_ITD:" and
"case Q_TYPE_SITD:" sections under scan_periodic() look alike.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>
---
 drivers/usb/host/ehci-sched.c |  156 ++++++++++++++++++++---------------------
 drivers/usb/host/ehci.h       |    3 +-
 2 files changed, 76 insertions(+), 83 deletions(-)

diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 80d99bc..e647842 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1486,6 +1486,8 @@ itd_link (struct ehci_hcd *ehci, unsigned frame, struct ehci_itd *itd)
 	itd->frame = frame;
 	wmb ();
 	ehci->periodic[frame] = cpu_to_hc32(ehci, itd->itd_dma | Q_TYPE_ITD);
+	if (unlikely(!ehci->periodic_sched++))
+		enable_periodic(ehci);
 }
 
 /* fit urb's itds into the selected schedule slot; activate as needed */
@@ -1558,30 +1560,28 @@ itd_link_urb (
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
+itd_scan(struct ehci_hcd *ehci, struct ehci_itd *itd, unsigned uframe_after)
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
+		struct usb_device *dev;
+
 		if (likely (itd->index[uframe] == -1))
 			continue;
+
 		urb_index = itd->index[uframe];
 		desc = &urb->iso_frame_desc [urb_index];
 
@@ -1608,45 +1608,54 @@ itd_complete (
 			desc->status = 0;
 			desc->actual_length = EHCI_ITD_LENGTH (t);
 		}
-	}
 
-	usb_put_urb (urb);
-	itd->urb = NULL;
-	itd->stream = NULL;
-	list_move (&itd->itd_list, &stream->free_list);
-	iso_stream_put (ehci, stream);
-
-	/* handle completion now? */
-	if (likely ((urb_index + 1) != urb->number_of_packets))
-		return 0;
+		/* handle completion now? */
+		if (urb_index + 1 != urb->number_of_packets)
+			continue;
 
-	/* ASSERT: it's really the last itd for this urb
-	list_for_each_entry (itd, &stream->td_list, itd_list)
-		BUG_ON (itd->urb == urb);
-	 */
+		usb_put_urb(urb);
+		/* ASSERT: it's really the last itd for this urb
+		   struct ehci_itd	*stritd;
+		   list_for_each_entry(stritd, &stream->td_list, itd_list)
+			BUG_ON(stritd != itd && stritd->urb == urb);
+		*/
+		itd->urb = NULL;
 
-	/* give urb back to the driver ... can be out-of-order */
-	dev = urb->dev;
-	ehci_urb_done(ehci, urb, 0);
-	urb = NULL;
+		/* give urb back to the driver ... can be out-of-order */
+		dev = urb->dev;
+		ehci_urb_done(ehci, urb, 0);
+		urb = NULL;
 
-	/* defer stopping schedule; completion can submit */
-	ehci->periodic_sched--;
-	if (unlikely (!ehci->periodic_sched))
-		(void) disable_periodic (ehci);
-	ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
+		ehci_to_hcd(ehci)->self.bandwidth_isoc_reqs--;
 
-	if (unlikely (list_empty (&stream->td_list))) {
-		ehci_to_hcd(ehci)->self.bandwidth_allocated
+		if (unlikely(list_empty(&stream->td_list))) {
+			ehci_to_hcd(ehci)->self.bandwidth_allocated
 				-= stream->bandwidth;
-		ehci_vdbg (ehci,
-			"deschedule devp %s ep%d%s-iso\n",
-			dev->devpath, stream->bEndpointAddress & 0x0f,
-			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
+			ehci_vdbg(ehci,
+				   "deschedule devp %s ep%d%s-iso\n",
+				   dev->devpath,
+				   stream->bEndpointAddress & 0x0f,
+				   (stream->bEndpointAddress & USB_DIR_IN) ?
+				   "in" : "out");
+		}
+		iso_stream_put(ehci, stream);
 	}
+
+	itd->uframe_scanned = uframe_after;
+	if (uframe_after < 8)
+		return false;
+
+	itd->stream = NULL;
+	itd->uframe_scanned = 0;
+	list_move(&itd->itd_list, &stream->free_list);
 	iso_stream_put (ehci, stream);
 
-	return 1;
+	/* defer stopping schedule; completion can submit */
+	ehci->periodic_sched--;
+	if (unlikely(!ehci->periodic_sched))
+		disable_periodic(ehci);
+
+	return true;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -1950,11 +1959,9 @@ sitd_link_urb (
 #define	SITD_ERRS (SITD_STS_ERR | SITD_STS_DBE | SITD_STS_BABBLE \
 				| SITD_STS_XACT | SITD_STS_MMF)
 
-static unsigned
-sitd_complete (
-	struct ehci_hcd		*ehci,
-	struct ehci_sitd	*sitd
-) {
+static bool
+sitd_scan(struct ehci_hcd *ehci, struct ehci_sitd *sitd, int live)
+{
 	struct urb				*urb = sitd->urb;
 	struct usb_iso_packet_descriptor	*desc;
 	u32					t;
@@ -1962,9 +1969,12 @@ sitd_complete (
 	struct ehci_iso_stream			*stream = sitd->stream;
 	struct usb_device			*dev;
 
+	t = hc32_to_cpup(ehci, &sitd->hw_results);
+	if (t & SITD_STS_ACTIVE && live)
+		return false;
+
 	urb_index = sitd->index;
 	desc = &urb->iso_frame_desc [urb_index];
-	t = hc32_to_cpup(ehci, &sitd->hw_results);
 
 	/* report transfer status */
 	if (t & SITD_ERRS) {
@@ -1991,7 +2001,7 @@ sitd_complete (
 
 	/* handle completion now? */
 	if ((urb_index + 1) != urb->number_of_packets)
-		return 0;
+		return true;
 
 	/* ASSERT: it's really the last sitd for this urb
 	list_for_each_entry (sitd, &stream->td_list, sitd_list)
@@ -2019,7 +2029,7 @@ sitd_complete (
 	}
 	iso_stream_put (ehci, stream);
 
-	return 1;
+	return true;
 }
 
 
@@ -2091,13 +2101,11 @@ sitd_submit (struct ehci_hcd *ehci, struct urb *urb, gfp_t mem_flags)
 	return -ENOSYS;
 }
 
-static inline unsigned
-sitd_complete (
-	struct ehci_hcd		*ehci,
-	struct ehci_sitd	*sitd
-) {
-	ehci_err (ehci, "sitd_complete %p?\n", sitd);
-	return 0;
+static inline bool
+sitd_scan(struct ehci_hcd *ehci, struct ehci_sitd *sitd)
+{
+	ehci_err(ehci, "%s %p?\n", __FUNCTION__, sitd);
+	return false;
 }
 
 #endif /* USB_EHCI_SPLIT_ISO */
@@ -2175,47 +2183,33 @@ restart:
 				q = q.fstn->fstn_next;
 				break;
 			case Q_TYPE_ITD:
-				/* skip itds for later in the frame */
 				rmb ();
-				for (uf = live ? uframes : 8; uf < 8; uf++) {
-					if (0 == (q.itd->hw_transaction [uf]
-							& ITD_ACTIVE(ehci)))
-						continue;
+				modified = itd_scan(ehci, q.itd,
+						    uf = live ? uframes : 8);
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
-				if ((q.sitd->hw_results & SITD_ACTIVE(ehci))
-						&& live) {
+				modified = sitd_scan(ehci, q.sitd, live);
+				if (!modified) {
 					q_p = &q.sitd->sitd_next;
 					hw_p = &q.sitd->hw_next;
-					type = Q_NEXT_TYPE(ehci,
-							q.sitd->hw_next);
-					q = *q_p;
-					break;
+				} else {
+					*q_p = q.sitd->sitd_next;
+					*hw_p = q.sitd->hw_next;
 				}
-				*q_p = q.sitd->sitd_next;
-				*hw_p = q.sitd->hw_next;
 				type = Q_NEXT_TYPE(ehci, q.sitd->hw_next);
+
 				wmb();
-				modified = sitd_complete (ehci, q.sitd);
 				q = *q_p;
 				break;
 			default:
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 951d69f..156c02f 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -581,6 +581,7 @@ struct ehci_itd {
 	struct urb		*urb;
 	struct ehci_iso_stream	*stream;	/* endpoint's queue */
 	struct list_head	itd_list;	/* list of stream's itds */
+	unsigned		uframe_scanned;
 
 	/* any/all hw_transactions here may be used by that urb */
 	unsigned		frame;		/* where scheduled */
@@ -615,8 +616,6 @@ struct ehci_sitd {
 #define	SITD_STS_MMF	(1 << 2)	/* incomplete split transaction */
 #define	SITD_STS_STS	(1 << 1)	/* split transaction state */
 
-#define SITD_ACTIVE(ehci)	cpu_to_hc32(ehci, SITD_STS_ACTIVE)
-
 	__hc32			hw_buf [2];		/* EHCI table 3-12 */
 	__hc32			hw_backpointer;		/* EHCI table 3-13 */
 	__hc32			hw_buf_hi [2];		/* Appendix B */
-- 
1.5.3.3
