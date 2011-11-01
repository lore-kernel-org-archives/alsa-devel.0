From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/5] RFC for snd-usb: rework usb endpoint
	logic
Date: Tue, 1 Nov 2011 20:03:02 +0100
Message-ID: <CAFz=ag4Vk3WaG3_4weK-_=Tbbvduvfn9kwFaKxRgFOd=tTovyg@mail.gmail.com>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<4EAE96BC.6060605@gmail.com> <s5haa8fn7cg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AC1A103891
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 20:03:04 +0100 (CET)
Received: by wwf27 with SMTP id 27so2812017wwf.2
	for <alsa-devel@alsa-project.org>; Tue, 01 Nov 2011 12:03:02 -0700 (PDT)
In-Reply-To: <s5haa8fn7cg.wl%tiwai@suse.de>
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
Cc: blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On my machine building from alsa-driver/alsa-kernel fails.

I've got my alsa-kernel from here:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
alsa-kernel

alsa-driver is this one:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git
alsa-driver

After successfully patching alsa-kernel the build fails:

./gitcompile  --with-oss=no --with-pcm-oss-plugins=no
--with-debug=full --enable-dynamic-minors --with-moddir=updates

[.....]

copying file alsa-kernel/usb/endpoint.cpatching file endpoint.cHunk #2
FAILED at 72.Hunk #3 FAILED at 84.Hunk #4 succeeded at 194 with fuzz 2
(offset 29 lines).Hunk #5 FAILED at 192.Hunk #6 FAILED at 341.4 out of
6 hunks FAILED -- saving rejects to file endpoint.c.rej

Here's endpoint.c.rej:

--- ../alsa-kernel/usb/endpoint.c       2011-09-14 13:57:01.622042886 +0200
+++ endpoint.c  2011-09-14 13:57:20.178761685 +0200
@@ -72,9 +74,12 @@
                if (test_bit(i, &subs->active_mask)) {
                        if (!test_and_set_bit(i, &subs->unlink_mask)) {
                                struct urb *u = subs->dataurb[i].urb;
-                               if (async)
+                               if (async) {
+#ifdef URB_ASYNC_UNLINK
+                                       u->transfer_flags |= URB_ASYNC_UNLINK;
+#endif
                                        usb_unlink_urb(u);
-                               else
+                               } else
                                        usb_kill_urb(u);
                        }
                }
@@ -84,9 +89,12 @@
                        if (test_bit(i+16, &subs->active_mask)) {
                                if (!test_and_set_bit(i+16,
&subs->unlink_mask)) {
                                        struct urb *u = subs->syncurb[i].urb;
-                                       if (async)
+                                       if (async) {
+#ifdef URB_ASYNC_UNLINK
+                                               u->transfer_flags |=
URB_ASYNC_UNLINK;
+#endif
                                                usb_unlink_urb(u);
-                                       else
+                                       } else
                                                usb_kill_urb(u);
                                }
                        }
@@ -192,7 +204,11 @@
 /*
  * complete callback from sync urb
  */
+#if !defined(OLD_USB) && !defined(CONFIG_SND_NEW_IRQ_HANDLER)
+static void snd_complete_sync_urb(struct urb *urb, struct pt_regs *regs)
+#else
 static void snd_complete_sync_urb(struct urb *urb)
+#endif
 {
        struct snd_urb_ctx *ctx = urb->context;
        struct snd_usb_substream *subs = ctx->subs;
@@ -341,7 +357,9 @@
                        if (!u->urb)
                                goto out_of_memory;
                        u->urb->transfer_buffer = subs->syncbuf + i * 4;
+#ifdef HAVE_USB_BUFFERS
                        u->urb->transfer_dma = subs->sync_dma + i * 4;
+#endif
                        u->urb->transfer_buffer_length = 4;
                        u->urb->pipe = subs->syncpipe;
                        u->urb->transfer_flags = URB_ISO_ASAP |
