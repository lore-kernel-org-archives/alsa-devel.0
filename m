From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: (no subject)
Date: Tue, 27 Jan 2009 01:16:02 +0100
Message-ID: <200901270116.02701.fzu@wemgehoertderstaat.de>
References: <8230211.582121223895071540.JavaMail.www@wwinf1d32>
	<200810141154.27011.fzu@wemgehoertderstaat.de>
	<1223980887.2915.4.camel@pollux.mecaflu.ec-lyon.fr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_CJlfJUbtEYzGQ5Q"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	by alsa0.perex.cz (Postfix) with ESMTP id EE45A1037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 01:16:05 +0100 (CET)
In-Reply-To: <1223980887.2915.4.camel@pollux.mecaflu.ec-lyon.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe Carriere <philippe-f.carriere@wanadoo.fr>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_CJlfJUbtEYzGQ5Q
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Dienstag, 14. Oktober 2008 schrieb Philippe Carriere:
> Might this patch (the original one, without features yet implemented in
> 2.6.26, and an extremely slight modification to fit it) I use on Fedora
> kernel (the patch also applies as it stands to vanilla) save works and
> time ?

I resent the patch to linux-usb@vger.kernel.org today.
Maybe it helps, if you post a "tested-by:" there.

Regards,
Karsten


--Boundary-00=_CJlfJUbtEYzGQ5Q
Content-Type: message/rfc822;
  name="forwarded message"
Content-Transfer-Encoding: 7bit
Content-Description: Karsten Wiese <fzu@wemgehoertderstaat.de>: [RESEND][PATCH] USB: Prevent EHCI ITDs reusage while frame is active
Content-Disposition: inline

From: Karsten Wiese <fzu@wemgehoertderstaat.de>
To: David Brownell <david-b@pacbell.net>
Subject: [RESEND][PATCH] USB: Prevent EHCI ITDs reusage while frame is active
Date: Mon, 26 Jan 2009 14:32:51 +0100
User-Agent: KMail/1.9.9
Cc: linux-usb@vger.kernel.org
References: <200802132238.51929.fzu@wemgehoertderstaat.de> <200803171405.02530.fzu@wemgehoertderstaat.de> <200805201315.08008.fzu@wemgehoertderstaat.de>
In-Reply-To: <200805201315.08008.fzu@wemgehoertderstaat.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901261432.51974.fzu@wemgehoertderstaat.de>

Hi,

this is a refresh to let patch fit ontop 2.6.29-rc2.
Changes from previous version:
- use variable clock_frame instead of hw_frame
- Patch Description exactified
snd_usb_us122l (in kernel since .28) needs it, if device is attached to
ehci.

thanks,
Karsten



----------------------------------------------------------------------
From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Date: Wed, 13 Feb 2008 22:22:09 +0100
Subject: [PATCH] USB: Prevent EHCI ITDs reusage while frame is active

ITDs can be detached from urbs, before the frame elapses. Now those ITDs are
immediately recycled.
If the ITD is reused before the frame elapses, the ITD becomes invalid
regarding the not yet elapsed frame.
Patch takes care of those ITDs by moving them into a new ehci member list
cached_itd_list. ITDs resting in cached_itd_list are moved back into their
stream's free_list once scan_periodic() detects that the active frame has
elapsed.

Signed-off-by: Karsten Wiese <fzu@wemgehoertderstaat.de>

---
 drivers/usb/host/ehci-hcd.c   |    2 +
 drivers/usb/host/ehci-mem.c   |    1 +
 drivers/usb/host/ehci-sched.c |   54 ++++++++++++++++++++++++++++++++++------
 drivers/usb/host/ehci.h       |    5 ++++
 4 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 4725d15..e551bb3 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -485,6 +485,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	 * periodic_size can shrink by USBCMD update if hcc_params allows.
 	 */
 	ehci->periodic_size = DEFAULT_I_TDPS;
+	INIT_LIST_HEAD(&ehci->cached_itd_list);
 	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
 		return retval;
 
@@ -497,6 +498,7 @@ static int ehci_init(struct usb_hcd *hcd)
 
 	ehci->reclaim = NULL;
 	ehci->next_uframe = -1;
+	ehci->clock_frame = -1;
 
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
index a081ee6..c1f7d5f 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -1004,7 +1004,8 @@ iso_stream_put(struct ehci_hcd *ehci, struct ehci_iso_stream *stream)
 
 		is_in = (stream->bEndpointAddress & USB_DIR_IN) ? 0x10 : 0;
 		stream->bEndpointAddress &= 0x0f;
-		stream->ep->hcpriv = NULL;
+		if (stream->ep)
+			stream->ep->hcpriv = NULL;
 
 		if (stream->rescheduled) {
 			ehci_info (ehci, "ep%d%s-iso rescheduled "
@@ -1653,14 +1654,26 @@ itd_complete (
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
+	if (ehci->clock_frame != itd->frame || itd->index[7] != -1) {
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
 
@@ -2101,6 +2114,20 @@ done:
 
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
@@ -2115,10 +2142,17 @@ scan_periodic (struct ehci_hcd *ehci)
 	 * Touches as few pages as possible:  cache-friendly.
 	 */
 	now_uframe = ehci->next_uframe;
-	if (HC_IS_RUNNING (ehci_to_hcd(ehci)->state))
+	if (HC_IS_RUNNING(ehci_to_hcd(ehci)->state)) {
 		clock = ehci_readl(ehci, &ehci->regs->frame_index);
-	else
+		clock_frame = (clock >> 3) % ehci->periodic_size;
+	} else  {
 		clock = now_uframe + mod - 1;
+		clock_frame = -1;
+	}
+	if (ehci->clock_frame != clock_frame) {
+		free_cached_itd_list(ehci);
+		ehci->clock_frame = clock_frame;
+	}
 	clock %= mod;
 	clock_frame = clock >> 3;
 
@@ -2277,6 +2311,10 @@ restart:
 			/* rescan the rest of this frame, then ... */
 			clock = now;
 			clock_frame = clock >> 3;
+			if (ehci->clock_frame != clock_frame) {
+				free_cached_itd_list(ehci);
+				ehci->clock_frame = clock_frame;
+			}
 		} else {
 			now_uframe++;
 			now_uframe %= mod;
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index fb7054c..5262fb7 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -86,6 +86,9 @@ struct ehci_hcd {			/* one per controller */
 	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
 	int			next_uframe;	/* scan periodic, start here */
 	unsigned		periodic_sched;	/* periodic activity count */
+	struct list_head	cached_itd_list; /* list of itds completed
+						    while frame hadn't yet elapsed */
+	unsigned		clock_frame;
 
 	/* per root hub port */
 	unsigned long		reset_done [EHCI_MAX_ROOT_PORTS];
@@ -220,6 +223,8 @@ timer_action (struct ehci_hcd *ehci, enum ehci_timer_action action)
 	}
 }
 
+static void free_cached_itd_list(struct ehci_hcd *ehci);
+
 /*-------------------------------------------------------------------------*/
 
 #include <linux/usb/ehci_def.h>
-- 
1.6.0.6


--Boundary-00=_CJlfJUbtEYzGQ5Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_CJlfJUbtEYzGQ5Q--
