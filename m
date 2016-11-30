From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 3/3 v3] ALSA: usb-audio: fix race in snd_usb_endpoint_stop
Date: Wed, 30 Nov 2016 16:59:23 +0900
Message-ID: <20161130075923.15205-4-jiada_wang@mentor.com>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161130075923.15205-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

From: Mark Craske <Mark_Craske@mentor.com>

Kernel crash seen once:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
pgd = a1d7c000
[00000008] *pgd=31c93831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1] PREEMPT SMP ARM
CPU: 0 PID: 250 Comm: dbus-daemon Not tainted 3.14.51-03479-gf50bdf4 #1
task: a3ae61c0 ti: a08c8000 task.ti: a08c8000
PC is at retire_capture_urb+0x10/0x1f4 [snd_usb_audio]
LR is at snd_complete_urb+0x140/0x1f0 [snd_usb_audio]
pc : [<7f0eb22c>]    lr : [<7f0e57fc>]    psr: 200e0193
sp : a08c9c98  ip : a08c9ce8  fp : a08c9ce4
r10: 0000000a  r9 : 00000102  r8 : 94cb3000
r7 : 94cb3000  r6 : 94d0f000  r5 : 94d0e8e8  r4 : 94d0e000
r3 : 7f0eb21c  r2 : 00000000  r1 : 94cb3000  r0 : 00000000
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c5387d  Table: 31d7c04a  DAC: 00000015
Process dbus-daemon (pid: 250, stack limit = 0xa08c8238)
Stack: (0xa08c9c98 to 0xa08ca000)
...
Backtrace:
[<7f0eb21c>] (retire_capture_urb [snd_usb_audio]) from [<7f0e57fc>] (snd_complete_urb+0x140/0x1f0 [snd_usb_audio])
[<7f0e56bc>] (snd_complete_urb [snd_usb_audio]) from [<80371118>] (__usb_hcd_giveback_urb+0x78/0xf4)
[<803710a0>] (__usb_hcd_giveback_urb) from [<80371514>] (usb_giveback_urb_bh+0x8c/0xc0)
[<80371488>] (usb_giveback_urb_bh) from [<80028e3c>] (tasklet_hi_action+0xc4/0x148)
[<80028d78>] (tasklet_hi_action) from [<80028358>] (__do_softirq+0x190/0x380)
[<800281c8>] (__do_softirq) from [<80028858>] (irq_exit+0x8c/0xfc)
[<800287cc>] (irq_exit) from [<8000ea88>] (handle_IRQ+0x8c/0xc8)
[<8000e9fc>] (handle_IRQ) from [<800085e8>] (gic_handle_irq+0xbc/0xf8)
[<8000852c>] (gic_handle_irq) from [<80509044>] (__irq_svc+0x44/0x78)
[<80508820>] (_raw_spin_unlock_irq) from [<8004b880>] (finish_task_switch+0x5c/0x100)
[<8004b824>] (finish_task_switch) from [<805052f0>] (__schedule+0x48c/0x6d8)
[<80504e64>] (__schedule) from [<805055d4>] (schedule+0x98/0x9c)
[<8050553c>] (schedule) from [<800116c8>] (do_work_pending+0x30/0xd0)
[<80011698>] (do_work_pending) from [<8000e160>] (work_pending+0xc/0x20)
Code: e1a0c00d e92ddff0 e24cb004 e24dd024 (e5902008)
Kernel panic - not syncing: Fatal exception in interrupt

There is a race between retire_capture_urb() & stop_endpoints() which is
setting ep->data_subs to NULL. The underlying cause is in
snd_usb_endpoint_stop(), which sets
  ep->data_subs = NULL;
  ep->sync_slave = NULL;
  ep->retire_data_urb = NULL;
  ep->prepare_data_urb = NULL;

An improvement, suggested by Andreas Pape (ADIT) is to read parameters
into local variables. This should solve race between stop and retire
where it is legal to store the pointers to local variable as they are
not freed in stop path but just set to NULL.
However, additional races may still happen in close+hw_free against
retire, as there pointers may be freed in addition. For example, while
in retire_capture_urb() runtime->dma_area might be freed/nulled.

Signed-off-by: Mark Craske <Mark_Craske@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/usb/endpoint.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 2f592dd..853cb79 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -162,25 +162,33 @@ int snd_usb_endpoint_next_packet_size(struct snd_usb_endpoint *ep)
 static void retire_outbound_urb(struct snd_usb_endpoint *ep,
 				struct snd_urb_ctx *urb_ctx)
 {
-	if (ep->retire_data_urb)
-		ep->retire_data_urb(ep->data_subs, urb_ctx->urb);
+	struct snd_usb_substream *subs = ep->data_subs;
+	void (*retire)(struct snd_usb_substream *subs, struct urb *urb)
+		= ep->retire_data_urb;
+
+	if (subs && retire)
+		retire(subs, urb_ctx->urb);
 }
 
 static void retire_inbound_urb(struct snd_usb_endpoint *ep,
 			       struct snd_urb_ctx *urb_ctx)
 {
 	struct urb *urb = urb_ctx->urb;
+	struct snd_usb_endpoint *slave = ep->sync_slave;
+	struct snd_usb_substream *subs = ep->data_subs;
+	void (*retire)(struct snd_usb_substream *subs, struct urb *urb)
+		= ep->retire_data_urb;
 
 	if (unlikely(ep->skip_packets > 0)) {
 		ep->skip_packets--;
 		return;
 	}
 
-	if (ep->sync_slave)
-		snd_usb_handle_sync_urb(ep->sync_slave, ep, urb);
+	if (slave)
+		snd_usb_handle_sync_urb(slave, ep, urb);
 
-	if (ep->retire_data_urb)
-		ep->retire_data_urb(ep->data_subs, urb);
+	if (subs && retire)
+		retire(subs, urb);
 }
 
 static void prepare_silent_urb(struct snd_usb_endpoint *ep,
-- 
2.9.3
