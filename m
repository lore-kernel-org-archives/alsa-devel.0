From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH] ALSA: snd-usb: fix IRQ triggered NULL pointer dereference
Date: Sun, 18 Dec 2016 03:08:00 +0200
Message-ID: <20161218010800.2173-1-adi@adirat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Commit 16200948d835 ("ALSA: usb-audio: Fix race at stopping the stream")
fixes a race-codition but it also introduces another really nasty data race
regression which makes my usb sound card [1] completely useless, throwing
the kernel into a panic if anything from userspace tries to start playback.

The problem is this: ep->data_subs is now set to NULL every time inside
wait_clear_urbs(). ep->data_subs is initalized only in one place in
start_endpoints(), then it is immediately wiped by the pre-existing call to
wait_clear_urbs() inside snd_usb_endpoint_start().

To ilustrate, this is what happens in the non-irq part of the code:

Step 1 (inside start_endpoints): ep->data_subs = subs;
Step 2 (inside start_endpoints): snd_usb_endpoint_start(ep, can_sleep);
Step 3 (inside snd_usb_endpoint_start): wait_clear_urbs(ep);
Step 4 (inside wait_clear_urbs): ep->data_subs = NULL;

Here's a simplified call stack for the IRQ part (full one at the end):

(NULL dereference, param "subs" is passed NULL value of ep->data_subs)
retire_playback_urb
retire_outbound_urb
snd_complete_urb
(...)
xhci_irq

Looking at the git log there seems to be quite a lot of history in this
part of the codebase, dating back to 2012 or earlier. My fix is based on
015618b90 ("ALSA: snd-usb: Fix URB cancellation at stream start") and
e9ba389c5 ("ALSA: usb-audio: Fix scheduling-while-atomic bug in PCM capture
stream") with a few modifications of my own. My idea is to do the
ep->data_subs wiping before endpoint initialization in a manner similar
to these older commits by using stop_endpoints() in snd_usb_pcm_prepare()
and at the same time keep the ep->data_subs = NULL in wait_clear_urbs() to
not trigger the recently fixed stream stopping race again.

Full call stack:

[  131.093240] BUG: unable to handle kernel NULL pointer dereference at 0000000000000010
[  131.094313] IP: retire_playback_urb+0x1b/0x160 [snd_usb_audio]
[  131.095046] PGD 0
[  131.095047]
[  131.096509] Oops: 0000 [#1] PREEMPT SMP
[  131.097255] Modules linked in: fuse snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device ctr ccm arc4 ath9k intel_rapl ath9k_common x86_pkg_temp_thermal ath9k_hw intel_powerclamp coretemp joydev mousedev ath kvm_intel mac80211 kvm
 input_leds hid_generic psmouse irqbypass usbhid hid crct10dif_pclmul crc32_pclmul serio_raw crc32c_intel atkbd ghash_clmulni_intel snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel pcbc aesni_intel libps2 cfg8
0211 aes_x86_64 crypto_simd dell_laptop glue_helper r8169 dell_smbios snd_hda_codec sr_mod cryptd led_class mii rfkill snd_hwdep cdrom snd_hda_core ac dcdbas i8042 xhci_pci serio xhci_hcd snd_pcm tpm_tis battery tpm_tis_core lpc_ich tpm
snd_timer evdev shpchp i2c_i801 sch_fq_codel
[  131.105551] CPU: 2 PID: 165 Comm: irq/29-xhci_hcd Not tainted 4.9.0-gd824cdc58ba0 #10
[  131.107516] Hardware name: Dell Inc. Inspiron 3521/018DYG, BIOS A14 07/31/2015
[  131.109592] task: ffff880154a70000 task.stack: ffffc90000f48000
[  131.111746] RIP: 0010:retire_playback_urb+0x1b/0x160 [snd_usb_audio]
[  131.113899] RSP: 0018:ffffc90000f4bc10 EFLAGS: 00010082
[  131.116080] RAX: ffffffffa04cabe0 RBX: 0000000000000000 RCX: 0000000000000000
[  131.118284] RDX: 0000000000000000 RSI: ffff8801435a4c00 RDI: 0000000000000000
[  131.120505] RBP: ffffc90000f4bc40 R08: 0000000000000001 R09: 0000000000000001
[  131.122807] R10: 0000000000000001 R11: ffffffff82f60d6d R12: ffff8801432a0238
[  131.125265] R13: ffff8801435a4c00 R14: 0000000000000000 R15: ffff8801535c83b8
[  131.127723] FS:  0000000000000000(0000) GS:ffff88015a000000(0000) knlGS:0000000000000000
[  131.130217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  131.132568] CR2: 0000000000000010 CR3: 0000000001e0b000 CR4: 00000000001406e0
[  131.135007] Call Trace:
[  131.137329]  snd_complete_urb+0x190/0x2b0 [snd_usb_audio]
[  131.139526]  __usb_hcd_giveback_urb+0x8e/0x160
[  131.141948]  usb_hcd_giveback_urb+0x43/0x110
[  131.144104]  xhci_giveback_urb_in_irq.isra.22+0x7d/0xb0 [xhci_hcd]
[  131.146521]  finish_td.constprop.38+0x1de/0x2f0 [xhci_hcd]
[  131.148736]  xhci_irq+0x13a2/0x1ca0 [xhci_hcd]
[  131.150972]  ? trace_hardirqs_on+0xd/0x10
[  131.153209]  ? _raw_spin_unlock_irq+0x2c/0x50
[  131.155390]  ? irq_thread+0xb5/0x1d0
[  131.157771]  xhci_msi_irq+0x11/0x20 [xhci_hcd]
[  131.159938]  irq_forced_thread_fn+0x2f/0x70
[  131.162072]  ? irq_thread+0xb5/0x1d0
[  131.164141]  irq_thread+0x149/0x1d0
[  131.166132]  ? irq_finalize_oneshot.part.2+0xe0/0xe0
[  131.168142]  ? wake_threads_waitq+0x30/0x30
[  131.170149]  kthread+0x10f/0x150
[  131.172144]  ? irq_thread_dtor+0xc0/0xc0
[  131.174139]  ? kthread_create_on_node+0x40/0x40
[  131.176116]  ret_from_fork+0x2a/0x40
[  131.178074] Code: 8b 77 64 4c 89 e7 e8 e5 fe ff ff eb c3 0f 1f 00 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 54 53 48 89 fb 48 83 ec 08 <48> 8b 47 10 48 8b 4f 70 48 c7 c7 88 7b 4d a0 4c 8b a0 78 01 00
[  131.182382] RIP: retire_playback_urb+0x1b/0x160 [snd_usb_audio] RSP: ffffc90000f4bc10
[  131.184562] CR2: 0000000000000010

[1] 041e:3232 Creative Technology SoundBlaster X-FI HD
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-December/115425.html

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 sound/usb/endpoint.c | 11 ++---------
 sound/usb/endpoint.h |  2 +-
 sound/usb/pcm.c      | 13 ++++++-------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a2cdf3370afe..4465f324c2c2 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -920,9 +920,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 /**
  * snd_usb_endpoint_start: start an snd_usb_endpoint
  *
- * @ep:		the endpoint to start
- * @can_sleep:	flag indicating whether the operation is executed in
- * 		non-atomic context
+ * @ep: the endpoint to start
  *
  * A call to this function will increment the use count of the endpoint.
  * In case it is not already running, the URBs for this endpoint will be
@@ -932,7 +930,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
  *
  * Returns an error if the URB submission failed, 0 in all other cases.
  */
-int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
+int snd_usb_endpoint_start(struct snd_usb_endpoint *ep)
 {
 	int err;
 	unsigned int i;
@@ -944,11 +942,6 @@ int snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep)
 	if (++ep->use_count != 1)
 		return 0;
 
-	/* just to be sure */
-	deactivate_urbs(ep, false);
-	if (can_sleep)
-		wait_clear_urbs(ep);
-
 	ep->active_mask = 0;
 	ep->unlink_mask = 0;
 	ep->phase = 0;
diff --git a/sound/usb/endpoint.h b/sound/usb/endpoint.h
index 6428392d8f62..584f295d7c77 100644
--- a/sound/usb/endpoint.h
+++ b/sound/usb/endpoint.h
@@ -18,7 +18,7 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 				struct audioformat *fmt,
 				struct snd_usb_endpoint *sync_ep);
 
-int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep, bool can_sleep);
+int  snd_usb_endpoint_start(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_stop(struct snd_usb_endpoint *ep);
 void snd_usb_endpoint_sync_pending_stop(struct snd_usb_endpoint *ep);
 int  snd_usb_endpoint_activate(struct snd_usb_endpoint *ep);
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 34c6d4f2c0b6..db26f767f851 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -218,7 +218,7 @@ int snd_usb_init_pitch(struct snd_usb_audio *chip, int iface,
 	}
 }
 
-static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
+static int start_endpoints(struct snd_usb_substream *subs)
 {
 	int err;
 
@@ -231,7 +231,7 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 		dev_dbg(&subs->dev->dev, "Starting data EP @%p\n", ep);
 
 		ep->data_subs = subs;
-		err = snd_usb_endpoint_start(ep, can_sleep);
+		err = snd_usb_endpoint_start(ep);
 		if (err < 0) {
 			clear_bit(SUBSTREAM_FLAG_DATA_EP_STARTED, &subs->flags);
 			return err;
@@ -260,7 +260,7 @@ static int start_endpoints(struct snd_usb_substream *subs, bool can_sleep)
 		dev_dbg(&subs->dev->dev, "Starting sync EP @%p\n", ep);
 
 		ep->sync_slave = subs->data_endpoint;
-		err = snd_usb_endpoint_start(ep, can_sleep);
+		err = snd_usb_endpoint_start(ep);
 		if (err < 0) {
 			clear_bit(SUBSTREAM_FLAG_SYNC_EP_STARTED, &subs->flags);
 			return err;
@@ -809,8 +809,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 		goto unlock;
 	}
 
-	snd_usb_endpoint_sync_pending_stop(subs->sync_endpoint);
-	snd_usb_endpoint_sync_pending_stop(subs->data_endpoint);
+	stop_endpoints(subs, true);
 
 	ret = set_format(subs, subs->cur_audiofmt);
 	if (ret < 0)
@@ -850,7 +849,7 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	/* for playback, submit the URBs now; otherwise, the first hwptr_done
 	 * updates for all URBs would happen at the same time when starting */
 	if (subs->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		ret = start_endpoints(subs, true);
+		return start_endpoints(subs);
 
  unlock:
 	snd_usb_unlock_shutdown(subs->stream->chip);
@@ -1666,7 +1665,7 @@ static int snd_usb_substream_capture_trigger(struct snd_pcm_substream *substream
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-		err = start_endpoints(subs, false);
+		err = start_endpoints(subs);
 		if (err < 0)
 			return err;
 
-- 
2.11.0
