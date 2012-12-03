From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: usb-audio: Fix missing autopm for
	MIDI input
Date: Mon,  3 Dec 2012 11:48:58 +0100
Message-ID: <1354531738-22046-3-git-send-email-tiwai@suse.de>
References: <1354531738-22046-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D59012615DF
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

The commit [88a8516a: ALSA: usbaudio: implement USB autosuspend] added
the support of autopm for USB MIDI output, but it didn't take the MIDI
input into account.

This patch adds the following for fixing the autopm:
- Manage the URB start at the first MIDI input stream open, instead of
  the time of instance creation
- Move autopm code to the common substream_open()
- Make snd_usbmidi_input_start/_stop() more robust and add the running
  state check

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 87 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 42 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index c0054ee..6da1cf1 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -126,8 +126,10 @@ struct snd_usb_midi {
 		struct snd_usb_midi_in_endpoint *in;
 	} endpoints[MIDI_MAX_ENDPOINTS];
 	unsigned long input_triggered;
-	unsigned int opened;
+	bool autopm_reference;
+	unsigned int opened[2];
 	unsigned char disconnected;
+	unsigned char input_running;
 
 	struct snd_kcontrol *roland_load_ctl;
 };
@@ -149,7 +151,6 @@ struct snd_usb_midi_out_endpoint {
 		struct snd_usb_midi_out_endpoint* ep;
 		struct snd_rawmidi_substream *substream;
 		int active;
-		bool autopm_reference;
 		uint8_t cable;		/* cable number << 4 */
 		uint8_t state;
 #define STATE_UNKNOWN	0
@@ -1034,36 +1035,57 @@ static void update_roland_altsetting(struct snd_usb_midi* umidi)
 	snd_usbmidi_input_start(&umidi->list);
 }
 
-static void substream_open(struct snd_rawmidi_substream *substream, int open)
+static int substream_open(struct snd_rawmidi_substream *substream, int dir,
+			  int open)
 {
 	struct snd_usb_midi* umidi = substream->rmidi->private_data;
 	struct snd_kcontrol *ctl;
+	int err;
 
 	down_read(&umidi->disc_rwsem);
 	if (umidi->disconnected) {
 		up_read(&umidi->disc_rwsem);
-		return;
+		return open ? -ENODEV : 0;
 	}
 
 	mutex_lock(&umidi->mutex);
 	if (open) {
-		if (umidi->opened++ == 0 && umidi->roland_load_ctl) {
-			ctl = umidi->roland_load_ctl;
-			ctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-			snd_ctl_notify(umidi->card,
+		if (!umidi->opened[0] && !umidi->opened[1]) {
+			err = usb_autopm_get_interface(umidi->iface);
+			umidi->autopm_reference = err >= 0;
+			if (err < 0 && err != -EACCES) {
+				up_read(&umidi->disc_rwsem);
+				return -EIO;
+			}
+			if (umidi->roland_load_ctl) {
+				ctl = umidi->roland_load_ctl;
+				ctl->vd[0].access |= SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+				snd_ctl_notify(umidi->card,
 				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
-			update_roland_altsetting(umidi);
+				update_roland_altsetting(umidi);
+			}
 		}
+		umidi->opened[dir]++;
+		if (umidi->opened[1])
+			snd_usbmidi_input_start(&umidi->list);
 	} else {
-		if (--umidi->opened == 0 && umidi->roland_load_ctl) {
-			ctl = umidi->roland_load_ctl;
-			ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
-			snd_ctl_notify(umidi->card,
+		umidi->opened[dir]--;
+		if (!umidi->opened[1])
+			snd_usbmidi_input_stop(&umidi->list);
+		if (!umidi->opened[0] && !umidi->opened[1]) {
+			if (umidi->roland_load_ctl) {
+				ctl = umidi->roland_load_ctl;
+				ctl->vd[0].access &= ~SNDRV_CTL_ELEM_ACCESS_INACTIVE;
+				snd_ctl_notify(umidi->card,
 				       SNDRV_CTL_EVENT_MASK_INFO, &ctl->id);
+			}
+			if (umidi->autopm_reference)
+				usb_autopm_put_interface(umidi->iface);
 		}
 	}
 	mutex_unlock(&umidi->mutex);
 	up_read(&umidi->disc_rwsem);
+	return 0;
 }
 
 static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
@@ -1071,7 +1093,6 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 	struct snd_usb_midi* umidi = substream->rmidi->private_data;
 	struct usbmidi_out_port* port = NULL;
 	int i, j;
-	int err;
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
 		if (umidi->endpoints[i].out)
@@ -1085,33 +1106,14 @@ static int snd_usbmidi_output_open(struct snd_rawmidi_substream *substream)
 		return -ENXIO;
 	}
 
-	down_read(&umidi->disc_rwsem);
-	if (umidi->disconnected) {
-		up_read(&umidi->disc_rwsem);
-		return -ENODEV;
-	}
-	err = usb_autopm_get_interface(umidi->iface);
-	port->autopm_reference = err >= 0;
-	up_read(&umidi->disc_rwsem);
-	if (err < 0 && err != -EACCES)
-		return -EIO;
 	substream->runtime->private_data = port;
 	port->state = STATE_UNKNOWN;
-	substream_open(substream, 1);
-	return 0;
+	return substream_open(substream, 0, 1);
 }
 
 static int snd_usbmidi_output_close(struct snd_rawmidi_substream *substream)
 {
-	struct snd_usb_midi* umidi = substream->rmidi->private_data;
-	struct usbmidi_out_port *port = substream->runtime->private_data;
-
-	substream_open(substream, 0);
-	down_read(&umidi->disc_rwsem);
-	if (!umidi->disconnected && port->autopm_reference)
-		usb_autopm_put_interface(umidi->iface);
-	up_read(&umidi->disc_rwsem);
-	return 0;
+	return substream_open(substream, 0, 0);
 }
 
 static void snd_usbmidi_output_trigger(struct snd_rawmidi_substream *substream, int up)
@@ -1164,14 +1166,12 @@ static void snd_usbmidi_output_drain(struct snd_rawmidi_substream *substream)
 
 static int snd_usbmidi_input_open(struct snd_rawmidi_substream *substream)
 {
-	substream_open(substream, 1);
-	return 0;
+	return substream_open(substream, 1, 1);
 }
 
 static int snd_usbmidi_input_close(struct snd_rawmidi_substream *substream)
 {
-	substream_open(substream, 0);
-	return 0;
+	return substream_open(substream, 1, 0);
 }
 
 static void snd_usbmidi_input_trigger(struct snd_rawmidi_substream *substream, int up)
@@ -2080,12 +2080,15 @@ void snd_usbmidi_input_stop(struct list_head* p)
 	unsigned int i, j;
 
 	umidi = list_entry(p, struct snd_usb_midi, list);
+	if (!umidi->input_running)
+		return;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint* ep = &umidi->endpoints[i];
 		if (ep->in)
 			for (j = 0; j < INPUT_URBS; ++j)
 				usb_kill_urb(ep->in->urbs[j]);
 	}
+	umidi->input_running = 0;
 }
 
 static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint* ep)
@@ -2110,8 +2113,11 @@ void snd_usbmidi_input_start(struct list_head* p)
 	int i;
 
 	umidi = list_entry(p, struct snd_usb_midi, list);
+	if (umidi->input_running || !umidi->opened[1])
+		return;
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
 		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
+	umidi->input_running = 1;
 }
 
 /*
@@ -2250,9 +2256,6 @@ int snd_usbmidi_create(struct snd_card *card,
 	}
 
 	list_add_tail(&umidi->list, midi_list);
-
-	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i)
-		snd_usbmidi_input_start_ep(umidi->endpoints[i].in);
 	return 0;
 }
 
-- 
1.8.0.1
