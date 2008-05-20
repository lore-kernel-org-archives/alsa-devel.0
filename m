From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] snd-usb-us122l v0.5 for US-122L
Date: Tue, 20 May 2008 12:45:14 +0200
Message-ID: <200805201245.14968.fzu@wemgehoertderstaat.de>
References: <200803161956.42461.fzu@wemgehoertderstaat.de>
	<s5hlk259ud3.wl%tiwai@suse.de>
	<200805201233.17256.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 4156624884
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 12:47:25 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so2234861fka.0
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 03:47:25 -0700 (PDT)
In-Reply-To: <200805201233.17256.fzu@wemgehoertderstaat.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is the ehci patch against 2.6.25.x needed to let the us122l work with my
driver if the device is connected to an ehci-hcd.

I've sent it to linux-usb in february. It hasn't been reviewed yet.

Thanks,
      Karsten

-----------------------------------------------------------------------------

From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Date: Wed, 13 Feb 2008 22:22:09 +0100
Subject: [PATCH] USB: Prevent EHCI ITDs reusage while frame is active

ITDs can be detached from urbs, before the frame elapses. Now those ITDs are
immediately recycled.
If the ITD is reused then, transaction based on its new usage can already
happen while the frame is still active, too early.
Patch takes care of those ITDs by moving them into a new ehci member list
cached_itd_list. ITDs resting in cached_itd_list are moved back into their
stream's free_list once scan_periodic() detects that the active frame has
elapsed.
---
 drivers/usb/host/ehci-hcd.c   |    2 +
 drivers/usb/host/ehci-mem.c   |    1 +
 drivers/usb/host/ehci-sched.c |   57 ++++++++++++++++++++++++++++++++++------
 drivers/usb/host/ehci.h       |    5 +++
 4 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 4caa6a8..b75db12 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -473,6 +473,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	 * periodic_size can shrink by USBCMD update if hcc_params allows.
 	 */
 	ehci->periodic_size = DEFAULT_I_TDPS;
+	INIT_LIST_HEAD(&ehci->cached_itd_list);
 	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
 		return retval;
 
@@ -485,6 +486,7 @@ static int ehci_init(struct usb_hcd *hcd)
 
 	ehci->reclaim = NULL;
 	ehci->next_uframe = -1;
+	ehci->hw_frame = -1;
 
 	/*
 	 * dedicate a qh for the async ring head, since we couldn't unlink
diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
index 0431397..10d5291 100644
--- a/drivers/usb/host/ehci-mem.c
+++ b/drivers/usb/host/ehci-mem.c
@@ -128,6 +128,7 @@ static inline void qh_put (struct ehci_qh *qh)
 
 static void ehci_mem_cleanup (struct ehci_hcd *ehci)
 {
+	free_cached_itd_list(ehci);
 	if (ehci->async)
 		qh_put (ehci->async);
 	ehci->async = NULL;
diff --git a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
index 8a8e08a..f3afade 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1005,7 +1005,8 @@ iso_stream_put(struct ehci_hcd *ehci, struct ehci_iso_stream *stream)
 
 		is_in = (stream->bEndpointAddress & USB_DIR_IN) ? 0x10 : 0;
 		stream->bEndpointAddress &= 0x0f;
-		stream->ep->hcpriv = NULL;
+		if (stream->ep)
+			stream->ep->hcpriv = NULL;
 
 		if (stream->rescheduled) {
 			ehci_info (ehci, "ep%d%s-iso rescheduled "
@@ -1647,14 +1648,26 @@ itd_complete (
 			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
 	}
 	iso_stream_put (ehci, stream);
-	/* OK to recycle this ITD now that its completion callback ran. */
+
 done:
 	usb_put_urb(urb);
 	itd->urb = NULL;
-	itd->stream = NULL;
-	list_move(&itd->itd_list, &stream->free_list);
-	iso_stream_put(ehci, stream);
-
+	if (ehci->hw_frame != itd->frame || itd->index[7] != -1) {
+		/* OK to recycle this ITD now. */
+		itd->stream = NULL;
+		list_move(&itd->itd_list, &stream->free_list);
+		iso_stream_put(ehci, stream);
+	} else {
+		/* HW might still start transactions based on this ITD.
+		   If its content changed that is. Move it to a safe place. */
+		list_move(&itd->itd_list, &ehci->cached_itd_list);
+		if (stream->refcount == 2) {
+			/* If iso_stream_put() would be called here, stream
+			   would be freed. Prevent stream's reusage instead. */
+			stream->ep->hcpriv = NULL;
+			stream->ep = NULL;
+		}
+	}
 	return retval;
 }
 
@@ -2100,10 +2113,24 @@ done:
 
 /*-------------------------------------------------------------------------*/
 
+static void free_cached_itd_list(struct ehci_hcd *ehci)
+{
+	struct ehci_itd *itd, *n;
+
+	list_for_each_entry_safe(itd, n, &ehci->cached_itd_list, itd_list) {
+		struct ehci_iso_stream	*stream = itd->stream;
+		itd->stream = NULL;
+		list_move(&itd->itd_list, &stream->free_list);
+		iso_stream_put(ehci, stream);
+	}
+}
+
+/*-------------------------------------------------------------------------*/
+
 static void
 scan_periodic (struct ehci_hcd *ehci)
 {
-	unsigned	frame, clock, now_uframe, mod;
+	unsigned	frame, hw_frame, clock, now_uframe, mod;
 	unsigned	modified;
 
 	mod = ehci->periodic_size << 3;
@@ -2114,10 +2141,17 @@ scan_periodic (struct ehci_hcd *ehci)
 	 * Touches as few pages as possible:  cache-friendly.
 	 */
 	now_uframe = ehci->next_uframe;
-	if (HC_IS_RUNNING (ehci_to_hcd(ehci)->state))
+	if (HC_IS_RUNNING(ehci_to_hcd(ehci)->state)) {
 		clock = ehci_readl(ehci, &ehci->regs->frame_index);
-	else
+		hw_frame = (clock >> 3) % ehci->periodic_size;
+	} else  {
 		clock = now_uframe + mod - 1;
+		hw_frame = -1;
+	}
+	if (ehci->hw_frame != hw_frame) {
+		free_cached_itd_list(ehci);
+		ehci->hw_frame = hw_frame;
+	}
 	clock %= mod;
 
 	for (;;) {
@@ -2268,6 +2302,11 @@ restart:
 
 			/* rescan the rest of this frame, then ... */
 			clock = now;
+			hw_frame = (clock >> 3);
+			if (ehci->hw_frame != hw_frame) {
+				free_cached_itd_list(ehci);
+				ehci->hw_frame = hw_frame;
+			}
 		} else {
 			now_uframe++;
 			now_uframe %= mod;
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index bf92d20..c61dcb6 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -86,6 +86,9 @@ struct ehci_hcd {			/* one per controller */
 	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
 	int			next_uframe;	/* scan periodic, start here */
 	unsigned		periodic_sched;	/* periodic activity count */
+	struct list_head	cached_itd_list; /* list of itds completed
+			while frame hadn't yet elapsed */
+	unsigned		hw_frame;
 
 	/* per root hub port */
 	unsigned long		reset_done [EHCI_MAX_ROOT_PORTS];
@@ -203,6 +206,8 @@ timer_action (struct ehci_hcd *ehci, enum ehci_timer_action action)
 	}
 }
 
+static void free_cached_itd_list(struct ehci_hcd *ehci);
+
 /*-------------------------------------------------------------------------*/
 
 /* EHCI register interface, corresponds to EHCI Revision 0.95 specification */
-- 
1.5.3.8
