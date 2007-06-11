From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] snd-usb-caiaq: Fix compatibility with kernels
	< 2.6.19
Date: Mon, 11 Jun 2007 20:39:44 +0400
Message-ID: <20070611163943.GC5347@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.altlinux.org (master.altlinux.org [62.118.250.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 3532E24483
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 18:40:18 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Kernels before 2.6.19 used a different signature for the urb->complete
callback (an additional "struct pt_regs *regs" parameter was present),
therefore snd-usb-caiaq needs some compatibility patches in
alsa-driver, like snd-usb-audio.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

---
The snd_usb_caiaq_midi_output_done() part is somewhat hackish - the
problem is that snd_usb_caiaq_midi_output_done() is declared in
caiaq-midi.h, and the alsa-driver build system does not support
patching of *.h files.  The rest is basically copied from
usbaudio.patch.

Without the patch compiling for 2.6.18 produces warnings:

.../usb/caiaq/caiaq-device.c: In function 'init_card':
.../usb/caiaq/caiaq-device.c:316: warning: passing argument 6 of 'usb_fill_bulk_urb' from incompatible pointer type
.../usb/caiaq/caiaq-device.c:321: warning: passing argument 6 of 'usb_fill_bulk_urb' from incompatible pointer type
.../usb/caiaq/caiaq-audio.c: In function 'alloc_urbs':
.../usb/caiaq/caiaq-audio.c:583: warning: assignment from incompatible pointer type


--- alsa-driver-1.0.14/usb/caiaq/Makefile.alt-caiaq-api	2007-06-11 16:29:28 +0400
+++ alsa-driver-1.0.14/usb/caiaq/Makefile	2007-06-11 19:50:39 +0400
@@ -5,6 +5,13 @@ endif
 include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf
 
+clean-files := caiaq-audio.c caiaq-device.c
+
 include $(SND_TOPDIR)/alsa-kernel/usb/caiaq/Makefile
 
+EXTRA_CFLAGS += -I$(SND_TOPDIR)/alsa-kernel/usb/caiaq
+
 include $(SND_TOPDIR)/Rules.make
+
+caiaq-audio.c: caiaq-audio.patch $(SND_TOPDIR)/alsa-kernel/usb/caiaq/caiaq-audio.c
+caiaq-device.c: caiaq-device.patch $(SND_TOPDIR)/alsa-kernel/usb/caiaq/caiaq-device.c
--- alsa-driver-1.0.14/usb/caiaq/caiaq-audio.patch.alt-caiaq-api	2007-06-11 19:18:40 +0400
+++ alsa-driver-1.0.14/usb/caiaq/caiaq-audio.patch	2007-06-11 19:18:17 +0400
@@ -0,0 +1,26 @@
+--- ../../alsa-kernel/usb/caiaq/caiaq-audio.c	2007-06-11 16:29:28 +0400
++++ caiaq-audio.c	2007-06-11 19:17:38 +0400
+@@ -464,7 +464,11 @@ static void fill_out_urb(struct snd_usb_
+ 	check_for_elapsed_periods(dev, dev->sub_playback);
+ }
+ 
++#if !defined(OLD_USB) && !defined(CONFIG_SND_NEW_IRQ_HANDLER)
++static void read_completed(struct urb *urb, struct pt_regs *regs)
++#else
+ static void read_completed(struct urb *urb)
++#endif
+ {
+ 	struct snd_usb_caiaq_cb_info *info = urb->context; 
+ 	struct snd_usb_caiaqdev *dev;
+@@ -518,7 +522,11 @@ static void read_completed(struct urb *u
+ 	usb_submit_urb(urb, GFP_ATOMIC);
+ }
+ 
++#if !defined(OLD_USB) && !defined(CONFIG_SND_NEW_IRQ_HANDLER)
++static void write_completed(struct urb *urb, struct pt_regs *regs)
++#else
+ static void write_completed(struct urb *urb)
++#endif
+ {
+ 	struct snd_usb_caiaq_cb_info *info = urb->context;
+ 	struct snd_usb_caiaqdev *dev = info->dev;
--- alsa-driver-1.0.14/usb/caiaq/caiaq-device.patch.alt-caiaq-api	2007-06-11 19:55:17 +0400
+++ alsa-driver-1.0.14/usb/caiaq/caiaq-device.patch	2007-06-11 19:54:49 +0400
@@ -0,0 +1,31 @@
+--- ../../alsa-kernel/usb/caiaq/caiaq-device.c	2007-06-11 16:29:28 +0400
++++ caiaq-device.c	2007-06-11 19:54:46 +0400
+@@ -100,7 +100,11 @@ static struct usb_device_id snd_usb_id_t
+ 	{ /* terminator */ }
+ };
+ 
++#if !defined(OLD_USB) && !defined(CONFIG_SND_NEW_IRQ_HANDLER)
++static void usb_ep1_command_reply_dispatch (struct urb* urb, struct pt_regs *regs)
++#else
+ static void usb_ep1_command_reply_dispatch (struct urb* urb)
++#endif
+ {
+ 	int ret;
+ 	struct snd_usb_caiaqdev *dev = urb->context;
+@@ -295,6 +299,16 @@ static struct snd_card* create_card(stru
+ 	return card;
+ }
+ 
++#if !defined(OLD_USB) && !defined(CONFIG_SND_NEW_IRQ_HANDLER)
++static void snd_usb_caiaq_midi_output_done_wrapper(struct urb* urb,
++						   struct pt_regs *regs)
++{
++	snd_usb_caiaq_midi_output_done(urb);
++}
++#undef snd_usb_caiaq_midi_output_done
++#define snd_usb_caiaq_midi_output_done snd_usb_caiaq_midi_output_done_wrapper
++#endif
++
+ static int init_card(struct snd_usb_caiaqdev *dev)
+ {
+ 	char *c;
