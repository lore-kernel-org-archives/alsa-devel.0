From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 25/49] fireworks/firewire-lib: Add a quirk for fixed interval
	of reported dbc
Date: Fri, 25 Apr 2014 22:45:06 +0900
Message-ID: <1398433530-13136-26-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Fireworks firmware version 5.5 reports fix interval for dbc in each packet.

For example, AudioFire4:
CIP0     CIP1     Payload
00070000 900484FF 72
00070008 9004A8FF 72
00070008 90FFFFFF 02
00070010 9004D0FF 72
00070018 9004C4FF 72
00070020 9004E8FF 72
00070020 90FFFFFF 02
00070028 900410FE 72

The interval of each dbc should be 16 except for empty packet but it's still 8.

This commit adds a flag for this quirk and codes to refer to a fixed value.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c                      | 15 +++++++++++----
 sound/firewire/amdtp.h                      |  3 +++
 sound/firewire/fireworks/fireworks.c        |  1 +
 sound/firewire/fireworks/fireworks.h        |  1 +
 sound/firewire/fireworks/fireworks_stream.c |  3 +++
 5 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 3903387..4a7cc1f 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -618,7 +618,8 @@ static void handle_in_packet(struct amdtp_stream *s,
 			     __be32 *buffer)
 {
 	u32 cip_header[2];
-	unsigned int data_blocks, data_block_quadlets, data_block_counter;
+	unsigned int data_blocks, data_block_quadlets, data_block_counter,
+		     dbc_interval;
 	struct snd_pcm_substream *pcm = NULL;
 	bool lost;
 
@@ -661,11 +662,17 @@ static void handle_in_packet(struct amdtp_stream *s,
 
 	/* Check data block counter continuity */
 	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
-	if (!(s->flags & CIP_DBC_IS_END_EVENT))
+	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		lost = data_block_counter != s->data_block_counter;
-	else
+	} else {
+		if ((data_blocks > 0) && (s->tx_dbc_interval > 0))
+			dbc_interval = s->tx_dbc_interval;
+		else
+			dbc_interval = data_blocks;
+
 		lost = data_block_counter !=
-		       ((s->data_block_counter + data_blocks) & 0xff);
+		       ((s->data_block_counter + dbc_interval) & 0xff);
+	}
 
 	if (lost) {
 		dev_info(&s->unit->device,
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index f334ae5..05f1b8b 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -119,6 +119,9 @@ struct amdtp_stream {
 
 	struct snd_rawmidi_substream *midi[AMDTP_MAX_CHANNELS_FOR_MIDI * 8];
 
+	/* quirk: fixed interval of dbc between previos/current packets. */
+	unsigned int tx_dbc_interval;
+
 	bool callbacked;
 	wait_queue_head_t callback_wait;
 	struct amdtp_stream *sync_slave;
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 02b3259..25997f1 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -84,6 +84,7 @@ get_hardware_info(struct snd_efw *efw)
 		 (hwinfo->arm_version >> 16) & 0xff);
 	if (err < 0)
 		goto end;
+	efw->firmware_version = hwinfo->arm_version;
 
 	strcpy(efw->card->driver, "Fireworks");
 	strcpy(efw->card->shortname, hwinfo->model_name);
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 9534e93..3f99851 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -63,6 +63,7 @@ struct snd_efw {
 
 	/* for quirks */
 	bool is_af9;
+	u32 firmware_version;
 
 	unsigned int midi_in_ports;
 	unsigned int midi_out_ports;
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index 7447af7..c75c2ef 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -201,6 +201,9 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 	/* AudioFire9 always reports wrong dbs. */
 	if (efw->is_af9)
 		efw->tx_stream.flags |= CIP_WRONG_DBS;
+	/* Firmware version 5.5 reports fixed interval for dbc. */
+	if (efw->firmware_version == 0x5050000)
+		efw->tx_stream.tx_dbc_interval = 8;
 
 	err = init_stream(efw, &efw->rx_stream);
 	if (err < 0) {
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
