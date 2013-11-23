From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 10/13] bebob: Add support for Focusrite
	Saffire/SaffirePro series
Date: Sat, 23 Nov 2013 15:09:22 +0900
Message-ID: <1385186965-8303-11-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 2715926530F
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:37 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit allows this driver to support all of models which Focusrite
produces with BeBoB chipset. They are:
 - Saffire
 - Saffire LE
 - SaffirePro 10
 - SaffirePro26

This commit adds Focusrite specific operations, quirks for its four
functionalities.

1. Switching source of clock
2. Change sampling frequency
3. Check clock synchronization
4. Get metering information

The driver uses these functionalities to read/write specific address by async
transaction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                 |   1 +
 sound/firewire/bebob/Makefile          |   2 +-
 sound/firewire/bebob/bebob.c           |  34 ++-
 sound/firewire/bebob/bebob.h           |   4 +
 sound/firewire/bebob/bebob_focusrite.c | 390 +++++++++++++++++++++++++++++++++
 5 files changed, 429 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/bebob/bebob_focusrite.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 427def7..b8d7fb5 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -82,6 +82,7 @@ config SND_BEBOB
 	  * BridgeCo RDAudio1/Audio5
 	  * M-Audio Firewire410/AudioPhile/Solo/Ozonic/NRV10
 	  * M-Audio Firewire1814/ProjectMix IO/ProfireLightBridge
+	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
 
           To compile this driver as a module, choose M here: the module
           will be called snd-fireworks.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 2e87d02..96f8e92 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,5 +1,5 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_control.o \
 		  bebob_midi.o bebob_pcm.o bebob_hwdep.o \
-		  bebob_maudio.o \
+		  bebob_maudio.o bebob_focusrite.o \
 		  bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index 576d801..6382b49 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -52,10 +52,12 @@ static unsigned int devices_used;
 #define VEN_PHONIC	0x00001496
 #define VEN_MAUDIO1	0x00000d6c
 #define VEN_MAUDIO2	0x000007f5
+#define VEN_FOCUSRITE	0x0000130e
 
 #define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
 #define MODEL_MAUDIO_FW1814		0x00010071
 #define MODEL_MAUDIO_PROJECTMIX		0x00010091
+#define MODEL_FOCUSRITE_SAFFIRE_BOTH	0x00000000
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -157,6 +159,21 @@ check_audiophile_booted(struct fw_unit *unit)
 		return true;
 }
 
+static const struct snd_bebob_spec *
+get_saffire_spec(struct fw_unit *unit)
+{
+	char name[24] = {0};
+
+	if (fw_csr_string(unit->directory, CSR_MODEL, name, sizeof(name)) < 0)
+		return NULL;
+
+	if (strcmp(name, "SaffireLE") == 0)
+		return &saffire_le_spec;
+	else
+		return &saffire_spec;
+}
+
+
 static int
 snd_bebob_probe(struct fw_unit *unit,
 		const struct ieee1394_device_id *entry)
@@ -179,7 +196,15 @@ snd_bebob_probe(struct fw_unit *unit,
 		goto end;
 	}
 
-	spec = (const struct snd_bebob_spec *)entry->driver_data;
+	if (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH)
+		spec = get_saffire_spec(unit);
+	else
+		spec = (const struct snd_bebob_spec *)entry->driver_data;
+
+	if (spec == NULL) {
+		err = -EIO;
+		goto end;
+	}
 
 	/* if needed, load firmware and exit */
 	if ((spec->load) &&
@@ -362,6 +387,13 @@ static const struct ieee1394_device_id snd_bebob_id_table[] = {
 						maudio_special_spec),
 	/* M-Audio, ProFireLightbridge */
 	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, spec_normal),
+	/* Focusrite, SaffirePro 26 I/O */
+	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, 0x00000003, saffirepro_26_spec),
+	/* Focusrite, SaffirePro 10 I/O */
+	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, 0x00000006, saffirepro_10_spec),
+	/* Focusrite, Saffire(no label and LE) */
+	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, MODEL_FOCUSRITE_SAFFIRE_BOTH,
+			    saffire_spec),
 	{}
 };
 MODULE_DEVICE_TABLE(ieee1394, snd_bebob_id_table);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index fb9d99d..90b37eb 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -234,6 +234,10 @@ extern struct snd_bebob_spec maudio_fw410_spec;
 extern struct snd_bebob_spec maudio_audiophile_spec;
 extern struct snd_bebob_spec maudio_solo_spec;
 extern struct snd_bebob_spec maudio_ozonic_spec;
+extern struct snd_bebob_spec saffirepro_26_spec;
+extern struct snd_bebob_spec saffirepro_10_spec;
+extern struct snd_bebob_spec saffire_le_spec;
+extern struct snd_bebob_spec saffire_spec;
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, private_data) \
 { \
diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
new file mode 100644
index 0000000..c4c7805
--- /dev/null
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -0,0 +1,390 @@
+/*
+ * bebob_focusrite.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
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
+#include "./bebob.h"
+
+#define ANA_IN	"Analog In"
+#define DIG_IN	"Digital In"
+#define ANA_OUT	"Analog Out"
+#define DIG_OUT	"Digital Out"
+#define STM_IN	"Stream In"
+
+#define SAFFIRE_ADDRESS_BASE			0x000100000000
+
+#define SAFFIRE_OFFSET_CLOCK_SOURCE		0x0000000000f8
+#define SAFFIREPRO_OFFSET_CLOCK_SOURCE		0x000000000174
+
+/* whether sync to external device or not */
+#define SAFFIRE_OFFSET_CLOCK_SYNC_EXT		0x00000000013c
+#define SAFFIRE_LE_OFFSET_CLOCK_SYNC_EXT	0x000000000432
+#define SAFFIREPRO_OFFSET_CLOCK_SYNC_EXT	0x000000000164
+
+#define SAFFIRE_CLOCK_SOURCE_INTERNAL		0
+#define SAFFIRE_CLOCK_SOURCE_SPDIF		1
+
+/* '1' is absent, why... */
+#define SAFFIREPRO_CLOCK_SOURCE_INTERNAL	0
+#define SAFFIREPRO_CLOCK_SOURCE_SPDIF		2
+#define SAFFIREPRO_CLOCK_SOURCE_ADAT1		3
+#define SAFFIREPRO_CLOCK_SOURCE_ADAT2		4
+#define SAFFIREPRO_CLOCK_SOURCE_WORDCLOCK	5
+
+/* S/PDIF, ADAT1, ADAT2 is enabled or not. three quadlets */
+#define SAFFIREPRO_ENABLE_DIG_IFACES		0x0000000001a4
+
+/* saffirepro has its own parameter for sampling frequency */
+#define SAFFIREPRO_RATE_NOREBOOT		0x0000000001cc
+/* index is the value for this register */
+const static unsigned int rates[] = {
+	[0] = 0,
+	[1] = 44100,
+	[2] = 48000,
+	[3] = 88200,
+	[4] = 96000,
+	[5] = 176400,
+	[6] = 192000
+};
+
+/* saffire(no label)/saffire LE has metering */
+#define SAFFIRE_OFFSET_METER			0x000000000100
+#define SAFFIRE_LE_OFFSET_METER			0x000000000168
+
+static inline int
+saffire_read_block(struct snd_bebob *bebob, u64 offset,
+		   u32 *buf, unsigned int size)
+{
+	unsigned int i;
+	int err;
+	__be32 *tmp = (__be32 *)buf;
+
+	err =  snd_fw_transaction(bebob->unit, TCODE_READ_BLOCK_REQUEST,
+				  SAFFIRE_ADDRESS_BASE + offset,
+				  tmp, size, 0);
+	if (err < 0)
+		goto end;
+
+	for (i = 0; i < size / sizeof(u32); i++)
+		buf[i] = be32_to_cpu(tmp[i]);
+end:
+	return err;
+}
+
+static inline int
+saffire_read_quad(struct snd_bebob *bebob, u64 offset, u32 *value)
+{
+	int err;
+	__be32 tmp;
+
+	err = snd_fw_transaction(bebob->unit, TCODE_READ_QUADLET_REQUEST,
+				 SAFFIRE_ADDRESS_BASE + offset,
+				 &tmp, sizeof(u32), 0);
+	if (err < 0)
+		goto end;
+
+	*value = be32_to_cpu(tmp);
+end:
+	return err;
+}
+
+static inline int
+saffire_write_quad(struct snd_bebob *bebob, u64 offset, u32 value)
+{
+	value = cpu_to_be32(value);
+
+	return snd_fw_transaction(bebob->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  SAFFIRE_ADDRESS_BASE + offset,
+				  &value, sizeof(u32), 0);
+}
+
+static char *saffirepro_26_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "ADAT1", "ADAT2", "Word Clock"
+};
+
+static char *saffirepro_10_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF", "Word Clock"
+};
+static int
+saffirepro_both_clk_freq_get(struct snd_bebob *bebob, unsigned int *rate)
+{
+	u32 id;
+	int err;
+
+	err = saffire_read_quad(bebob, SAFFIREPRO_RATE_NOREBOOT, &id);
+	if (err < 0)
+		goto end;
+	if (id >= ARRAY_SIZE(rates)) {
+		err = -EIO;
+		goto end;
+	}
+
+	*rate = rates[id];
+end:
+	return err;
+}
+static int
+saffirepro_both_clk_freq_set(struct snd_bebob *bebob, unsigned int rate)
+{
+	u32 id;
+	bool flag;
+
+	flag = false;
+	for (id = 0; id < ARRAY_SIZE(rates); id++) {
+		if (rates[id] == rate)
+			flag = true;
+	}
+	if (!flag)
+		return -EINVAL;
+
+	return saffire_write_quad(bebob, SAFFIREPRO_RATE_NOREBOOT, id);
+}
+static int
+saffirepro_both_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	int err;
+	u32 value;
+
+	err = saffire_read_quad(bebob, SAFFIREPRO_OFFSET_CLOCK_SOURCE, &value);
+	if (err < 0)
+		goto end;
+
+	if (bebob->spec->clock->labels == saffirepro_10_clk_src_labels) {
+		if (value == SAFFIREPRO_CLOCK_SOURCE_WORDCLOCK)
+			*id = 2;
+		else if (value == SAFFIREPRO_CLOCK_SOURCE_SPDIF)
+			*id = 1;
+	} else if (value > 1)
+		*id = value - 1;
+end:
+	return err;
+}
+static int
+saffirepro_both_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	int err;
+	u32 values[3];
+
+	if (bebob->spec->clock->labels == saffirepro_10_clk_src_labels) {
+		if (id == 2)
+			id = 5;
+		else if (id == 1)
+			id = 2;
+	} else if (id > 0)
+		id++;
+
+	/* if requesting digital input, check whether it's enabled or not */
+	/* TODO: consider to add switch for these digital inputs */
+	if ((id > 1) && (id < 5)) {
+		err = saffire_read_block(bebob, SAFFIREPRO_ENABLE_DIG_IFACES,
+					 values, sizeof(values));
+		if (err < 0)
+			goto end;
+		if (values[id - 2] == 0)
+			goto end;
+	}
+
+	err = saffire_write_quad(bebob, SAFFIREPRO_OFFSET_CLOCK_SOURCE, id);
+end:
+	return err;
+}
+static int
+saffirepro_both_clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	unsigned int clock;
+	u32 value;
+	int err;
+
+	err = saffirepro_both_clk_src_get(bebob, &clock);
+	if (err < 0)
+		goto end;
+	/* internal */
+	if (clock == 0) {
+		*synced = true;
+		goto end;
+	}
+
+	err = saffire_read_quad(bebob,
+				SAFFIREPRO_OFFSET_CLOCK_SYNC_EXT, &value);
+	if (err < 0)
+		goto end;
+
+	*synced = (value & 0x01);
+end:
+	return err;
+}
+
+struct snd_bebob_spec saffire_le_spec;
+static char *saffire_both_clk_src_labels[] = {
+	SND_BEBOB_CLOCK_INTERNAL, "S/PDIF"
+};
+static int
+saffire_both_clk_src_get(struct snd_bebob *bebob, unsigned int *id)
+{
+	int err;
+	u32 value;
+
+	err = saffire_read_quad(bebob, SAFFIRE_OFFSET_CLOCK_SOURCE, &value);
+	if (err < 0)
+		goto end;
+
+	*id = 0xff & value;
+end:
+	return err;
+};
+static int
+saffire_both_clk_src_set(struct snd_bebob *bebob, unsigned int id)
+{
+	return saffire_write_quad(bebob, SAFFIRE_OFFSET_CLOCK_SOURCE, id);
+};
+static int
+saffire_both_clk_synced(struct snd_bebob *bebob, bool *synced)
+{
+	int err;
+	u64 offset;
+	u32 value;
+
+	err = saffire_both_clk_src_get(bebob, &value);
+	if (err < 0)
+		goto end;
+	/* internal */
+	if (value == 0) {
+		*synced = true;
+		goto end;
+	}
+
+	if (bebob->spec == &saffire_le_spec)
+		offset = SAFFIRE_LE_OFFSET_CLOCK_SYNC_EXT;
+	else
+		offset = SAFFIRE_OFFSET_CLOCK_SYNC_EXT;
+
+	err = saffire_read_quad(bebob, offset, &value);
+	if (err < 0)
+		goto end;
+
+	*synced = (0x01 & value);
+end:
+	return err;
+}
+static char *saffire_le_meter_labels[] = {
+	ANA_IN, ANA_IN, DIG_IN,
+	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT,
+	STM_IN, STM_IN
+};
+#define SWAP(a, b) \
+	tmp = a; \
+	a = b; \
+	b = tmp
+static int
+saffire_le_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	int err;
+	u32 tmp;
+
+	if (size < sizeof(saffire_le_meter_labels) * sizeof(u32))
+		return -EIO;
+
+	err = saffire_read_block(bebob, SAFFIRE_LE_OFFSET_METER, buf, size);
+	if (err < 0)
+		goto end;
+
+	SWAP(buf[1], buf[3]);
+	SWAP(buf[2], buf[3]);
+	SWAP(buf[3], buf[4]);
+
+	SWAP(buf[7], buf[10]);
+	SWAP(buf[8], buf[10]);
+	SWAP(buf[9], buf[11]);
+	SWAP(buf[11], buf[12]);
+
+	SWAP(buf[15], buf[16]);
+
+end:
+	return err;
+}
+static char *saffire_meter_labels[] = {
+	ANA_IN, ANA_IN,
+	STM_IN, STM_IN, STM_IN, STM_IN, STM_IN,
+};
+static int
+saffire_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	return saffire_read_block(bebob, SAFFIRE_OFFSET_METER, buf, size);
+}
+
+/* Saffire Pro 26 I/O  */
+static struct snd_bebob_clock_spec saffirepro_26_clk_spec = {
+	.num		= ARRAY_SIZE(saffirepro_26_clk_src_labels),
+	.labels		= saffirepro_26_clk_src_labels,
+	.get_src	= &saffirepro_both_clk_src_get,
+	.set_src	= &saffirepro_both_clk_src_set,
+	.get_freq	= &saffirepro_both_clk_freq_get,
+	.set_freq	= &saffirepro_both_clk_freq_set,
+	.synced		= &saffirepro_both_clk_synced
+};
+struct snd_bebob_spec saffirepro_26_spec = {
+	.load	= NULL,
+	.clock	= &saffirepro_26_clk_spec,
+	.meter	= NULL
+};
+
+/* Saffire Pro 10 I/O */
+static struct snd_bebob_clock_spec saffirepro_10_clk_spec = {
+	.num		= ARRAY_SIZE(saffirepro_10_clk_src_labels),
+	.labels		= saffirepro_10_clk_src_labels,
+	.get_src	= &saffirepro_both_clk_src_get,
+	.set_src	= &saffirepro_both_clk_src_set,
+	.get_freq	= &saffirepro_both_clk_freq_get,
+	.set_freq	= &saffirepro_both_clk_freq_set,
+	.synced		= &saffirepro_both_clk_synced
+};
+struct snd_bebob_spec saffirepro_10_spec = {
+	.load	= NULL,
+	.clock	= &saffirepro_10_clk_spec,
+	.meter	= NULL
+};
+
+struct snd_bebob_clock_spec saffire_both_clk_spec= {
+	.num		= ARRAY_SIZE(saffire_both_clk_src_labels),
+	.labels		= saffire_both_clk_src_labels,
+	.get_src	= &saffire_both_clk_src_get,
+	.set_src	= &saffire_both_clk_src_set,
+	.get_freq	= &snd_bebob_stream_get_rate,
+	.set_freq	= &snd_bebob_stream_set_rate,
+	.synced		= &saffire_both_clk_synced
+};
+
+/* Saffire LE */
+struct snd_bebob_meter_spec saffire_le_meter_spec = {
+	.num	= ARRAY_SIZE(saffire_le_meter_labels),
+	.labels	= saffire_le_meter_labels,
+	.get	= &saffire_le_meter_get,
+};
+struct snd_bebob_spec saffire_le_spec = {
+	.load	= NULL,
+	.clock	= &saffire_both_clk_spec,
+	.meter	= &saffire_le_meter_spec
+};
+/* Saffire */
+struct snd_bebob_meter_spec saffire_meter_spec = {
+	.num	= ARRAY_SIZE(saffire_meter_labels),
+	.labels	= saffire_meter_labels,
+	.get	= &saffire_meter_get,
+};
+struct snd_bebob_spec saffire_spec ={
+	.load	= NULL,
+	.clock	= &saffire_both_clk_spec,
+	.meter	= &saffire_meter_spec
+};
-- 
1.8.3.2
