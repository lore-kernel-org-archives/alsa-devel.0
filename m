From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/15] ALSA: firewire-lib: arrange structure
	for AMDTP stream
Date: Sat, 19 Sep 2015 11:21:48 +0900
Message-ID: <1442629322-15457-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 41AC72604A9
 for <alsa-devel@alsa-project.org>; Sat, 19 Sep 2015 04:22:12 +0200 (CEST)
In-Reply-To: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
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

In later commit, some members related to AM824 data format will be moved
from AMDTP stream structure to data block structure. This commit is a
preparation for it. Additionally, current layout of AMDTP stream structure
is a bit mess by several extensions. This commit also arranges the layout.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.h | 58 +++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index b2cf9e7..4640d2b 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -117,52 +117,56 @@ struct amdtp_stream {
 	struct fw_unit *unit;
 	enum cip_flags flags;
 	enum amdtp_stream_direction direction;
-	struct fw_iso_context *context;
 	struct mutex mutex;
 
-	enum cip_sfc sfc;
-	unsigned int data_block_quadlets;
-	unsigned int pcm_channels;
-	unsigned int midi_ports;
-	void (*transfer_samples)(struct amdtp_stream *s,
-				 struct snd_pcm_substream *pcm,
-				 __be32 *buffer, unsigned int frames);
-	u8 pcm_positions[AMDTP_MAX_CHANNELS_FOR_PCM];
-	u8 midi_position;
-
-	unsigned int syt_interval;
-	unsigned int transfer_delay;
-	unsigned int source_node_id_field;
+	/* For packet processing. */
+	struct fw_iso_context *context;
 	struct iso_packets_buffer buffer;
-
-	struct snd_pcm_substream *pcm;
-	struct tasklet_struct period_tasklet;
-
 	int packet_index;
+
+	/* For CIP headers. */
+	unsigned int source_node_id_field;
+	unsigned int data_block_quadlets;
 	unsigned int data_block_counter;
+	/* quirk: fixed interval of dbc between previos/current packets. */
+	unsigned int tx_dbc_interval;
+	/* quirk: indicate the value of dbc field in a first packet. */
+	unsigned int tx_first_dbc;
 
+	/* Internal flags. */
+	enum cip_sfc sfc;
+	unsigned int syt_interval;
+	unsigned int transfer_delay;
 	unsigned int data_block_state;
-
 	unsigned int last_syt_offset;
 	unsigned int syt_offset_state;
 
+	/* For a PCM substream processing. */
+	struct snd_pcm_substream *pcm;
+	struct tasklet_struct period_tasklet;
 	unsigned int pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 	bool pointer_flush;
-	bool double_pcm_frames;
 
+	/* To wait for first packet. */
+	bool callbacked;
+	wait_queue_head_t callback_wait;
+	struct amdtp_stream *sync_slave;
+
+	/* For AM824 processing. */
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
 	int midi_fifo_limit;
 	int midi_fifo_used[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
+	unsigned int pcm_channels;
+	unsigned int midi_ports;
 
-	/* quirk: fixed interval of dbc between previos/current packets. */
-	unsigned int tx_dbc_interval;
-	/* quirk: indicate the value of dbc field in a first packet. */
-	unsigned int tx_first_dbc;
+	u8 pcm_positions[AMDTP_MAX_CHANNELS_FOR_PCM];
+	u8 midi_position;
+	bool double_pcm_frames;
 
-	bool callbacked;
-	wait_queue_head_t callback_wait;
-	struct amdtp_stream *sync_slave;
+	void (*transfer_samples)(struct amdtp_stream *s,
+				 struct snd_pcm_substream *pcm,
+				 __be32 *buffer, unsigned int frames);
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-- 
2.1.4
