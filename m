From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 14/17] ALSA: oxfw: copy handlers of
	asynchronous transaction for MIDI playback
Date: Sun,  6 Dec 2015 13:18:22 +0900
Message-ID: <1449375505-2704-15-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id B45532651CB
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:32 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit copies some functions of asynchronous transactions for MIDI
playback, to merge scs1x module. The features of payload in asynchronous
transaction are the same as captured MIDI messages.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw-scs1x.c | 161 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw-scs1x.c b/sound/firewire/oxfw/oxfw-scs1x.c
index 807009f..94477a5 100644
--- a/sound/firewire/oxfw/oxfw-scs1x.c
+++ b/sound/firewire/oxfw/oxfw-scs1x.c
@@ -18,6 +18,20 @@ struct fw_scs1x {
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
+	struct fw_device *fw_dev;
 };
 
 static const u8 sysex_escape_prefix[] = {
@@ -106,6 +120,148 @@ end:
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
+	struct snd_rawmidi_substream *stream;
+	unsigned int i;
+	u8 byte;
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
+	generation = scs->fw_dev->generation;
+	smp_rmb(); /* node_id vs. generation */
+	fw_send_request(scs->fw_dev->card, &scs->transaction,
+			TCODE_WRITE_BLOCK_REQUEST, scs->fw_dev->node_id,
+			generation, scs->fw_dev->max_speed, HSS1394_ADDRESS,
+			scs->buffer, i, scs_write_callback, scs);
+}
+
 static int midi_capture_open(struct snd_rawmidi_substream *stream)
 {
 	struct fw_scs1x *scs = stream->rmidi->private_data;
@@ -169,6 +325,7 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 	scs = kzalloc(sizeof(struct fw_scs1x), GFP_KERNEL);
 	if (scs == NULL)
 		return -ENOMEM;
+	scs->fw_dev = fw_parent_device(oxfw->unit);
 	oxfw->spec = scs;
 
 	/* Allocate own handler for imcoming asynchronous transaction. */
@@ -198,6 +355,10 @@ int snd_oxfw_scs1x_add(struct snd_oxfw *oxfw)
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT,
 			    &midi_capture_ops);
 
+	tasklet_init(&scs->tasklet, scs_output_tasklet, (unsigned long)scs);
+	init_waitqueue_head(&scs->idle_wait);
+	scs->output_idle = true;
+
 	return 0;
 err_allocated:
 	fw_core_remove_address_handler(&scs->hss_handler);
-- 
2.5.0
