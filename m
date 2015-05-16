From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/4] ALSA: firewire-lib: add buffer-over-run protection at
	receiving more data blocks than expected
Date: Sat, 16 May 2015 20:22:42 +0900
Message-ID: <1431775365-25211-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

In IEC 61883-6, the number of data blocks in a packet is limited up to
the value of SYT_INTERVAL. Current implementation is compliant to the
limitation, while it can cause buffer-over-run when the value of dbs
field in received packet is illegally large.

This commit adds a validator to detect such illegal packets to prevent
the buffer-over-run. Actually, the buffer is aligned to the size of memory
 page, thus this issue hardly causes system errors due to the room to page
alignment.

But, Behringer F-Control Audio 202 (based on OXFW 970) has a quirk to
postpone transferring isochronous packet till finish handling any
asynchronous packets. In this case, this model is lazy, transfers no
packets during several cycle-start packets. After finishing, this model
pushes required data in next isochronous packet. As a result, the
packet include more data blocks than IEC 61883-6 defines.

To continue to support this model, this commit adds a new flag to extend
the length of calculated payload. This flag allows the size of payload
5 times as large as IEC 61883-6 defines. As a result, packets from this
model passed the validator successfully.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c            | 15 ++++++++++++++-
 sound/firewire/amdtp.h            |  4 ++++
 sound/firewire/oxfw/oxfw-stream.c | 10 ++++++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index e061355..6424382 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -251,7 +251,12 @@ EXPORT_SYMBOL(amdtp_stream_set_parameters);
  */
 unsigned int amdtp_stream_get_max_payload(struct amdtp_stream *s)
 {
-	return 8 + s->syt_interval * s->data_block_quadlets * 4;
+	unsigned int multiplier = 1;
+
+	if (s->flags & CIP_JUMBO_DATA_BLOCKS)
+		multiplier = 5;
+
+	return 8 + s->syt_interval * s->data_block_quadlets * 4 * multiplier;
 }
 EXPORT_SYMBOL(amdtp_stream_get_max_payload);
 
@@ -687,6 +692,14 @@ static void handle_in_packet(struct amdtp_stream *s,
 	struct snd_pcm_substream *pcm = NULL;
 	bool lost;
 
+	/* Protect from buffer-over-run. */
+	if (payload_quadlets > amdtp_stream_get_max_payload(s)) {
+		dev_info(&s->unit->device,
+			 "Too many data blocks in a packet: %02X %02X\n",
+			 amdtp_stream_get_max_payload(s), payload_quadlets);
+		goto err;
+	}
+
 	cip_header[0] = be32_to_cpu(buffer[0]);
 	cip_header[1] = be32_to_cpu(buffer[1]);
 
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 8a03a91..6e06203 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -29,6 +29,9 @@
  *	packet is not continuous from an initial value.
  * @CIP_EMPTY_HAS_WRONG_DBC: Only for in-stream. The value of dbc in empty
  *	packet is wrong but the others are correct.
+ * @CIP_JUMBO_DATA_BLOCKS: Only for in-stream. The number of data blocks in an
+ *	packet is sometimes larger than IEC 61883-6 defines. Current
+ *	implementation allows 5 times as large as IEC 61883-6 defines.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -40,6 +43,7 @@ enum cip_flags {
 	CIP_SKIP_DBC_ZERO_CHECK	= 0x20,
 	CIP_SKIP_INIT_DBC_CHECK	= 0x40,
 	CIP_EMPTY_HAS_WRONG_DBC	= 0x80,
+	CIP_JUMBO_DATA_BLOCKS	= 0x100,
 };
 
 /**
diff --git a/sound/firewire/oxfw/oxfw-stream.c b/sound/firewire/oxfw/oxfw-stream.c
index e6757cd..74ec2dc 100644
--- a/sound/firewire/oxfw/oxfw-stream.c
+++ b/sound/firewire/oxfw/oxfw-stream.c
@@ -232,9 +232,15 @@ int snd_oxfw_stream_init_simplex(struct snd_oxfw *oxfw,
 		goto end;
 	}
 
-	/* OXFW starts to transmit packets with non-zero dbc. */
+	/*
+	 * OXFW starts to transmit packets with non-zero dbc.
+	 * OXFW postpone transferring packets till handling any asynchronous
+	 * packets. As a result, next isochronous packet includes more data
+	 * blocks than IEC 61883-6 defines.
+	 */
 	if (stream == &oxfw->tx_stream)
-		oxfw->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK;
+		oxfw->tx_stream.flags |= CIP_SKIP_INIT_DBC_CHECK |
+					 CIP_JUMBO_DATA_BLOCKS;
 end:
 	return err;
 }
-- 
2.1.4


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
