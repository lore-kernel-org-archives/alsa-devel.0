From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/3] ALSA: firewire-digi00x: add MIDI
	operations for MIDI control port
Date: Sat, 31 Oct 2015 02:43:15 +0900
Message-ID: <1446226996-2299-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1446226996-2299-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D81626067B
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2015 18:43:23 +0100 (CET)
In-Reply-To: <1446226996-2299-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Digi 002/003 family has two types of MIDI port; one is for physical MIDI
port and another is for MIDI control message. The former is transferred in
isochronous packet, and the latter is transferred by asynchronous
transaction. These transmission mechanisms are completely different, while
current ALSA digi00x driver defines a set of operations for them with
several condition statements. As a result, codes for the operation are
messy.

This commit adds a set of MIDI operation for control MIDI ports. In later
commit, it's applied as an operation for ALSA rawmidi character device.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/digi00x/digi00x-midi.c | 63 +++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/sound/firewire/digi00x/digi00x-midi.c b/sound/firewire/digi00x/digi00x-midi.c
index 1d649e3..527f4b3 100644
--- a/sound/firewire/digi00x/digi00x-midi.c
+++ b/sound/firewire/digi00x/digi00x-midi.c
@@ -113,6 +113,69 @@ static struct snd_rawmidi_ops midi_phys_playback_ops = {
 	.trigger	= midi_phys_playback_trigger,
 };
 
+static int midi_ctl_open(struct snd_rawmidi_substream *substream)
+{
+	/* Do nothing. */
+	return 0;
+}
+
+static int midi_ctl_capture_close(struct snd_rawmidi_substream *substream)
+{
+	/* Do nothing. */
+	return 0;
+}
+
+static int midi_ctl_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+
+	snd_fw_async_midi_port_finish(&dg00x->out_control);
+
+	return 0;
+}
+
+static void midi_ctl_capture_trigger(struct snd_rawmidi_substream *substream,
+				     int up)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dg00x->lock, flags);
+
+	if (up)
+		dg00x->in_control = substream;
+	else
+		dg00x->in_control = NULL;
+
+	spin_unlock_irqrestore(&dg00x->lock, flags);
+}
+
+static void midi_ctl_playback_trigger(struct snd_rawmidi_substream *substream,
+				      int up)
+{
+	struct snd_dg00x *dg00x = substream->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dg00x->lock, flags);
+
+	if (up)
+		snd_fw_async_midi_port_run(&dg00x->out_control, substream);
+
+	spin_unlock_irqrestore(&dg00x->lock, flags);
+}
+
+static struct snd_rawmidi_ops midi_ctl_capture_ops = {
+	.open		= midi_ctl_open,
+	.close		= midi_ctl_capture_close,
+	.trigger	= midi_ctl_capture_trigger,
+};
+
+static struct snd_rawmidi_ops midi_ctl_playback_ops = {
+	.open		= midi_ctl_open,
+	.close		= midi_ctl_playback_close,
+	.trigger	= midi_ctl_playback_trigger,
+};
+
 static void set_midi_substream_names(struct snd_dg00x *dg00x,
 				     struct snd_rawmidi_str *str)
 {
-- 
2.1.4
