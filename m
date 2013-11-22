From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: firewire-lib: an issue to generate packet with 'no
 data' in blocking mode
Date: Fri, 22 Nov 2013 14:59:58 +0900
Message-ID: <528EF2DE.9060700@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090005030205020404040004"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F26B261622
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 07:00:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090005030205020404040004
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Clemens,

I have a question about generate packet with 'no data' in blocking mode.
I think there is out of specification in current firewire-lib.

If this is a qurk for some devices, I'll prepare patches to switch
generating mode because BeBoB cannot sound with current firewire-lib. If
this is a bug, then I want to discuss which is better for firewire-lib.


In my understanding of IEC 61883-6, there are two ways:

1. generate 'empty packet' defined in IEC 61883-1
   - size of packet is 2 quadlets
   - FDF = sfc
   - packet includes just CIP headers

2. generate 'special non-empty packet' defined in IEC 61883-6
   - size of packet is following to blocking mode
   - FDF = 0xff ('NO-DATA' code)
   - packet includes dummy data

But current implementation is a strange combination of them.
 - size of packet is 2 (way 1)
 - FDF = 0xff (way 2)

I attach two patches. 'empty.patch' is for 1 and 'special.patch' is for 2.


Regards

Takashi Sakamoto

--------------090005030205020404040004
Content-Type: text/x-patch;
 name="empty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="empty.patch"

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index d322689..a387fff 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -442,7 +442,7 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 			data_blocks = s->syt_interval;
 		} else {
 			data_blocks = 0;
-			syt = 0xffffff;
+			syt = 0xffff;
 		}
 	}
 

--------------090005030205020404040004
Content-Type: text/x-patch;
 name="special.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="special.patch"

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index d322689..92bb9bb 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -425,8 +425,8 @@ static void amdtp_fill_midi(struct amdtp_out_stream *s,
 static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 {
 	__be32 *buffer;
-	unsigned int index, data_blocks, syt, ptr;
-	struct snd_pcm_substream *pcm;
+	unsigned int index, data_blocks, fdf, syt, ptr;
+	struct snd_pcm_substream *pcm = NULL;
 	struct fw_iso_packet packet;
 	int err;
 
@@ -435,34 +435,37 @@ static void queue_out_packet(struct amdtp_out_stream *s, unsigned int cycle)
 	index = s->packet_index;
 
 	syt = calculate_syt(s, cycle);
-	if (!(s->flags & CIP_BLOCKING)) {
+
+	/* this module uses 'special non-empty packet' for 'no data' packet */
+	if (syt == 0xffff)
+		fdf = 0xff;	/* 'NO-DATA' FDF */
+	else
+		fdf = s->sfc;
+
+	if (!(s->flags & CIP_BLOCKING))
 		data_blocks = calculate_data_blocks(s);
-	} else {
-		if (syt != 0xffff) {
-			data_blocks = s->syt_interval;
-		} else {
-			data_blocks = 0;
-			syt = 0xffffff;
-		}
-	}
+	else
+		data_blocks = s->syt_interval;
 
 	buffer = s->buffer.packets[index].buffer;
 	buffer[0] = cpu_to_be32(ACCESS_ONCE(s->source_node_id_field) |
 				(s->data_block_quadlets << 16) |
 				s->data_block_counter);
 	buffer[1] = cpu_to_be32(CIP_EOH | CIP_FMT_AM | AMDTP_FDF_AM824 |
-				(s->sfc << AMDTP_FDF_SFC_SHIFT) | syt);
+				(fdf << AMDTP_FDF_SFC_SHIFT) | syt);
 	buffer += 2;
 
-	pcm = ACCESS_ONCE(s->pcm);
-	if (pcm)
-		s->transfer_samples(s, pcm, buffer, data_blocks);
-	else
-		amdtp_fill_pcm_silence(s, buffer, data_blocks);
-	if (s->midi_ports)
-		amdtp_fill_midi(s, buffer, data_blocks);
+	if (fdf == 0xff) {
+		pcm = ACCESS_ONCE(s->pcm);
+		if (pcm)
+			s->transfer_samples(s, pcm, buffer, data_blocks);
+		else
+			amdtp_fill_pcm_silence(s, buffer, data_blocks);
+		if (s->midi_ports)
+			amdtp_fill_midi(s, buffer, data_blocks);
 
-	s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+		s->data_block_counter = (s->data_block_counter + data_blocks) & 0xff;
+	}
 
 	packet.payload_length = 8 + data_blocks * 4 * s->data_block_quadlets;
 	packet.interrupt = IS_ALIGNED(index + 1, INTERRUPT_INTERVAL);

--------------090005030205020404040004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090005030205020404040004--
