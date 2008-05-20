From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] snd-usb-us122l v0.5 for US-122L
Date: Tue, 20 May 2008 12:33:17 +0200
Message-ID: <200805201233.17256.fzu@wemgehoertderstaat.de>
References: <200803161956.42461.fzu@wemgehoertderstaat.de>
	<200805201129.39484.fzu@wemgehoertderstaat.de>
	<s5hlk259ud3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AB0D2485F
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 12:47:19 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so2234861fka.0
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 03:47:18 -0700 (PDT)
In-Reply-To: <s5hlk259ud3.wl%tiwai@suse.de>
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

Am Dienstag, 20. Mai 2008 schrieb Takashi Iwai:
> 
> Well, I meant the missing patches, usb-ehci etc :)
> 

I run below patch on top of 2.6.25.x. It also contains some patches not
actually needed to let the us122l connected to ehci work.

The needed .asoundrc section is contained in the description part of
the plugin patch I've just sent.

Will post the ehci patch I posted to linux-usb after this e-mail.

Thanks,
      Karsten

---
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 46ee7f4..aebd534 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -174,6 +174,16 @@ static int handshake (struct ehci_hcd *ehci, void __iomem *ptr,
 	return -ETIMEDOUT;
 }
 
+static int handshake_on_error_set_halt(struct ehci_hcd *ehci, void __iomem *ptr,
+				       u32 mask, u32 done, int usec)
+{
+	int error = handshake(ehci, ptr, mask, done, usec);
+	if (error)
+		ehci_to_hcd(ehci)->state = HC_STATE_HALT;
+
+	return error;
+}
+
 /* force HC to halt state from unknown (EHCI spec section 2.3) */
 static int ehci_halt (struct ehci_hcd *ehci)
 {
@@ -246,11 +256,9 @@ static void ehci_quiesce (struct ehci_hcd *ehci)
 	/* wait for any schedule enables/disables to take effect */
 	temp = ehci_readl(ehci, &ehci->regs->command) << 10;
 	temp &= STS_ASS | STS_PSS;
-	if (handshake (ehci, &ehci->regs->status, STS_ASS | STS_PSS,
-				temp, 16 * 125) != 0) {
-		ehci_to_hcd(ehci)->state = HC_STATE_HALT;
+	if (handshake_on_error_set_halt(ehci, &ehci->regs->status,
+					STS_ASS | STS_PSS, temp, 16 * 125))
 		return;
-	}
 
 	/* then disable anything that's still active */
 	temp = ehci_readl(ehci, &ehci->regs->command);
@@ -258,11 +266,8 @@ static void ehci_quiesce (struct ehci_hcd *ehci)
 	ehci_writel(ehci, temp, &ehci->regs->command);
 
 	/* hardware can take 16 microframes to turn off ... */
-	if (handshake (ehci, &ehci->regs->status, STS_ASS | STS_PSS,
-				0, 16 * 125) != 0) {
-		ehci_to_hcd(ehci)->state = HC_STATE_HALT;
-		return;
-	}
+	handshake_on_error_set_halt(ehci, &ehci->regs->status,
+				    STS_ASS | STS_PSS, 0, 16 * 125);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -355,17 +360,13 @@ static void ehci_turn_off_all_ports(struct ehci_hcd *ehci)
 				&ehci->regs->port_status[port]);
 }
 
-/* ehci_shutdown kick in for silicon on any bus (not just pci, etc).
- * This forcibly disables dma and IRQs, helping kexec and other cases
- * where the next system software may expect clean state.
+/*
+ * Halt HC, turn off all ports, and let the BIOS use the companion controllers.
+ * Should be called with ehci->lock held.
  */
-static void
-ehci_shutdown (struct usb_hcd *hcd)
+static void ehci_silence_controller(struct ehci_hcd *ehci)
 {
-	struct ehci_hcd	*ehci;
-
-	ehci = hcd_to_ehci (hcd);
-	(void) ehci_halt (ehci);
+	ehci_halt(ehci);
 	ehci_turn_off_all_ports(ehci);
 
 	/* make BIOS/etc use companion controller during reboot */
@@ -375,6 +376,22 @@ ehci_shutdown (struct usb_hcd *hcd)
 	ehci_readl(ehci, &ehci->regs->configured_flag);
 }
 
+/* ehci_shutdown kick in for silicon on any bus (not just pci, etc).
+ * This forcibly disables dma and IRQs, helping kexec and other cases
+ * where the next system software may expect clean state.
+ */
+static void ehci_shutdown(struct usb_hcd *hcd)
+{
+	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
+
+	del_timer_sync(&ehci->watchdog);
+	del_timer_sync(&ehci->iaa_watchdog);
+
+	spin_lock_irq(&ehci->lock);
+	ehci_silence_controller(ehci);
+	spin_unlock_irq(&ehci->lock);
+}
+
 static void ehci_port_power (struct ehci_hcd *ehci, int is_on)
 {
 	unsigned port;
@@ -425,15 +442,15 @@ static void ehci_work (struct ehci_hcd *ehci)
 		timer_action (ehci, TIMER_IO_WATCHDOG);
 }
 
+/*
+ * Called when the ehci_hcd module is removed.
+ */
 static void ehci_stop (struct usb_hcd *hcd)
 {
 	struct ehci_hcd		*ehci = hcd_to_ehci (hcd);
 
 	ehci_dbg (ehci, "stop\n");
 
-	/* Turn off port power on all root hub ports. */
-	ehci_port_power (ehci, 0);
-
 	/* no more interrupts ... */
 	del_timer_sync (&ehci->watchdog);
 	del_timer_sync(&ehci->iaa_watchdog);
@@ -442,13 +459,10 @@ static void ehci_stop (struct usb_hcd *hcd)
 	if (HC_IS_RUNNING (hcd->state))
 		ehci_quiesce (ehci);
 
+	ehci_silence_controller(ehci);
 	ehci_reset (ehci);
-	ehci_writel(ehci, 0, &ehci->regs->intr_enable);
 	spin_unlock_irq(&ehci->lock);
 
-	/* let companion controllers work when we aren't */
-	ehci_writel(ehci, 0, &ehci->regs->configured_flag);
-
 	remove_companion_file(ehci);
 	remove_debug_files (ehci);
 
@@ -494,6 +508,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	 * periodic_size can shrink by USBCMD update if hcc_params allows.
 	 */
 	ehci->periodic_size = DEFAULT_I_TDPS;
+	INIT_LIST_HEAD(&ehci->cached_itd_list);
 	if ((retval = ehci_mem_init(ehci, GFP_KERNEL)) < 0)
 		return retval;
 
@@ -506,6 +521,7 @@ static int ehci_init(struct usb_hcd *hcd)
 
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
index 8a8e08a..b8646ac 100644
--- a/drivers/usb/host/ehci-sched.c
+++ b/drivers/usb/host/ehci-sched.c
@@ -440,11 +440,10 @@ static int enable_periodic (struct ehci_hcd *ehci)
 	/* did clearing PSE did take effect yet?
 	 * takes effect only at frame boundaries...
 	 */
-	status = handshake(ehci, &ehci->regs->status, STS_PSS, 0, 9 * 125);
-	if (status != 0) {
-		ehci_to_hcd(ehci)->state = HC_STATE_HALT;
+	status = handshake_on_error_set_halt(ehci, &ehci->regs->status,
+					     STS_PSS, 0, 9 * 125);
+	if (status)
 		return status;
-	}
 
 	cmd = ehci_readl(ehci, &ehci->regs->command) | CMD_PSE;
 	ehci_writel(ehci, cmd, &ehci->regs->command);
@@ -465,11 +464,10 @@ static int disable_periodic (struct ehci_hcd *ehci)
 	/* did setting PSE not take effect yet?
 	 * takes effect only at frame boundaries...
 	 */
-	status = handshake(ehci, &ehci->regs->status, STS_PSS, STS_PSS, 9 * 125);
-	if (status != 0) {
-		ehci_to_hcd(ehci)->state = HC_STATE_HALT;
+	status = handshake_on_error_set_halt(ehci, &ehci->regs->status,
+					     STS_PSS, STS_PSS, 9 * 125);
+	if (status)
 		return status;
-	}
 
 	cmd = ehci_readl(ehci, &ehci->regs->command) & ~CMD_PSE;
 	ehci_writel(ehci, cmd, &ehci->regs->command);
@@ -1005,7 +1003,8 @@ iso_stream_put(struct ehci_hcd *ehci, struct ehci_iso_stream *stream)
 
 		is_in = (stream->bEndpointAddress & USB_DIR_IN) ? 0x10 : 0;
 		stream->bEndpointAddress &= 0x0f;
-		stream->ep->hcpriv = NULL;
+		if (stream->ep)
+			stream->ep->hcpriv = NULL;
 
 		if (stream->rescheduled) {
 			ehci_info (ehci, "ep%d%s-iso rescheduled "
@@ -1183,21 +1182,18 @@ itd_urb_transaction (
 					struct ehci_itd, itd_list);
 			list_del (&itd->itd_list);
 			itd_dma = itd->itd_dma;
-		} else
-			itd = NULL;
-
-		if (!itd) {
+		} else {
 			spin_unlock_irqrestore (&ehci->lock, flags);
 			itd = dma_pool_alloc (ehci->itd_pool, mem_flags,
 					&itd_dma);
 			spin_lock_irqsave (&ehci->lock, flags);
+			if (unlikely(!itd)) {
+				iso_sched_free(stream, sched);
+				spin_unlock_irqrestore(&ehci->lock, flags);
+				return -ENOMEM;
+			}
 		}
 
-		if (unlikely (NULL == itd)) {
-			iso_sched_free (stream, sched);
-			spin_unlock_irqrestore (&ehci->lock, flags);
-			return -ENOMEM;
-		}
 		memset (itd, 0, sizeof *itd);
 		itd->itd_dma = itd_dma;
 		list_add (&itd->itd_list, &sched->td_list);
@@ -1647,14 +1643,26 @@ itd_complete (
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
 
@@ -1816,21 +1824,18 @@ sitd_urb_transaction (
 					 struct ehci_sitd, sitd_list);
 			list_del (&sitd->sitd_list);
 			sitd_dma = sitd->sitd_dma;
-		} else
-			sitd = NULL;
-
-		if (!sitd) {
+		} else {
 			spin_unlock_irqrestore (&ehci->lock, flags);
 			sitd = dma_pool_alloc (ehci->sitd_pool, mem_flags,
 					&sitd_dma);
 			spin_lock_irqsave (&ehci->lock, flags);
+			if (!sitd) {
+				iso_sched_free(stream, iso_sched);
+				spin_unlock_irqrestore(&ehci->lock, flags);
+				return -ENOMEM;
+			}
 		}
 
-		if (!sitd) {
-			iso_sched_free (stream, iso_sched);
-			spin_unlock_irqrestore (&ehci->lock, flags);
-			return -ENOMEM;
-		}
 		memset (sitd, 0, sizeof *sitd);
 		sitd->sitd_dma = sitd_dma;
 		list_add (&sitd->sitd_list, &iso_sched->td_list);
@@ -2100,10 +2105,24 @@ done:
 
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
@@ -2114,10 +2133,17 @@ scan_periodic (struct ehci_hcd *ehci)
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
@@ -2268,6 +2294,11 @@ restart:
 
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
