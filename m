From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 13/18] ALSA: firewire-motu: add MIDI
	functionality
Date: Wed, 22 Mar 2017 21:30:23 +0900
Message-ID: <20170322123028.24148-14-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 135552673C6
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:42 +0100 (CET)
In-Reply-To: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In MOTU FireWire series, MIDI messages are multiplexed to isochronous
packets as well as PCM frames, while the way is different from the one
in IEC 61883-6.

MIDI messages are put into a certain position in message chunks. One data
block can includes one byte of the MIDI messages. When data block includes
a MIDI byte, the block has a flag in a certain position of the message
chunk. These positions are unique depending on protocols.

Once a data block includes a MIDI byte, some following data blocks includes
no MIDI bytes. Next MIDI byte appears on a data block corresponding to
next cycle of physical MIDI bus. This seems to avoid buffer overflow caused
by bandwidth differences between IEEE 1394 bus and physical MIDI bus.

This commit adds MIDI functionality to transfer/receive MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/Makefile      |   2 +-
 sound/firewire/motu/amdtp-motu.c  |  84 +++++++++++++++++++++
 sound/firewire/motu/motu-midi.c   | 153 ++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu-stream.c |   9 ++-
 sound/firewire/motu/motu.c        |   7 ++
 sound/firewire/motu/motu.h        |   9 +++
 6 files changed, 260 insertions(+), 4 deletions(-)
 create mode 100644 sound/firewire/motu/motu-midi.c

diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
index 508b689..a512c1e 100644
--- a/sound/firewire/motu/Makefile
+++ b/sound/firewire/motu/Makefile
@@ -1,3 +1,3 @@
 snd-firewire-motu-objs := motu.o amdtp-motu.o motu-transaction.o motu-stream.o \
-			  motu-proc.o motu-pcm.o
+			  motu-proc.o motu-pcm.o motu-midi.o
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += snd-firewire-motu.o
diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 11e4412..0930cd8 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -13,6 +13,12 @@
 #define CIP_FMT_MOTU		0x02
 #define MOTU_FDF_AM824		0x22
 
+/*
+ * Nominally 3125 bytes/second, but the MIDI port's clock might be
+ * 1% too slow, and the bus clock 100 ppm too fast.
+ */
+#define MIDI_BYTES_PER_SECOND	3093
+
 struct amdtp_motu {
 	/* For timestamp processing.  */
 	unsigned int quotient_ticks_per_event;
@@ -24,9 +30,18 @@ struct amdtp_motu {
 
 	unsigned int pcm_chunks;
 	unsigned int pcm_byte_offset;
+
+	struct snd_rawmidi_substream *midi;
+	unsigned int midi_ports;
+	unsigned int midi_flag_offset;
+	unsigned int midi_byte_offset;
+
+	int midi_db_count;
+	unsigned int midi_db_interval;
 };
 
 int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			      unsigned int midi_ports,
 			      struct snd_motu_packet_format *formats)
 {
 	static const struct {
@@ -76,6 +91,13 @@ int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
 	p->pcm_chunks = pcm_chunks;
 	p->pcm_byte_offset = formats->pcm_byte_offset;
 
+	p->midi_ports = midi_ports;
+	p->midi_flag_offset = formats->midi_flag_offset;
+	p->midi_byte_offset = formats->midi_byte_offset;
+
+	p->midi_db_count = 0;
+	p->midi_db_interval = rate / MIDI_BYTES_PER_SECOND;
+
 	/* IEEE 1394 bus requires. */
 	delay = 0x2e00;
 
@@ -187,12 +209,70 @@ int amdtp_motu_add_pcm_hw_constraints(struct amdtp_stream *s,
 	return amdtp_stream_add_pcm_hw_constraints(s, runtime);
 }
 
+void amdtp_motu_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			     struct snd_rawmidi_substream *midi)
+{
+	struct amdtp_motu *p = s->protocol;
+
+	if (port < p->midi_ports)
+		WRITE_ONCE(p->midi, midi);
+}
+
+static void write_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+				unsigned int data_blocks)
+{
+	struct amdtp_motu *p = s->protocol;
+	struct snd_rawmidi_substream *midi = READ_ONCE(p->midi);
+	u8 *b;
+	int i;
+
+	for (i = 0; i < data_blocks; i++) {
+		b = (u8 *)buffer;
+
+		if (midi && p->midi_db_count == 0 &&
+		    snd_rawmidi_transmit(midi, b + p->midi_byte_offset, 1) == 1) {
+			b[p->midi_flag_offset] = 0x01;
+		} else {
+			b[p->midi_byte_offset] = 0x00;
+			b[p->midi_flag_offset] = 0x00;
+		}
+
+		buffer += s->data_block_quadlets;
+
+		if (--p->midi_db_count < 0)
+			p->midi_db_count = p->midi_db_interval;
+	}
+}
+
+static void read_midi_messages(struct amdtp_stream *s, __be32 *buffer,
+			       unsigned int data_blocks)
+{
+	struct amdtp_motu *p = s->protocol;
+	struct snd_rawmidi_substream *midi;
+	u8 *b;
+	int i;
+
+	for (i = 0; i < data_blocks; i++) {
+		b = (u8 *)buffer;
+		midi = READ_ONCE(p->midi);
+
+		if (midi && (b[p->midi_flag_offset] & 0x01))
+			snd_rawmidi_receive(midi, b + p->midi_byte_offset, 1);
+
+		buffer += s->data_block_quadlets;
+	}
+}
+
 static unsigned int process_tx_data_blocks(struct amdtp_stream *s,
 				__be32 *buffer, unsigned int data_blocks,
 				unsigned int *syt)
 {
+	struct amdtp_motu *p = s->protocol;
 	struct snd_pcm_substream *pcm;
 
+	if (p->midi_ports)
+		read_midi_messages(s, buffer, data_blocks);
+
 	pcm = ACCESS_ONCE(s->pcm);
 	if (data_blocks > 0 && pcm)
 		read_pcm_s32(s, pcm->runtime, buffer, data_blocks);
@@ -246,6 +326,7 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 				__be32 *buffer, unsigned int data_blocks,
 				unsigned int *syt)
 {
+	struct amdtp_motu *p = (struct amdtp_motu *)s->protocol;
 	struct snd_pcm_substream *pcm;
 
 	/* Not used. */
@@ -253,6 +334,9 @@ static unsigned int process_rx_data_blocks(struct amdtp_stream *s,
 
 	/* TODO: how to interact control messages between userspace? */
 
+	if (p->midi_ports)
+		write_midi_messages(s, buffer, data_blocks);
+
 	pcm = ACCESS_ONCE(s->pcm);
 	if (pcm)
 		write_pcm_s32(s, pcm->runtime, buffer, data_blocks);
diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
new file mode 100644
index 0000000..f232f29
--- /dev/null
+++ b/sound/firewire/motu/motu-midi.c
@@ -0,0 +1,153 @@
+/*
+ * motu-midi.h - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+#include "motu.h"
+
+static int midi_capture_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_motu *motu = substream->rmidi->private_data;
+	int err;
+
+	mutex_lock(&motu->mutex);
+
+	motu->capture_substreams++;
+	err = snd_motu_stream_start_duplex(motu, 0);
+
+	mutex_unlock(&motu->mutex);
+
+	return err;
+}
+
+static int midi_playback_open(struct snd_rawmidi_substream *substream)
+{
+	struct snd_motu *motu = substream->rmidi->private_data;
+	int err;
+
+	mutex_lock(&motu->mutex);
+
+	motu->playback_substreams++;
+	err = snd_motu_stream_start_duplex(motu, 0);
+
+	mutex_unlock(&motu->mutex);
+
+	return err;
+}
+
+static int midi_capture_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_motu *motu = substream->rmidi->private_data;
+
+	mutex_lock(&motu->mutex);
+
+	motu->capture_substreams--;
+	snd_motu_stream_stop_duplex(motu);
+
+	mutex_unlock(&motu->mutex);
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *substream)
+{
+	struct snd_motu *motu = substream->rmidi->private_data;
+
+	mutex_lock(&motu->mutex);
+
+	motu->playback_substreams--;
+	snd_motu_stream_stop_duplex(motu);
+
+	mutex_unlock(&motu->mutex);
+
+	return 0;
+}
+
+static void midi_capture_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_motu *motu = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&motu->lock, flags);
+
+	if (up)
+		amdtp_motu_midi_trigger(&motu->tx_stream, substrm->number,
+					substrm);
+	else
+		amdtp_motu_midi_trigger(&motu->tx_stream, substrm->number,
+					NULL);
+
+	spin_unlock_irqrestore(&motu->lock, flags);
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *substrm, int up)
+{
+	struct snd_motu *motu = substrm->rmidi->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&motu->lock, flags);
+
+	if (up)
+		amdtp_motu_midi_trigger(&motu->rx_stream, substrm->number,
+					substrm);
+	else
+		amdtp_motu_midi_trigger(&motu->rx_stream, substrm->number,
+					NULL);
+
+	spin_unlock_irqrestore(&motu->lock, flags);
+}
+
+static void set_midi_substream_names(struct snd_motu *motu,
+				     struct snd_rawmidi_str *str)
+{
+	struct snd_rawmidi_substream *subs;
+
+	list_for_each_entry(subs, &str->substreams, list) {
+		snprintf(subs->name, sizeof(subs->name),
+			 "%s MIDI %d", motu->card->shortname, subs->number + 1);
+	}
+}
+
+int snd_motu_create_midi_devices(struct snd_motu *motu)
+{
+	static struct snd_rawmidi_ops capture_ops = {
+		.open		= midi_capture_open,
+		.close		= midi_capture_close,
+		.trigger	= midi_capture_trigger,
+	};
+	static struct snd_rawmidi_ops playback_ops = {
+		.open		= midi_playback_open,
+		.close		= midi_playback_close,
+		.trigger	= midi_playback_trigger,
+	};
+	struct snd_rawmidi *rmidi;
+	struct snd_rawmidi_str *str;
+	int err;
+
+	/* create midi ports */
+	err = snd_rawmidi_new(motu->card, motu->card->driver, 0, 1, 1, &rmidi);
+	if (err < 0)
+		return err;
+
+	snprintf(rmidi->name, sizeof(rmidi->name),
+		 "%s MIDI", motu->card->shortname);
+	rmidi->private_data = motu;
+
+	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_INPUT |
+			     SNDRV_RAWMIDI_INFO_OUTPUT |
+			     SNDRV_RAWMIDI_INFO_DUPLEX;
+
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
+			    &capture_ops);
+	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT];
+	set_midi_substream_names(motu, str);
+
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT,
+			    &playback_ops);
+	str = &rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT];
+	set_midi_substream_names(motu, str);
+
+	return 0;
+}
diff --git a/sound/firewire/motu/motu-stream.c b/sound/firewire/motu/motu-stream.c
index 9aa698f..911d348 100644
--- a/sound/firewire/motu/motu-stream.c
+++ b/sound/firewire/motu/motu-stream.c
@@ -28,22 +28,25 @@
 
 static int start_both_streams(struct snd_motu *motu, unsigned int rate)
 {
+	unsigned int midi_ports = 0;
 	__be32 reg;
 	u32 data;
 	int err;
 
+	if (motu->spec->flags & SND_MOTU_SPEC_HAS_MIDI)
+		midi_ports = 1;
+
 	/* Set packet formation to our packet streaming engine. */
-	err = amdtp_motu_set_parameters(&motu->rx_stream, rate,
+	err = amdtp_motu_set_parameters(&motu->rx_stream, rate, midi_ports,
 					&motu->rx_packet_formats);
 	if (err < 0)
 		return err;
 
-	err = amdtp_motu_set_parameters(&motu->tx_stream, rate,
+	err = amdtp_motu_set_parameters(&motu->tx_stream, rate, midi_ports,
 					&motu->tx_packet_formats);
 	if (err < 0)
 		return err;
 
-
 	/* Get isochronous resources on the bus. */
 	err = fw_iso_resources_allocate(&motu->rx_resources,
 				amdtp_stream_get_max_payload(&motu->rx_stream),
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 801d6a7..d4da137 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -103,6 +103,12 @@ static void do_registration(struct work_struct *work)
 	if (err < 0)
 		goto error;
 
+	if (motu->spec->flags & SND_MOTU_SPEC_HAS_MIDI) {
+		err = snd_motu_create_midi_devices(motu);
+		if (err < 0)
+			goto error;
+	}
+
 	err = snd_card_register(motu->card);
 	if (err < 0)
 		goto error;
@@ -138,6 +144,7 @@ static int motu_probe(struct fw_unit *unit,
 	dev_set_drvdata(&unit->device, motu);
 
 	mutex_init(&motu->mutex);
+	spin_lock_init(&motu->lock);
 
 	/* Allocate and register this sound card later. */
 	INIT_DEFERRABLE_WORK(&motu->dwork, do_registration);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index afc6de6..338b351 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -21,12 +21,15 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/info.h>
+#include <sound/rawmidi.h>
 
 #include "../lib.h"
 #include "../amdtp-stream.h"
 #include "../iso-resources.h"
 
 struct snd_motu_packet_format {
+	unsigned char midi_flag_offset;
+	unsigned char midi_byte_offset;
 	unsigned char pcm_byte_offset;
 
 	unsigned char msg_chunks;
@@ -38,6 +41,7 @@ struct snd_motu {
 	struct snd_card *card;
 	struct fw_unit *unit;
 	struct mutex mutex;
+	spinlock_t lock;
 
 	bool registered;
 	struct delayed_work dwork;
@@ -113,9 +117,12 @@ int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 		    enum amdtp_stream_direction dir,
 		    const struct snd_motu_protocol *const protocol);
 int amdtp_motu_set_parameters(struct amdtp_stream *s, unsigned int rate,
+			      unsigned int midi_ports,
 			      struct snd_motu_packet_format *formats);
 int amdtp_motu_add_pcm_hw_constraints(struct amdtp_stream *s,
 				      struct snd_pcm_runtime *runtime);
+void amdtp_motu_midi_trigger(struct amdtp_stream *s, unsigned int port,
+			     struct snd_rawmidi_substream *midi);
 
 int snd_motu_transaction_read(struct snd_motu *motu, u32 offset, __be32 *reg,
 			      size_t size);
@@ -133,4 +140,6 @@ void snd_motu_stream_stop_duplex(struct snd_motu *motu);
 void snd_motu_proc_init(struct snd_motu *motu);
 
 int snd_motu_create_pcm_devices(struct snd_motu *motu);
+
+int snd_motu_create_midi_devices(struct snd_motu *motu);
 #endif
-- 
2.9.3
