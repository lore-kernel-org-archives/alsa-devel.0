From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 42/44] bebob/firewire-lib: Add a quirk of wrong dbc in empty
	packet for M-Audio special Firewire series
Date: Fri, 21 Mar 2014 20:10:27 +0900
Message-ID: <1395400229-22957-43-git-send-email-o-takashi@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
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

M-Audio Firewire 1814 has a quirk, ProjectMix I/O also has. They transmit
empty packet with wrong value of dbc incremented by 8 at high sampling rate.
According to IEC 61883-1, this value should be the same as the one in
previous packet.

This commit adds a flag named as CIP_EMPTY_HAS_WRONG_DBC. With flag, the value
of dbc in empty packet is overwittern by the one in expected value.

This is an example of this quirk:
CIP Header 0	CIP Header 1	Payload size
010D0000	9004F759	210
010D0010	90040B59	210
010D0020	90042359	210
01020028	9004FFFF	2  <-
010D0030	90043759	210
010D0040	90044B59	210
010D0050	90046359	210
01020058	9004FFFF	2  <-
010D0060	90047759	210
010D0070	90048B59	210
010D0080	9004A359	210
01020088	9004FFFF	2  <-
010D0090	9004B759	210
010D00A0	9004CB59	210
010D00B0	9004E359	210
010200B8	9004FFFF	2  <-
010D00C0	9004F759	210
010D00D0	90040B59	210
010D00E0	90042359	210

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c              | 2 ++
 sound/firewire/amdtp.h              | 3 +++
 sound/firewire/bebob/bebob_stream.c | 7 +++++++
 3 files changed, 12 insertions(+)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 820d790..c443a3a 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -745,6 +745,8 @@ static void handle_in_packet(struct amdtp_stream *s,
 
 	/* Check data block counter continuity */
 	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
+	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC))
+		data_block_counter = s->data_block_counter;
 	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		lost = data_block_counter != s->data_block_counter;
 	} else {
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index e3ee739..7981f4d 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -29,6 +29,8 @@
  *	The value of data_block_quadlets is used instead of reported value.
  * @CIP_SKIP_INIT_DBC_CHECK: Only for in-stream. The value of dbc in first
  *	packet is not continuous from an initial value.
+ * @CIP_EMPTY_HAS_WRONG_DBC: Only for in-stream. The value of dbc in empty
+ *	packet is wrong but the others are correct.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -39,6 +41,7 @@ enum cip_flags {
 	CIP_DBC_IS_END_EVENT	= 0x10,
 	CIP_WRONG_DBS		= 0x20,
 	CIP_SKIP_INIT_DBC_CHECK	= 0x40,
+	CIP_EMPTY_HAS_WRONG_DBC	= 0x80,
 };
 
 /**
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 95d82f4..5be82f1 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -436,6 +436,13 @@ int snd_bebob_stream_init_duplex(struct snd_bebob *bebob)
 	}
 	/* See comments in next function */
 	bebob->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
+	/*
+	 * At high sampling rate, M-Audio special firmware transmits empty
+	 * packet with the value of dbc incremented by 8 but the others are
+	 * valid to IEC 61883-1.
+	 */
+	if (bebob->maudio_special_quirk)
+		bebob->tx_stream.flags |= CIP_EMPTY_HAS_WRONG_DBC;
 
 	err = amdtp_stream_init(&bebob->rx_stream, bebob->unit,
 				AMDTP_OUT_STREAM, CIP_BLOCKING);
-- 
1.8.3.2


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
