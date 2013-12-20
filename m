From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 35/38] bebob: Add support for Focusrite Saffire/SaffirePro
	series
Date: Fri, 20 Dec 2013 22:14:26 +0900
Message-ID: <1387545269-3875-36-git-send-email-o-takashi@sakamocchi.jp>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
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

This commit allows this driver to support all of models which Focusrite
produces with DM1000/BeBoB. They are:
 - Saffire
 - Saffire LE
 - SaffirePro 10 I/O
 - SaffirePro 26 I/O

This commit adds Focusrite specific operations:
1. Get source of clock
2. Get/Set sampling frequency
3. Get metering information

The driver uses these functionalities to read/write specific address by async
transaction.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig                 |   1 +
 sound/firewire/bebob/Makefile          |   2 +-
 sound/firewire/bebob/bebob.c           |  30 +++-
 sound/firewire/bebob/bebob.h           |   4 +
 sound/firewire/bebob/bebob_focusrite.c | 289 +++++++++++++++++++++++++++++++++
 5 files changed, 324 insertions(+), 2 deletions(-)
 create mode 100644 sound/firewire/bebob/bebob_focusrite.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index d23bfa8..608547c 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -108,6 +108,7 @@ config SND_BEBOB
 	  * Terratec EWS MIC2/EWS MIC4
 	  * Terratec Aureon 7.1 Firewire
 	  * Yamaha GO44/GO46
+	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index c35eee1..6565420 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
 		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o bebob_yamaha.o \
-		  bebob.o
+		  bebob_focusrite.o bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index ad6a27e..d02686e 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -54,6 +54,9 @@ static unsigned int devices_used;
 #define VEN_PRISMSOUND	0x00001198
 #define VEN_TERRATEC	0x00000aac
 #define VEN_YAMAHA	0x0000a0de
+#define VEN_FOCUSRITE	0x0000130e
+
+#define MODEL_FOCUSRITE_SAFFIRE_BOTH	0x00000000
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -124,6 +127,20 @@ bebob_card_free(struct snd_card *card)
 	return;
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
 static int
 bebob_probe(struct fw_unit *unit,
 	    const struct ieee1394_device_id *entry)
@@ -145,7 +162,11 @@ bebob_probe(struct fw_unit *unit,
 		goto end;
 	}
 
-	spec = (const struct snd_bebob_spec *)entry->driver_data;
+	if ((entry->vendor_id == VEN_FOCUSRITE) &&
+	    (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH))
+		spec = get_saffire_spec(unit);
+	else
+		spec = (const struct snd_bebob_spec *)entry->driver_data;
 	if (spec == NULL) {
 		err = -ENOSYS;
 		goto end;
@@ -301,6 +322,13 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000b, &yamaha_go_spec),
 	/* YAMAHA, GO46 */
 	SND_BEBOB_DEV_ENTRY(VEN_YAMAHA, 0x0010000c, &yamaha_go_spec),
+	/* Focusrite, SaffirePro 26 I/O */
+	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, 0x00000003, &saffirepro_26_spec),
+	/* Focusrite, SaffirePro 10 I/O */
+	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, 0x00000006, &saffirepro_10_spec),
+	/* Focusrite, Saffire(no label and LE) */
+	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, MODEL_FOCUSRITE_SAFFIRE_BOTH,
+			    &saffire_spec),
 	/* Ids are unknown but able to be supported */
 	/*  Mackie, Digital X Bus x.200 */
 	/*  Mackie, Digital X Bus x.400 */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index a684f06..7dc5e55 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -231,6 +231,10 @@ int snd_bebob_create_hwdep_device(struct snd_bebob *bebob);
 extern struct snd_bebob_spec phase88_rack_spec;
 extern struct snd_bebob_spec phase24_series_spec;
 extern struct snd_bebob_spec yamaha_go_spec;
+extern struct snd_bebob_spec saffirepro_26_spec;
+extern struct snd_bebob_spec saffirepro_10_spec;
+extern struct snd_bebob_spec saffire_le_spec;
+extern struct snd_bebob_spec saffire_spec;
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
diff --git a/sound/firewire/bebob/bebob_focusrite.c b/sound/firewire/bebob/bebob_focusrite.c
new file mode 100644
index 0000000..01996c9
--- /dev/null
+++ b/sound/firewire/bebob/bebob_focusrite.c
@@ -0,0 +1,289 @@
+/*
+ * bebob_focusrite.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
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
+static const unsigned int rates[] = {
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
+				 &tmp, sizeof(__be32), 0);
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
+	__be32 data = cpu_to_be32(value);
+
+	return snd_fw_transaction(bebob->unit, TCODE_WRITE_QUADLET_REQUEST,
+				  SAFFIRE_ADDRESS_BASE + offset,
+				  &data, sizeof(__be32), 0);
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
+static char *saffire_le_meter_labels[] = {
+	ANA_IN, ANA_IN, DIG_IN,
+	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT,
+	STM_IN, STM_IN
+};
+#define SWAP(a, b) \
+	do { \
+		tmp = a; \
+		a = b; \
+		b = tmp; \
+	} while (0)
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
+static struct snd_bebob_rate_spec saffirepro_both_rate_spec = {
+	.get	= &saffirepro_both_clk_freq_get,
+	.set	= &saffirepro_both_clk_freq_set,
+};
+static struct snd_bebob_clock_spec saffirepro_26_clk_spec = {
+	.num	= ARRAY_SIZE(saffirepro_26_clk_src_labels),
+	.labels	= saffirepro_26_clk_src_labels,
+	.get	= &saffirepro_both_clk_src_get,
+};
+struct snd_bebob_spec saffirepro_26_spec = {
+	.clock	= &saffirepro_26_clk_spec,
+	.rate	= &saffirepro_both_rate_spec,
+	.meter	= NULL
+};
+/* Saffire Pro 10 I/O */
+static struct snd_bebob_clock_spec saffirepro_10_clk_spec = {
+	.num	= ARRAY_SIZE(saffirepro_10_clk_src_labels),
+	.labels	= saffirepro_10_clk_src_labels,
+	.get	= &saffirepro_both_clk_src_get,
+};
+struct snd_bebob_spec saffirepro_10_spec = {
+	.clock	= &saffirepro_10_clk_spec,
+	.rate	= &saffirepro_both_rate_spec,
+	.meter	= NULL
+};
+
+/* Saffire LE */
+static struct snd_bebob_rate_spec saffire_both_rate_spec = {
+	.get	= &snd_bebob_stream_get_rate,
+	.set	= &snd_bebob_stream_set_rate,
+};
+static struct snd_bebob_clock_spec saffire_both_clk_spec = {
+	.num	= ARRAY_SIZE(saffire_both_clk_src_labels),
+	.labels	= saffire_both_clk_src_labels,
+	.get	= &saffire_both_clk_src_get,
+};
+struct snd_bebob_meter_spec saffire_le_meter_spec = {
+	.num	= ARRAY_SIZE(saffire_le_meter_labels),
+	.labels	= saffire_le_meter_labels,
+	.get	= &saffire_le_meter_get,
+};
+struct snd_bebob_spec saffire_le_spec = {
+	.clock	= &saffire_both_clk_spec,
+	.rate	= &saffire_both_rate_spec,
+	.meter	= &saffire_le_meter_spec
+};
+/* Saffire */
+struct snd_bebob_meter_spec saffire_meter_spec = {
+	.num	= ARRAY_SIZE(saffire_meter_labels),
+	.labels	= saffire_meter_labels,
+	.get	= &saffire_meter_get,
+};
+struct snd_bebob_spec saffire_spec = {
+	.clock	= &saffire_both_clk_spec,
+	.rate	= &saffire_both_rate_spec,
+	.meter	= &saffire_meter_spec
+};
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
