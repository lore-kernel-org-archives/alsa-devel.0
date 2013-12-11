From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/8] fireworks: Add proc interface for
	debugging purpose
Date: Wed, 11 Dec 2013 18:15:55 +0900
Message-ID: <1386753359-12458-5-git-send-email-o-takashi@sakamocchi.jp>
References: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EFA12615F3
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 10:16:37 +0100 (CET)
In-Reply-To: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit adds proc interface to output infomation for debugging.
 - hardware capabilities
 - sampling rate and clock source
 - physical metering (linear value)

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/fireworks/Makefile         |   2 +-
 sound/firewire/fireworks/fireworks.c      |  12 ++
 sound/firewire/fireworks/fireworks.h      |  11 ++
 sound/firewire/fireworks/fireworks_proc.c | 198 ++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+), 1 deletion(-)
 create mode 100644 sound/firewire/fireworks/fireworks_proc.c

diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index 1bccb65..52bd15e 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,3 +1,3 @@
 snd-fireworks-objs := fireworks_transaction.o fireworks_command.o \
-		      fireworks_stream.o fireworks.o
+		      fireworks_stream.o fireworks_proc.o fireworks.o
 obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 0c3fb34..adc4a91 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -143,6 +143,16 @@ get_hardware_info(struct snd_efw *efw)
 	efw->pcm_playback_channels[0] = hwinfo->amdtp_rx_pcm_channels;
 	efw->pcm_playback_channels[1] = hwinfo->amdtp_rx_pcm_channels_2x;
 	efw->pcm_playback_channels[2] = hwinfo->amdtp_rx_pcm_channels_4x;
+
+	/* hardware metering */
+	efw->phys_out = hwinfo->phys_out;
+	efw->phys_in = hwinfo->phys_in;
+	efw->phys_out_grp_count = hwinfo->phys_out_grp_count;
+	efw->phys_in_grp_count = hwinfo->phys_in_grp_count;
+	memcpy(&efw->phys_out_grps, hwinfo->phys_out_grps,
+	       sizeof(struct snd_efw_phys_grp) * HWINFO_MAX_CAPS_GROUPS);
+	memcpy(&efw->phys_in_grps, hwinfo->phys_in_grps,
+	       sizeof(struct snd_efw_phys_grp) * HWINFO_MAX_CAPS_GROUPS);
 end:
 	kfree(hwinfo);
 	return err;
@@ -205,6 +215,8 @@ efw_probe(struct fw_unit *unit,
 	if (err < 0)
 		goto error;
 
+	snd_efw_proc_init(efw);
+
 	snd_card_set_dev(card, &unit->device);
 	err = snd_card_register(card);
 	if (err < 0)
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 4867264..2b0d85c 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -31,6 +31,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/info.h>
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
@@ -74,6 +75,14 @@ struct snd_efw {
 	struct amdtp_stream rx_stream;
 	struct cmp_connection out_conn;
 	struct cmp_connection in_conn;
+
+	/* hardware metering parameters */
+	unsigned int phys_out;
+	unsigned int phys_in;
+	unsigned int phys_out_grp_count;
+	unsigned int phys_in_grp_count;
+	struct snd_efw_phys_grp phys_out_grps[HWINFO_MAX_CAPS_GROUPS];
+	struct snd_efw_phys_grp phys_in_grps[HWINFO_MAX_CAPS_GROUPS];
 };
 
 /* for transaction */
@@ -195,6 +204,8 @@ int snd_efw_stream_stop_duplex(struct snd_efw *efw);
 void snd_efw_stream_update_duplex(struct snd_efw *efw);
 void snd_efw_stream_destroy_duplex(struct snd_efw *efw);
 
+void snd_efw_proc_init(struct snd_efw *efw);
+
 #define SND_EFW_DEV_ENTRY(vendor, model) \
 { \
 	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
diff --git a/sound/firewire/fireworks/fireworks_proc.c b/sound/firewire/fireworks/fireworks_proc.c
new file mode 100644
index 0000000..2b0f936
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks_proc.c
@@ -0,0 +1,198 @@
+/*
+ * fireworks_proc.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2009-2010 Clemens Ladisch
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "./fireworks.h"
+
+static inline const char*
+get_phys_name(struct snd_efw_phys_grp *grp)
+{
+	const char *ch_type[] = {
+		"Analog", "S/PDIF", "ADAT", "S/PDIF or ADAT",
+		"Mirroring", "Headphones", "I2S", "Guitar",
+		"Pirzo Guitar", "Guitar String", "Virtual", "Dummy"
+	};
+
+	if (grp->type < 10)
+		return ch_type[grp->type];
+	else if (grp->type == 0x10000)
+		return ch_type[10];
+	else
+		return ch_type[11];
+}
+
+static void
+proc_read_hwinfo(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
+{
+	struct snd_efw *efw = entry->private_data;
+	unsigned short i;
+	struct snd_efw_hwinfo hwinfo;
+
+	if (snd_efw_command_get_hwinfo(efw, &hwinfo) < 0)
+		goto end;
+
+	snd_iprintf(buffer, "guid_hi: 0x%X\n", hwinfo.guid_hi);
+	snd_iprintf(buffer, "guid_lo: 0x%X\n", hwinfo.guid_lo);
+	snd_iprintf(buffer, "type: 0x%X\n", hwinfo.type);
+	snd_iprintf(buffer, "version: 0x%X\n", hwinfo.version);
+	snd_iprintf(buffer, "vendor_name: %s\n", hwinfo.vendor_name);
+	snd_iprintf(buffer, "model_name: %s\n", hwinfo.model_name);
+
+	snd_iprintf(buffer, "dsp_version: 0x%X\n", hwinfo.dsp_version);
+	snd_iprintf(buffer, "arm_version: 0x%X\n", hwinfo.arm_version);
+	snd_iprintf(buffer, "fpga_version: 0x%X\n", hwinfo.fpga_version);
+
+	snd_iprintf(buffer, "flags: 0x%X\n", hwinfo.flags);
+
+	snd_iprintf(buffer, "max_sample_rate: 0x%X\n", hwinfo.max_sample_rate);
+	snd_iprintf(buffer, "min_sample_rate: 0x%X\n", hwinfo.min_sample_rate);
+	snd_iprintf(buffer, "supported_clock: 0x%X\n",
+		    hwinfo.supported_clocks);
+
+	snd_iprintf(buffer, "phys out: 0x%X\n", hwinfo.phys_out);
+	snd_iprintf(buffer, "phys in: 0x%X\n", hwinfo.phys_in);
+
+	snd_iprintf(buffer, "phys in grps: 0x%X\n", hwinfo.phys_in_grp_count);
+	for (i = 0; i < hwinfo.phys_in_grp_count; i++) {
+		snd_iprintf(buffer,
+			    "phys in grp[0x%d]: type 0x%d, count 0x%d\n",
+			    i, hwinfo.phys_out_grps[i].type,
+			    hwinfo.phys_out_grps[i].count);
+	}
+
+	snd_iprintf(buffer, "phys out grps: 0x%X\n", hwinfo.phys_out_grp_count);
+	for (i = 0; i < hwinfo.phys_out_grp_count; i++) {
+		snd_iprintf(buffer,
+			    "phys out grps[0x%d]: type 0x%d, count 0x%d\n",
+			    i, hwinfo.phys_out_grps[i].type,
+			    hwinfo.phys_out_grps[i].count);
+	}
+
+	snd_iprintf(buffer, "amdtp rx pcm channels 1x: 0x%X\n",
+		    hwinfo.amdtp_rx_pcm_channels);
+	snd_iprintf(buffer, "amdtp tx pcm channels 1x: 0x%X\n",
+		    hwinfo.amdtp_tx_pcm_channels);
+	snd_iprintf(buffer, "amdtp rx pcm channels 2x: 0x%X\n",
+		    hwinfo.amdtp_rx_pcm_channels_2x);
+	snd_iprintf(buffer, "amdtp tx pcm channels 2x: 0x%X\n",
+		    hwinfo.amdtp_tx_pcm_channels_2x);
+	snd_iprintf(buffer, "amdtp rx pcm channels 4x: 0x%X\n",
+		    hwinfo.amdtp_rx_pcm_channels_4x);
+	snd_iprintf(buffer, "amdtp tx pcm channels 4x: 0x%X\n",
+		    hwinfo.amdtp_tx_pcm_channels_4x);
+
+	snd_iprintf(buffer, "midi out ports: 0x%X\n", hwinfo.midi_out_ports);
+	snd_iprintf(buffer, "midi in ports: 0x%X\n", hwinfo.midi_in_ports);
+
+	snd_iprintf(buffer, "num mixer_playback_channels: 0x%X\n",
+		    hwinfo.mixer_playback_channels);
+	snd_iprintf(buffer, "num mixer_capture_channels: 0x%X\n",
+		    hwinfo.mixer_capture_channels);
+end:
+	return;
+}
+
+static void
+proc_read_clock(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
+{
+	struct snd_efw *efw = entry->private_data;
+	enum snd_efw_clock_source clock_source;
+	unsigned int sampling_rate;
+
+	if (snd_efw_command_get_clock_source(efw, &clock_source) < 0)
+		goto end;
+
+	if (snd_efw_command_get_sampling_rate(efw, &sampling_rate) < 0)
+		goto end;
+
+	snd_iprintf(buffer, "Clock Source: %d\n", clock_source);
+	snd_iprintf(buffer, "Sampling Rate: %d\n", sampling_rate);
+
+end:
+	return;
+}
+
+/*
+ * NOTE:
+ *  dB = 20 * log10(linear / 0x01000000)
+ *  -144.0 dB when linear is 0
+ */
+static void
+proc_read_phys_meters(struct snd_info_entry *entry,
+		      struct snd_info_buffer *buffer)
+{
+	struct snd_efw *efw = entry->private_data;
+	struct snd_efw_phys_meters *meters;
+	unsigned int g, c, m, max, size;
+	const char *name;
+	u32 *linear;
+	int err;
+
+	size = sizeof(struct snd_efw_phys_meters) +
+	       (efw->phys_in + efw->phys_out) * sizeof(u32);
+	meters = kzalloc(size, GFP_KERNEL);
+	if (meters == NULL)
+		return;
+
+	err = snd_efw_command_get_phys_meters(efw, meters, size);
+	if (err < 0)
+		goto end;
+
+	snd_iprintf(buffer, "Physical Meters:\n");
+
+	m = 0;
+	max = min(efw->phys_out, meters->out_meters);
+	linear = meters->values;
+	snd_iprintf(buffer, " %d Outputs:\n", max);
+	for (g = 0; g < efw->phys_out_grp_count; g++) {
+		name = get_phys_name(&efw->phys_out_grps[g]);
+		for (c = 0; c < efw->phys_out_grps[g].count; c++) {
+			if (m < max)
+				snd_iprintf(buffer, "\t%s [%d]: %d\n",
+					    name, c, linear[m++]);
+		}
+	}
+
+	m = 0;
+	max = min(efw->phys_in, meters->in_meters);
+	linear = meters->values + meters->out_meters;
+	snd_iprintf(buffer, " %d Inputs:\n", max);
+	for (g = 0; g < efw->phys_in_grp_count; g++) {
+		name = get_phys_name(&efw->phys_in_grps[g]);
+		for (c = 0; c < efw->phys_in_grps[g].count; c++)
+			if (m < max)
+				snd_iprintf(buffer, "\t%s [%d]: %d\n",
+					    name, c, linear[m++]);
+	}
+end:
+	kfree(meters);
+	return;
+}
+
+void snd_efw_proc_init(struct snd_efw *efw)
+{
+	struct snd_info_entry *entry;
+
+	if (!snd_card_proc_new(efw->card, "#hardware", &entry))
+		snd_info_set_text_ops(entry, efw, proc_read_hwinfo);
+	if (!snd_card_proc_new(efw->card, "#clock", &entry))
+		snd_info_set_text_ops(entry, efw, proc_read_clock);
+	if (!snd_card_proc_new(efw->card, "#meters", &entry))
+		snd_info_set_text_ops(entry, efw, proc_read_phys_meters);
+	return;
+}
-- 
1.8.3.2
