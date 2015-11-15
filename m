From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/9] ALSA: oxfw: copy MIDI playback
	functionality to scs1x layer
Date: Sun, 15 Nov 2015 18:26:03 +0900
Message-ID: <1447579565-4615-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id D946A261A64
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:26:11 +0100 (CET)
In-Reply-To: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit copies MIDI playback functionality to merge scs1x module. The
features of payload in asynchronous transaction are the same as captured
MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 208 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 2 deletions(-)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 5bf52b7..89ba8f6 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -22,6 +22,19 @@ struct fw_scs1x {
 	struct fw_address_handler hss_handler;
 	u8 input_escape_count;
 	struct snd_rawmidi_substream *input;
+
+	/* For MIDI playback. */
+	struct snd_rawmidi_substream *output;
+	bool output_idle;
+	u8 output_status;
+	u8 output_bytes;
+	bool output_escaped;
+	bool output_escape_high_nibble;
+	struct tasklet_struct tasklet;
+	wait_queue_head_t idle_wait;
+	u8 buffer[HSS1394_MAX_PACKET_SIZE];
+	bool transaction_running;
+	struct fw_transaction transaction;
 };
 
 static const u8 sysex_escape_prefix[] = {
@@ -110,6 +123,151 @@ end:
 	fw_send_response(card, request, rcode);
 }
 
+static void scs_write_callback(struct fw_card *card, int rcode,
+			       void *data, size_t length, void *callback_data)
+{
+	struct fw_scs1x *scs = callback_data;
+
+	if (rcode == RCODE_GENERATION)
+		;	/* TODO: retry this packet */
+
+	scs->transaction_running = false;
+	tasklet_schedule(&scs->tasklet);
+}
+
+static bool is_valid_running_status(u8 status)
+{
+	return status >= 0x80 && status <= 0xef;
+}
+
+static bool is_one_byte_cmd(u8 status)
+{
+	return status == 0xf6 ||
+	       status >= 0xf8;
+}
+
+static bool is_two_bytes_cmd(u8 status)
+{
+	return (status >= 0xc0 && status <= 0xdf) ||
+	       status == 0xf1 ||
+	       status == 0xf3;
+}
+
+static bool is_three_bytes_cmd(u8 status)
+{
+	return (status >= 0x80 && status <= 0xbf) ||
+	       (status >= 0xe0 && status <= 0xef) ||
+	       status == 0xf2;
+}
+
+static bool is_invalid_cmd(u8 status)
+{
+	return status == 0xf4 ||
+	       status == 0xf5 ||
+	       status == 0xf9 ||
+	       status == 0xfd;
+}
+
+static void scs_output_tasklet(unsigned long data)
+{
+	struct fw_scs1x *scs = (struct fw_scs1x *)data;
+	struct snd_oxfw *oxfw = scs->oxfw;
+	struct snd_rawmidi_substream *stream;
+	unsigned int i;
+	u8 byte;
+	struct fw_device *dev;
+	int generation;
+
+	if (scs->transaction_running)
+		return;
+
+	stream = ACCESS_ONCE(scs->output);
+	if (!stream) {
+		scs->output_idle = true;
+		wake_up(&scs->idle_wait);
+		return;
+	}
+
+	i = scs->output_bytes;
+	for (;;) {
+		if (snd_rawmidi_transmit(stream, &byte, 1) != 1) {
+			scs->output_bytes = i;
+			scs->output_idle = true;
+			wake_up(&scs->idle_wait);
+			return;
+		}
+		/*
+		 * Convert from real MIDI to what I think the device expects (no
+		 * running status, one command per packet, unescaped SysExs).
+		 */
+		if (scs->output_escaped && byte < 0x80) {
+			if (scs->output_escape_high_nibble) {
+				if (i < HSS1394_MAX_PACKET_SIZE) {
+					scs->buffer[i] = byte << 4;
+					scs->output_escape_high_nibble = false;
+				}
+			} else {
+				scs->buffer[i++] |= byte & 0x0f;
+				scs->output_escape_high_nibble = true;
+			}
+		} else if (byte < 0x80) {
+			if (i == 1) {
+				if (!is_valid_running_status(
+							scs->output_status))
+					continue;
+				scs->buffer[0] = HSS1394_TAG_USER_DATA;
+				scs->buffer[i++] = scs->output_status;
+			}
+			scs->buffer[i++] = byte;
+			if ((i == 3 && is_two_bytes_cmd(scs->output_status)) ||
+			    (i == 4 && is_three_bytes_cmd(scs->output_status)))
+				break;
+			if (i == 1 + ARRAY_SIZE(sysex_escape_prefix) &&
+			    !memcmp(scs->buffer + 1, sysex_escape_prefix,
+				    ARRAY_SIZE(sysex_escape_prefix))) {
+				scs->output_escaped = true;
+				scs->output_escape_high_nibble = true;
+				i = 0;
+			}
+			if (i >= HSS1394_MAX_PACKET_SIZE)
+				i = 1;
+		} else if (byte == 0xf7) {
+			if (scs->output_escaped) {
+				if (i >= 1 && scs->output_escape_high_nibble &&
+				    scs->buffer[0] !=
+						HSS1394_TAG_CHANGE_ADDRESS)
+					break;
+			} else {
+				if (i > 1 && scs->output_status == 0xf0) {
+					scs->buffer[i++] = 0xf7;
+					break;
+				}
+			}
+			i = 1;
+			scs->output_escaped = false;
+		} else if (!is_invalid_cmd(byte) && byte < 0xf8) {
+			i = 1;
+			scs->buffer[0] = HSS1394_TAG_USER_DATA;
+			scs->buffer[i++] = byte;
+			scs->output_status = byte;
+			scs->output_escaped = false;
+			if (is_one_byte_cmd(byte))
+				break;
+		}
+	}
+	scs->output_bytes = 1;
+	scs->output_escaped = false;
+
+	scs->transaction_running = true;
+	dev = fw_parent_device(oxfw->unit);
+	generation = dev->generation;
+	smp_rmb(); /* node_id vs. generation */
+	fw_send_request(dev->card, &scs->transaction, TCODE_WRITE_BLOCK_REQUEST,
+			dev->node_id, generation, dev->max_speed,
+			HSS1394_ADDRESS, scs->buffer, i,
+			scs_write_callback, scs);
+}
+
 static int midi_capture_open(struct snd_rawmidi_substream *stream)
 {
 	struct fw_scs1x *scs = stream->rmidi->private_data;
@@ -137,6 +295,39 @@ static struct snd_rawmidi_ops capture_ops = {
 	.trigger = midi_capture_trigger,
 };
 
+static int midi_playback_open(struct snd_rawmidi_substream *stream)
+{
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	scs->output_status = 0;
+	scs->output_bytes = 1;
+	scs->output_escaped = false;
+
+	return 0;
+}
+
+static int midi_playback_close(struct snd_rawmidi_substream *stream)
+{
+	return 0;
+}
+
+static void midi_playback_trigger(struct snd_rawmidi_substream *stream, int up)
+{
+	struct fw_scs1x *scs = stream->rmidi->private_data;
+
+	ACCESS_ONCE(scs->output) = up ? stream : NULL;
+	if (up) {
+		scs->output_idle = false;
+		tasklet_schedule(&scs->tasklet);
+	}
+}
+
+static struct snd_rawmidi_ops playback_ops = {
+	.open    = midi_playback_open,
+	.close   = midi_playback_close,
+	.trigger = midi_playback_trigger,
+};
+
 static int register_address(struct snd_oxfw *oxfw)
 {
 	struct fw_scs1x *scs = oxfw->spec->private_data;
@@ -171,7 +362,7 @@ static int scs1x_add(struct snd_oxfw *oxfw)
 	}
 
 	/* For backward compatibility to scs1x module, use unique name. */
-	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 0, 1, &rmidi);
+	err = snd_rawmidi_new(oxfw->card, "SCS.1x", 0, 1, 1, &rmidi);
 	if (err < 0) {
 		fw_core_remove_address_handler(&scs->hss_handler);
 		return err;
@@ -179,10 +370,18 @@ static int scs1x_add(struct snd_oxfw *oxfw)
 
 	snprintf(rmidi->name, sizeof(rmidi->name),
 		 "%s MIDI", oxfw->card->shortname);
-	rmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT;
+	rmidi->info_flags = SNDRV_RAWMIDI_INFO_INPUT |
+			    SNDRV_RAWMIDI_INFO_OUTPUT |
+			    SNDRV_RAWMIDI_INFO_DUPLEX;
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &capture_ops);
+	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &playback_ops);
 	rmidi->private_data = scs;
 
+	scs->oxfw = oxfw;
+	tasklet_init(&scs->tasklet, scs_output_tasklet, (unsigned long)scs);
+	init_waitqueue_head(&scs->idle_wait);
+	scs->output_idle = true;
+
 	return err;
 }
 
@@ -195,8 +394,13 @@ static void scs1x_remove(struct snd_oxfw *oxfw)
 {
 	struct fw_scs1x *scs = oxfw->spec->private_data;
 
+	ACCESS_ONCE(scs->output) = NULL;
 	ACCESS_ONCE(scs->input) = NULL;
 
+	wait_event(scs->idle_wait, scs->output_idle);
+
+	tasklet_kill(&scs->tasklet);
+
 	fw_core_remove_address_handler(&scs->hss_handler);
 }
 
-- 
2.5.0
