From: Philippe Carriere <philippe-f.carriere@wanadoo.fr>
Subject: Re: (no subject)
Date: Tue, 14 Oct 2008 12:41:22 +0200
Message-ID: <1223980887.2915.4.camel@pollux.mecaflu.ec-lyon.fr>
References: <8230211.582121223895071540.JavaMail.www@wwinf1d32>
	<s5hhc7g602g.wl%tiwai@suse.de>
	<200810141154.27011.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-92wkVZNkkY9fRCWg548+"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp27.orange.fr (smtp27.orange.fr [80.12.242.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B767244AA
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 12:42:01 +0200 (CEST)
In-Reply-To: <200810141154.27011.fzu@wemgehoertderstaat.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-92wkVZNkkY9fRCWg548+
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Might this patch (the original one, without features yet implemented in
2.6.26, and an extremely slight modification to fit it) I use on Fedora
kernel (the patch also applies as it stands to vanilla) save works and
time ?

Regards,

Phil.
Le mardi 14 octobre 2008 =C3=A0 11:54 +0200, Karsten Wiese a =C3=A9crit :

> Am Montag, 13. Oktober 2008 schrieb Takashi Iwai:
>=20
> > > Thus, a patched ehci-hcd module is required. Is the patch scheduled=
 to appear in kernel 2.6.27 or would it be useful to  work for providing =
a kind of kmod ?
> >=20
> > Hm, I thought Karsten mentioned that patch will go to the upstream us=
b
> > tree, but it seems not done yet.
> >=20
> > Karsten, what is the current status of your ehci patch?
>=20
> has to be adjusted to fit head and submitted to usb-devel again.
> will get back to it once my current main-project allows me to.
> that might well be 09. sorry.
>=20
> thanks,
> Karsten
>=20

--=-92wkVZNkkY9fRCWg548+
Content-Disposition: attachment; filename=ehci-hcd_2.6.26.patch
Content-Type: text/x-patch; name=ehci-hcd_2.6.26.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -uNrp /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci.h vanilla-2.6.26/drivers/usb/host/ehci.h
--- /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci.h	2008-07-13 23:51:29.000000000 +0200
+++ vanilla-2.6.26/drivers/usb/host/ehci.h	2008-09-21 16:43:06.000000000 +0200
@@ -86,6 +86,9 @@ struct ehci_hcd {			/* one per controlle
 	union ehci_shadow	*pshadow;	/* mirror hw periodic table */
 	int			next_uframe;	/* scan periodic, start here */
 	unsigned		periodic_sched;	/* periodic activity count */
+	struct list_head	cached_itd_list; /* list of itds completed
+			while frame hadn't yet elapsed */
+	unsigned		hw_frame;
 
 	/* per root hub port */
 	unsigned long		reset_done [EHCI_MAX_ROOT_PORTS];
@@ -205,6 +208,9 @@ timer_action (struct ehci_hcd *ehci, enu
 	}
 }
 
+static void free_cached_itd_list(struct ehci_hcd *ehci);
+
+
 /*-------------------------------------------------------------------------*/
 
 /* EHCI register interface, corresponds to EHCI Revision 0.95 specification */
diff -uNrp /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci-hcd.c vanilla-2.6.26/drivers/usb/host/ehci-hcd.c
--- /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci-hcd.c	2008-07-13 23:51:29.000000000 +0200
+++ vanilla-2.6.26/drivers/usb/host/ehci-hcd.c	2008-09-21 16:23:32.000000000 +0200
@@ -479,6 +479,7 @@ static int ehci_init(struct usb_hcd *hcd
 	 * periodic_size can shrink by USBCMD update if hcc_params allows.
 	 */
 	ehci->periodic_size = DEFAULT_I_TDPS;
+	INIT_LIST_HEAD(&ehci->cached_itd_list);
 	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
 		return retval;
 
@@ -491,6 +492,7 @@ static int ehci_init(struct usb_hcd *hcd
 
 	ehci->reclaim = NULL;
 	ehci->next_uframe = -1;
+	ehci->hw_frame = -1;
 
 	/*
 	 * dedicate a qh for the async ring head, since we couldn't unlink
diff -uNrp /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci-mem.c vanilla-2.6.26/drivers/usb/host/ehci-mem.c
--- /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci-mem.c	2008-07-13 23:51:29.000000000 +0200
+++ vanilla-2.6.26/drivers/usb/host/ehci-mem.c	2008-09-21 16:25:16.000000000 +0200
@@ -128,6 +128,7 @@ static inline void qh_put (struct ehci_q
 
 static void ehci_mem_cleanup (struct ehci_hcd *ehci)
 {
+	free_cached_itd_list(ehci);
 	if (ehci->async)
 		qh_put (ehci->async);
 	ehci->async = NULL;
diff -uNrp /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci-sched.c vanilla-2.6.26/drivers/usb/host/ehci-sched.c
--- /home/Test/rpmbuild/BUILD/kernel-2.6.26/vanilla-2.6.26/drivers/usb/host/ehci-sched.c	2008-07-13 23:51:29.000000000 +0200
+++ vanilla-2.6.26/drivers/usb/host/ehci-sched.c	2008-09-21 16:40:38.000000000 +0200
@@ -1003,7 +1003,8 @@ iso_stream_put(struct ehci_hcd *ehci, st
 
 		is_in = (stream->bEndpointAddress & USB_DIR_IN) ? 0x10 : 0;
 		stream->bEndpointAddress &= 0x0f;
-		stream->ep->hcpriv = NULL;
+		if (stream->ep)
+			stream->ep->hcpriv = NULL;
 
 		if (stream->rescheduled) {
 			ehci_info (ehci, "ep%d%s-iso rescheduled "
@@ -1654,13 +1655,25 @@ itd_complete (
 			(stream->bEndpointAddress & USB_DIR_IN) ? "in" : "out");
 	}
 	iso_stream_put (ehci, stream);
-	/* OK to recycle this ITD now that its completion callback ran. */
 done:
 	usb_put_urb(urb);
 	itd->urb = NULL;
-	itd->stream = NULL;
-	list_move(&itd->itd_list, &stream->free_list);
-	iso_stream_put(ehci, stream);
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
@@ -2104,10 +2117,24 @@ done:
 
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
-	unsigned	now_uframe, frame, clock, clock_frame, mod;
+	unsigned	frame, hw_frame, clock, clock_frame, now_uframe, mod;
 	unsigned	modified;
 
 	mod = ehci->periodic_size << 3;
@@ -2118,10 +2145,17 @@ scan_periodic (struct ehci_hcd *ehci)
 	 * Touches as few pages as possible:  cache-friendly.
 	 */
 	now_uframe = ehci->next_uframe;
-	if (HC_IS_RUNNING (ehci_to_hcd(ehci)->state))
+	if (HC_IS_RUNNING (ehci_to_hcd(ehci)->state)) {
 		clock = ehci_readl(ehci, &ehci->regs->frame_index);
-	else
+		hw_frame = (clock >> 3) % ehci->periodic_size;
+	} else {
 		clock = now_uframe + mod - 1;
+		hw_frame = -1;
+	}
+	if (ehci->hw_frame != hw_frame) {
+		free_cached_itd_list(ehci);
+		ehci->hw_frame = hw_frame;
+	}
 	clock %= mod;
 	clock_frame = clock >> 3;
 
@@ -2281,6 +2315,11 @@ restart:
 			/* rescan the rest of this frame, then ... */
 			clock = now;
 			clock_frame = clock >> 3;
+			hw_frame = (clock >> 3);
+			if (ehci->hw_frame != hw_frame) {
+				free_cached_itd_list(ehci);
+				ehci->hw_frame = hw_frame;
+			}
 		} else {
 			now_uframe++;
 			now_uframe %= mod;

--=-92wkVZNkkY9fRCWg548+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-92wkVZNkkY9fRCWg548+--
