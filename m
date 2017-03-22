From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 04/18] ALSA: firewire-motu: add an abstraction
	layer for three types of protocols
Date: Wed, 22 Mar 2017 21:30:14 +0900
Message-ID: <20170322123028.24148-5-o-takashi@sakamocchi.jp>
References: <20170322123028.24148-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 468EF2673BB
 for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2017 13:30:39 +0100 (CET)
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

In an aspect of used protocols to communicate, models of MOTU FireWire
units are categorized to three generations.

This commit adds an abstraction layer of the protocols for features
related to packet streaming functionality. This layer includes 5
operations.

When configuring packet streaming functionality with sampling rate and
sampling transmission frequency, .get_clock_rate and .set_clock_rate are
called with proper arguments. MOTU FireWire series supports up to 192.0kHz.

When checking current source of sampling clock (not clock for packetization
layer), .get_clock_source is used. Enumeration is added to represent the
sources supported by this series. This operation can be used to expose
available sampling rate to user space applications when the unit is
configured to use any input signal as source of clock instead of crystal
clock.

In the protocols, the path between packet processing layer and digital
signal processing layer can be controlled. This looks a functionality to
'mute' the unit. For this feature, .switch_fetching_mode is added. This
can be used to suppress noises every time packet streaming starts/stops.

In a point of the size of data blocks at a certain sampling transmission
frequency, the most units accept several modes. This is due to usage of
optical interfaces. The size differs depending on which modes are
configured to the interfaces; None, S/PDIF and ADAT. Additionally, format
of packet is different depending on protocols. To cache current size of
data blocks and its format, .cache_packet_formats is added. This is used
by PCM functionality, packet streaming functionality and data block
processing layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/motu/motu.c | 12 ++++++++++++
 sound/firewire/motu/motu.h | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
index e69aa7b..1e6fc74 100644
--- a/sound/firewire/motu/motu.c
+++ b/sound/firewire/motu/motu.c
@@ -14,6 +14,18 @@ MODULE_DESCRIPTION("MOTU FireWire driver");
 MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
 MODULE_LICENSE("GPL v2");
 
+const unsigned int snd_motu_clock_rates[SND_MOTU_CLOCK_RATE_COUNT] = {
+	/* mode 0 */
+	[0] =  44100,
+	[1] =  48000,
+	/* mode 1 */
+	[2] =  88200,
+	[3] =  96000,
+	/* mode 2 */
+	[4] = 176400,
+	[5] = 192000,
+};
+
 static void name_card(struct snd_motu *motu)
 {
 	struct fw_device *fw_dev = fw_parent_device(motu->unit);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
index cb7324d..cb6b573 100644
--- a/sound/firewire/motu/motu.h
+++ b/sound/firewire/motu/motu.h
@@ -22,6 +22,16 @@
 
 #include "../lib.h"
 
+struct snd_motu_packet_format {
+	unsigned char midi_flag_offset;
+	unsigned char midi_byte_offset;
+	unsigned char pcm_byte_offset;
+
+	unsigned char msg_chunks;
+	unsigned char fixed_part_pcm_chunks[3];
+	unsigned char differed_part_pcm_chunks[3];
+};
+
 struct snd_motu {
 	struct snd_card *card;
 	struct fw_unit *unit;
@@ -32,6 +42,10 @@ struct snd_motu {
 
 	/* Model dependent information. */
 	const struct snd_motu_spec *spec;
+
+	/* For packet streaming */
+	struct snd_motu_packet_format tx_packet_formats;
+	struct snd_motu_packet_format rx_packet_formats;
 };
 
 enum snd_motu_spec_flags {
@@ -46,12 +60,41 @@ enum snd_motu_spec_flags {
 	SND_MOTU_SPEC_HAS_MIDI		= 0x0100,
 };
 
+#define SND_MOTU_CLOCK_RATE_COUNT	6
+extern const unsigned int snd_motu_clock_rates[SND_MOTU_CLOCK_RATE_COUNT];
+
+enum snd_motu_clock_source {
+	SND_MOTU_CLOCK_SOURCE_INTERNAL,
+	SND_MOTU_CLOCK_SOURCE_ADAT_ON_DSUB,
+	SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT,
+	SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT_A,
+	SND_MOTU_CLOCK_SOURCE_ADAT_ON_OPT_B,
+	SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT,
+	SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT_A,
+	SND_MOTU_CLOCK_SOURCE_SPDIF_ON_OPT_B,
+	SND_MOTU_CLOCK_SOURCE_SPDIF_ON_COAX,
+	SND_MOTU_CLOCK_SOURCE_AESEBU_ON_XLR,
+	SND_MOTU_CLOCK_SOURCE_WORD_ON_BNC,
+	SND_MOTU_CLOCK_SOURCE_UNKNOWN,
+};
+
+struct snd_motu_protocol {
+	int (*get_clock_rate)(struct snd_motu *motu, unsigned int *rate);
+	int (*set_clock_rate)(struct snd_motu *motu, unsigned int rate);
+	int (*get_clock_source)(struct snd_motu *motu,
+				enum snd_motu_clock_source *source);
+	int (*switch_fetching_mode)(struct snd_motu *motu, bool enable);
+	int (*cache_packet_formats)(struct snd_motu *motu);
+};
+
 struct snd_motu_spec {
 	const char *const name;
 	enum snd_motu_spec_flags flags;
 
 	unsigned char analog_in_ports;
 	unsigned char analog_out_ports;
+
+	const struct snd_motu_protocol *const protocol;
 };
 
 #endif
-- 
2.9.3
