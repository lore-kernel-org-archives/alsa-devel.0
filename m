From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: firewire-motu: add support MOTU 8pre
	FireWire
Date: Sun, 17 Mar 2019 16:50:24 +0900
Message-ID: <20190317075024.6882-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com
 [66.111.4.230])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 775CBF8968A
 for <alsa-devel@alsa-project.org>; Sun, 17 Mar 2019 08:50:32 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit adds support for MOTU 8pre FireWire, which was shipped 2007
and nowadays already discontinued. Userspace applications can transmit
and receive PCM frames and MIDI messages for this model via ALSA PCM
interface and RawMidi/Sequencer interfaces.

Like the other models of MOTU FireWire series, this model has many
quirks in its CIP.

At first, data channels for two pairs of optical interfaces. At lower
sampling transmission frequency, i.e. 44.1 and 48.0 kHz, one pair is
available for ADAT data, thus 8 data chunks are transferred by CIP.
At middle sampling transmission frequency, i.e.  88.2 and 96.0 kHz,
two pairs are available to keep 8 chunks for ADAT data, thus CIP
still includes 8 data chunks.

Apart from data chunks for optical interface, CIP includes fixed number
of data chunks. In tx stream, two chunks for status message, eight
chunks for samples from analog 1-8 input, two chunks for mix-return.
In rx stream, two chunks for control message, two chunks for main 1-2
output, two chunks for phone 1-2 output, two chunks for dummy 1-2.

CIP header in tx stream includes quirks for its dbs and dbc fields.
The value of dbs field is fixed to 0x13, against its actual size.
The value of dbc field is firstly updated to 0x07 from zero, then
it's incremented continuously according to actual number of data h
blocks.

Finally, the model has own bits to disable frame fetch.

This commit uses several options to absorb the above quirks.

$ python2 crpp < /sys/bus/firewire/devices/fw1/config_rom
               ROM header and bus information block
               -----------------------------------------------------------------
400  0410b57d  bus_info_length 4, crc_length 16, crc 46461
404  31333934  bus_name "1394"
408  20001000  irmc 0, cmc 0, isc 1, bmc 0, cyc_clk_acc 0, max_rec 1 (4)
40c  0001f200  company_id 0001f2     |
410  00083dfb  device_id 0000083dfb  | EUI-64 0001f20000083dfb

               root directory
               -----------------------------------------------------------------
414  0004c65c  directory_length 4, crc 50780
418  030001f2  vendor
41c  0c0083c0  node capabilities per IEEE 1394
420  8d000006  --> eui-64 leaf at 438
424  d1000001  --> unit directory at 428

               unit directory at 428
               -----------------------------------------------------------------
428  0003991c  directory_length 3, crc 39196
42c  120001f2  specifier id
430  1300000f  version
434  17103800  model

               eui-64 leaf at 438
               -----------------------------------------------------------------
438  00022681  leaf_length 2, crc 9857
43c  0001f200  company_id 0001f2     |
440  00083dfb  device_id 0000083dfb  | EUI-64 0001f20000083dfb

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/amdtp-motu.c       |  6 ++++
 sound/firewire/motu/motu-protocol-v2.c | 43 +++++++++++++++++++-------
 sound/firewire/motu/motu.c             | 15 +++++++++
 sound/firewire/motu/motu.h             |  1 +
 4 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/sound/firewire/motu/amdtp-motu.c b/sound/firewire/motu/amdtp-motu.c
index 6c9b743ea74b..cb0c967dea63 100644
--- a/sound/firewire/motu/amdtp-motu.c
+++ b/sound/firewire/motu/amdtp-motu.c
@@ -412,6 +412,12 @@ int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 				 CIP_HEADER_WITHOUT_EOH;
 			fmt = CIP_FMT_MOTU_TX_V3;
 		}
+
+		if (protocol == &snd_motu_protocol_v2) {
+			// 8pre has some quirks.
+			flags |= CIP_WRONG_DBS |
+				 CIP_SKIP_DBC_ZERO_CHECK;
+		}
 	} else {
 		process_data_blocks = process_rx_data_blocks;
 		flags |= CIP_DBC_IS_END_EVENT;
diff --git a/sound/firewire/motu/motu-protocol-v2.c b/sound/firewire/motu/motu-protocol-v2.c
index 453fc29fade7..848fffe7387e 100644
--- a/sound/firewire/motu/motu-protocol-v2.c
+++ b/sound/firewire/motu/motu-protocol-v2.c
@@ -15,6 +15,8 @@
 #define  V2_CLOCK_SRC_SHIFT			0
 #define  V2_CLOCK_TRAVELER_FETCH_DISABLE	0x04000000
 #define  V2_CLOCK_TRAVELER_FETCH_ENABLE		0x03000000
+#define  V2_CLOCK_8PRE_FETCH_DISABLE		0x02000000
+#define  V2_CLOCK_8PRE_FETCH_ENABLE		0x00000000
 
 #define V2_IN_OUT_CONF_OFFSET			0x0c04
 #define  V2_OPT_OUT_IFACE_MASK			0x00000c00
@@ -132,20 +134,31 @@ static int v2_switch_fetching_mode(struct snd_motu *motu, bool enable)
 	u32 data;
 	int err = 0;
 
-	if (motu->spec == &snd_motu_spec_traveler) {
+	if (motu->spec == &snd_motu_spec_traveler ||
+	    motu->spec == &snd_motu_spec_8pre) {
 		err = snd_motu_transaction_read(motu, V2_CLOCK_STATUS_OFFSET,
 						&reg, sizeof(reg));
 		if (err < 0)
 			return err;
 		data = be32_to_cpu(reg);
 
-		data &= ~(V2_CLOCK_TRAVELER_FETCH_DISABLE |
-			  V2_CLOCK_TRAVELER_FETCH_ENABLE);
-
-		if (enable)
-			data |= V2_CLOCK_TRAVELER_FETCH_ENABLE;
-		else
-			data |= V2_CLOCK_TRAVELER_FETCH_DISABLE;
+		if (motu->spec == &snd_motu_spec_traveler) {
+			data &= ~(V2_CLOCK_TRAVELER_FETCH_DISABLE |
+				  V2_CLOCK_TRAVELER_FETCH_ENABLE);
+
+			if (enable)
+				data |= V2_CLOCK_TRAVELER_FETCH_ENABLE;
+			else
+				data |= V2_CLOCK_TRAVELER_FETCH_DISABLE;
+		} else if (motu->spec == &snd_motu_spec_8pre) {
+			data &= ~(V2_CLOCK_8PRE_FETCH_DISABLE |
+				  V2_CLOCK_8PRE_FETCH_ENABLE);
+
+			if (enable)
+				data |= V2_CLOCK_8PRE_FETCH_DISABLE;
+			else
+				data |= V2_CLOCK_8PRE_FETCH_ENABLE;
+		}
 
 		reg = cpu_to_be32(data);
 		err = snd_motu_transaction_write(motu, V2_CLOCK_STATUS_OFFSET,
@@ -220,10 +233,16 @@ static void calculate_differed_part(struct snd_motu_packet_format *formats,
 	 * interfaces.
 	 */
 	data = (data & mask) >> shift;
-	if ((flags & SND_MOTU_SPEC_HAS_OPT_IFACE_A) &&
-	    data == V2_OPT_IFACE_MODE_ADAT) {
-		pcm_chunks[0] += 8;
-		pcm_chunks[1] += 4;
+	if (data == V2_OPT_IFACE_MODE_ADAT) {
+		if (flags & SND_MOTU_SPEC_HAS_OPT_IFACE_A) {
+			pcm_chunks[0] += 8;
+			pcm_chunks[1] += 4;
+		}
+		// 8pre has two sets of optical interface and doesn't reduce
+		// chunks for ADAT signals.
+		if (flags & SND_MOTU_SPEC_HAS_OPT_IFACE_B) {
+			pcm_chunks[1] += 4;
+		}
 	}
 
 	/* At mode x4, no data chunks are supported in this part. */
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index 513291ba0ab0..201539d4488c 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -203,6 +203,20 @@ const struct snd_motu_spec snd_motu_spec_traveler = {
 	.analog_out_ports = 8,
 };
 
+const struct snd_motu_spec snd_motu_spec_8pre = {
+	.name = "8pre",
+	.protocol = &snd_motu_protocol_v2,
+	// In tx, use coax chunks for mix-return 1/2. In rx, use coax chunks for
+	// dummy 1/2.
+	.flags = SND_MOTU_SPEC_SUPPORT_CLOCK_X2 |
+		 SND_MOTU_SPEC_HAS_OPT_IFACE_A |
+		 SND_MOTU_SPEC_HAS_OPT_IFACE_B |
+		 SND_MOTU_SPEC_RX_MIDI_2ND_Q |
+		 SND_MOTU_SPEC_TX_MIDI_2ND_Q,
+	.analog_in_ports = 8,
+	.analog_out_ports = 2,
+};
+
 static const struct snd_motu_spec motu_828mk3 = {
 	.name = "828mk3",
 	.protocol = &snd_motu_protocol_v3,
@@ -248,6 +262,7 @@ static const struct snd_motu_spec motu_audio_express = {
 static const struct ieee1394_device_id motu_id_table[] = {
 	SND_MOTU_DEV_ENTRY(0x000003, &motu_828mk2),
 	SND_MOTU_DEV_ENTRY(0x000009, &snd_motu_spec_traveler),
+	SND_MOTU_DEV_ENTRY(0x00000f, &snd_motu_spec_8pre),
 	SND_MOTU_DEV_ENTRY(0x000015, &motu_828mk3),	/* FireWire only. */
 	SND_MOTU_DEV_ENTRY(0x000035, &motu_828mk3),	/* Hybrid. */
 	SND_MOTU_DEV_ENTRY(0x000033, &motu_audio_express),
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index fd5327d30ab1..1cd112be7dad 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -130,6 +130,7 @@ extern const struct snd_motu_protocol snd_motu_protocol_v2;
 extern const struct snd_motu_protocol snd_motu_protocol_v3;
 
 extern const struct snd_motu_spec snd_motu_spec_traveler;
+extern const struct snd_motu_spec snd_motu_spec_8pre;
 
 int amdtp_motu_init(struct amdtp_stream *s, struct fw_unit *unit,
 		    enum amdtp_stream_direction dir,
-- 
2.19.1
