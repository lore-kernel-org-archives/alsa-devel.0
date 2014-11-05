From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: usb-audio: Fix device_del() sysfs
	warnings at disconnect
Date: Wed,  5 Nov 2014 15:21:07 +0100
Message-ID: <1415197267-30291-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 700E62625D7
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 15:21:08 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 53B82ACEE
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 14:21:08 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some USB-audio devices show weird sysfs warnings at disconnecting the
devices, e.g.
 usb 1-3: USB disconnect, device number 3
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 973 at fs/sysfs/group.c:216 device_del+0x39/0x180()
 sysfs group ffffffff8183df40 not found for kobject 'midiC1D0'
 Call Trace:
  [<ffffffff814a3e38>] ? dump_stack+0x49/0x71
  [<ffffffff8103cb72>] ? warn_slowpath_common+0x82/0xb0
  [<ffffffff8103cc55>] ? warn_slowpath_fmt+0x45/0x50
  [<ffffffff813521e9>] ? device_del+0x39/0x180
  [<ffffffff81352339>] ? device_unregister+0x9/0x20
  [<ffffffff81352384>] ? device_destroy+0x34/0x40
  [<ffffffffa00ba29f>] ? snd_unregister_device+0x7f/0xd0 [snd]
  [<ffffffffa025124e>] ? snd_rawmidi_dev_disconnect+0xce/0x100 [snd_rawmidi]
  [<ffffffffa00c0192>] ? snd_device_disconnect+0x62/0x90 [snd]
  [<ffffffffa00c025c>] ? snd_device_disconnect_all+0x3c/0x60 [snd]
  [<ffffffffa00bb574>] ? snd_card_disconnect+0x124/0x1a0 [snd]
  [<ffffffffa02e54e8>] ? usb_audio_disconnect+0x88/0x1c0 [snd_usb_audio]
  [<ffffffffa015260e>] ? usb_unbind_interface+0x5e/0x1b0 [usbcore]
  [<ffffffff813553e9>] ? __device_release_driver+0x79/0xf0
  [<ffffffff81355485>] ? device_release_driver+0x25/0x40
  [<ffffffff81354e11>] ? bus_remove_device+0xf1/0x130
  [<ffffffff813522b9>] ? device_del+0x109/0x180
  [<ffffffffa01501d5>] ? usb_disable_device+0x95/0x1f0 [usbcore]
  [<ffffffffa014634f>] ? usb_disconnect+0x8f/0x190 [usbcore]
  [<ffffffffa0149179>] ? hub_thread+0x539/0x13a0 [usbcore]
  [<ffffffff810669f5>] ? sched_clock_local+0x15/0x80
  [<ffffffff81066c98>] ? sched_clock_cpu+0xb8/0xd0
  [<ffffffff81070730>] ? bit_waitqueue+0xb0/0xb0
  [<ffffffffa0148c40>] ? usb_port_resume+0x430/0x430 [usbcore]
  [<ffffffffa0148c40>] ? usb_port_resume+0x430/0x430 [usbcore]
  [<ffffffff8105973e>] ? kthread+0xce/0xf0
  [<ffffffff81059670>] ? kthread_create_on_node+0x1c0/0x1c0
  [<ffffffff814a8b7c>] ? ret_from_fork+0x7c/0xb0
  [<ffffffff81059670>] ? kthread_create_on_node+0x1c0/0x1c0
 ---[ end trace 40b1928d1136b91e ]---

This comes from the fact that usb-audio driver may receive the
disconnect callback multiple times, per each usb interface.  When a
device has both audio and midi interfaces, it gets called twice, and
currently the driver tries to release resources at the last call.
At this point, the first parent interface has been already deleted,
thus deleting a child of the first parent hits such a warning.

For fixing this problem, we need to call snd_card_disconnect() and
cancel pending operations at the very first disconnect while the
release of the whole objects waits until the last disconnect call.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=80931
Reported-and-tested-by: Tomas Gayoso <tgayoso@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 7ecd0e8a5c51..f61ebb17cc64 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -591,18 +591,19 @@ static void snd_usb_audio_disconnect(struct usb_device *dev,
 {
 	struct snd_card *card;
 	struct list_head *p;
+	bool was_shutdown;
 
 	if (chip == (void *)-1L)
 		return;
 
 	card = chip->card;
 	down_write(&chip->shutdown_rwsem);
+	was_shutdown = chip->shutdown;
 	chip->shutdown = 1;
 	up_write(&chip->shutdown_rwsem);
 
 	mutex_lock(&register_mutex);
-	chip->num_interfaces--;
-	if (chip->num_interfaces <= 0) {
+	if (!was_shutdown) {
 		struct snd_usb_endpoint *ep;
 
 		snd_card_disconnect(card);
@@ -622,6 +623,10 @@ static void snd_usb_audio_disconnect(struct usb_device *dev,
 		list_for_each(p, &chip->mixer_list) {
 			snd_usb_mixer_disconnect(p);
 		}
+	}
+
+	chip->num_interfaces--;
+	if (chip->num_interfaces <= 0) {
 		usb_chip[chip->index] = NULL;
 		mutex_unlock(&register_mutex);
 		snd_card_free_when_closed(card);
-- 
2.1.3
