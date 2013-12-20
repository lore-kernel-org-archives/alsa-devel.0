From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 36/38] bebob: Add support for M-Audio usual Firewire series
Date: Fri, 20 Dec 2013 22:14:27 +0900
Message-ID: <1387545269-3875-37-git-send-email-o-takashi@sakamocchi.jp>
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

This commit allows this driver to support some models which M-Audio produces
with DM1000/DM1000E with usual firmware. They are:
 - Firewire 410
 - Firewire AudioPhile
 - Firewire Solo
 - Ozonic
 - NRV10
 - FirewireLightBridge

According to person of BridgeCo, Some models are produced with 'Pre-BeBoB'. This
means that these products were released before BeBoB was officially produced. So
these models have some quirks.

M-Audio usual firmware quirks:
 - Just after powering on, 'Firewire 410' waits to download firmware. This
   state is changed when receiving cue. Then bus reset is generated and the
   device is recognized as a different model with the uploaded firmware.
 - 'Firewire Audiophile' also waits to download firmware but its
   vendor id/model id is the same as the one after loading firmware.
 - The information of channel mapping for MIDI conformant data channel is
   invalid against BridgeCo specification.

This commit adds some codes for these quirks but don't support to upload
firmware.

This commit also adds specific operations to get metering information. The
metering information also includes status of clock synchronization if the model
supports to switch source of clock.

The specification of FirewireLightBridge is unknown. So in this time, normal
operations are applied for this model.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig              |   2 +
 sound/firewire/bebob/Makefile       |   2 +-
 sound/firewire/bebob/bebob.c        |  45 +++++-
 sound/firewire/bebob/bebob.h        |   5 +
 sound/firewire/bebob/bebob_maudio.c | 295 ++++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob_stream.c |   9 ++
 6 files changed, 355 insertions(+), 3 deletions(-)
 create mode 100644 sound/firewire/bebob/bebob_maudio.c

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 608547c..d71faf6 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -109,6 +109,8 @@ config SND_BEBOB
 	  * Terratec Aureon 7.1 Firewire
 	  * Yamaha GO44/GO46
 	  * Focusrite Saffire/Saffire LE/SaffirePro10 IO/SaffirePro26 IO
+	  * M-Audio Firewire410/AudioPhile/Solo
+	  * M-Audio Ozonic/NRV10/ProfireLightBridge
 
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 6565420..6cf470c 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
 		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o bebob_yamaha.o \
-		  bebob_focusrite.o bebob.o
+		  bebob_focusrite.o bebob_maudio.o bebob.o
 obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
index d02686e..65554ef 100644
--- a/sound/firewire/bebob/bebob.c
+++ b/sound/firewire/bebob/bebob.c
@@ -55,8 +55,11 @@ static unsigned int devices_used;
 #define VEN_TERRATEC	0x00000aac
 #define VEN_YAMAHA	0x0000a0de
 #define VEN_FOCUSRITE	0x0000130e
+#define VEN_MAUDIO1	0x00000d6c
+#define VEN_MAUDIO2	0x000007f5
 
 #define MODEL_FOCUSRITE_SAFFIRE_BOTH	0x00000000
+#define MODEL_MAUDIO_AUDIOPHILE_BOTH	0x00010060
 
 static int
 name_device(struct snd_bebob *bebob, unsigned int vendor_id)
@@ -141,6 +144,17 @@ get_saffire_spec(struct fw_unit *unit)
 		return &saffire_spec;
 }
 
+static bool
+check_audiophile_booted(struct fw_unit *unit)
+{
+	char name[24] = {0};
+
+	if (fw_csr_string(unit->directory, CSR_MODEL, name, sizeof(name)) < 0)
+		return false;
+
+	return strncmp(name, "FW Audiophile Bootloader", 15) != 0;
+}
+
 static int
 bebob_probe(struct fw_unit *unit,
 	    const struct ieee1394_device_id *entry)
@@ -163,10 +177,16 @@ bebob_probe(struct fw_unit *unit,
 	}
 
 	if ((entry->vendor_id == VEN_FOCUSRITE) &&
-	    (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH))
+	    (entry->model_id == MODEL_FOCUSRITE_SAFFIRE_BOTH)) {
 		spec = get_saffire_spec(unit);
-	else
+	} else if ((entry->vendor_id == VEN_MAUDIO1) &&
+		   (entry->model_id == MODEL_MAUDIO_AUDIOPHILE_BOTH) &&
+		   !check_audiophile_booted(unit)) {
+			err = 0;
+			goto end;
+	} else {
 		spec = (const struct snd_bebob_spec *)entry->driver_data;
+	}
 	if (spec == NULL) {
 		err = -ENOSYS;
 		goto end;
@@ -239,6 +259,10 @@ static void
 bebob_update(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+
+	if (bebob == NULL)
+		return;
+
 	fcp_bus_reset(bebob->unit);
 	snd_bebob_stream_update_duplex(bebob);
 }
@@ -247,6 +271,10 @@ bebob_update(struct fw_unit *unit)
 static void bebob_remove(struct fw_unit *unit)
 {
 	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+
+	if (bebob == NULL)
+		return;
+
 	snd_bebob_stream_destroy_duplex(bebob);
 	snd_card_disconnect(bebob->card);
 	snd_card_free_when_closed(bebob->card);
@@ -329,6 +357,19 @@ static const struct ieee1394_device_id bebob_id_table[] = {
 	/* Focusrite, Saffire(no label and LE) */
 	SND_BEBOB_DEV_ENTRY(VEN_FOCUSRITE, MODEL_FOCUSRITE_SAFFIRE_BOTH,
 			    &saffire_spec),
+	/* M-Audio, Firewire 410 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO2, 0x00010046, &maudio_fw410_spec),
+	/* M-Audio, Firewire Audiophile */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, MODEL_MAUDIO_AUDIOPHILE_BOTH,
+			    &maudio_audiophile_spec),
+	/* M-Audio, Firewire Solo */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010062, &maudio_solo_spec),
+	/* M-Audio, Ozonic */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x0000000a, &maudio_ozonic_spec),
+	/* M-Audio NRV10 */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x00010081, &maudio_nrv10_spec),
+	/* M-Audio, ProFireLightbridge */
+	SND_BEBOB_DEV_ENTRY(VEN_MAUDIO1, 0x000100a1, &spec_normal),
 	/* Ids are unknown but able to be supported */
 	/*  Mackie, Digital X Bus x.200 */
 	/*  Mackie, Digital X Bus x.400 */
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index 7dc5e55..c67d5e5 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -235,6 +235,11 @@ extern struct snd_bebob_spec saffirepro_26_spec;
 extern struct snd_bebob_spec saffirepro_10_spec;
 extern struct snd_bebob_spec saffire_le_spec;
 extern struct snd_bebob_spec saffire_spec;
+extern struct snd_bebob_spec maudio_fw410_spec;
+extern struct snd_bebob_spec maudio_audiophile_spec;
+extern struct snd_bebob_spec maudio_solo_spec;
+extern struct snd_bebob_spec maudio_ozonic_spec;
+extern struct snd_bebob_spec maudio_nrv10_spec;
 
 #define SND_BEBOB_DEV_ENTRY(vendor, model, data) \
 { \
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
new file mode 100644
index 0000000..715cf34
--- /dev/null
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -0,0 +1,295 @@
+/*
+ * bebob_maudio.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "./bebob.h"
+
+/*
+ * Just powering on, Firewire 410/Audiophile wait to
+ * download firmware blob. To enable these devices, drivers should upload
+ * firmware blob and send a command to initialize configuration to factory
+ * settings when completing uploading. Then these devices generate bus reset
+ * and are recognized as new devices with the firmware.
+ *
+ * For streaming, both of output and input streams are needed for Firewire 410
+ * and Ozonic. The single stream is OK for the other devices even if the clock
+ * source is not SYT-Match (I note no devices use SYT-Match).
+ *
+ * Without streaming, the devices except for Firewire Audiophile can mix any
+ * input and output. For this reason, Audiophile cannot be used as standalone
+ * mixer.
+ */
+
+#define MAUDIO_SPECIFIC_ADDRESS	0xffc700000000
+
+#define METER_OFFSET		0x00600000
+
+/* some device has sync info after metering data */
+#define METER_SIZE_FW410	76	/* with sync info */
+#define METER_SIZE_AUDIOPHILE	60	/* with sync info */
+#define METER_SIZE_SOLO		52	/* with sync info */
+#define METER_SIZE_OZONIC	48
+#define METER_SIZE_NRV10	80
+
+/* labels for metering */
+#define ANA_IN		"Analog In"
+#define ANA_OUT		"Analog Out"
+#define DIG_IN		"Digital In"
+#define SPDIF_IN	"S/PDIF In"
+#define ADAT_IN		"ADAT In"
+#define DIG_OUT		"Digital Out"
+#define SPDIF_OUT	"S/PDIF Out"
+#define ADAT_OUT	"ADAT Out"
+#define STRM_IN		"Stream In"
+#define AUX_OUT		"Aux Out"
+#define HP_OUT		"HP Out"
+/* for NRV */
+#define UNKNOWN_METER	"Unknown"
+
+static inline int
+get_meter(struct snd_bebob *bebob, void *buf, unsigned int size)
+{
+	return snd_fw_transaction(bebob->unit, TCODE_READ_BLOCK_REQUEST,
+				  MAUDIO_SPECIFIC_ADDRESS + METER_OFFSET,
+				  buf, size, 0);
+}
+
+static int
+check_clk_sync(struct snd_bebob *bebob, unsigned int size, bool *sync)
+{
+	int err;
+	u8 *buf;
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+
+	err = get_meter(bebob, buf, size);
+	if (err < 0)
+		goto end;
+
+	/* if synced, this value is the same of SFC of FDF in CIP header */
+	*sync = (buf[size - 2] != 0xff);
+end:
+	kfree(buf);
+	return err;
+}
+
+/* Firewire 410 specific operation */
+static char *fw410_meter_labels[] = {
+	ANA_IN, DIG_IN,
+	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT, DIG_OUT,
+	HP_OUT
+};
+static int
+fw410_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+
+	unsigned int c, channels;
+	int err;
+
+	/* last 4 bytes are omitted because it's clock info. */
+	channels = ARRAY_SIZE(fw410_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		be32_to_cpus(&buf[c]);
+end:
+	return err;
+}
+
+/* Firewire Audiophile specific operation */
+static char *audiophile_meter_labels[] = {
+	ANA_IN, DIG_IN,
+	ANA_OUT, ANA_OUT, DIG_OUT,
+	HP_OUT, AUX_OUT,
+};
+static int
+audiophile_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c, channels;
+	int err;
+
+	/* last 4 bytes are omitted because it's clock info. */
+	channels = ARRAY_SIZE(audiophile_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		be32_to_cpus(&buf[c]);
+end:
+	return err;
+}
+
+/* Firewire Solo specific operation */
+static char *solo_meter_labels[] = {
+	ANA_IN, DIG_IN,
+	STRM_IN, STRM_IN,
+	ANA_OUT, DIG_OUT
+};
+static int
+solo_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c;
+	int err;
+	u32 tmp;
+
+	/* last 4 bytes are omitted because it's clock info. */
+	if (size < ARRAY_SIZE(solo_meter_labels) * 2 * sizeof(u32))
+		return -EINVAL;
+
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	c = 0;
+	do
+		buf[c] = be32_to_cpu(buf[c]);
+	while (++c < 4);
+
+	/* swap stream channels because inverted */
+	tmp = be32_to_cpu(buf[c]);
+	buf[c] = be32_to_cpu(buf[c + 2]);
+	buf[c + 2] = tmp;
+	tmp = be32_to_cpu(buf[c + 1]);
+	buf[c + 1] = be32_to_cpu(buf[c + 3]);
+	buf[c + 3] = tmp;
+
+	c += 4;
+	do
+		be32_to_cpus(&buf[c]);
+	while (++c < 12);
+end:
+	return err;
+}
+
+/* Ozonic specific operation */
+static char *ozonic_meter_labels[] = {
+	ANA_IN, ANA_IN,
+	STRM_IN, STRM_IN,
+	ANA_OUT, ANA_OUT
+};
+static int
+ozonic_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c, channels;
+	int err;
+
+	channels = ARRAY_SIZE(ozonic_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		be32_to_cpus(&buf[c]);
+end:
+	return err;
+}
+
+/* NRV10 specific operation */
+/* TODO: need testers. these positions are based on my assumption */
+static char *nrv10_meter_labels[] = {
+	ANA_IN, ANA_IN, ANA_IN, ANA_IN,
+	DIG_IN,
+	ANA_OUT, ANA_OUT, ANA_OUT, ANA_OUT,
+	DIG_IN
+};
+static int
+nrv10_meter_get(struct snd_bebob *bebob, u32 *buf, unsigned int size)
+{
+	unsigned int c, channels;
+	int err;
+
+	channels = ARRAY_SIZE(nrv10_meter_labels) * 2;
+	if (size < channels * sizeof(u32))
+		return -EINVAL;
+
+	err = get_meter(bebob, (void *)buf, size);
+	if (err < 0)
+		goto end;
+
+	for (c = 0; c < channels; c++)
+		be32_to_cpus(&buf[c]);
+end:
+	return err;
+}
+
+/* Firewire 410 specification */
+static struct snd_bebob_rate_spec usual_rate_spec = {
+	.get	= &snd_bebob_stream_get_rate,
+	.set	= &snd_bebob_stream_set_rate,
+};
+static struct snd_bebob_meter_spec fw410_meter_spec = {
+	.num	= ARRAY_SIZE(fw410_meter_labels),
+	.labels	= fw410_meter_labels,
+	.get	= &fw410_meter_get
+};
+struct snd_bebob_spec maudio_fw410_spec = {
+	.clock	= NULL,
+	.rate	= &usual_rate_spec,
+	.meter	= &fw410_meter_spec
+};
+
+/* Firewire Audiophile specification */
+static struct snd_bebob_meter_spec audiophile_meter_spec = {
+	.num	= ARRAY_SIZE(audiophile_meter_labels),
+	.labels	= audiophile_meter_labels,
+	.get	= &audiophile_meter_get
+};
+struct snd_bebob_spec maudio_audiophile_spec = {
+	.clock	= NULL,
+	.rate	= &usual_rate_spec,
+	.meter	= &audiophile_meter_spec
+};
+
+/* Firewire Solo specification */
+static struct snd_bebob_meter_spec solo_meter_spec = {
+	.num	= ARRAY_SIZE(solo_meter_labels),
+	.labels	= solo_meter_labels,
+	.get	= &solo_meter_get
+};
+struct snd_bebob_spec maudio_solo_spec = {
+	.clock	= NULL,
+	.rate	= &usual_rate_spec,
+	.meter	= &solo_meter_spec
+};
+
+/* Ozonic specification */
+static struct snd_bebob_meter_spec ozonic_meter_spec = {
+	.num	= ARRAY_SIZE(ozonic_meter_labels),
+	.labels	= ozonic_meter_labels,
+	.get	= &ozonic_meter_get
+};
+struct snd_bebob_spec maudio_ozonic_spec = {
+	.clock	= NULL,
+	.rate	= &usual_rate_spec,
+	.meter	= &ozonic_meter_spec
+};
+
+/* NRV10 specification */
+static struct snd_bebob_meter_spec nrv10_meter_spec = {
+	.num	= ARRAY_SIZE(nrv10_meter_labels),
+	.labels	= nrv10_meter_labels,
+	.get	= &nrv10_meter_get
+};
+struct snd_bebob_spec maudio_nrv10_spec = {
+	.clock	= NULL,
+	.rate	= &usual_rate_spec,
+	.meter	= &nrv10_meter_spec
+};
diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 76be74b..5865fed 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -198,6 +198,15 @@ map_stream(struct snd_bebob *bebob, struct amdtp_stream *s)
 			/* location of this channel in this section */
 			sec_loc = buf[pos++] - 1;
 
+			/*
+			 * Basically the number of location is within the
+			 * number of channels in this section. But some models
+			 * of M-Audio don't follow this. Its location for MIDI
+			 * is the position of MIDI channels in AMDTP packet.
+			 */
+			if (sec_loc >= channels)
+				sec_loc = ch;
+
 			switch (type) {
 			/* for MIDI conformant data channel */
 			case 0x0a:
-- 
1.8.3.2


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
