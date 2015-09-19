From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/15] ALSA: firewire-lib: add a member of
	frame_multiplier instead of double_pcm_frames
Date: Sat, 19 Sep 2015 11:21:51 +0900
Message-ID: <1442629322-15457-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1442629322-15457-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 43CE62604BD
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

In future commit, interface between data block processing layer and packet
stream processing layer is defined. These two layers communicate the
number of data blocks and the number of PCM frames.

The data block processing layer has a responsibility for calculating the
number of PCM frames. Therefore, 'dual wire' of Dice quirk should be
handled in data block processing layer.

This commit adds a member of 'frame_multiplier'. This member represents
the ratio of the number of PCM frames against the number of data blocks.
Usually, the value of this member is 1, while it's 2 in Dice's 'dual wire'.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c | 22 ++++++++++++----------
 sound/firewire/amdtp.h |  3 ++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 094982f..0bb5e14 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -225,6 +225,16 @@ int amdtp_stream_set_parameters(struct amdtp_stream *s,
 	s->data_block_quadlets = s->pcm_channels + midi_channels;
 	s->midi_ports = midi_ports;
 
+	/*
+	 * In IEC 61883-6, one data block represents one event. In ALSA, one
+	 * event equals to one PCM frame. But Dice has a quirk at higher
+	 * sampling rate to transfer two PCM frames in one data block.
+	 */
+	if (double_pcm_frames)
+		s->frame_multiplier = 2;
+	else
+		s->frame_multiplier = 1;
+
 	s->syt_interval = amdtp_syt_intervals[sfc];
 
 	/* default buffering in the device */
@@ -584,14 +594,6 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 {
 	unsigned int ptr;
 
-	/*
-	 * In IEC 61883-6, one data block represents one event. In ALSA, one
-	 * event equals to one PCM frame. But Dice has a quirk to transfer
-	 * two PCM frames in one data block.
-	 */
-	if (s->double_pcm_frames)
-		frames *= 2;
-
 	ptr = s->pcm_buffer_pointer + frames;
 	if (ptr >= pcm->runtime->buffer_size)
 		ptr -= pcm->runtime->buffer_size;
@@ -685,7 +687,7 @@ static int handle_out_packet(struct amdtp_stream *s, unsigned int data_blocks,
 		return -EIO;
 
 	if (pcm)
-		update_pcm_pointers(s, pcm, data_blocks);
+		update_pcm_pointers(s, pcm, data_blocks * s->frame_multiplier);
 
 	/* No need to return the number of handled data blocks. */
 	return 0;
@@ -788,7 +790,7 @@ end:
 		return -EIO;
 
 	if (pcm)
-		update_pcm_pointers(s, pcm, *data_blocks);
+		update_pcm_pointers(s, pcm, *data_blocks * s->frame_multiplier);
 
 	return 0;
 }
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 2c91306..6522925 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -162,11 +162,12 @@ struct amdtp_stream {
 
 	u8 pcm_positions[AMDTP_MAX_CHANNELS_FOR_PCM];
 	u8 midi_position;
-	bool double_pcm_frames;
 
 	void (*transfer_samples)(struct amdtp_stream *s,
 				 struct snd_pcm_substream *pcm,
 				 __be32 *buffer, unsigned int frames);
+
+	unsigned int frame_multiplier;
 };
 
 int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
-- 
2.1.4
