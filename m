From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] [25/29] ALSA: dice: add a proc file to show device information
Date: Mon, 21 Oct 2013 21:34:54 +0200
Message-ID: <526581DE.4090208@ladisch.de>
References: <52657E3B.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <52657E3B.7040205@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For easier debugging, add a proc file to show the device's capabilities
and current status.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 sound/firewire/dice.c |  246 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 246 insertions(+)

diff --git a/sound/firewire/dice.c b/sound/firewire/dice.c
index 3395c8b..25a9636 100644
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -22,6 +22,7 @@
 #include <sound/core.h>
 #include <sound/firewire.h>
 #include <sound/hwdep.h>
+#include <sound/info.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -857,6 +858,249 @@ static int dice_create_hwdep(struct dice *dice)
 	return 0;
 }

+static int dice_proc_read_mem(struct dice *dice, void *buffer,
+			      unsigned int offset_q, unsigned int quadlets)
+{
+	unsigned int i;
+	int err;
+
+	err = snd_fw_transaction(dice->unit, TCODE_READ_BLOCK_REQUEST,
+				 DICE_PRIVATE_SPACE + 4 * offset_q,
+				 buffer, 4 * quadlets, 0);
+	if (err < 0)
+		return err;
+
+	for (i = 0; i < quadlets; ++i)
+		be32_to_cpus(&((u32 *)buffer)[i]);
+
+	return 0;
+}
+
+static const char *str_from_array(const char *const strs[], unsigned int count,
+				  unsigned int i)
+{
+	if (i < count)
+		return strs[i];
+	else
+		return "(unknown)";
+}
+
+static void dice_proc_fixup_string(char *s, unsigned int size)
+{
+	unsigned int i;
+
+	for (i = 0; i < size; i += 4)
+		cpu_to_le32s((u32 *)(s + i));
+
+	for (i = 0; i < size - 2; ++i) {
+		if (s[i] == '\0')
+			return;
+		if (s[i] == '\\' && s[i + 1] == '\\') {
+			s[i + 2] = '\0';
+			return;
+		}
+	}
+	s[size - 1] = '\0';
+}
+
+static void dice_proc_read(struct snd_info_entry *entry,
+			   struct snd_info_buffer *buffer)
+{
+	static const char *const section_names[5] = {
+		"global", "tx", "rx", "ext_sync", "unused2"
+	};
+	static const char *const clock_sources[] = {
+		"aes1", "aes2", "aes3", "aes4", "aes", "adat", "tdif",
+		"wc", "arx1", "arx2", "arx3", "arx4", "internal"
+	};
+	static const char *const rates[] = {
+		"32000", "44100", "48000", "88200", "96000", "176400", "192000",
+		"any low", "any mid", "any high", "none"
+	};
+	struct dice *dice = entry->private_data;
+	u32 sections[ARRAY_SIZE(section_names) * 2];
+	struct {
+		u32 number;
+		u32 size;
+	} tx_rx_header;
+	union {
+		struct {
+			u32 owner_hi, owner_lo;
+			u32 notification;
+			char nick_name[NICK_NAME_SIZE];
+			u32 clock_select;
+			u32 enable;
+			u32 status;
+			u32 extended_status;
+			u32 sample_rate;
+			u32 version;
+			u32 clock_caps;
+			char clock_source_names[CLOCK_SOURCE_NAMES_SIZE];
+		} global;
+		struct {
+			u32 iso;
+			u32 number_audio;
+			u32 number_midi;
+			u32 speed;
+			char names[TX_NAMES_SIZE];
+			u32 ac3_caps;
+			u32 ac3_enable;
+		} tx;
+		struct {
+			u32 iso;
+			u32 seq_start;
+			u32 number_audio;
+			u32 number_midi;
+			char names[RX_NAMES_SIZE];
+			u32 ac3_caps;
+			u32 ac3_enable;
+		} rx;
+		struct {
+			u32 clock_source;
+			u32 locked;
+			u32 rate;
+			u32 adat_user_data;
+		} ext_sync;
+	} buf;
+	unsigned int quadlets, stream, i;
+
+	if (dice_proc_read_mem(dice, sections, 0, ARRAY_SIZE(sections)) < 0)
+		return;
+	snd_iprintf(buffer, "sections:\n");
+	for (i = 0; i < ARRAY_SIZE(section_names); ++i)
+		snd_iprintf(buffer, "  %s: offset %u, size %u\n",
+			    section_names[i],
+			    sections[i * 2], sections[i * 2 + 1]);
+
+	quadlets = min_t(u32, sections[1], sizeof(buf.global) / 4);
+	if (dice_proc_read_mem(dice, &buf.global, sections[0], quadlets) < 0)
+		return;
+	snd_iprintf(buffer, "global:\n");
+	snd_iprintf(buffer, "  owner: %04x:%04x%08x\n",
+		    buf.global.owner_hi >> 16,
+		    buf.global.owner_hi & 0xffff, buf.global.owner_lo);
+	snd_iprintf(buffer, "  notification: %08x\n", buf.global.notification);
+	dice_proc_fixup_string(buf.global.nick_name, NICK_NAME_SIZE);
+	snd_iprintf(buffer, "  nick name: %s\n", buf.global.nick_name);
+	snd_iprintf(buffer, "  clock select: %s %s\n",
+		    str_from_array(clock_sources, ARRAY_SIZE(clock_sources),
+				   buf.global.clock_select & CLOCK_SOURCE_MASK),
+		    str_from_array(rates, ARRAY_SIZE(rates),
+				   (buf.global.clock_select & CLOCK_RATE_MASK)
+				   >> CLOCK_RATE_SHIFT));
+	snd_iprintf(buffer, "  enable: %u\n", buf.global.enable);
+	snd_iprintf(buffer, "  status: %slocked %s\n",
+		    buf.global.status & STATUS_SOURCE_LOCKED ? "" : "un",
+		    str_from_array(rates, ARRAY_SIZE(rates),
+				   (buf.global.status &
+				    STATUS_NOMINAL_RATE_MASK)
+				   >> CLOCK_RATE_SHIFT));
+	snd_iprintf(buffer, "  ext status: %08x\n", buf.global.extended_status);
+	snd_iprintf(buffer, "  sample rate: %u\n", buf.global.sample_rate);
+	snd_iprintf(buffer, "  version: %u.%u.%u.%u\n",
+		    (buf.global.version >> 24) & 0xff,
+		    (buf.global.version >> 16) & 0xff,
+		    (buf.global.version >>  8) & 0xff,
+		    (buf.global.version >>  0) & 0xff);
+	if (quadlets >= 90) {
+		snd_iprintf(buffer, "  clock caps:");
+		for (i = 0; i <= 6; ++i)
+			if (buf.global.clock_caps & (1 << i))
+				snd_iprintf(buffer, " %s", rates[i]);
+		for (i = 0; i <= 12; ++i)
+			if (buf.global.clock_caps & (1 << (16 + i)))
+				snd_iprintf(buffer, " %s", clock_sources[i]);
+		snd_iprintf(buffer, "\n");
+		dice_proc_fixup_string(buf.global.clock_source_names,
+				       CLOCK_SOURCE_NAMES_SIZE);
+		snd_iprintf(buffer, "  clock source names: %s\n",
+			    buf.global.clock_source_names);
+	}
+
+	if (dice_proc_read_mem(dice, &tx_rx_header, sections[2], 2) < 0)
+		return;
+	quadlets = min_t(u32, tx_rx_header.size, sizeof(buf.tx));
+	for (stream = 0; stream < tx_rx_header.number; ++stream) {
+		if (dice_proc_read_mem(dice, &buf.tx, sections[2] + 2 +
+				       stream * tx_rx_header.size,
+				       quadlets) < 0)
+			break;
+		snd_iprintf(buffer, "tx %u:\n", stream);
+		snd_iprintf(buffer, "  iso channel: %d\n", (int)buf.tx.iso);
+		snd_iprintf(buffer, "  audio channels: %u\n",
+			    buf.tx.number_audio);
+		snd_iprintf(buffer, "  midi ports: %u\n", buf.tx.number_midi);
+		snd_iprintf(buffer, "  speed: S%u\n", 100u << buf.tx.speed);
+		if (quadlets >= 68) {
+			dice_proc_fixup_string(buf.tx.names, TX_NAMES_SIZE);
+			snd_iprintf(buffer, "  names: %s\n", buf.tx.names);
+		}
+		if (quadlets >= 70) {
+			snd_iprintf(buffer, "  ac3 caps: %08x\n",
+				    buf.tx.ac3_caps);
+			snd_iprintf(buffer, "  ac3 enable: %08x\n",
+				    buf.tx.ac3_enable);
+		}
+	}
+
+	if (dice_proc_read_mem(dice, &tx_rx_header, sections[4], 2) < 0)
+		return;
+	quadlets = min_t(u32, tx_rx_header.size, sizeof(buf.rx));
+	for (stream = 0; stream < tx_rx_header.number; ++stream) {
+		if (dice_proc_read_mem(dice, &buf.rx, sections[4] + 2 +
+				       stream * tx_rx_header.size,
+				       quadlets) < 0)
+			break;
+		snd_iprintf(buffer, "rx %u:\n", stream);
+		snd_iprintf(buffer, "  iso channel: %d\n", (int)buf.rx.iso);
+		snd_iprintf(buffer, "  sequence start: %u\n",
+			    (int)buf.rx.seq_start);
+		snd_iprintf(buffer, "  audio channels: %u\n",
+			    buf.rx.number_audio);
+		snd_iprintf(buffer, "  midi ports: %u\n", buf.rx.number_midi);
+		if (quadlets >= 68) {
+			dice_proc_fixup_string(buf.rx.names, RX_NAMES_SIZE);
+			snd_iprintf(buffer, "  names: %s\n", buf.rx.names);
+		}
+		if (quadlets >= 70) {
+			snd_iprintf(buffer, "  ac3 caps: %08x\n",
+				    buf.rx.ac3_caps);
+			snd_iprintf(buffer, "  ac3 enable: %08x\n",
+				    buf.rx.ac3_enable);
+		}
+	}
+
+	quadlets = min_t(u32, sections[7], sizeof(buf.ext_sync) / 4);
+	if (quadlets >= 4) {
+		if (dice_proc_read_mem(dice, &buf.ext_sync,
+				       sections[6], 4) < 0)
+			return;
+		snd_iprintf(buffer, "ext status:\n");
+		snd_iprintf(buffer, "  clock source: %s\n",
+			    str_from_array(clock_sources,
+					   ARRAY_SIZE(clock_sources),
+					   buf.ext_sync.clock_source));
+		snd_iprintf(buffer, "  locked: %u\n", buf.ext_sync.locked);
+		snd_iprintf(buffer, "  rate: %s\n",
+			    str_from_array(rates, ARRAY_SIZE(rates),
+					   buf.ext_sync.rate));
+		snd_iprintf(buffer, "  adat user data: ");
+		if (buf.ext_sync.adat_user_data & ADAT_USER_DATA_NO_DATA)
+			snd_iprintf(buffer, "-\n");
+		else
+			snd_iprintf(buffer, "%x\n",
+				    buf.ext_sync.adat_user_data);
+	}
+}
+
+static void dice_create_proc(struct dice *dice)
+{
+	struct snd_info_entry *entry;
+
+	if (!snd_card_proc_new(dice->card, "dice", &entry))
+		snd_info_set_text_ops(entry, dice, dice_proc_read);
+}
+
 static void dice_card_free(struct snd_card *card)
 {
 	struct dice *dice = card->private_data;
@@ -1131,6 +1375,8 @@ static int dice_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
 	if (err < 0)
 		goto error;

+	dice_create_proc(dice);
+
 	err = snd_card_register(card);
 	if (err < 0)
 		goto error;

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
