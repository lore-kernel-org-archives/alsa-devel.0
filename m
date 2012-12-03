From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: usb-audio: Avoid autopm calls after
	disconnection
Date: Mon,  3 Dec 2012 11:48:57 +0100
Message-ID: <1354531738-22046-2-git-send-email-tiwai@suse.de>
References: <1354531738-22046-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D07C42615D4
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 11:49:14 +0100 (CET)
In-Reply-To: <1354531738-22046-1-git-send-email-tiwai@suse.de>
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
Cc: Jonathan Nieder <jrnieder@gmail.com>, David Banks <amoebae@gmail.com>, Olivier MATZ <zer0@droids-corp.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Add a similar protection against the disconnection race and the
invalid use of usb instance after disconnection, as well as we've done
for the USB audio PCM.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=51201
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index eeefbce..c0054ee 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -116,6 +116,7 @@ struct snd_usb_midi {
 	struct list_head list;
 	struct timer_list error_timer;
 	spinlock_t disc_lock;
+	struct rw_semaphore disc_rwsem;
 	struct mutex mutex;
 	u32 usb_id;
 	int next_midi_device;
@@ -1038,6 +1039,12 @@ static void substream_open(struct snd_rawmidi_substream *substream, int open)
 	struct snd_usb_midi* umidi = substream->rmidi->private_data;
 	struct snd_kcontrol *ctl;
 
+	down_read(&umidi->disc_rwsem);
+	if (umidi->disconnected) {
+		up_read(&umidi->disc_rwsem);
+		return;
+	}
+
 	mutex_lock(&umidi->mutex);
 	if (open) {
 		if (umidi->opened++ == 0 && umidi->roland_load_ctl) {
@@ -1056,6 +1063,7 @@ static void substream_open(struct snd_rawmidi_substream *substream, int open)
 		}
 	}
 	mutex_unlock(&umidi->mutex);
+	up_read(&umidi->disc_rwsem);
 }
 
 static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
@@ -1076,8 +1084,15 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 		snd_BUG();
 		return -ENXIO;
 	}
+
+	down_read(&umidi->disc_rwsem);
+	if (umidi->disconnected) {
+		up_read(&umidi->disc_rwsem);
+		return -ENODEV;
+	}
 	err = usb_autopm_get_interface(umidi->iface);
 	port->autopm_reference = err >= 0;
+	up_read(&umidi->disc_rwsem);
 	if (err < 0 && err != -EACCES)
 		return -EIO;
 	substream->runtime->private_data = port;
@@ -1092,8 +1107,10 @@ static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 	struct usbmidi_out_port *port = substream->runtime->private_data;
 
 	substream_open(substream, 0);
-	if (port->autopm_reference)
+	down_read(&umidi->disc_rwsem);
+	if (!umidi->disconnected && port->autopm_reference)
 		usb_autopm_put_interface(umidi->iface);
+	up_read(&umidi->disc_rwsem);
 	return 0;
 }
 
@@ -1403,9 +1420,12 @@ void snd_usbmidi_disconnect(struct list_head* p)
 	 * a timer may submit an URB. To reliably break the cycle
 	 * a flag under lock must be used
 	 */
+	down_write(&umidi->disc_rwsem);
 	spin_lock_irq(&umidi->disc_lock);
 	umidi->disconnected = 1;
 	spin_unlock_irq(&umidi->disc_lock);
+	up_write(&umidi->disc_rwsem);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint* ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -2117,6 +2137,7 @@ int snd_usbmidi_create(struct snd_card *card,
 	umidi->usb_protocol_ops = &snd_usbmidi_standard_ops;
 	init_timer(&umidi->error_timer);
 	spin_lock_init(&umidi->disc_lock);
+	init_rwsem(&umidi->disc_rwsem);
 	mutex_init(&umidi->mutex);
 	umidi->usb_id = USB_ID(le16_to_cpu(umidi->dev->descriptor.idVendor),
 			       le16_to_cpu(umidi->dev->descriptor.idProduct));
-- 
1.8.0.1
